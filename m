From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] git: add --no-replace-objects option to disable replacing
Date: Mon, 12 Oct 2009 22:30:32 +0200
Message-ID: <20091012203033.8939.43473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxRmw-0006mu-4m
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 22:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbZJLUgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbZJLUgW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 16:36:22 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41397 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbZJLUgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 16:36:21 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 55FA981B3B9;
	Mon, 12 Oct 2009 22:35:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 340C681B3A0;
	Mon, 12 Oct 2009 22:35:34 +0200 (CEST)
X-git-sha1: af97d265e8c56c69782df9f24381fd705bbbb200 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130063>

Commit dae556b (environment: add global variable to disable replacement)
adds a variable to enable/disable replacement, and it is enabled by
default for most commands.

So there is no way to disable it for some commands, which is annoying
when we want to get information about a commit that has been replaced.

For example:

$ git cat-file -p N

would output information about the replacement commit if commit N is
replaced.

With the "--no-replace-objects" option that this patch adds it is
possible to get information about the original commit using:

$ git --no-replace-objects cat-file -p N

While at it, let's add some documentation about this new option in the
"git replace" man page too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt |   21 +++++++++++++++++++++
 Documentation/git.txt         |    6 +++++-
 git.c                         |    4 +++-
 t/t6050-replace.sh            |    7 +++++++
 4 files changed, 36 insertions(+), 2 deletions(-)

	Here is a patch with some tests and documentation.
	The new option is now called "--no-replace-objects" instead of
	"--no-replace".

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 915cb77..8adc1ef 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -23,6 +23,26 @@ replacement object.
 Unless `-f` is given, the replace reference must not yet exist in
 `.git/refs/replace/` directory.
 
+Replace references will be used by default by all git commands except
+those doing reachability traversal (prune, pack transfer and fsck).
+
+It is possible to disable use of replacement refs for any command
+using the --no-replace-objects option just after "git".
+
+For example if commit "foo" has been replaced by commit "bar":
+
+------------------------------------------------
+$ git --no-replace-object cat-file commit foo
+------------------------------------------------
+
+show information about commit "foo", while:
+
+------------------------------------------------
+$ git cat-file commit foo
+------------------------------------------------
+
+show information about commit "bar".
+
 OPTIONS
 -------
 -f::
@@ -54,6 +74,7 @@ SEE ALSO
 --------
 linkgit:git-tag[1]
 linkgit:git-branch[1]
+linkgit:git[1]
 
 Author
 ------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d97aaf5..2f45417 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
-    [-p|--paginate|--no-pager]
+    [-p|--paginate|--no-pager] [--no-replace-objects]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]
 
@@ -237,6 +237,10 @@ help ...`.
 	environment is not set, it is set to the current working
 	directory.
 
+--no-replace-objects::
+	Do not use replacement refs to replace git objects. See
+	linkgit:git-replace[1] for more information.
+
 
 FURTHER DOCUMENTATION
 ---------------------
diff --git a/git.c b/git.c
index 9883009..80ebb04 100644
--- a/git.c
+++ b/git.c
@@ -6,7 +6,7 @@
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]\n"
-	"           [-p|--paginate|--no-pager]\n"
+	"           [-p|--paginate|--no-pager] [--no-replace_objects]\n"
 	"           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]\n"
 	"           [--help] COMMAND [ARGS]";
 
@@ -87,6 +87,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			use_pager = 0;
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-replace-objects")) {
+			read_replace_refs = 0;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --git-dir.\n" );
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 8b8bd81..d4818b4 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -70,6 +70,13 @@ test_expect_success 'replace the author' '
      git show $HASH2 | grep "O Thor"
 '
 
+test_expect_success 'test --no-replace-objects option' '
+     git cat-file commit $HASH2 | grep "author O Thor" &&
+     git --no-replace-objects cat-file commit $HASH2 | grep "author A U Thor" &&
+     git show $HASH2 | grep "O Thor" &&
+     git --no-replace-objects show $HASH2 | grep "A U Thor"
+'
+
 cat >tag.sig <<EOF
 object $HASH2
 type commit
-- 
1.6.5.1.gaf97d
