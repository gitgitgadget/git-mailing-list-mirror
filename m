From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] optionally disable gitattributes
Date: Wed, 27 Jan 2016 10:50:21 +0100
Message-ID: <20160127095021.GA25281@ecki.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 10:59:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOMsw-0000p5-8B
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbcA0J7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 04:59:31 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:1757 "EHLO bsmtp5.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbcA0J72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 04:59:28 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2016 04:59:28 EST
Received: from bsmtp8.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 3pr0c3694kz5vgn
	for <git@vger.kernel.org>; Wed, 27 Jan 2016 10:53:07 +0100 (CET)
Received: from [127.0.0.1] (ip5f5adbb8.dynamic.kabel-deutschland.de [95.90.219.184])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pr0bz1ZK8z5tlX;
	Wed, 27 Jan 2016 10:53:02 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284905>

If committed files are not normalized, adding gitattributes has the
side effect that such files are shown as modified, even though they
were not actually modified by the user, and the work tree matches
the committed file. This is because with gitattributes, the file is
modified on the fly when git reads it from disk, before it compares
with the index contents.

This is desirable in most situations, because it makes the user
aware that files should be normalized. However, it can become an
issue for automation. Since Git considers the work tree to be
dirty, some operations such as git rebase or git cherry-pick refuse
to operate. Those commands offer no flag to force overwrite work
tree changes. The only options are to commit the changes, or to
remove gitattributes, but that changes the repository state, which
may be undesirable in a scripted context.

Introduce an environment variable GIT_ATTRIBUTES_DISABLED, which if
set makes Git ignore any gitattributes.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 Documentation/git.txt           |  4 ++++
 Documentation/gitattributes.txt |  6 ++++++
 attr.c                          |  3 +++
 t/t0003-attributes.sh           | 43 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index bff6302..00f4e3b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1132,6 +1132,10 @@ of clones and fetches.
 	  - any external helpers are named by their protocol (e.g., use
 	    `hg` to allow the `git-remote-hg` helper)
 
+'GIT_ATTRIBUTES_DISABLED'::
+	If set, attributes are disabled for all paths. See
+	linkgit:gitattributes[1] for more details on attributes.
+
 
 Discussion[[Discussion]]
 ------------------------
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..f6a2b1d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -996,6 +996,12 @@ frotz	unspecified
 ----------------------------------------------------------------
 
 
+ENVIRONMENT
+-----------
+
+GIT_ATTRIBUTES_DISABLED::
+	If set, attributes are disabled for all paths.
+
 SEE ALSO
 --------
 linkgit:git-check-attr[1].
diff --git a/attr.c b/attr.c
index 086c08d..0fa2f1a 100644
--- a/attr.c
+++ b/attr.c
@@ -547,6 +547,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	int len;
 	const char *cp;
 
+	if (getenv("GIT_ATTRIBUTES_DISABLED"))
+		return;
+
 	/*
 	 * At the bottom of the attribute stack is the built-in
 	 * set of attribute definitions, followed by the contents
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f0fbb42..26e6766 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -13,6 +13,14 @@ attr_check () {
 	test_line_count = 0 err
 }
 
+attr_check_disabled () {
+	(
+		GIT_ATTRIBUTES_DISABLED=t
+		export GIT_ATTRIBUTES_DISABLED
+		attr_check "$@" unspecified
+	)
+}
+
 test_expect_success 'setup' '
 	mkdir -p a/b/d a/c b &&
 	(
@@ -84,6 +92,41 @@ test_expect_success 'attribute test' '
 	attr_check a/b/d/yes unspecified
 '
 
+test_expect_success 'gitattributes disabled' '
+	attr_check_disabled f &&
+	attr_check_disabled a/f &&
+	attr_check_disabled a/c/f &&
+	attr_check_disabled a/g &&
+	attr_check_disabled a/b/g &&
+	attr_check_disabled b/g &&
+	attr_check_disabled a/b/h &&
+	attr_check_disabled a/b/d/g &&
+	attr_check_disabled onoff &&
+	attr_check_disabled offon &&
+	attr_check_disabled no &&
+	attr_check_disabled a/b/d/no &&
+	attr_check_disabled a/b/d/yes
+'
+
+test_expect_success 'no changes if gitattributes disabled' '
+	mkdir clean &&
+	git init clean &&
+	(
+		cd clean &&
+		printf "foo\r\n" >dos.txt &&
+		git add dos.txt &&
+		test_tick &&
+		git commit -q -m dos.txt &&
+		echo "*.txt text eol=lf" >.gitattributes &&
+		git add .gitattributes &&
+		test_tick &&
+		git commit -q -m .gitattributes &&
+		rm -f .git/index &&
+		git reset &&
+		GIT_ATTRIBUTES_DISABLED=t git diff --exit-code
+	)
+'
+
 test_expect_success 'attribute matching is case sensitive when core.ignorecase=0' '
 
 	test_must_fail attr_check F f "-c core.ignorecase=0" &&
-- 
2.7.0
