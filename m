From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Tue, 11 Nov 2008 00:43:23 +0100
Message-ID: <4ac8254d0811101543q612917b5ib83e7e657d17ef3c@mail.gmail.com>
References: <1226028387-23867-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgQz-0007rG-Up
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYKJXn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYKJXn1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:43:27 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:5816 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbYKJXnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:43:25 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1055420yxm.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 15:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=y8AFQAEcmqe3gew2VKUxxJzIFpPfiHuv8yOPmYDIDs8=;
        b=GSYnGdfke/gKe7iVVAFn7lMXDSrM47R5TQbOnedfCgd6zb39H8RXoU36L2PY5wxXdB
         Dmxjykld9xraKRY0sGC7FLwKheG8A/A+kbAgjnSPjEieDsytejjofrvCQWo2Qs8Lu8qD
         60hvdoy3ys9YwYvl68cCThYO1N0adWyxrecto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vHRaSB6lLtIN+ShNuBr45BAX86t8kouotgTJY7ukjFTj6hAaTiUr+hITvftVSnLTFy
         ELxEsmgSnFbm8sHnGc3ow9H2BEM2GyzEhzIG1buFhYG/L2rEQomQWUFifxounuOrAD19
         ycWooh8MBztr/LZwcrQ3M3gOh0NyV2aofAeQQ=
Received: by 10.65.224.11 with SMTP id b11mr7135161qbr.33.1226360603805;
        Mon, 10 Nov 2008 15:43:23 -0800 (PST)
Received: by 10.65.231.17 with HTTP; Mon, 10 Nov 2008 15:43:23 -0800 (PST)
In-Reply-To: <1226028387-23867-1-git-send-email-tuncer.ayaz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100594>

On Fri, Nov 7, 2008 at 4:26 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> Implement git-pull --quiet and git-pull --verbose by
> adding the options to git-pull and fixing verbosity
> handling in git-fetch.

Junio,

is there anything still missing in this patch?
Maybe the name of the test-case is bad.
Maybe you've queued it for review already.

Regards,

        Tuncer Ayaz

> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
> ---
>  Documentation/merge-options.txt |    8 +++++
>  builtin-fetch.c                 |   21 +++++++------
>  builtin-merge.c                 |   22 ++++++++++----
>  git-pull.sh                     |   10 ++++--
>  t/t5521-pull-options.sh         |   60 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 20 deletions(-)
>  create mode 100755 t/t5521-pull-options.sh
>
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 007909a..427cdef 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -1,3 +1,11 @@
> +-q::
> +--quiet::
> +       Operate quietly.
> +
> +-v::
> +--verbose::
> +       Be verbose.
> +
>  --stat::
>        Show a diffstat at the end of the merge. The diffstat is also
>        controlled by the configuration option merge.stat.
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index f151cfa..efc5801 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -22,16 +22,17 @@ enum {
>        TAGS_SET = 2
>  };
>
> -static int append, force, keep, update_head_ok, verbose, quiet;
> +static int append, force, keep, update_head_ok;
>  static int tags = TAGS_DEFAULT;
>  static const char *depth;
>  static const char *upload_pack;
>  static struct strbuf default_rla = STRBUF_INIT;
>  static struct transport *transport;
> +static enum { QUIET, NORMAL, VERBOSE } verbosity = NORMAL;
>
>  static struct option builtin_fetch_options[] = {
> -       OPT__QUIET(&quiet),
> -       OPT__VERBOSE(&verbose),
> +       OPT_SET_INT('v', "verbose", &verbosity, "be verbose", VERBOSE),
> +       OPT_SET_INT('q', "quiet", &verbosity, "operate quietly", QUIET),
>        OPT_BOOLEAN('a', "append", &append,
>                    "append to .git/FETCH_HEAD instead of overwriting"),
>        OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
> @@ -192,7 +193,6 @@ static int s_update_ref(const char *action,
>
>  static int update_local_ref(struct ref *ref,
>                            const char *remote,
> -                           int verbose,
>                            char *display)
>  {
>        struct commit *current = NULL, *updated;
> @@ -210,7 +210,7 @@ static int update_local_ref(struct ref *ref,
>                die("object %s not found", sha1_to_hex(ref->new_sha1));
>
>        if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
> -               if (verbose)
> +               if (verbosity == VERBOSE)
>                        sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
>                                "[up to date]", REFCOL_WIDTH, remote,
>                                pretty_ref);
> @@ -366,18 +366,19 @@ static int store_updated_refs(const char *url, const char *remote_name,
>                        note);
>
>                if (ref)
> -                       rc |= update_local_ref(ref, what, verbose, note);
> +                       rc |= update_local_ref(ref, what, note);
>                else
>                        sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
>                                SUMMARY_WIDTH, *kind ? kind : "branch",
>                                 REFCOL_WIDTH, *what ? what : "HEAD");
>                if (*note) {
> -                       if (!shown_url) {
> +                       if (verbosity > QUIET && !shown_url) {
>                                fprintf(stderr, "From %.*s\n",
>                                                url_len, url);
>                                shown_url = 1;
>                        }
> -                       fprintf(stderr, " %s\n", note);
> +                       if (verbosity > QUIET)
> +                               fprintf(stderr, " %s\n", note);
>                }
>        }
>        fclose(fp);
> @@ -637,9 +638,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>                remote = remote_get(argv[0]);
>
>        transport = transport_get(remote, remote->url[0]);
> -       if (verbose >= 2)
> +       if (verbosity == VERBOSE)
>                transport->verbose = 1;
> -       if (quiet)
> +       if (verbosity == QUIET)
>                transport->verbose = -1;
>        if (upload_pack)
>                set_option(TRANS_OPT_UPLOADPACK, upload_pack);
> diff --git a/builtin-merge.c b/builtin-merge.c
> index 5e7910b..76e2890 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -50,6 +50,7 @@ static unsigned char head[20], stash[20];
>  static struct strategy **use_strategies;
>  static size_t use_strategies_nr, use_strategies_alloc;
>  static const char *branch;
> +static enum { QUIET, NORMAL, VERBOSE } verbosity = NORMAL;
>
>  static struct strategy all_strategy[] = {
>        { "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
> @@ -152,6 +153,8 @@ static int option_parse_n(const struct option *opt,
>  }
>
>  static struct option builtin_merge_options[] = {
> +       OPT_SET_INT('v', "verbose", &verbosity, "be verbose", VERBOSE),
> +       OPT_SET_INT('q', "quiet", &verbosity, "operate quietly", QUIET),
>        { OPTION_CALLBACK, 'n', NULL, NULL, NULL,
>                "do not show a diffstat at the end of the merge",
>                PARSE_OPT_NOARG, option_parse_n },
> @@ -250,7 +253,8 @@ static void restore_state(void)
>  /* This is called when no merge was necessary. */
>  static void finish_up_to_date(const char *msg)
>  {
> -       printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
> +       if (verbosity > QUIET)
> +               printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
>        drop_save();
>  }
>
> @@ -331,14 +335,15 @@ static void finish(const unsigned char *new_head, const char *msg)
>        if (!msg)
>                strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
>        else {
> -               printf("%s\n", msg);
> +               if (verbosity > QUIET)
> +                       printf("%s\n", msg);
>                strbuf_addf(&reflog_message, "%s: %s",
>                        getenv("GIT_REFLOG_ACTION"), msg);
>        }
>        if (squash) {
>                squash_message();
>        } else {
> -               if (!merge_msg.len)
> +               if (verbosity > QUIET && !merge_msg.len)
>                        printf("No merge message -- not updating HEAD\n");
>                else {
>                        const char *argv_gc_auto[] = { "gc", "--auto", NULL };
> @@ -872,6 +877,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>
>        argc = parse_options(argc, argv, builtin_merge_options,
>                        builtin_merge_usage, 0);
> +       if (verbosity > QUIET)
> +               show_diffstat = 0;
>
>        if (squash) {
>                if (!allow_fast_forward)
> @@ -1013,10 +1020,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>
>                strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
>
> -               printf("Updating %s..%s\n",
> -                       hex,
> -                       find_unique_abbrev(remoteheads->item->object.sha1,
> -                       DEFAULT_ABBREV));
> +               if (verbosity > QUIET)
> +                       printf("Updating %s..%s\n",
> +                               hex,
> +                               find_unique_abbrev(remoteheads->item->object.sha1,
> +                               DEFAULT_ABBREV));
>                strbuf_addstr(&msg, "Fast forward");
>                if (have_message)
>                        strbuf_addstr(&msg,
> diff --git a/git-pull.sh b/git-pull.sh
> index 664fe34..8866f2a 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -16,13 +16,17 @@ cd_to_toplevel
>  test -z "$(git ls-files -u)" ||
>        die "You are in the middle of a conflicted merge."
>
> -strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
> +strategy_args= no_stat= no_commit= squash= no_ff= log_arg= verbosity=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
>  rebase=$(git config --bool branch.$curr_branch_short.rebase)
>  while :
>  do
>        case "$1" in
> +       -q|--quiet)
> +               verbosity=-q ;;
> +       -v|--verbose)
> +               verbosity=-v ;;
>        -n|--no-stat|--no-summary)
>                no_stat=-n ;;
>        --stat|--summary)
> @@ -121,7 +125,7 @@ test true = "$rebase" && {
>                "refs/remotes/$origin/$reflist" 2>/dev/null)"
>  }
>  orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
> -git fetch --update-head-ok "$@" || exit 1
> +git fetch $verbosity --update-head-ok "$@" || exit 1
>
>  curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
>  if test -n "$orig_head" && test "$curr_head" != "$orig_head"
> @@ -182,4 +186,4 @@ test true = "$rebase" &&
>        exec git-rebase $strategy_args --onto $merge_head \
>        ${oldremoteref:-$merge_head}
>  exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
> -       "$merge_name" HEAD $merge_head
> +       "$merge_name" HEAD $merge_head $verbosity
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> new file mode 100755
> index 0000000..83e2e8a
> --- /dev/null
> +++ b/t/t5521-pull-options.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +
> +test_description='pull options'
> +
> +. ./test-lib.sh
> +
> +D=`pwd`
> +
> +test_expect_success 'setup' '
> +       mkdir parent &&
> +       (cd parent && git init &&
> +        echo one >file && git add file &&
> +        git commit -m one)
> +'
> +
> +cd "$D"
> +
> +test_expect_success 'git pull -q' '
> +       mkdir clonedq &&
> +       cd clonedq &&
> +       git pull -q "$D/parent" >out 2>err &&
> +       test ! -s out
> +'
> +
> +cd "$D"
> +
> +test_expect_success 'git pull' '
> +       mkdir cloned &&
> +       cd cloned &&
> +       git pull "$D/parent" >out 2>err &&
> +       test -s out
> +'
> +cd "$D"
> +
> +test_expect_success 'git pull -v' '
> +       mkdir clonedv &&
> +       cd clonedv &&
> +       git pull -v "$D/parent" >out 2>err &&
> +       test -s out
> +'
> +
> +cd "$D"
> +
> +test_expect_success 'git pull -v -q' '
> +       mkdir clonedvq &&
> +       cd clonedvq &&
> +       git pull -v -q "$D/parent" >out 2>err &&
> +       test ! -s out
> +'
> +
> +cd "$D"
> +
> +test_expect_success 'git pull -q -v' '
> +       mkdir clonedqv &&
> +       cd clonedqv &&
> +       git pull -q -v "$D/parent" >out 2>err &&
> +       test -s out
> +'
> +
> +test_done
> --
> 1.6.0.2.GIT
>
>
