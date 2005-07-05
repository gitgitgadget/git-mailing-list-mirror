From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Short-cut git-fetch-pack while cloning locally.
Date: Tue, 05 Jul 2005 13:17:31 -0700
Message-ID: <7vekaddn38.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050704.125744.59481768.davem@davemloft.net>
	<Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
	<20050704204235.GE21128@pasky.ji.cz>
	<20050704.140043.112609056.davem@davemloft.net>
	<Pine.LNX.4.58.0507041443510.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Tue Jul 05 22:19:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DptsS-0002l5-PK
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 22:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVGEUSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVGEUSg
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 16:18:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56012 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261739AbVGEURz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 16:17:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050705201732.KALW18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 5 Jul 2005 16:17:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507041443510.3570@g5.osdl.org> (Linus Torvalds's message of "Mon, 4 Jul 2005 14:44:08 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Well, I'm not working on it, but tested patches...

Prodded by the hint...

------------
The git-fetch-pack command used internally by git-fetch-script
which in turn is used by git-clone-script refuses to run if
there is no common head.  When cloning locally, just copy/link the
objects directory to avoid its use, since we know there will not
be any common head (the target is empty).  It also should be
more efficient.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This is slightly different from the one I sent as a response
*** to David's inquiry, in that it uses cp -rl (or just cp -r)
*** instead of cpio.  Also I added the copyright notices and one
*** liner description.

 git-clone-script |   43 +++++++++++++++++++++++++++++++++++++++----
 rev-list.c       |    5 ++++-
 2 files changed, 43 insertions(+), 5 deletions(-)

f33df082e175f7fc717a75e528eab3db1d294576
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -1,7 +1,42 @@
 #!/bin/sh
+#
+# Copyright (c) 2005, Linus Torvalds
+# Copyright (c) 2005, Junio C Hamano
+# 
+# Clone a repository into a different directory that does not yet exist.
+
 repo="$1"
 dir="$2"
-mkdir $dir || exit 1
-cd $dir
-git-init-db
-git fetch "$repo" && ( git-rev-parse FETCH_HEAD > .git/HEAD )
+mkdir "$dir" &&
+D=$(
+	(cd "$dir" && git-init-db && pwd)
+) || exit 1
+
+# See if repo is a local directory.
+if (
+	cd "$repo/objects" 2>/dev/null
+)
+then
+	# See if we can hardlink and drop "l" if not.
+	sample_file=$(cd "$repo" && find objects -type f -print | sed -e 1q)
+
+	# objects directory should not be empty since we are cloning!
+	test -f "$repo/$sample_file" || exit
+
+	if ln "$repo/$sample_file" "$D/.git/objects/sample" 2>/dev/null
+	then
+		l=l
+	else
+		l=
+	fi &&
+	rm -f "$D/.git/objects/sample" &&
+
+	cp -r$l "$repo/objects" "$D/.git/" || exit 1
+
+	# FETCH_HEAD is always HEAD because we do not do the
+	# extra parameter to "git fetch".
+	cat "$repo/HEAD" >"$D/.git/FETCH_HEAD"
+	cd "$D"
+else
+	cd "$D" && git fetch "$repo"
+fi && git-rev-parse FETCH_HEAD > .git/HEAD
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -482,7 +482,10 @@ int main(int argc, char **argv)
 		commit = get_commit_reference(arg, flags);
 		if (!commit)
 			continue;
-		insert_by_date(&list, commit);
+		if (!merge_order)
+			insert_by_date(&list, commit);
+		else
+			commit_list_insert(commit, &list);
 	}
 
 	if (!merge_order) {		
