From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 3/3] worktree: add 'list' command
Date: Sun, 13 Sep 2015 00:25:29 -0400
Message-ID: <CAPig+cSfduAgj7WP2JmqecVbQMRoZu+9O0f9vPSF1ee8h=1LmA@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-4-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	karthik nayak <karthik.188@gmail.com>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 06:25:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZayrV-00008H-6P
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 06:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbbIMEZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 00:25:31 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36677 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbIMEZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 00:25:30 -0400
Received: by ykdt18 with SMTP id t18so105995721ykd.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=C0B51dUkkeju5sbXCB2ft8gKTPOUq1MyluI6o16c9U4=;
        b=Drk9vVigWBjkY9lPujA4nXmqxoP+7cRInwRne8FYfs+KEU21yb9+m+enjG9eRZ/M1q
         HRagnhxcXeio0NKAX3+9nNIiJCjUgyApMstVDwBjszbA1YeSTvLQK1sTK4qHrb5breww
         jdsfyocxi2aprCgN3ykPpafR6a8yEukiyuhUcZcna3DLJO/kYh29boWA2+A8zcrM+g9+
         sV3iBPKKiKnkHcexM0gO+SbixxsWW0fno/jwp2neNdGODXbPlAIP8t/K4PaN2h5e5pGV
         UWa0Fy3UsUYddVt6QENnQbzCvhDYUPcH9/CrJFPKcV3uXnLgPoUh3AmKiTir1SfsdCpp
         wZsg==
X-Received: by 10.170.158.10 with SMTP id z10mr6884657ykc.71.1442118329312;
 Sat, 12 Sep 2015 21:25:29 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sat, 12 Sep 2015 21:25:29 -0700 (PDT)
In-Reply-To: <1441402769-35897-4-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: vR7chGy872Th4eLuEkBtQRrWdHk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277756>

On Fri, Sep 4, 2015 at 5:39 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> 'git worktree list' iterates through the worktree list, and outputs
> the worktree dir.  By default, only the worktree path is output.

Comments below in addition to Junio's...

> Supported options include:
>         --skip-bare: do not output bare worktrees
>         --verbose: include the current head and ref (if applicable), also
>                 decorate bare worktrees

I don't care strongly at this point, but an alternate, (possibly) more
reviewer-friendly, approach would be to split this into several
patches: the first would add a bare-bones "list" command, and each
subsequent patch would flesh it out by introducing one option and/or
enhancing the output in some way.

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index fb68156..b9339ed 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
>  'git worktree prune' [-n] [-v] [--expire <expire>]
> +'git worktree list' [-v] [--skip-bare]

I'm somewhat skeptical of the --skip-bare option. Recalling my v2
review[1] skepticism of the --main-only option:

    The more options we have, the more we have to document, test, and
    support...

Thus, I wonder how much value this option has. Presumably, for
scripters, we will want to have a --porcelain option, the output of
which will contain useful information about a worktree, including
whether it's bare, and a script can, on its own, easily filter out a
bare worktree if desired.

[1]: http://article.gmane.org/gmane.comp.version-control.git/275528

>  DESCRIPTION
>  -----------
> @@ -59,6 +60,10 @@ prune::
>
>  Prune working tree information in $GIT_DIR/worktrees.
>
> +list::
> +
> +List the main worktree followed by each of the linked worktrees.
> +
>  OPTIONS
>  -------
>
> @@ -89,10 +94,14 @@ OPTIONS
>  -v::
>  --verbose::
>         With `prune`, report all removals.
> +       With `list`, show more information about each worktree.  This includes
> +       if the worktree is bare, the revision currently checked out, and the
> +       branch currently checked out (or 'detached HEAD' if none).

Hmm, this prints both the SHA1 and the branch name (or literal string
"detached HEAD")? Is that a good use of screen real-estate? In
particular, I'm wondering how useful the SHA1 is to the user when not
detached. I would expect (perhaps wrongly) that it would be sufficient
to output either the branch name *or* the SHA1 (which implies
"detached" without having to say so literally).

>  --expire <time>::
>         With `prune`, only expire unused working trees older than <time>.

