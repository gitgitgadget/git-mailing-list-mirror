From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Sun, 27 Jan 2013 11:04:08 -0800
Message-ID: <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzXWv-0002nX-1T
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab3A0TEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:04:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754890Ab3A0TEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 14:04:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AC64B7DB;
	Sun, 27 Jan 2013 14:04:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=spDZrHn3auWv4nU6Bw0HX8CHtlU=; b=SKi7v1
	UOsD/x9HkRA2wtGfxb9kNbDkQoXL4JOpLRxcOt/VjPygDOKoLAxOUyDxbGLqhj0N
	BLV66IiJrkE+6Azxn72ZjXGgKdskEMeD+gb5Mc/6VUZpAUIJ/0nvkb6PWJ1x6JTI
	orufJGm+uP8drmxlBQAEmsI4H07pBRPJbZ/fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=abrwct2HCPF48WWigtQA2BtvogGCQQcz
	FvemtOKy4qp+NAJSRw/wm/xfZlCWlzxS9dCqwwkkIef8XNgX90foO29PGyY2flbM
	hBu50/rqL8bs1Kw+jD352M10J6hwJH2qO+uJEMeIxsRu392i0cfzMSqqnKpPKly7
	ne+wV+W02Jk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCF40B7D6;
	Sun, 27 Jan 2013 14:04:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B82D3B7C8; Sun, 27 Jan 2013
 14:04:10 -0500 (EST)
In-Reply-To: <1359290777-5483-2-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Sun, 27 Jan 2013 13:46:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 553757E8-68B4-11E2-AD0D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214715>

Lars Hjemli <hjemli@gmail.com> writes:

> When working with multiple, unrelated (or loosly related) git repos,
> there is often a need to locate all repos with uncommitted work and
> perform some action on them (say, commit and push). Before this patch,
> such tasks would require manually visiting all repositories, running
> `git status` within each one and then decide what to do next.
>
> This mundane task can now be automated by e.g. `git for-each-repo --dirty
> status`, which will find all non-bare git repositories below the current
> directory (even nested ones), check if they are dirty (as defined by
> `git diff --quiet && git diff --cached --quiet`), and for each dirty repo
> print the path to the repo and then execute `git status` within the repo.
>
> The command also honours the option '--clean' which restricts the set of
> repos to those which '--dirty' would skip, and '-x' which is used to
> execute non-git commands.

It might make sense to internally use RUN_GIT_CMD flag when the
first word of the command line is 'git' as an optimization, but 
I am not sure it is a good idea to force the end users to think
when to use -x and when not to is a good idea.

In other words, I think

     git for-each-repo -d diff --name-only
     git for-each-repo -d -x ls '*.c'

is less nice than letting the user say

     git for-each-repo -d git diff --name-only
     git for-each-repo -d ls '*.c'

> Finally, the command to execute within each repo is optional. If none is
> given, git-for-each-repo will just print the path to each repo found. And
> since the command supports -z, this can be used for more advanced scripting
> needs.

It amounts to the same thing, but I would rather describe it as:

    To allow scripts to handle paths with shell-unsafe characters,
    support "-z" to show paths with NUL termination.  Otherwise,
    such paths are shown with the usual c-quoting.

One more thing that nobody brought up during the previous reviews is
if we want to support subset of repositories by allowing the
standard pathspec match mechanism.  For example,

	git for-each-repo -d git diff --name-only -- foo/ bar/b\*z

might be a way to ask "please find repositories match the given
pathspecs (i.e. foo/ bar/b\*z) and run the command in the ones that
are dirty".  We would need to think about how to mark the end of the
command though---we could borrow \; from find(1), even though find
is not the best example of the UI design.  I.e.

	git for-each-repo -d git diff --name-only \; [--] foo/ bar/b\*z

with or without "--".

> diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
> new file mode 100644
> index 0000000..fb12b3f
> --- /dev/null
> +++ b/Documentation/git-for-each-repo.txt
> @@ -0,0 +1,71 @@
> +git-for-each-repo(1)
> +====================
> +
> +NAME
> +----
> +git-for-each-repo - Execute a git command in multiple non-bare repositories

There is a separate topic in flight that turns s/git/Git/ when we
refer to the system as a whole.  In any case, this is no longer
limited to "execute a Git command".

	Find non-bare Git repositories in subdirectories

or

	Find or execute a command in non-bare Git repositories in subdirectories


perhaps?

> +SYNOPSIS
> +--------
> +[verse]
> +'git for-each-repo' [-acdxz] [command]
> +
> +DESCRIPTION
> +-----------
> +The git-for-each-repo command is used to locate all non-bare git

Should be sufficient to say s/is used to locate/locates/.

> +repositories within the current directory tree, and optionally
> +execute a git command in each of the found repos.

