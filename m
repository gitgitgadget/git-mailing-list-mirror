From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] worktree: list operation
Date: Sun, 9 Aug 2015 03:45:43 -0400
Message-ID: <CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com>
References: <1439079599-87904-1-git-send-email-rappazzo@gmail.com>
	<1439079599-87904-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 09:45:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOLIi-0008F0-IY
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 09:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbbHIHpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 03:45:44 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33965 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbbHIHpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 03:45:43 -0400
Received: by ykdt205 with SMTP id t205so38025267ykd.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dvELE4D7C+HAbM80ClNsKF0msuhZwJpcI7im7SdjveQ=;
        b=RZ8vMChiJL/0f3xMd5OWVvocvsDaYf5FiYt4TPlFjAaUpHJpuFLTdqmEDnWmsGoIJ0
         cPVqIo1ENnMRSP+D99OoTeHzzsfAziquAISMC+qSiUL/Dimqx2Vq9H03B7RZMqKGUEXR
         gphCAaQCtB98OFTJR7XHnP4fKnZ59TycoK0RW9+nqyuKAXWDkOXPNnGe22O/mkZ5rLQi
         z1HlizKxvQN4Bqsv4/l5fiuscCTjFMt/fNukeHHASezWWaiXaTIQZ2ojd//84GQTgcjf
         JFa+JYWjSE9UITnNXriz8CwIyLfVxOElmoLysDGMONzgd5LwfcCI4yPz/Y4y6iaTvdap
         yZ6g==
X-Received: by 10.170.233.10 with SMTP id z10mr15577069ykf.71.1439106343176;
 Sun, 09 Aug 2015 00:45:43 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 9 Aug 2015 00:45:43 -0700 (PDT)
In-Reply-To: <1439079599-87904-2-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: KLHkzHMR1Task5ck5FXF-HgRdm8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275528>

Thanks for the patch. Comments below...

On Sat, Aug 8, 2015 at 8:19 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> worktree: list operation

Imperative mood:

    worktree: add 'list' command

> 'git worktree list' will list the main worktree followed by any linked
> worktrees which were created using 'git worktree add'.  The option
> '--main-only' will restrict the list to only the main worktree.

Missing sign-off.

> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 3387e2f..2b6b543 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -59,6 +60,10 @@ prune::
> +list::
> +
> +List the main worktree followed by all of the linked worktrees.
> +
>  OPTIONS
>  -------
> @@ -86,6 +91,9 @@ OPTIONS
> +--main-only::
> +       With `list`, only list the main worktree.

Considering that the main worktree is always listed first, I wonder
how much value the --main-only option has. That is (Windows aside),
the same can easily be achieved via:

    git worktree list | head -1

The more options we have, the more we have to document, test, and
support, so I'm feeling skeptical about --main-only since it can be
easily handled externally (for instance, via "head").

>  -v::
>  --verbose::
>         With `prune`, report all removals.
> @@ -36,7 +37,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>         fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
>         if (fd < 0) {
>                 strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
> -                           id, strerror(errno));
> +                       id, strerror(errno));

Unintended whitespace change here (and 7 places below)? The
indentation looks fine as-is, so I think you don't want to include
these changes.

