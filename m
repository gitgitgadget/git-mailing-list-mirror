From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH v3] Teach git to change to a given directory using -C option
Date: Tue, 3 Sep 2013 19:59:47 +0800
Message-ID: <20130903115944.GA29542@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 13:59:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGpGb-0000WS-0W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 13:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776Ab3ICL7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 07:59:24 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40680 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642Ab3ICL7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 07:59:22 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so5892286pdj.16
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=a76NgL4fYk4G/6kVEsAC3ImGjwIWae3mpNS9EH0YwPA=;
        b=CHLX2rfLA4a4klvAqNTJJBmlK/jJKvTLpgF/3MEeW0Romp2PE/XD1+2QP64oY4MjMi
         L4iov7JHcLVYVN9iVaghEsfd/8hVs9kxaO7akXzLAqfbZ5D/NxdO9Zpz5W7nND2Zss5z
         4Nzm5W8d7YkXhE9n0vCENdjd8X4p6YsWYh/6x+gm7UqxzZsJA9Fj3Yv6DZ2am3DPQ/M/
         8oEC5gVSsk4ZmlxCoP+wzIgLHlW90HspYjFu2NvKq/HIAH7a2O+4oDX4SQ/MKT8Xb/o/
         EKXOOdXfY7Psm2wBVhoJWmJVh5bwN98pVhvTEZhyQUbfyXmzCbzH4brKHhadsKSDMZ3a
         D/+A==
X-Received: by 10.66.155.36 with SMTP id vt4mr31412423pab.93.1378209562077;
        Tue, 03 Sep 2013 04:59:22 -0700 (PDT)
Received: from gmail.com ([210.195.237.83])
        by mx.google.com with ESMTPSA id gg10sm6011510pbc.46.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 04:59:21 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233719>

On Tue, Sep 3, 2013 at 3:42 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> No wish to bike-shed, however, I find "effective directory" somewhat
> difficult to digest due to its jargony feel. It also seems ambiguous
> (to me) since "previous effective directory" may mean "directory when
> git was run" or "directory set by most recent -C". My earlier
> suggestion
>
>     When multiple -C options are given, each subsequent non-absolute
>     -C <path> is interpreted relative to the preceding -C <path>.
>
> avoided jargon and left no room for ambiguity.
>
> However, perhaps the examples are clear enough to make excessive prose
> explanation unnecessary, thus:
>
>     Run as if git was started in <path> instead of the current
>     working directory. Multiple -C options are allowed and acted upon
>     in the order given, thus "-C /usr -C src" is equivalent to "-C
>     /usr/src", and "-C src -C /usr" is equivalent to "C /usr". This
>     option affects ...

I did feel that the explanation is becoming wordy.  I'll take the former
as it is terser. I've split the part that explain the effects on other
options that take path argument into a separate paragraph.


> It's curious that this test uses a variable ($expected) to avoid
> repeating literal "initial in dir1/dir2", however, the previous test
> repeats its literal "initial in dir1". (IMHO, the repeated literal
> actually makes the test a bit easier to read, and it's not likely to
> be a maintenance burden.)

Fixed.


> It is suggested in t/README that, for Windows (MSYS bash)
> compatibility, you should use $(pwd) rather than $PWD.

Fixed.

Thanks for another round of review!

nazri
-- >8 --
Subject: [PATCH] Teach git to change to a given directory using -C option

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

With this new option, the above can be done with fewer keystrokes:

    1. git -C ~/foo status
    2. git -C ../.. grep foo
    3. for d in d1 d2 d3; do git -C $d svn rebase; done

A new test script is added to verify the behavior of this option with
other path-related options like --git-dir and --work-tree.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 Documentation/git.txt | 16 +++++++++-
 git.c                 | 15 ++++++++--
 t/t0056-git-C.sh      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 3 deletions(-)
 create mode 100755 t/t0056-git-C.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 83edf30..6105cb0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-c <name>=<value>]
+'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
@@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
+-C <path>::
+	Run as if git was started in <path> instead of the current working
+	directory.  When multiple -C options are given, each subsequent
+	non-absolute "-C <path>" is interpreted relative to the preceding "-C
+	<path>".
+
+	This option affects options that expect path name like --git-dir and
+	--work-tree in that their interpretations of the path names would be
+	made relative to the working directory caused by the -C option. For
+	example the following invocations are equivalent:
+
+	    git --git-dir=a.git --work-tree=b -C c status
+	    git --git-dir=c/a.git --work-tree=c/b status
+
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/git.c b/git.c
index 2025f77..52bce74 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 #include "commit.h"
 
 const char git_usage_string[] =
-	"git [--version] [--help] [-c name=value]\n"
+	"git [--version] [--help] [-C <path>] [-c name=value]\n"
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
index 0000000..c0006da
--- /dev/null
+++ b/t/t0056-git-C.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='"-C <path>" option and its effects on other path-related options'
+
+. ./test-lib.sh
+
+test_expect_success '"git -C <path>" runs git from the directory <path>' '
+	test_create_repo dir1 &&
+	echo 1 >dir1/a.txt &&
+	(cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
+	echo "initial in dir1" >expected &&
+	git -C dir1 log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
+	test_create_repo dir1/dir2 &&
+	echo 1 >dir1/dir2/a.txt &&
+	git -C dir1/dir2 add a.txt &&
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1/dir2 commit -m "initial in dir1/dir2" &&
+	git -C dir1 -C dir2 log --format=%s >actual &&
+	test_cmp expected actual
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
+	git --git-dir=c/a.git log -1 --format=%s >expected &&
+	git -C c --git-dir=a.git log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivalent to "-C c --git-dir=a.git"' '
+	git -C c --git-dir=a.git log -1 --format=%s >expected &&
+	git --git-dir=a.git -C c log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
+	rm c/a/a.txt &&
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c/a.git --work-tree=../a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
+	git -C c/a.git --work-tree=../a status >expected &&
+	git --work-tree=../a -C c/a.git status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir and --work-tree options - "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=c/a.git --work-tree=c/a"' '
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c --git-dir=a.git --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git -C c --work-tree=a"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git -C c --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git --work-tree=a -C c"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git --work-tree=a -C c status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Relative followed by fullpath: "-C ./here -C /there" is equivalent to "-C /there"' '
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1 -C "$(pwd)/dir1/dir2" log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4.22.g38647a4
