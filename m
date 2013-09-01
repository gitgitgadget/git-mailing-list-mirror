From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Teach git to change to a given directory using -C option
Date: Sun, 1 Sep 2013 00:48:23 -0400
Message-ID: <CAPig+cSMZ+uBe=SiTpbfy1kBYRBh60uWZVv5cJhi7tkHMqeTDw@mail.gmail.com>
References: <1377869719-5942-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 06:48:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFzaQ-0002Q7-1Z
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 06:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab3IAEs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 00:48:26 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:35201 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab3IAEsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 00:48:25 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so2621780lab.22
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QuMFxJPy1yTsvdeH9UVJddbu84HYjvSwnrH7gvPNnXg=;
        b=L0OqbwRzaogw2aWyIxSq+XQoy3RrCMlk5f1ePwYQVpU7tiqmTqvYLEkx+c505tck1c
         C2TV0U2hYfnM7GBVrW+zzU1MQHckgiuJKtrCGpclrGm/IzOSUHVDIsDJaqTSz4YRZJbQ
         4PCNMwQl4ieKIaxptv+do83BmDPdQvTHdyRqXq9zRY6EsnWh7s4uIFyrPztp4HpEAKZK
         ve4m1klrsZsvJEBNJUqv1zb8JilbH7+BFptkPGuw9zgbwsmaQMjsEqix+dfIiTpZhDjZ
         yRk15dA/eyVnicLr2XlU2ztfDrathuefX1lE5xMxKl/h+KLfRp8ncD6aFII5ONNgyi8H
         6O4Q==
X-Received: by 10.152.115.176 with SMTP id jp16mr15203451lab.17.1378010903414;
 Sat, 31 Aug 2013 21:48:23 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sat, 31 Aug 2013 21:48:23 -0700 (PDT)
In-Reply-To: <1377869719-5942-1-git-send-email-ayiehere@gmail.com>
X-Google-Sender-Auth: t3ShqAXL48H1sv0G-x9TnTt6OW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233564>

On Fri, Aug 30, 2013 at 9:35 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".
>
> Currently it takes more effort (keypresses) to invoke git command in a
> different directory than the current one without leaving the current
> directory:
>
>     1. (cd ~/foo && git status)
>        git --git-dir=~/foo/.git --work-dir=~/foo status
>        GIT_DIR=~/foo/.git GIT_WORK_TREE=~/foo git status
>     2. (cd ../..; git grep foo)
>     3. for d in d1 d2 d3; do (cd $d && git svn rebase); done
>
> While doable the methods shown above are arguably more suitable for
> scripting than quick command line invocations.
>
> With this new option, the above can be done with less keystrokes:

Grammar: s/less/fewer/

More below...

>     1. git -C ~/foo status
>     2. git -C ../.. grep foo
>     3. for d in d1 d2 d3; do git -C $d svn rebase; done
>
> A new test script is added to verify the behavior of this option with
> other path-related options like --git-dir and --work-tree.
>
> Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
> ---
> This is a reroll of [1]. The only difference is the rewording of the
> commit message.  I'm resending this as I've found it to be useful in my
> daily git usage in that it helps me stay focused on what I'm doing in
> the current directory while needing to run git on another directory.
>
> nazri.
>
> [1] http://permalink.gmane.org/gmane.comp.version-control.git/221954
>
>  Documentation/git.txt | 13 +++++++++
>  git.c                 | 15 ++++++++--
>  t/t0056-git-C.sh      | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+), 2 deletions(-)
>  create mode 100755 t/t0056-git-C.sh
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index dca11cc..0d44fa2 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -395,6 +395,19 @@ displayed. See linkgit:git-help[1] for more information,
>  because `git --help ...` is converted internally into `git
>  help ...`.
>
> +-C <directory>::

The synopsis at the top of git.txt mentions --git-dir and --work-tree.
For consistency, -C probably ought to be mentioned there, as well.

Other options which accept a directory, such as --git-dir and
--work-tree, are documented as accepting <path>, but -C is
inconsistently documented as accepting <directory>.

> +       Run as if git were started in <directory> instead of the current
> +       working directory. If multiple -C options are given, subsequent
> +       directory arguments are interpreted relative to the previous one: -C
> +       /usr -C src is equivalent to -C /usr/src. This option affects options

The fragment "interpreted relative" seems ambiguous when absolute
paths are involved. For instance, what happens when the user specifies
"-C /foo/ -C /bar/". From the implementation I can see that the
working directory becomes /bar, but without checking the
implementation, it's not clear what the result would be. For instance,
if the implementation merely did string concatenation of the -C
arguments, then input "-C /foo/ -C /bar/" might try to set the working
directory to "/foo//bar/" which would be interpreted as "/foo/bar/" on
Unix, but would probably fail on Windows. Perhaps rewriting might
remove the ambiguity?

    [...] When multiple -C options are given, each subsequent non-absolute
    -C <path> is interpreted relative to the preceding -C <path>. [...]

> +       that expect path name like --git-dir and --work-tree in that their
> +       interpretations of the path names would be made relative to the
> +       effective working directory caused by the -C option. For example the
> +       following invocations are equivalent:
> +
> +           git --git-dir=a.git --work-tree=b -C c status
> +           git --git-dir=c/a.git --work-tree=c/b status
> +
>  -c <name>=<value>::
>         Pass a configuration parameter to the command. The value
>         given will override values from configuration files.
> diff --git a/git.c b/git.c
> index 2025f77..2207ee5 100644
> --- a/git.c
> +++ b/git.c
> @@ -7,7 +7,7 @@
>  #include "commit.h"
>
>  const char git_usage_string[] =
> -       "git [--version] [--help] [-c name=value]\n"
> +       "git [--version] [--help] [-C directory] [-c name=value]\n"
>         "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
>         "           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
>         "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"

