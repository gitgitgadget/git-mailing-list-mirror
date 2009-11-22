From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/4] replace: use a GIT_NO_REPLACE_OBJECTS env variable
Date: Sun, 22 Nov 2009 07:56:42 +0100
Message-ID: <20091122065645.4811.9133.chriscool@tuxfamily.org>
References: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 07:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC6MV-0000Ul-CW
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 07:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbZKVGzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 01:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbZKVGzg
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 01:55:36 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38963 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbZKVGzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 01:55:22 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DE8DC81809E;
	Sun, 22 Nov 2009 07:55:19 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 969D181808E;
	Sun, 22 Nov 2009 07:55:16 +0100 (CET)
X-git-sha1: ced01c2af3750d128703d0664d014e8a86bccb6f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133426>

Replace refs are useful to change some git objects after they
have started to be shared between different repositories. One
might want to ignore them to see the original state, and
the "--no-replace-objects" option can be used from the command
line to do so.

But the effects of this command line option were not propagated
to git commands called by the original command that was passed
this option.

The goal of this patch is to propagate these effects by using
a new GIT_NO_REPLACE_OBJECTS environment variable.

This environment variable is set when the --no-replace-objects
flag is passed to git, and it is read when other environment
variables are read.

It is useful for example for scripts, as the git commands used in
them can now be aware that they must not read replace refs.

The GIT_NO_REPLACE_OBJECTS is set to "1" instead of "" as it is
safer on some platforms, thanks to Johannes Sixt and Michael J
Gruber.

Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h            |    1 +
 connect.c          |    1 +
 environment.c      |    2 ++
 git.c              |    3 +++
 t/t6050-replace.sh |   17 +++++++++++++++++
 5 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 22a06d6..fcdc954 100644
--- a/cache.h
+++ b/cache.h
@@ -374,6 +374,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
+#define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
diff --git a/connect.c b/connect.c
index 839a103..db965c9 100644
--- a/connect.c
+++ b/connect.c
@@ -609,6 +609,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 			GIT_WORK_TREE_ENVIRONMENT,
 			GRAFT_ENVIRONMENT,
 			INDEX_ENVIRONMENT,
+			NO_REPLACE_OBJECTS_ENVIRONMENT,
 			NULL
 		};
 		conn->env = env;
diff --git a/environment.c b/environment.c
index ed17043..c7ebc54 100644
--- a/environment.c
+++ b/environment.c
@@ -85,6 +85,8 @@ static void setup_git_env(void)
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = git_pathdup("info/grafts");
+	if (read_replace_refs && getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
+		read_replace_refs = 0;
 }
 
 int is_bare_repository(void)
diff --git a/git.c b/git.c
index 743ee57..11544cd 100644
--- a/git.c
+++ b/git.c
@@ -89,6 +89,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
 			read_replace_refs = 0;
+			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --git-dir.\n" );
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d4818b4..203ffdb 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -77,6 +77,11 @@ test_expect_success 'test --no-replace-objects option' '
      git --no-replace-objects show $HASH2 | grep "A U Thor"
 '
 
+test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
+     GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
+     GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
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
+     GIT_NO_REPLACE_OBJECTS=1 git bisect start $HASH7 $HASH1 &&
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