s/a git command/a command/;

> +OPTIONS
> +-------
> ...
> +-x::
> +	Execute a genric (non-git) command in each repo.

Drop this option.

> +NOTES
> +-----
> +
> +For the purpose of `git-for-each-repo`, a dirty worktree is defined as a
> +worktree with uncommitted changes.

Is it a definition that is different from usual?  If so why does it
need to be inconsistent with the rest of the system?

> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> new file mode 100644
> index 0000000..9333ae0
> --- /dev/null
> +++ b/builtin/for-each-repo.c
> @@ -0,0 +1,145 @@
> +/*
> + * "git for-each-repo" builtin command.
> + *
> + * Copyright (c) 2013 Lars Hjemli <hjemli@gmail.com>
> + */
> +#include "cache.h"
> +#include "color.h"
> +#include "quote.h"
> +#include "builtin.h"
> +#include "run-command.h"
> +#include "parse-options.h"
> +
> +#define ALL 0
> +#define DIRTY 1
> +#define CLEAN 2
> +
> +static char *color = GIT_COLOR_NORMAL;
> +static int eol = '\n';
> +static int match;
> +static int runopt = RUN_GIT_CMD;
> +
> +static const char * const builtin_foreachrepo_usage[] = {
> +	N_("git for-each-repo [-acdxz] [cmd]"),
> +	NULL
> +};
> +
> +static struct option builtin_foreachrepo_options[] = {
> +	OPT_SET_INT('a', "all", &match, N_("match both clean and dirty repositories"), ALL),
> +	OPT_SET_INT('c', "clean", &match, N_("only show clean repositories"), CLEAN),
> +	OPT_SET_INT('d', "dirty", &match, N_("only show dirty repositories"), DIRTY),
> +	OPT_SET_INT('x', NULL, &runopt, N_("execute generic (non-git) command"), 0),
> +	OPT_SET_INT('z', NULL, &eol, N_("terminate each repo path with NUL character"), 0),
> +	OPT_END(),
> +};
> +
> +static int get_repo_state(const char *dir)
> +{
> +	const char *diffidx[] = {"diff", "--quiet", "--cached", NULL};
> +	const char *diffwd[] = {"diff", "--quiet", NULL};
> +
> +	if (run_command_v_opt_cd_env(diffidx, RUN_GIT_CMD, dir, NULL) != 0)
> +		return DIRTY;
> +	if (run_command_v_opt_cd_env(diffwd, RUN_GIT_CMD, dir, NULL) != 0)
> +		return DIRTY;
> +	return CLEAN;
> +}
> +
> +static void print_repo_path(const char *path, unsigned pretty)
> +{
> +	if (path[0] == '.' && path[1] == '/')
> +		path += 2;
> +	if (pretty)
> +		color_fprintf_ln(stdout, color, "[%s]", path);

This is shown before running a command in that repository.  I am of
two minds.  It certainly is nice to be able to tell which repository
each block of output lines comes from, and not requiring the command
to do this themselves is a good default.  However, I wonder if people
would want to do something like this:

	git for-each-repo sh -c '
		git diff --name-only |
		sed -e "s|^|$path/|"
        '

to get a consolidated view, in a way similar to how "submodule
foreach" can be used.  This unconditional output will get in the way
for such a use case.

Oh, that reminds me of another thing.  Perhaps we would want to
export the (relative) path to the found repository in some way to
allow the commands to do this kind of thing in the first place?
"submodule foreach" does this with $path, I think.

> +	else
> +		write_name_quoted(path, stdout, eol);
> +}

Nice.  Doubly nice that you do not hardcode "color" at this point
but made it into a separate variable.

