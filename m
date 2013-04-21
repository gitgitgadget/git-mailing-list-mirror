From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Teach git to change to a given directory using -C option
Date: Sun, 21 Apr 2013 21:48:46 +0800
Message-ID: <1366552126-6090-1-git-send-email-ayiehere@gmail.com>
References: <20130419161250.GC14263@sigill.intra.peff.net>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: peff@peff.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 21 15:49:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTudb-0003Nz-J1
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab3DUNs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:48:58 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:45227 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3DUNs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:48:57 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so3034794pdj.34
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=AAI5bXimDinWYDZWvZbkYEozv9DguhWN//g/YzKan9g=;
        b=WGoS0Vbl9cNAdBm0VZIZxGC33Of3LiHPJlOklPHpxLu8UGCzCdziYWDbNYVM/xBt4u
         rxo0Z2eaFabpysTIovu2xdCB6UVRKGNuNdS/2l6tP2Di0sdLhYzp25VTqp3njC0P5OBW
         mld4kuoqCYyB4q4tORMGh88A7Q2as6B32LKi+vdEQZlVYzh9yc3HarDZxNK6dbeUkr9s
         3yCaXWipo36SrZ1yAg/EIMwJA6WSB3a4S5TPPUL+U33mo/0YXOEYYLxEx5GYHXGSYndG
         mOO83rvXEC/89dYrRjYIEeakVTGk0k0cbBbvIcROTKnyr0UaDBmkAtL5f0qU80j5/Qn7
         jbfQ==
X-Received: by 10.68.106.196 with SMTP id gw4mr27558316pbb.126.1366552137273;
        Sun, 21 Apr 2013 06:48:57 -0700 (PDT)
Received: from bigbear.localdomain ([60.51.114.108])
        by mx.google.com with ESMTPS id yp2sm22861127pab.10.2013.04.21.06.48.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 06:48:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.339.g52a3e01
In-Reply-To: <20130419161250.GC14263@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221954>

This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".

Currently finding out the status of a git repository that is located
away from the current working directory without going to that directory
can be done in the following ways:

    1. (cd ~/foo && git status)
    2. git --git-dir=~/foo/.git --work-dir=~/foo status
    3. GIT_DIR=~/foo/.git GIT_WORK_TREE=~/foo git status

While doable the methods shown above are arguably more suitable for
scripting than quick command line invocations.

With this new option, the above can be done a bit more tersely:

    $ git -C ~/foo status

A new test script is added to verify the behavior of this option with
other path-related options like --git-dir and --work-tree.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
Jeff: Thanks for pointing out the mistakes.

But I did not address your concern:
> I know you are copying this from the other options in the same function,
> but I wonder if they should all be calling "error()" (and dropping the
> terminating ".") to better match our usual error messages.

because I'd rather have that fix be done in a separate topic.

The other points raised are all valid and fixed in this new patch.

 Documentation/git.txt | 13 +++++++++
 git.c                 | 15 ++++++++--
 t/t0056-git-C.sh      | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100755 t/t0056-git-C.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6a875f2..6064b3d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -379,6 +379,19 @@ displayed. See linkgit:git-help[1] for more information,
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
index 1ada169..a8731e9 100644
--- a/git.c
+++ b/git.c
@@ -6,7 +6,7 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--help] [-c name=value]\n"
+	"git [--version] [--help] [-C directory] [-c name=value]\n"
 	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
@@ -53,7 +53,18 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
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
1.8.2.1.339.g52a3e01
