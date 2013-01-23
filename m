From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Tue, 22 Jan 2013 16:43:07 -0800
Message-ID: <CAJDDKr6exXh14m08HTihxREjSFgyPT0bN1cF8eUryXJHOgFL1A@mail.gmail.com>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 01:43:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxoRA-0007Gq-PU
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 01:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab3AWAnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 19:43:11 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:61385 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3AWAnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 19:43:09 -0500
Received: by mail-ea0-f169.google.com with SMTP id d13so3133654eaa.14
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=G8kAenfhdrK6NrBqEsd6HtfoZ+zkAioTzK5JTKjG73k=;
        b=oPsRSsmAZVlQqRnVZ+L6I/zyj1+8v8wUa9w0SBxpj15R6a1VcXTUbMDqyXhRg3+Kf0
         ZCCSLiuyG0Yj6M6TGarGk+E2YZe8BpurX1JCjmXgiuaIQM63GfY6rnAvZdTTkrvDPd32
         UEWvKaO6v4VRQjB+JprJdBDt2LCMxXOBMtCSZ9R1uVxDbaiFXuntRK05edIYnZwTxIam
         5gd8R04D249OZv7wtp8hxVJZ3ONqiklkkZHidVxCBCYYoueqEtJa/kZGdz4G9dbNGrA1
         X2XhaXJPeS+CLSwAEhhDAhnuDbiyy6LiPfKk5TaXNwKiNIrTR2As4eTlSL1qV8ZVi7Ve
         cKOw==
X-Received: by 10.14.219.72 with SMTP id l48mr78719873eep.37.1358901787396;
 Tue, 22 Jan 2013 16:43:07 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Tue, 22 Jan 2013 16:43:07 -0800 (PST)
In-Reply-To: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214267>