Documentation for --skip-bare (and --no-skip-bare) seems to be missing.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 71bb770..a0c0fe8 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -359,6 +362,64 @@ static int add(int ac, const char **av, const char *prefix)
> +static int list(int ac, const char **av, const char *prefix)
> +{
> +       int no_bare = 0;
> +
> +       struct option options[] = {
> +               OPT_BOOL(0, "skip-bare", &no_bare,  N_("exclude bare worktrees from the list")),
> +               OPT__VERBOSE(&verbose, N_("include more worktree details")),
> +               OPT_END()
> +       };
> +
> +       ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> +       if (ac)
> +               usage_with_options(worktree_usage, options);
> +       else {
> +               struct worktree_list *worktree_list = get_worktree_list();
> +               struct worktree_list *orig = worktree_list;
> +               struct strbuf sb = STRBUF_INIT;
> +               int path_maxlen = 0;
> +
> +               if (verbose) {
> +                       while (worktree_list) {
> +                               int cur_len = strlen(worktree_list->worktree->path);
> +                               if (cur_len > path_maxlen)
> +                                       path_maxlen = cur_len;
> +                               worktree_list = worktree_list->next ? worktree_list->next : NULL;
> +                       }
> +                       worktree_list = orig;
> +               }
> +               while (worktree_list) {
> +                       /* if this work tree is not bare OR if bare repos are to be shown (default) */
> +                       if (!worktree_list->worktree->is_bare || !no_bare) {

Double negatives (!no_bare) are hard to grok. 'bare_only' or
'skip_bare' might be better, and then the comment would likely be
superfluous. Also, having the "default" behavior mentioned in the
comment is an invitation for it to become outdated.

> +                               strbuf_reset(&sb);
> +                               if (!verbose)
> +                                       strbuf_addstr(&sb, worktree_list->worktree->path);
> +                               else {
> +                                       int cur_len = strlen(worktree_list->worktree->path);
> +                                       int utf8_adj = cur_len - utf8_strwidth(worktree_list->worktree->path);
> +                                       strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + utf8_adj, worktree_list->worktree->path);

I'm not personally convinced that this sort of alignment is desirable,
however, the new strbuf_utf8_align()[2] might be useful here.

[2]: Once it graduates to 'master', that is; it's currently in 'pu' at
5df5352 (utf8: add function to align a string into given strbuf,
2015-09-10).

> +                                       if (worktree_list->worktree->is_bare)
> +                                               strbuf_addstr(&sb, "(bare)");
> +                                       else {
> +                                               strbuf_addf(&sb, "%s ", find_unique_abbrev(worktree_list->worktree->head_sha1, DEFAULT_ABBREV));
> +                                               if (!worktree_list->worktree->is_detached)
> +                                                       strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(worktree_list->worktree->head_ref, 0));
> +                                               else
> +                                                       strbuf_addstr(&sb, "(detached HEAD)");
> +                                       }
> +                               }
> +                               printf("%s\n", sb.buf);
> +                       }
> +                       worktree_list = worktree_list->next ? worktree_list->next : NULL;
> +               }
> +               worktree_list_release(orig);
> +               strbuf_release(&sb);
> +       }
> +       return 0;
> +}
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> new file mode 100755
> index 0000000..246890c
> --- /dev/null
> +++ b/t/t2027-worktree-list.sh
> @@ -0,0 +1,122 @@
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
> +test_expect_success '"list" all worktrees from main' '
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       git -C here rev-parse --show-toplevel >>expect &&
> +       git worktree list >actual &&
> +       test_cmp expect actual &&
> +       rm -rf here &&
> +       git worktree prune

If the test fails somewhere above the 'rm', then the cleanup won't
take place, which will result in cascading failures of subsequent
tests. Instead, use test_when_finished() before the "worktree add"
line to ensure cleanup whether successful or not:

    test_when_finished "rm -rf here && git worktree prune" &&
    git worktree add ... &&

Same comment applies to remaining tests.

> +'
> +
> +test_expect_success '"list" all worktrees from linked' '
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       git -C here rev-parse --show-toplevel >>expect &&
> +       git -C here worktree list >actual &&
> +       test_cmp expect actual &&
> +       rm -rf here &&
> +       git worktree prune
> +'
> +
> +test_expect_success 'bare repo setup' '
> +       git init --bare bare1 &&
> +       echo "data" > file1 &&

Style: No space after redirection operator.

Nit: Unnecessary quotes around 'data'.

> +       git add file1 &&
> +       git commit -m"File1: add data" &&
> +       git push bare1 master &&
> +       git reset --hard HEAD^
> +'
> +
> +test_expect_success '"list" all worktrees from bare main' '
> +       git -C bare1 worktree add --detach ../there master &&
> +       echo "$(cd bare1 && pwd)" >expect &&

This may be problematic on Windows. See the discussion of $PWD in
t/README. You may need to use $(pwd) instead. Same comment applies
below, too.

> +       echo "$(git -C there rev-parse --show-toplevel)" >>expect &&
> +       git -C bare1 worktree list >actual &&
> +       test_cmp expect actual &&
> +       rm -rf there &&
> +       git -C bare1 worktree prune
> +'
> +test_expect_success '"list" all worktrees --verbose from bare main' '
> +       git -C bare1 worktree add --detach ../there master &&
> +   echo "$(cd bare1 && pwd)  (bare)" >expect &&
> +   echo "$(git -C there rev-parse --show-toplevel)  $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&

Botched indentation here and in next test.

> +       git -C bare1 worktree list --verbose >actual &&
> +       test_cmp expect actual &&
> +       rm -rf there &&
> +       git -C bare1 worktree prune
> +'
> +
> +test_expect_success '"list" all worktrees --verbose from worktree with a bare main' '
> +       git -C bare1 worktree add --detach ../there master &&
> +   echo "$(cd bare1 && pwd)  (bare)" >expect &&
> +   echo "$(git -C there rev-parse --show-toplevel)  $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
> +       git -C there worktree list --verbose >actual &&
> +       test_cmp expect actual &&
> +       rm -rf there &&
> +       git -C bare1 worktree prune
> +'
> +
> +test_expect_success 'bare repo cleanup' '
> +       rm -rf bare1
> +'

Meh. Probably unnecessary cleanup.

> +
> +test_done
> --
> 2.5.0