>                 return 1;
>         }
>         len = st.st_size;
> @@ -316,6 +317,71 @@ static int add(int ac, const char **av, const char *prefix)
> +static int list(int ac, const char **av, const char *prefix)
> +{
> +       int main_only = 0;
> +       struct option options[] = {
> +               OPT_BOOL(0, "main-only", &main_only, N_("only list the main worktree")),
> +               OPT_END()
> +       };
> +
> +       ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> +       if (ac)
> +               usage_with_options(worktree_usage, options);
> +
> +       const char *work_tree;
> +       work_tree = get_git_work_tree();
> +       if (!work_tree)
> +               die("This operation must be run in a work tree");

Why this restriction? Other git-worktree operations support a bare
repository, so this one ought to also.

(In fact, when dealing with a bare repository, the "main worktree" is
really the bare repository, so the term "worktree" is a bit of a
misnomer.)

> +       struct strbuf worktree_git_path = STRBUF_INIT;
> +       strbuf_addf(&worktree_git_path, _("%s/.git"), work_tree);
> +
> +       struct strbuf main_work_tree = STRBUF_INIT;
> +       if (is_directory(worktree_git_path.buf)) {

This is probably not a valid test. Even in the main worktree, ".git"
may not be a directory; it could be a symref to the actual repository.

> +               /* This is the main tree */
> +               strbuf_addstr(&main_work_tree, work_tree);
> +       } else {
> +               const char *git_dir = get_git_dir();
> +               strbuf_addf(&main_work_tree, "%.*s", (int)(strstr(git_dir, "/.git/") - git_dir), git_dir);
> +       }
> +       printf("%s\n", main_work_tree.buf);

This can probably all be done more simply by taking a hint from the
code which tests if a branch is already checked out in the main or a
linked worktree. For the main worktree, it just uses
get_git_common_dir() and strips the trailing ".git" and prints that.
For instance:

    strbuf_addstr(&sb, get_git_common_dir());
    strbuf_strip_suffix(&sb, ".git");
    printf(...);

should probably suffice in place of all the above code.

> +       if (!main_only) {
> +               chdir( main_work_tree.buf );

Style: Drop spaces inside parentheses.

I realize that the program exits after printing the list of worktrees,
but this chdir() makes me uncomfortable, partly because it's not
necessary, and partly because it could negatively impact code which
someone later adds to extend "list", if that new code expects the
current working directory to be the top of the worktree (as most git
code assumes).

> +               if ( is_directory(git_path("worktrees")) ) {
> +                       DIR *dir = opendir( git_path("worktrees") );

Style: Drop spaces inside parentheses (both lines).

The opendir() will fail if the directory doesn't exist anyhow, so the
'if (is_directory(...))' is superfluous and can be dropped altogether.

Taking a hint from the code which tests if a branch is already checked
out elsewhere:

    strbuf_addf(&sb, "%s/worktrees", get_git_common_dir());
    dir = opendir(sb.buf);

> +                       if (dir != NULL) {

Style: if (dir) {

> +                               struct dirent *d;
> +                               struct stat st;
> +                               char *path;
> +                               int fd, len;
> +                               while ((d = readdir(dir)) != NULL) {
> +                                       if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +                                               continue;

This is at least the third bit of functionality which needs to iterate
over the linked worktrees and glean information about them. As such,
it would make sense to factor out that logic so that it can be
re-used, as one or more preparatory patches if you feel so inclined
(though is not a requirement by any means).

> +                                       if (stat(git_path("worktrees/%s/gitdir", d->d_name), &st))
> +                                               continue;
> +                                       fd = open(git_path("worktrees/%s/gitdir", d->d_name), O_RDONLY);
> +                                       if (fd < 0)
> +                                               continue;
> +
> +                                       len = st.st_size;
> +                                       path = xmalloc(len + 1);
> +                                       read_in_full(fd, path, len);
> +                                       close(fd);

I realize that this code was pretty much copied from elsewhere in
worktree.c, but it could be simplified considerably by taking
advantage of strbuf_read_file() to slurp the entire file into a
strbuf, thus allowing you to drop the stat(), open(), xmalloc(),
read_in_full(), and close() calls:

    if (strbuf_read_file(&sb, "whatever/.../gitdir", 0) < 0)
        continue;
     strbuf_rtrim(&sb);
     strbuf_strip_suffix(&sb, ".git");

> +                                       printf("%.*s\n", (int)(strstr(path, "/.git") - path), path);

For git-worktree commands such as "lock", "mv", "remove", it likely
will be nice to allow people to specify the linked worktree not only
by path, but also by tag, and possibly even by $(basename $path) if
not ambiguous. Therefore, to support such usage, at minimum, I think
you also want to show the worktree's tag (d->d_name) in addition to
the path.

Other information which would be nice to display for each worktree
(possibly controlled by a --verbose flag):

   * the checked out branch or detached head
   * whether it is locked
        - the lock reason (if available)
        - and whether the worktree is currently accessible
    * whether it can be pruned
        - and the prune reason if so

The prune reason could be obtained by factoring out the
reason-determination code from worktree.c:prune_worktree() to make it
re-usable.

For scripters, a --porcelain option might be useful.

None of this additional functionality is an immediate requirement, and
wouldn't belong in this patch anyhow, but can be added via follow-up
patches (if you or someone else is interested in the task).

> +                                       free(path);
> +                               }
> +                       }
> +                       closedir(dir);
> +               }
> +       }
> +       strbuf_release(&main_work_tree);
> +       strbuf_release(&worktree_git_path);
> +       return 0;
> +}
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> new file mode 100755
> index 0000000..998b34f
> --- /dev/null
> +++ b/t/t2027-worktree-list.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +
> +test_description='test git worktree list'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       test_commit init
> +'
> +
> +

Drop the extra blank line.

> +test_expect_success '"list" all worktrees from main' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               git rev-parse --show-toplevel >>"$orig_path/expect" &&
> +               cd "$orig_path" &&

The normal and automatic way to return to the original directory is
simply to end the subshell; that is, have the closing ')' at this
point. No need for 'orig_path'.

In fact, in this case, you don't even need a subshell at all because,
these days, you don't need to 'cd here'. Instead, take advantage of
-C:

    git -C here rev-parse --show-toplevel >>expect &&

> +               git worktree list >actual &&
> +               test_cmp expect actual &&
> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +test_expect_success '"list" all worktrees from linked' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               git rev-parse --show-toplevel >>"$orig_path/expect" &&
> +               git worktree list >actual &&
> +               test_cmp "$orig_path/expect" actual &&
> +               cd "$orig_path" &&

Ditto. Just end the subshell to return to the original directory. Or,
better, ditch the subshell entirely and use -C:

    git rev-parse -C here --show-toplevel >>expect &&
    git -C here worktree list >actual &&

> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +
> +test_expect_success '"list" main worktree from main' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               cd "$orig_path" &&
> +               git worktree list --main-only >actual &&
> +               test_cmp expect actual &&
> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +test_expect_success '"list" main worktree from linked' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               git worktree list --main-only >actual &&
> +               test_cmp "$orig_path/expect" actual &&
> +               cd "$orig_path" &&
> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +
> +test_done
> --
> 2.5.0
