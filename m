From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] replace: use a GIT_NO_REPLACE_OBJECTS env variable
Date: Tue, 17 Nov 2009 06:11:23 +0100
Message-ID: <20091117051125.3588.91072.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 06:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAGQV-0005L4-MP
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 06:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbZKQFQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 00:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbZKQFQM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 00:16:12 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47774 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbZKQFQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 00:16:11 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8FBBF818072;
	Tue, 17 Nov 2009 06:16:06 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E5526818049;
	Tue, 17 Nov 2009 06:16:03 +0100 (CET)
X-git-sha1: 86449357238b9d60be1d68fbffbdeb8443b83af9 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133058>

This environment variable is set when the --no-replace-objects
flag is passed to git, and it is read when other environment
variables are read.

It is useful for example for scripts, as the git commands used in
them can now be aware that they must not read replace refs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h            |    1 +
 environment.c      |    2 ++
 git.c              |    3 +++
 t/t6050-replace.sh |   17 +++++++++++++++++
 4 files changed, 23 insertions(+), 0 deletions(-)

	Michael J Gruber wrote:
	>
	> [ The example also shows that we need a way to specify
	> --no-replace-objects for gitk. Would easier if gitk really
	> where git something. ]

	These 2 patches should fix that for gitk and many other scripted
	commands. But if it doesn't for some, please tell me.

	Thanks,
	Christian.

diff --git a/cache.h b/cache.h
index 71a731d..bc77909 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
+#define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
diff --git a/environment.c b/environment.c
index 5de6837..279a38a 100644
--- a/environment.c
+++ b/environment.c
@@ -83,6 +83,8 @@ static void setup_git_env(void)
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = git_pathdup("info/grafts");
+	if (read_replace_refs && getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
+		read_replace_refs = 0;
 }
 
 int is_bare_repository(void)
diff --git a/git.c b/git.c
index bd2c5fe..7f7d73d 100644
--- a/git.c
+++ b/git.c
@@ -89,6 +89,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
 			read_replace_refs = 0;
+			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --git-dir.\n" );
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d4818b4..82cf2ec 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -77,6 +77,11 @@ test_expect_success 'test --no-replace-objects option' '
      git --no-replace-objects show $HASH2 | grep "A U Thor"
 '
 
+test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
+     GIT_NO_REPLACE_OBJECTS= git cat-file commit $HASH2 | grep "author A U Thor" &&
+     GIT_NO_REPLACE_OBJECTS= git show $HASH2 | grep "A U Thor"
+'
+
 cat >tag.sig <<EOF
 object $HASH2
 type commit
@@ -202,6 +207,18 @@ test_expect_success 'fetch branch with replacement' '
      cd ..
 '
 
+test_expect_success 'bisect and replacements' '
+     git bisect start $HASH7 $HASH1 &&
+     test "$S" = "$(git rev-parse --verify HEAD)" &&
+     git bisect reset &&
+     GIT_NO_REPLACE_OBJECTS= git bisect start $HASH7 $HASH1 &&
+     test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
+     git bisect reset &&
+     git --no-replace-objects bisect start $HASH7 $HASH1 &&
+     test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
+     git bisect reset
+'
+
 #
 #
 test_done
-- 
1.6.5.1.gaf97d
