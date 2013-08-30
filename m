From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Teach git to change to a given directory using -C option
Date: Fri, 30 Aug 2013 21:35:19 +0800
Message-ID: <1377869719-5942-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 30 15:35:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFOr0-0006wH-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 15:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab3H3NfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 09:35:04 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:40616 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab3H3NfD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 09:35:03 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so1885898pbc.2
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=egOXhQqrvW9wrSfIBCZreqtUragmifpFfyN4YcRj8Kw=;
        b=T3l+4Z8XcEocFNG+V9RP60DdpRXZIlynS2/mUG++dUnrrOImbSdFD3m7+h7MReVn+0
         5aXJOBeLOZKAXvLtEpb/xn5jo5IWFWfJWybgA9RTDof0fQeJd4mJxKW/H2dJ4P+/ll+3
         NcjaKLGdpxSbJdiopduowF5EcPuSernhf8KrTe0FSQEYe/sudNIbOEIgJdrOjrI3Ymap
         wmp9kpd73eNm+OUT707dNC6awuvFK2uIWe2h0z+Kcn/FnJfh4Z5OV88esbKBlvQ2zrHc
         T7rWt5M6svGmd7JCUxNTq+pvSEMoicDWSjykFUdObn3RwAsJay+irFUqfe39RiroEi7t
         AVKg==
X-Received: by 10.68.164.1 with SMTP id ym1mr10219746pbb.33.1377869702350;
        Fri, 30 Aug 2013 06:35:02 -0700 (PDT)
Received: from bigbear.localdomain (lbn-26-27.tm.net.my. [202.188.26.27])
        by mx.google.com with ESMTPSA id qf7sm47892310pac.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 06:35:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.g098df5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233441>

This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".

Currently it takes more effort (keypresses) to invoke git command in a
different directory than the current one without leaving the current
directory:

    1. (cd ~/foo && git status)
       git --git-dir=~/foo/.git --work-dir=~/foo status
       GIT_DIR=~/foo/.git GIT_WORK_TREE=~/foo git status
    2. (cd ../..; git grep foo)
    3. for d in d1 d2 d3; do (cd $d && git svn rebase); done

While doable the methods shown above are arguably more suitable for
scripting than quick command line invocations.

With this new option, the above can be done with less keystrokes:

    1. git -C ~/foo status
    2. git -C ../.. grep foo
    3. for d in d1 d2 d3; do git -C $d svn rebase; done

A new test script is added to verify the behavior of this option with
other path-related options like --git-dir and --work-tree.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
This is a reroll of [1]. The only difference is the rewording of the
commit message.  I'm resending this as I've found it to be useful in my
daily git usage in that it helps me stay focused on what I'm doing in
the current directory while needing to run git on another directory.

nazri.

[1] http://permalink.gmane.org/gmane.comp.version-control.git/221954

 Documentation/git.txt | 13 +++++++++
 git.c                 | 15 ++++++++--
 t/t0056-git-C.sh      | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100755 t/t0056-git-C.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dca11cc..0d44fa2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -395,6 +395,19 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
+-C <directory>::
+	Run as if git were started in <directory> instead of the current
+	working directory. If multiple -C options are given, subsequent
+	directory arguments are interpreted relative to the previous one: -C
+	/usr -C src is equivalent to -C /usr/src. This option affects options
+	that expect path name like --git-dir and --work-tree in that their
+	interpretations of the path names would be made relative to the
+	effective working directory caused by the -C option. For example the
+	following invocations are equivalent:
+
+	    git --git-dir=a.git --work-tree=b -C c status
+	    git --git-dir=c/a.git --work-tree=c/b status
+
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/git.c b/git.c
index 2025f77..2207ee5 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 #include "commit.h"
 
 const char git_usage_string[] =
-	"git [--version] [--help] [-c name=value]\n"
+	"git [--version] [--help] [-C directory] [-c name=value]\n"
 	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
@@ -54,7 +54,18 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		/*
 		 * Check remaining flags.
 		 */
-		if (!prefixcmp(cmd, "--exec-path")) {
+		if (!strcmp(cmd, "-C")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for -C.\n" );
+				usage(git_usage_string);
+			}
+			if (chdir((*argv)[1]))
+				die_errno("Cannot change to '%s'", (*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--exec-path")) {
 			cmd += 11;
 			if (*cmd == '=')
 				git_set_argv_exec_path(cmd + 1);
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
new file mode 100755
index 0000000..370eae6
--- /dev/null
+++ b/t/t0056-git-C.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='"-C <directory>" option and it effects on other path-related options'
+
+. ./test-lib.sh
+
+test_expect_success '"git -C <dir>" runs git from the directory <dir>' '
+	test_create_repo dir1 &&
+	echo 1 >dir1/a.txt &&
+	(cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
+	expected="initial in dir1" &&
+	actual=$(git -C dir1 log --format=%s) &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
+	test_create_repo dir1/dir2 &&
+	echo 1 >dir1/dir2/a.txt &&
+	git -C dir1/dir2 add a.txt &&
+	expected="initial in dir1/dir2" &&
+	git -C dir1/dir2 commit -m "$expected" &&
+	actual=$(git -C dir1 -C dir2 log --format=%s) &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Effect on --git-dir option: "-C c --git-dir=a.git" is equivalent to "--git-dir c/a.git"' '
+	mkdir c &&
+	mkdir c/a &&
+	mkdir c/a.git &&
+	(cd c/a.git && git init --bare) &&
+	echo 1 >c/a/a.txt &&
+	git --git-dir c/a.git --work-tree=c/a add a.txt &&
+	git --git-dir c/a.git --work-tree=c/a commit -m "initial" &&
+	expected="$(git --git-dir=c/a.git log -1 --format=%s)" &&
+	actual=$(git -C c --git-dir=a.git log -1 --format=%s) &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivalent to "-C c --git-dir=a.git"' '
+	expected="$(git -C c --git-dir=a.git log -1 --format=%s)" &&
+	actual=$(git --git-dir=a.git -C c log -1 --format=%s) &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
+	rm c/a/a.txt &&
+	expected="$(git --git-dir=c/a.git --work-tree=c/a status)" &&
+	actual="$(git -C c/a.git --work-tree=../a status)" &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
+	expected="$(git -C c/a.git --work-tree=../a status)" &&
+	actual="$(git --work-tree=../a -C c/a.git status)" &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Effect on --git-dir and --work-tree options - "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=c/a.git --work-tree=c/a"' '
+	expected="$(git --git-dir=c/a.git --work-tree=c/a status)" &&
+	actual="$(git -C c --git-dir=a.git --work-tree=a status)" &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git -C c --work-tree=a"' '
+	expected="$(git -C c --git-dir=a.git --work-tree=a status)" &&
+	actual="$(git --git-dir=a.git -C c --work-tree=a status)" &&
+	test "$expected" = "$actual"
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git --work-tree=a -C c"' '
+	expected="$(git -C c --git-dir=a.git --work-tree=a status)" &&
+	actual="$(git --git-dir=a.git --work-tree=a -C c status)" &&
+	test "$expected" = "$actual"
+'
+
+test_done
-- 
1.8.4.1.g098df5a