For existing options accepting an argument, the argument is formatted
as <argument>. The -C option does not follow suit.

As mentioned above, all other options accepting a directory are
documented as taking <path>, but -C is inconsistent and is documented
as taking 'directory' instead.

> @@ -54,7 +54,18 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>                 /*
>                  * Check remaining flags.
>                  */
> -               if (!prefixcmp(cmd, "--exec-path")) {
> +               if (!strcmp(cmd, "-C")) {
> +                       if (*argc < 2) {
> +                               fprintf(stderr, "No directory given for -C.\n" );
> +                               usage(git_usage_string);
> +                       }
> +                       if (chdir((*argv)[1]))
> +                               die_errno("Cannot change to '%s'", (*argv)[1]);
> +                       if (envchanged)
> +                               *envchanged = 1;
> +                       (*argv)++;
> +                       (*argc)--;
> +               } else if (!prefixcmp(cmd, "--exec-path")) {
>                         cmd += 11;
>                         if (*cmd == '=')
>                                 git_set_argv_exec_path(cmd + 1);
> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> new file mode 100755
> index 0000000..370eae6
> --- /dev/null
> +++ b/t/t0056-git-C.sh
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +
> +test_description='"-C <directory>" option and it effects on other path-related options'

s/it/its/
s/<directory>/<path>/

> +
> +. ./test-lib.sh
> +
> +test_expect_success '"git -C <dir>" runs git from the directory <dir>' '

s/<dir>/<path>/g

> +       test_create_repo dir1 &&
> +       echo 1 >dir1/a.txt &&
> +       (cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
> +       expected="initial in dir1" &&
> +       actual=$(git -C dir1 log --format=%s) &&
> +       test "$expected" = "$actual"
> +'

Modern git tests tend to place the expected and actual outputs in
files and then use test_cmp to verify that they are identical. For
instance:

    echo "initial in dir1" >expected &&
    git -C dir1 log --format="%s" >actual &&
    test_cmp expected actual

The benefit of doing so is that test_cmp will print the difference
between the expected and actual values when they differ, which
facilitates debugging a failed test.

> +test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
> +       test_create_repo dir1/dir2 &&
> +       echo 1 >dir1/dir2/a.txt &&
> +       git -C dir1/dir2 add a.txt &&
> +       expected="initial in dir1/dir2" &&
> +       git -C dir1/dir2 commit -m "$expected" &&
> +       actual=$(git -C dir1 -C dir2 log --format=%s) &&
> +       test "$expected" = "$actual"
> +'

It would make sense also to test multiple -C options with combinations
of absolute and and relative paths.

> +test_expect_success 'Effect on --git-dir option: "-C c --git-dir=a.git" is equivalent to "--git-dir c/a.git"' '
> +       mkdir c &&
> +       mkdir c/a &&
> +       mkdir c/a.git &&
> +       (cd c/a.git && git init --bare) &&
> +       echo 1 >c/a/a.txt &&
> +       git --git-dir c/a.git --work-tree=c/a add a.txt &&
> +       git --git-dir c/a.git --work-tree=c/a commit -m "initial" &&
> +       expected="$(git --git-dir=c/a.git log -1 --format=%s)" &&
> +       actual=$(git -C c --git-dir=a.git log -1 --format=%s) &&
> +       test "$expected" = "$actual"
> +'
> +
> +test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivalent to "-C c --git-dir=a.git"' '
> +       expected="$(git -C c --git-dir=a.git log -1 --format=%s)" &&
> +       actual=$(git --git-dir=a.git -C c log -1 --format=%s) &&
> +       test "$expected" = "$actual"
> +'
> +
> +test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
> +       rm c/a/a.txt &&
> +       expected="$(git --git-dir=c/a.git --work-tree=c/a status)" &&
> +       actual="$(git -C c/a.git --work-tree=../a status)" &&
> +       test "$expected" = "$actual"
> +'
> +
> +test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
> +       expected="$(git -C c/a.git --work-tree=../a status)" &&
> +       actual="$(git --work-tree=../a -C c/a.git status)" &&
> +       test "$expected" = "$actual"
> +'
> +
> +test_expect_success 'Effect on --git-dir and --work-tree options - "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=c/a.git --work-tree=c/a"' '
> +       expected="$(git --git-dir=c/a.git --work-tree=c/a status)" &&
> +       actual="$(git -C c --git-dir=a.git --work-tree=a status)" &&
> +       test "$expected" = "$actual"
> +'
> +
> +test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git -C c --work-tree=a"' '
> +       expected="$(git -C c --git-dir=a.git --work-tree=a status)" &&
> +       actual="$(git --git-dir=a.git -C c --work-tree=a status)" &&
> +       test "$expected" = "$actual"
> +'
> +
> +test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git --work-tree=a -C c"' '
> +       expected="$(git -C c --git-dir=a.git --work-tree=a status)" &&
> +       actual="$(git --git-dir=a.git --work-tree=a -C c status)" &&
> +       test "$expected" = "$actual"
> +'
> +
> +test_done
> --
> 1.8.4.1.g098df5a
