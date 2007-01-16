From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Mon, 15 Jan 2007 17:31:29 -0800
Message-ID: <17437.1168911089@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 16 02:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6dSL-0003aq-SY
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 02:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbXAPBtl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 20:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbXAPBtl
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 20:49:41 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45209 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbXAPBtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 20:49:40 -0500
X-Greylist: delayed 1120 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 20:49:40 EST
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0G1VTSH017454
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:31:29 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0G1VTEw017451
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:31:29 -0800 (PST)
To: git@vger.kernel.org
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36908>

Not all echos know -n.  This was causing a test failure in
t5401-update-hooks.sh, but not t3800-mktag.sh for some reason.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---
 contrib/remotes2config.sh |    2 +-
 git-quiltimport.sh        |    2 +-
 git-reset.sh              |    2 +-
 t/t3800-mktag.sh          |    2 +-
 t/t5401-update-hooks.sh   |    4 ++--
 t/t6023-merge-file.sh     |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
index 25901e2..b996996 100644
--- a/contrib/remotes2config.sh
+++ b/contrib/remotes2config.sh
@@ -11,7 +11,7 @@ if [ -d "$GIT_DIR"/remotes ]; then
 	{
 		cd "$GIT_DIR"/remotes
 		ls | while read f; do
-			name=$(echo -n "$f" | tr -c "A-Za-z0-9" ".")
+			name=$(printf "$f" | tr -c "A-Za-z0-9" ".")
 			sed -n \
 			-e "s/^URL: \(.*\)$/remote.$name.url \1 ./p" \
 			-e "s/^Pull: \(.*\)$/remote.$name.fetch \1 ^$ /p" \
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 10135da..2ae1f20 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -89,7 +89,7 @@ for patch_name in $(cat "$QUILT_PATCHES/series" | grep -v '^#'); do
 			echo "No author found in $patch_name" >&2;
 			echo "---"
 			cat $tmp_msg
-			echo -n "Author: ";
+			printf "Author: ";
 			read patch_author
 
 			echo "$patch_author"
diff --git a/git-reset.sh b/git-reset.sh
index 91c7e6e..bf2a058 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -87,7 +87,7 @@ update_ref_status=$?
 case "$reset_type" in
 --hard )
 	test $update_ref_status = 0 && {
-		echo -n "HEAD is now at "
+		printf "HEAD is now at "
 		GIT_PAGER= git log --max-count=1 --pretty=oneline \
 			--abbrev-commit HEAD
 	}
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 5b23b77..ede4d42 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -88,7 +88,7 @@ check_verify_failure '"type" line label check'
 #  5. type line eol check
 
 echo "object 779e9b33986b1c2670fff52c5067603117b3e895" >tag.sig
-echo -n "type tagsssssssssssssssssssssssssssssss" >>tag.sig
+printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
 
 cat >expect.pat <<EOF
 ^error: char48: .*"[\]n"$
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index cd8cee6..0514056 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 cat >victim/.git/hooks/update <<'EOF'
 #!/bin/sh
 echo "$@" >$GIT_DIR/update.args
-read x; echo -n "$x" >$GIT_DIR/update.stdin
+read x; printf "$x" >$GIT_DIR/update.stdin
 echo STDOUT update
 echo STDERR update >&2
 EOF
@@ -32,7 +32,7 @@ chmod u+x victim/.git/hooks/update
 cat >victim/.git/hooks/post-update <<'EOF'
 #!/bin/sh
 echo "$@" >$GIT_DIR/post-update.args
-read x; echo -n "$x" >$GIT_DIR/post-update.stdin
+read x; printf "$x" >$GIT_DIR/post-update.stdin
 echo STDOUT post-update
 echo STDERR post-update >&2
 EOF
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 1c21d8c..f3cd3db 100644
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -52,7 +52,7 @@ super aquam refectionis educavit me;
 animam meam convertit,
 deduxit me super semitas jusitiae,
 EOF
-echo -n "propter nomen suum." >> new4.txt
+printf "propter nomen suum." >> new4.txt
 
 cp new1.txt test.txt
 test_expect_success "merge without conflict" \
-- 
1.5.0.rc1.gf4b6c
