From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: [PATCH] Add git-save script
Date: Sat, 23 Jun 2007 22:02:15 +0900
Message-ID: <20070623220215.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 15:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I25Qb-0005vm-4N
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 15:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbXFWNNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 09:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbXFWNNY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 09:13:24 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:33992 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbXFWNNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 09:13:23 -0400
Received: from fe1.bluebottle.com (internal.bluebottle.com [206.188.24.43])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5NDDMc4025487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 23 Jun 2007 06:13:22 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:date:subject:to:message-id:content-type:
	mime-version:x-trusted-delivery;
	b=cNYMrWb/1e3qIVpvUxx84/tStAYMP2UlXOvz/fVk65kL9Ix5jx3QibPE6pa1sOl8m
	x8G3GhzgVInPTficxnphKmOWEmL4U3RyxRNYgqk6dm/pKTbYFr0WmVrnDbQO1lY
Received: from nanako3.mail.bluebottle.com (81-21-243-20.televork.ee [81.21.243.20])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5NDDH0k020317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 23 Jun 2007 06:13:21 -0700
X-Trusted-Delivery: <c7b27b4b516cb7eef734dcb28e85ac6b>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50737>

When my boss has something to show me and I have to update, for some reason I
am always in the middle of doing something else, and git pull command refuses
to work in such a case.

I wrote this little script to save the changes I made, perform the update,
and then come back to where I was, but on top of the updated commit.

Here is how to use my script:

    $ git save
    $ git pull
    $ git save restore

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>

diff --git a/git-save.sh b/git-save.sh
new file mode 100755
index 0000000..b45652e
--- /dev/null
+++ b/git-save.sh
@@ -0,0 +1,74 @@
+#! /bin/sh
+
+. git-sh-setup
+require_work_tree
+
+function save_work () {
+	save=$( (
+		i_tree=$(git-write-tree)
+
+		TMP=$GIT_DIR/.git-save-tmp
+		GIT_INDEX_FILE=$TMP
+		export GIT_INDEX_FILE
+
+		git-read-tree $i_tree
+		git-add -u
+		w_tree=$(git-write-tree)
+		rm $TMP
+		git-read-tree --prefix=base/ HEAD^{tree}
+		git-read-tree --prefix=indx/ $i_tree
+		git-read-tree --prefix=work/ $w_tree
+		git-write-tree
+		rm $TMP
+	) )
+
+	head=$(git-log --abbrev-commit --pretty=oneline -n 1 HEAD)
+	if branch=$(git symbolic-ref -q HEAD); then
+		branch=${branch#refs/heads/}
+	else
+		branch='(no branch)'
+	fi &&
+	msg=$(printf 'WIP on %s "%s"' "$branch" "$head")
+
+	saved=$(printf '%s' "$msg" | git-commit-tree "$save")
+	git update-ref -m "$msg" refs/heads/saved $saved
+	printf 'Saved %s\n' "$msg" >&2
+}
+
+function list_save () {
+	git-log --abbrev-commit --pretty=oneline -g "$@" saved
+}
+
+function show_save () {
+	save=$(git rev-parse --verify --default saved "$1")
+	git diff-tree --stat $save:base $save:work
+}
+
+function restore_save () {
+	save=$(git rev-parse --verify --default saved "$1")
+	h_tree=$(git rev-parse --verify $save:base)
+	i_tree=$(git rev-parse --verify $save:indx)
+	w_tree=$(git rev-parse --verify $save:work)
+
+	git-merge-recursive $h_tree -- HEAD^{tree} $w_tree
+}
+
+if [ "$1" = list ]; then
+	shift
+	if [ "$#" = 0 ]; then
+		set x -n 10
+		shift
+	fi
+	list_save "$@"
+elif [ "$1" = show ]; then
+	shift
+	show_save "$@"
+elif [ "$1" = restore ]; then
+	shift
+	restore_save "$@"
+else
+	save_work
+	git reset --hard
+fi
+
+
-- 
しらいし ななこ http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com