On Tue, Jan 22, 2013 at 1:10 PM, Lars Hjemli <hjemli@gmail.com> wrote:
> When working with multiple, unrelated (or loosly related) git repos,
> there is often a need to locate all repos with uncommitted work and
> perform some action on them (say, commit and push). Before this patch,
> such tasks would require manually visiting all repositories, running
> `git status` within each one and then decide what to do next.
>
> This mundane task can now be automated by e.g. `git all --dirty status`,
> which will find all git repositories below the current directory (even
> nested ones), check if they are dirty (as defined by `git diff --quiet &&
> git diff --cached --quiet`), and for each dirty repo print the path to the
> repo and then execute `git status` within the repo.
>
> The command also honours the option '--clean' which restricts the set of
> repos to those which '--dirty' would skip.
>
> Finally, the command to execute within each repo is optional. If none is
> given, git-all will just print the path to each repo found.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>  Documentation/git-all.txt |  37 ++++++++++++++++
>  Makefile                  |   1 +
>  builtin.h                 |   1 +
>  builtin/all.c             | 105 ++++++++++++++++++++++++++++++++++++++++++++++
>  command-list.txt          |   1 +
>  git.c                     |   1 +
>  t/t0064-all.sh            |  42 +++++++++++++++++++
>  7 files changed, 188 insertions(+)
>  create mode 100644 Documentation/git-all.txt
>  create mode 100644 builtin/all.c
>  create mode 100755 t/t0064-all.sh
>
> diff --git a/Documentation/git-all.txt b/Documentation/git-all.txt
> new file mode 100644
> index 0000000..b25f23c
> --- /dev/null
> +++ b/Documentation/git-all.txt
> @@ -0,0 +1,37 @@
> +git-all(1)
> +==========
> +
> +NAME
> +----
> +git-all - Execute a git command in multiple repositories
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git all' [--dirty|--clean] [command]
> +
> +DESCRIPTION
> +-----------
> +The git-all command is used to locate all git repositoris within the
> +current directory tree, and optionally execute a git command in each
> +of the found repos.
> +
> +OPTIONS
> +-------
> +-c::
> +--clean::
> +       Only include repositories with a clean worktree.
> +
> +-d::
> +--dirty::
> +       Only include repositories with a dirty worktree.
> +
> +NOTES
> +-----
> +
> +For the purpose of `git-all`, a dirty worktree is defined as a worktree
> +with uncommitted changes.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 1b30d7b..8bf0583 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -840,6 +840,7 @@ LIB_OBJS += xdiff-interface.o
>  LIB_OBJS += zlib.o
>
>  BUILTIN_OBJS += builtin/add.o
> +BUILTIN_OBJS += builtin/all.o
>  BUILTIN_OBJS += builtin/annotate.o
>  BUILTIN_OBJS += builtin/apply.o
>  BUILTIN_OBJS += builtin/archive.o
> diff --git a/builtin.h b/builtin.h
> index 7e7bbd6..438c265 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -41,6 +41,7 @@ void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
>  extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
>
>  extern int cmd_add(int argc, const char **argv, const char *prefix);
> +extern int cmd_all(int argc, const char **argv, const char *prefix);
>  extern int cmd_annotate(int argc, const char **argv, const char *prefix);
>  extern int cmd_apply(int argc, const char **argv, const char *prefix);
>  extern int cmd_archive(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/all.c b/builtin/all.c
> new file mode 100644
> index 0000000..ee9270d
> --- /dev/null
> +++ b/builtin/all.c
> @@ -0,0 +1,105 @@
> +/*
> + * "git all" builtin command.
> + *
> + * Copyright (c) 2013 Lars Hjemli <hjemli@gmail.com>
> + */
> +#include "cache.h"
> +#include "color.h"
> +#include "builtin.h"
> +#include "run-command.h"
> +#include "parse-options.h"
> +
> +static int only_dirty;
> +static int only_clean;
> +char root[PATH_MAX];
> +
> +static const char * const builtin_all_usage[] = {
> +       N_("git all [options] [cmd]"),
> +       NULL
> +};
> +
> +static struct option builtin_all_options[] = {
> +       OPT_BOOLEAN('c', "clean", &only_clean, N_("only show clean repositories")),
> +       OPT_BOOLEAN('d', "dirty", &only_dirty, N_("only show dirty repositories")),
> +       OPT_END(),
> +};
> +
> +static int is_dirty()
> +{
> +       const char *diffidx[] = {"diff", "--quiet", "--cached", NULL};
> +       const char *diffwd[] = {"diff", "--quiet", NULL};
> +
> +       if (run_command_v_opt(diffidx, RUN_GIT_CMD) != 0)
> +               return 1;
> +       if (run_command_v_opt(diffwd, RUN_GIT_CMD) != 0)
> +               return 1;
> +       return 0;
> +}
> +
> +static void handle_repo(char *path, const char **argv)
> +{
> +       int dirty;
> +
> +       if (path[0] == '.' && path[1] == '/')
> +               path += 2;
> +       if (only_dirty || only_clean) {
> +               dirty = is_dirty();
> +               if ((dirty && only_clean) ||
> +                    (!dirty && only_dirty))
> +                       return;
> +       }
> +       if (*argv) {
> +               color_fprintf_ln(stdout, GIT_COLOR_YELLOW, "[%s]", path);
> +               run_command_v_opt(argv, RUN_GIT_CMD);
> +       } else
> +               printf("%s\n", path);
> +}
> +
> +static int walk(struct strbuf *path, int argc, const char **argv)
> +{
> +       DIR *dir;
> +       struct dirent *ent;
> +       size_t len;
> +
> +       dir = opendir(path->buf);
> +       if (!dir)
> +               return errno;
> +       strbuf_addstr(path, "/");
> +       len = path->len;
> +       while ((ent = readdir(dir))) {
> +               if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
> +                       continue;
> +               if (!strcmp(ent->d_name, ".git")) {
> +                       strbuf_setlen(path, len - 1);
> +                       chdir(path->buf);
> +                       handle_repo(path->buf, argv);
> +                       chdir(root);
> +                       strbuf_addstr(path, "/");
> +                       continue;
> +               }

Does this section above properly handle .git files (where .git is a
file, not a directory)?  I wonder whether the check should be tighter,
e.g. something closer to what's done in setup.c:is_git_repository().

The name of this function leads me to believe that this walks
everything below the current directory looking for Git repos.  How
deep does it walk?  Does this handle nested repositories, e.g.
foo/bar/ and foo/bar/baz/ when you are inside foo/ ?  After re-reading
the documentation I am led to believe that it only walks one level
deep.

I did not notice a test for nested repos which is what sparked my
curiosity. ;-)  If we do not expect to handle them in the first
version then we should have a test to ensure the expected behavior.
It would also be nice to see a test with a .git file.

I do wonder what the end user experience is with this command when
used alongside other Git aggregate commands such as "repo" or "git
submodule".  This command is basically "git submodule foreach ..."
without needing to buy into the whole submodule thing.  This is an
argument for naming it something like "git foreach-repo" since it
would be named more closely to the "foreach" submodule command.

While "all" is less to type than "foreach-repo", most of the extra
work can be eliminated by installing the wonderful git completion
scripts for bash/zsh.

All that said, I have very real use cases for this command.  Thanks
for writing it.

> +               if (ent->d_type != DT_DIR)
> +                       continue;
> +               strbuf_setlen(path, len);
> +               strbuf_addstr(path, ent->d_name);
> +               walk(path, argc, argv);
> +       }
> +       closedir(dir);
> +       return 0;
> +}
> +
> +int cmd_all(int argc, const char **argv, const char *prefix)
> +{
> +       struct strbuf path = STRBUF_INIT;
> +
> +       if (!getcwd(root, sizeof(root)))
> +               return 1;
> +
> +       argc = parse_options(argc, argv, prefix, builtin_all_options,
> +                            builtin_all_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +       unsetenv(GIT_DIR_ENVIRONMENT);
> +       unsetenv(GIT_WORK_TREE_ENVIRONMENT);
> +
> +       strbuf_addstr(&path, ".");
> +       return walk(&path, argc, argv);
> +}
> diff --git a/command-list.txt b/command-list.txt
> index 7e8cfec..f955895 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,6 +1,7 @@
>  # List of known git commands.
>  # command name                         category [deprecated] [common]
>  git-add                                 mainporcelain common
> +git-all                                 mainporcelain
>  git-am                                  mainporcelain
>  git-annotate                            ancillaryinterrogators
>  git-apply                               plumbingmanipulators
> diff --git a/git.c b/git.c
> index ed66c66..53fd963 100644
> --- a/git.c
> +++ b/git.c
> @@ -304,6 +304,7 @@ static void handle_internal_command(int argc, const char **argv)
>         const char *cmd = argv[0];
>         static struct cmd_struct commands[] = {
>                 { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +               { "all", cmd_all },
>                 { "annotate", cmd_annotate, RUN_SETUP },
>                 { "apply", cmd_apply, RUN_SETUP_GENTLY },
>                 { "archive", cmd_archive },
> diff --git a/t/t0064-all.sh b/t/t0064-all.sh
> new file mode 100755
> index 0000000..932e374
> --- /dev/null
> +++ b/t/t0064-all.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2013 Lars Hjemli
> +#
> +
> +test_description='Test the git-all command'
> +
> +. ./test-lib.sh
> +
> +test_expect_success "setup" '
> +       test_create_repo clean &&
> +       (cd clean && test_commit foo) &&
> +       test_create_repo dirty-wt &&
> +       (cd dirty-wt && test_commit foo && rm foo.t) &&
> +       test_create_repo dirty-idx &&
> +       (cd dirty-idx && test_commit foo && git rm foo.t)
> +'
> +
> +test_expect_success "without flags, all repos are included" '
> +       echo "." >expect &&
> +       echo "clean" >>expect &&
> +       echo "dirty-idx" >>expect &&
> +       echo "dirty-wt" >>expect &&
> +       git all | sort >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success "--dirty only includes dirty repos" '
> +       echo "dirty-idx" >expect &&
> +       echo "dirty-wt" >>expect &&
> +       git all --dirty | sort >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success "--clean only includes clean repos" '
> +       echo "." >expect &&
> +       echo "clean" >>expect &&
> +       git all --clean | sort >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_done
> --
> 1.8.1.1.296.g725455c
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
David
