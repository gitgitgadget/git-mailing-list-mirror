From: David Caldwell <david@porkrind.org>
Subject: [PATCH] stash: Add --clean option to stash and remove all untracked files
Date: Mon, 20 Jun 2011 16:36:26 -0700
Message-ID: <1308612986-26593-1-git-send-email-david@porkrind.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Caldwell <david@porkrind.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 01:46:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYoAz-0001Ls-2d
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 01:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab1FTXqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 19:46:35 -0400
Received: from kill.porkrind.org ([68.68.97.104]:41482 "EHLO
	david.xen.prgmr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab1FTXqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 19:46:34 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jun 2011 19:46:34 EDT
Received: from porkrind.org (cpe-98-151-185-99.socal.res.rr.com [98.151.185.99])
	by david.xen.prgmr.com (Postfix) with ESMTPS id 811CD2BD5B;
	Mon, 20 Jun 2011 16:36:31 -0700 (PDT)
Authentication-Results: david.xen.prgmr.com; dkim=pass
	(1536-bit key; insecure key) header.i=@porkrind.org
	header.b=BXDwfT3K; dkim-adsp=pass
Received-SPF: pass (porkrind.org: domain of david@porkrind.org designates 127.0.0.1 as permitted sender) receiver=porkrind.org; client-ip=127.0.0.1; helo=porkrind.org; envelope-from=david@porkrind.org; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from porkrind.org (localhost [127.0.0.1])
	by porkrind.org (8.14.4/8.14.4/Debian-2) with ESMTP id p5KNaSIF026638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Jun 2011 16:36:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=porkrind.org;
	s=apoptygma; t=1308612988;
	bh=tgKb/6daga93t9kntOv4psdCw9FKIoIF5j8E3aOPwAM=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=BXDwfT3Kd2wtICsKonaotgMjggc5E74f/8x/iEtNHuk8+rY046YzS0N3x9jZ1TQOH
	 SZWhHhXN1XPZv43/oMjpMIr5SHCSr/tbvhELSfTvGu+vMugiE39Oz4kASYhD6xJsEM
	 d2EE2k4T0n/m2tu4507snOPj1UCGkwAy7cEnJ6KIWVk0g13kFJ2BL/K+gDEbWy+PId
	 tcy7+/iv4NAMxuruXxXw+f/py0UxxmI6+TMT2XVDJcIU+J4L5obLndWJtiK
Received: (from david@localhost)
	by porkrind.org (8.14.4/8.14.4/Submit) id p5KNaRfD026636;
	Mon, 20 Jun 2011 16:36:27 -0700
X-Mailer: git-send-email 1.7.5.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
	T_DKIM_INVALID,UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on kill.porkrind.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176112>

The --clean option acts like the normal "git stash save" but also adds all
untracked files in the working directory to the stash and then calls "git
clean --force --quiet" to restore the working directory to a pristine
state.

I find this useful for certain projects that need to run release
scripts. With this option I can run the release scripts from my main working
directory and not have to maintain a "clean" directory in parallel just for
releasing. Basically the work-flow becomes:

   $ git tag release-1.0
   $ git stash --clean
   $ make release
   $ git stash pop

"git stash" alone is not enough in this case--it leaves untracked files
lying around (configure and automake droppings, for instance) that might
mess up a release process that expects everything to be very clean.

Signed-off-by: David Caldwell <david@porkrind.org>

Hi,

  This is my first patch to git so I have a couple questions:

  * I used 'find . -name ".git" -prune -o -print' to get a list of all the
    files in the working directory. That assumes ".git" is the name
    of the repo--is that assumption valid?

  * Also, that find command does not respect .gitignore. Should it? If it
    does then I think it would need another option to also clean up stuff
    that is normally ignored (similar to the way "git clean" works with the
    -x option). My thoughts were that if we were stashing everything, being
    overzealous with the cleanup wouldn't hurt (and would generally be
    exactly what you want).

Thanks,
  David

---
 Documentation/git-stash.txt |    8 ++-
 git-stash.sh                |   20 +++++++-
 t/t3905-stash-clean.sh      |  111 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 5 deletions(-)
 create mode 100755 t/t3905-stash-clean.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 15f051f..7c9055c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
+'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-c|--clean] [-q|--quiet] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -42,7 +42,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index] [-c|--clean] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -54,6 +54,10 @@ save [-p|--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
 +
+If the `--clean` option is used, all non-tracked files are also stashed and
+then cleaned up with `git clean`, leaving the working directory in a very
+clean state.
++
 With `--patch`, you can interactively select hunks from the diff
 between HEAD and the working tree to be stashed.  The stash entry is
 constructed such that its index state is the same as the index state