> +static void handle_repo(struct strbuf *path, const char **argv)
> +{
> +	const char *gitdir;
> +	int len;
> +
> +	len = path->len;
> +	strbuf_addstr(path, ".git");
> +	gitdir = resolve_gitdir(path->buf);
> +	strbuf_setlen(path, len - 1);
> +	if (!gitdir)
> +		goto done;
> +	if (match != ALL && match != get_repo_state(path->buf))
> +		goto done;
> +	print_repo_path(path->buf, *argv != NULL);
> +	if (*argv)
> +		run_command_v_opt_cd_env(argv, runopt, path->buf, NULL);
> +done:
> +	strbuf_addstr(path, "/");

OK, you get "$D/" from the caller, make it "$D/.git" to call
resolve_gitdir() with, turn it to "$D" before printing and runnning,
and then add "/" back.  Slightly tricky but correct.

> +static int walk(struct strbuf *path, int argc, const char **argv)
> +{
> +	DIR *dir;
> +	struct dirent *ent;
> +	struct stat st;
> +	size_t len;
> +	int has_dotgit = 0;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +
> +	dir = opendir(path->buf);
> +	if (!dir)
> +		return errno;
> +	strbuf_addstr(path, "/");
> +	len = path->len;
> +	while ((ent = readdir(dir))) {
> +		if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
> +			continue;
> +		if (!strcmp(ent->d_name, ".git")) {
> +			has_dotgit = 1;
> +			continue;
> +		}
> +		switch (DTYPE(ent)) {
> +		case DT_UNKNOWN:
> +		case DT_LNK:
> +			/* Use stat() to figure out if this path leads
> +			 * to a directory - it's  not important if it's
> +			 * a symlink which gets us there.
> +			 */
> +			strbuf_setlen(path, len);
> +			strbuf_addstr(path, ent->d_name);
> +			if (stat(path->buf, &st) || !S_ISDIR(st.st_mode))
> +				break;
> +			/* fallthrough */
> +		case DT_DIR:
> +			string_list_append(&list, ent->d_name);
> +			break;
> +		}
> +	}
> +	closedir(dir);
> +	strbuf_setlen(path, len);
> +	if (has_dotgit)
> +		handle_repo(path, argv);
> +	sort_string_list(&list);
> +	for_each_string_list_item(item, &list) {
> +		strbuf_setlen(path, len);
> +		strbuf_addstr(path, item->string);
> +		walk(path, argc, argv);
> +	}
> +	string_list_clear(&list, 0);
> +	return 0;
> +}

Is the "collect-first-and-then-sort" done so that the repositories
are shown in a stable order regardless of the order in which
readdir() returns he entries?  I am not complaining, but being
curious.

> diff --git a/t/t6400-for-each-repo.sh b/t/t6400-for-each-repo.sh

This command does not look like "6 - the revision tree commands" to
me. "7 - the porcelainish commands concerning the working tree" or
"9 - the git tools" may be a better match?

> new file mode 100755
> index 0000000..af02c0c
> --- /dev/null
> +++ b/t/t6400-for-each-repo.sh
> @@ -0,0 +1,150 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2013 Lars Hjemli
> +#
> +
> +test_description='Test the git-for-each-repo command'
> +
> +. ./test-lib.sh
> +
> +qname="with\"quote"
> +qqname="\"with\\\"quote\""

If Windows does not have problems with paths with dq in it, then
this is fine, but I dunno.  Otherwise, you may want to exclude the
c-quote testing from the main part of the test, and have a single
test that has prerequisite for filesystems that can do this at the
end of the script.

> +test_expect_success "setup" '
> +	test_create_repo clean &&
> +	(cd clean && test_commit foo1) &&
> +	git init --separate-git-dir=.cleansub clean/gitfile &&
> +	(cd clean/gitfile && test_commit foo2 && echo bar >>foo2.t) &&
> +	test_create_repo dirty-idx &&
> +	(cd dirty-idx && test_commit foo3 && git rm foo3.t) &&
> +	test_create_repo dirty-wt &&
> +	(cd dirty-wt && mv .git .linkedgit && ln -s .linkedgit .git &&

Some platforms are symlink-challenged.  Can we do this test without
"ln -s"?  SYMLINKS prereq wouldn't be very useful for the setup
step, as all the remaining tests won't work without setting up the
test scenario.

> +	  test_commit foo4 && rm foo4.t) &&
> +	test_create_repo "$qname" &&
> +	(cd "$qname" && test_commit foo5) &&
> +	mkdir fakedir && mkdir fakedir/.git
> +'
> +
> +test_expect_success "without filtering, all repos are included" '
> +	echo "." >expect &&
> +	echo "clean" >>expect &&
> +	echo "clean/gitfile" >>expect &&
> +	echo "dirty-idx" >>expect &&
> +	echo "dirty-wt" >>expect &&
> +	echo "$qqname" >>expect &&

A single

	cat >expect <<-EOF
        .
        clean
        clean/gitfile
        ...
	$qqname
	EOF

may be a lot easier to read (likewise for all the "expect"
preparation in the rest of the script).

> +test_expect_success "-z NUL-terminates each path" '
> +	echo "(.)" >expect &&
> +	echo "(clean)" >>expect &&
> +	echo "(clean/gitfile)" >>expect &&
> +	echo "(dirty-idx)" >>expect &&
> +	echo "(dirty-wt)" >>expect &&
> +	echo "($qname)" >>expect &&
> +	git for-each-repo -z | xargs -0 printf "(%s)\n"  >actual &&

This needs prereq on "xargs -0", but because we know we do not have
any string with Q in it in the expected list of repositories, it may
be simpler to do something like this:

	echo ".QcleanQclean/gitfileQ...$qname" >expect &&
	git for-each-repo -z | tr "\0" Q >actual &&
	test_cmp expect actual

Thanks.
