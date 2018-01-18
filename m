Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196321FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeARWAv (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:00:51 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:10984 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753762AbeARWAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:00:50 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id cIEpeTggfAp17cIEpeDYAD; Thu, 18 Jan 2018 22:00:48 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ZybCDeFdfy6KP-5SPRoA:9
 a=wPNLvfGTeEIA:10
Message-ID: <5FC5C1765B7648F7A166363BED3AFFA3@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.keller@gmail.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <e3c3c703f8eae723c4fbbd08d2c329d81179dbee.1516225925.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH 8/8] rebase -i: introduce --recreate-merges=no-rebase-cousins
Date:   Thu, 18 Jan 2018 22:00:48 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180118-34, 18/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfCxF08MsLmso9/VgYx5Ed5HAFyzOXlVPVsUORvf88pC3x4f3FuGXP6EOdx73svh4NIY2zlzOMEa8k/ZiPCWQo6ino8wXvXjAU4fmrYBsxfNdhB01eEcA
 LO05xJqGI+/eJjZ5IMhugscDO/kO5LKJ0maTgmI4BokOkO7Ko1MgJM3gLjOrvmftsbmp1Ofxnw9kH88wUvKfuhFi+gjr5QohkWu1ARAgYFXjkL5QgaOkuRZT
 it2RxHxaQN1pD7e+csE9znTREtYuzUU3f8peD4jdQus=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> This one is a bit tricky to explain, so let's try with a diagram:
>
>        C
>      /   \
> A - B - E - F
>  \   /
>    D
>
> To illustrate what this new mode is all about, let's consider what
> happens upon `git rebase -i --recreate-merges B`, in particular to
> the commit `D`. In the default mode, the new branch structure is:
>
>       --- C' --
>      /         \
> A - B ------ E' - F'
>      \    /
>        D'
>
> This is not really preserving the branch topology from before! The
> reason is that the commit `D` does not have `B` as ancestor, and
> therefore it gets rebased onto `B`.
>
> However, when recreating branch structure, there are legitimate use
> cases where one might want to preserve the branch points of commits that
> do not descend from the <upstream> commit that was passed to the rebase
> command, e.g. when a branch from core Git's `next` was merged into Git
> for Windows' master we will not want to rebase those commits on top of a
> Windows-specific commit. In the example above, the desired outcome would
> look like this:
>
>       --- C' --
>      /         \
> A - B ------ E' - F'
>  \        /
>   -- D' --

I'm not understanding this. I see that D properly starts from A, but don't 
see why it is now D'. Surely it's unchanged.
Maybe it's the arc/node confusion. Maybe even spell out that the rebased 
commits from the command are B..HEAD, but that includes D, which may not be 
what folk had expected. (not even sure if the reflog comes into determining 
merge-bases here..)

I do think an exact definition is needed (e.g. via --ancestry-path or its 
equivalent?).