diff --git a/git-stash.sh b/git-stash.sh
index 0a94036..ea34dc4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-c|--clean] [-q|--quiet] [<message>]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -49,6 +49,7 @@ clear_stash () {
 
 create_stash () {
 	stash_msg="$1"
+	clean="$2"
 
 	git update-index -q --refresh
 	if no_changes
@@ -86,7 +87,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
+			(git diff --name-only -z HEAD; test -n "$clean" && find . -name ".git" -prune -o -print0) | git update-index -z --add --remove --stdin &&
 			git write-tree &&
 			rm -f "$TMPindex"
 		) ) ||
@@ -129,6 +130,7 @@ create_stash () {
 save_stash () {
 	keep_index=
 	patch_mode=
+	clean=
 	while test $# != 0
 	do
 		case "$1" in
@@ -146,6 +148,9 @@ save_stash () {
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
+		-c|--clean)
+			clean=t
+			;;
 		--)
 			shift
 			break
@@ -162,6 +167,11 @@ save_stash () {
 		shift
 	done
 
+	if test -n "$patch_mode" && test -n "$clean"
+	then
+	    die "Can't stash --patch and --clean at the same time"
+	fi
+
 	stash_msg="$*"
 
 	git update-index -q --refresh
@@ -173,7 +183,7 @@ save_stash () {
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "Cannot initialize stash"
 
-	create_stash "$stash_msg"
+	create_stash "$stash_msg" $clean
 
 	# Make sure the reflog for stash is kept.
 	: >>"$GIT_DIR/logs/$ref_stash"
@@ -185,6 +195,10 @@ save_stash () {
 	if test -z "$patch_mode"
 	then
 		git reset --hard ${GIT_QUIET:+-q}
+		if test -n "$clean"
+		then
+			git clean --force --quiet
+		fi
 
 		if test "$keep_index" = "t" && test -n $i_tree
 		then
diff --git a/t/t3905-stash-clean.sh b/t/t3905-stash-clean.sh
new file mode 100755
index 0000000..301e4b0
--- /dev/null
+++ b/t/t3905-stash-clean.sh
@@ -0,0 +1,111 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 David Caldwell
+#
+
+test_description='Test git stash --clean'
+
+. ./test-lib.sh
+
+# Test code doesn't seem to clean the test dir out between runs.
+#git clean --force --quiet
+
+test_expect_success 'stash save --clean some dirty working directory' '
+	echo 1 > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 2 > file &&
+	git add file &&
+	echo 3 > file &&
+	test_tick &&
+	echo 1 > file2 &&
+	git stash --clean &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD
+'
+
+cat > expect <<EOF
+?? expect
+?? output
+EOF
+
+test_expect_success 'stash save --clean cleaned the untracked files' '
+	git status --porcelain > output
+	test_cmp output expect
+'
+
+cat > expect << EOF
+diff --git a/file b/file
+index 0cfbf08..00750ed 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-2
++3
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000..d00491f
+--- /dev/null
++++ b/file2
+@@ -0,0 +1 @@
++1
+EOF
+
+test_expect_success 'stash save --clean stashed the untracked files' '
+	git diff stash^2..stash > output &&
+	test_cmp output expect
+'
+
+test_expect_success 'stash save --patch --clean fails' '
+	test_must_fail git stash --patch --clean
+'
+
+git clean --force --quiet
+
+test_expect_success 'stash save -c dirty index' '
+	echo 4 > file3 &&
+	git add file3 &&
+	test_tick &&
+	git stash -c
+'
+
+cat > expect <<EOF
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..b8626c4
+--- /dev/null
++++ b/file3
+@@ -0,0 +1 @@
++4
+EOF
+
+test_expect_success 'stash save --clean dirty index got stashed' '
+	git stash pop --index &&
+	git diff --cached > output &&
+	test_cmp output expect
+'
+
+git reset
+
+test_expect_success 'stash save --clean -q is quiet' '
+	echo 1 > file5
+	git stash save --clean --quiet > output.out 2>&1 &&
+	test ! -s output.out
+'
+
+test_expect_success 'stash save --clean removed files' '
+	rm -f file &&
+	git stash save --clean &&
+	echo 1 > expect &&
+	test_cmp file expect
+'
+
+rm -f expect
+
+test_expect_success 'stash save --clean removed files got stashed' '
+	git stash pop &&
+	test ! -f file
+'
+
+test_done
-- 
1.7.5.3