>
> Let's introduce the term "cousins" for such commits ("D" in the
> example), and the "no-rebase-cousins" mode of the merge-recreating
> rebase, to help those use cases.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Documentation/git-rebase.txt      |  7 ++++++-
> builtin/rebase--helper.c          |  9 ++++++++-
> git-rebase--interactive.sh        |  1 +
> git-rebase.sh                     | 12 +++++++++++-
> sequencer.c                       |  4 ++++
> sequencer.h                       |  8 ++++++++
> t/t3430-rebase-recreate-merges.sh | 23 +++++++++++++++++++++++
> 7 files changed, 61 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 1d061373288..ac07a5c3fc9 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -368,10 +368,15 @@ The commit list format can be changed by setting the 
> configuration option
> rebase.instructionFormat.  A customized instruction format will 
> automatically
> have the long commit hash prepended to the format.
>
> ---recreate-merges::
> +--recreate-merges[=(rebase-cousins|no-rebase-cousins)]::
>  Recreate merge commits instead of flattening the history by replaying
>  merges. Merge conflict resolutions or manual amendments to merge
>  commits are not preserved.
> ++
> +By default, or when `rebase-cousins` was specified, commits which do not 
> have
> +`<upstream>` as direct ancestor are rebased onto `<upstream>` (or 
> `<onto>`,
> +if specified). If the `rebase-cousins` mode is turned off, such commits 
> will
> +retain their original branch point.
>
> -p::
> --preserve-merges::
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index a34ab5c0655..ef08fef4d14 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -13,7 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, 
> const char *prefix)
> {
>  struct replay_opts opts = REPLAY_OPTS_INIT;
>  unsigned flags = 0, keep_empty = 0, recreate_merges = 0;
> - int abbreviate_commands = 0;
> + int abbreviate_commands = 0, no_rebase_cousins = -1;
>  enum {
>  CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>  CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
> @@ -23,6 +23,8 @@ int cmd_rebase__helper(int argc, const char **argv, 
> const char *prefix)
>  OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
>  OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
>  OPT_BOOL(0, "recreate-merges", &recreate_merges, N_("recreate merge 
> commits")),
> + OPT_BOOL(0, "no-rebase-cousins", &no_rebase_cousins,
> + N_("keep original branch points of cousins")),
>  OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  CONTINUE),
>  OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
> @@ -57,8 +59,13 @@ int cmd_rebase__helper(int argc, const char **argv, 
> const char *prefix)
>  flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
>  flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
>  flags |= recreate_merges ? TODO_LIST_RECREATE_MERGES : 0;
> + flags |= no_rebase_cousins > 0 ? TODO_LIST_NO_REBASE_COUSINS : 0;
>  flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
>
> + if (no_rebase_cousins >= 0&& !recreate_merges)
> + warning(_("--[no-]rebase-cousins has no effect without "
> +   "--recreate-merges"));
> +
>  if (command == CONTINUE && argc == 1)
>  return !!sequencer_continue(&opts);
>  if (command == ABORT && argc == 1)
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 3459ec5a018..23184c77e88 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -901,6 +901,7 @@ if test t != "$preserve_merges"
> then
>  git rebase--helper --make-script ${keep_empty:+--keep-empty} \
>  ${recreate_merges:+--recreate-merges} \
> + ${no_rebase_cousins:+--no-rebase-cousins} \
>  $revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
>  die "$(gettext "Could not generate todo list")"
> else
> diff --git a/git-rebase.sh b/git-rebase.sh
> index d69bc7d0e0d..3403b1416a8 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -17,7 +17,7 @@ q,quiet!           be quiet. implies --no-stat
> autostash          automatically stash/stash pop before and after
> fork-point         use 'merge-base --fork-point' to refine upstream
> onto=!             rebase onto given branch instead of upstream
> -recreate-merges!   try to recreate merges instead of skipping them
> +recreate-merges?   try to recreate merges instead of skipping them
> p,preserve-merges! try to recreate merges instead of ignoring them
> s,strategy=!       use the given merge strategy
> no-ff!             cherry-pick all commits, even if unchanged
> @@ -88,6 +88,7 @@ state_dir=
> # One of {'', continue, skip, abort}, as parsed from command line
> action=
> recreate_merges=
> +no_rebase_cousins=
> preserve_merges=
> autosquash=
> keep_empty=
> @@ -268,6 +269,15 @@ do
>  recreate_merges=t
>  test -z "$interactive_rebase" && interactive_rebase=implied
>  ;;
> + --recreate-merges=*)
> + recreate_merges=t
> + case "${1#*=}" in
> + rebase-cousins) no_rebase_cousins=;;
> + no-rebase-cousins) no_rebase_cousins=t;;
> + *) die "Unknown mode: $1";;
> + esac
> + test -z "$interactive_rebase" && interactive_rebase=implied
> + ;;
>  --preserve-merges)
>  preserve_merges=t
>  test -z "$interactive_rebase" && interactive_rebase=implied
> diff --git a/sequencer.c b/sequencer.c
> index b63bfb9a141..2b4e6b12321 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2905,6 +2905,7 @@ static int make_script_with_merges(struct 
> pretty_print_context *pp,
>     unsigned flags)
> {
>  int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
> + int no_rebase_cousins = flags & TODO_LIST_NO_REBASE_COUSINS;
>  struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
>  struct strbuf label = STRBUF_INIT;
>  struct commit_list *commits = NULL, **tail = &commits, *iter;
> @@ -3078,6 +3079,9 @@ static int make_script_with_merges(struct 
> pretty_print_context *pp,
>     &commit->object.oid);
>  if (entry)
>  to = entry->string;
> + else if (no_rebase_cousins)
> + to = label_oid(&commit->object.oid, NULL,
> +        &state);
>
>  if (!to || !strcmp("onto", to))
>  fprintf(out, "%s\n", b);
> diff --git a/sequencer.h b/sequencer.h
> index 11d1ac925ef..9530dba3cba 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -49,6 +49,14 @@ int sequencer_remove_state(struct replay_opts *opts);
> #define TODO_LIST_SHORTEN_IDS (1U << 1)
> #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
> #define TODO_LIST_RECREATE_MERGES (1U << 3)
> +/*
> + * When recreating merges, commits that do have the base commit as 
> ancestor
> + * ("cousins") are rebased onto the new base by default. If those commits
> + * should keep their original branch point, this flag needs to be passed.
> + *
> + * This flag only makes sense when <base> and <onto> are different.
> + */
> +#define TODO_LIST_NO_REBASE_COUSINS (1U << 4)
> int sequencer_make_script(FILE *out, int argc, const char **argv,
>    unsigned flags);
>
> diff --git a/t/t3430-rebase-recreate-merges.sh 
> b/t/t3430-rebase-recreate-merges.sh
> index 76e615bd7c1..22930e470a4 100755
> --- a/t/t3430-rebase-recreate-merges.sh
> +++ b/t/t3430-rebase-recreate-merges.sh
> @@ -143,6 +143,29 @@ test_expect_success 'with a branch tip that was 
> cherry-picked already' '
>  EOF
> '
>
> +test_expect_success 'rebase cousins unless told not to' '
> + write_script copy-editor.sh <<-\EOF &&
> + cp "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
> + EOF
> +
> + test_config sequence.editor \""$PWD"/copy-editor.sh\" &&
> + git checkout -b cousins master &&
> + before="$(git rev-parse --verify HEAD)" &&
> + test_tick &&
> + git rebase -i --recreate-merges=no-rebase-cousins HEAD^ &&
> + test_cmp_rev HEAD $before &&
> + test_tick &&
> + git rebase -i --recreate-merges HEAD^ &&
> + test_cmp_graph HEAD^.. <<-\EOF
> + *   Merge the topic branch '\''onebranch'\''
> + |\
> + | * D
> + | * G
> + |/
> + o H
> + EOF
> +'
> +
> test_expect_success 'refs/rewritten/* is worktree-local' '
>  git worktree add wt &&
>  cat >wt/script-from-scratch <<-\EOF &&
> -- 
> 2.15.1.windows.2.1430.ga56c4f9e2a9 

