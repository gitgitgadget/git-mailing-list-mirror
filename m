From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 04/44] builtin-am: implement patch queue mechanism
Date: Sun, 28 Jun 2015 22:08:11 -0700
Message-ID: <CAGZ79kYxFceV=w3CQ1xFsT0igy2g=DX2JiV2hwqVLxq-OJ1AOg@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 07:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9RIp-0004hH-48
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 07:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbF2FIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 01:08:15 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36222 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbF2FIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 01:08:12 -0400
Received: by ykdr198 with SMTP id r198so105438763ykd.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 22:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HLq5TdwuD8vCu8M5dvg8QBU93KnK1uEzr+aKCFs81dQ=;
        b=mXmrWlJhdf5oyVxmLvv0VB8cBg4WxPM+VMGqeFYS64Tg0rq00tIJco5VFR8DSGMapx
         ehPYOuo8Q0KZQCCQVR0nw5wiIoNbjithA+mXVksoGvamZCoE74V+/d36A4gZuRj6erLQ
         hBLk7FaoSk0H5pG8UaCv0PbXyKK/iiocb2bqMATRIIAm6yQNxcKhRXalVeFEN5wSIrJu
         x6NNE5c+qqi8dR2WSzc9xZ+Nrg7uJNcOTx0A0SluRIiRB+vgUtADne0EH1qTkhCVqLDR
         46LXpuCCVghysfxh7xjtGxFsm3nrdrg5RPR+MI8JFpyYfTndqSmeZDEGwaMKaoNejUgQ
         ItAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HLq5TdwuD8vCu8M5dvg8QBU93KnK1uEzr+aKCFs81dQ=;
        b=JULEU6qfqXGBwQhZJxsNJ2QQvYXLCdm3JmS/u/uI6dMeaSBtfMooe5tyVfDBqPI2vw
         foTRv/qnvrgr+3wdEbpeSErVZ9GNTwuqwXaKy508YkuBVJEFprUVSuUlO5ZBTrc7cMHi
         K8MMGPnnFzlOKMENDT/h/yS9aghUxMDE2N4UDjnfFfwbSUQi8d2MdpnE8AjpRu+oC6RM
         NxQ6TULfhu2izXSxkovTRxL5u81zJRgwLjK2UcX6+RXIucrzc53QBsrgwIml5oH6zxHB
         MB4S3MLeUETF7JqqqaRxfYhvPwcGt6FSx0jKY5giENdE6P1Ub3mTKW2OrGDbzdDW3GpM
         XSMQ==
X-Gm-Message-State: ALoCoQnoI41CGUHcZOT+A0bOBCXH1DuO5B2wzW6pAyMEk9gyg+hYZnpZqp+oEkQJxudXvRFkJOxy
X-Received: by 10.170.117.210 with SMTP id j201mr16762382ykb.56.1435554491318;
 Sun, 28 Jun 2015 22:08:11 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Sun, 28 Jun 2015 22:08:11 -0700 (PDT)
In-Reply-To: <1435500366-31700-5-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272937>

On Sun, Jun 28, 2015 at 7:05 AM, Paul Tan <pyokagan@gmail.com> wrote:
> git-am applies a series of patches. If the process terminates
> abnormally, we want to be able to resume applying the series of patches.
> This requires the session state to be saved in a persistent location.
>
> Implement the mechanism of a "patch queue", represented by 2 integers --
> the index of the current patch we are applying and the index of the last
> patch, as well as its lifecycle through the following functions:
>
> * am_setup(), which will set up the state directory
>   $GIT_DIR/rebase-apply. As such, even if the process exits abnormally,
>   the last-known state will still persist.
>
> * am_load(), which is called if there is an am session in
>   progress, to load the last known state from the state directory so we
>   can resume applying patches.
>
> * am_run(), which will do the actual patch application. After applying a
>   patch, it calls am_next() to increment the current patch index. The
>   logic for applying and committing a patch is not implemented yet.
>
> * am_destroy(), which is finally called when we successfully applied all
>   the patches in the queue, to clean up by removing the state directory
>   and its contents.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Stefan Beller <sbeller@google.com>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v4
>
>     * Corrected docstring of read_state_file()
>
>     * Corrected docstring of am_state_release()
>
>     * am_state's "dir" field is now a char*. To help API users,
>       am_state_init() takes an additional const char *dir argument.
>
>     * The opt_* option variables, am_options[] and am_usage[] have been
>       moved into cmd_am()'s scope.
>
>     * signature of read_state_file() has been changed to
>       read_state_file(strbuf, state, file, trim)
>
>  builtin/am.c | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index fd32caf..5b4e9af 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -6,9 +6,174 @@
>  #include "cache.h"
>  #include "builtin.h"
>  #include "exec_cmd.h"
> +#include "parse-options.h"
> +#include "dir.h"
> +
> +struct am_state {
> +       /* state directory path */
> +       char *dir;
> +
> +       /* current and last patch numbers, 1-indexed */
> +       int cur;
> +       int last;
> +};
> +
> +/**
> + * Initializes am_state with the default values. The state directory is set to
> + * dir.
> + */
> +static void am_state_init(struct am_state *state, const char *dir)
> +{
> +       memset(state, 0, sizeof(*state));
> +
> +       assert(dir);
> +       state->dir = xstrdup(dir);
> +}
> +
> +/**
> + * Releases memory allocated by an am_state.
> + */
> +static void am_state_release(struct am_state *state)
> +{
> +       if (state->dir)
> +               free(state->dir);
> +}
> +
> +/**
> + * Returns path relative to the am_state directory.
> + */
> +static inline const char *am_path(const struct am_state *state, const char *path)
> +{
> +       assert(state->dir);
> +       assert(path);
> +       return mkpath("%s/%s", state->dir, path);
> +}
> +
> +/**
> + * Returns 1 if there is an am session in progress, 0 otherwise.
> + */
> +static int am_in_progress(const struct am_state *state)
> +{
> +       struct stat st;
> +
> +       if (lstat(state->dir, &st) < 0 || !S_ISDIR(st.st_mode))
> +               return 0;
> +       if (lstat(am_path(state, "last"), &st) || !S_ISREG(st.st_mode))
> +               return 0;
> +       if (lstat(am_path(state, "next"), &st) || !S_ISREG(st.st_mode))
> +               return 0;
> +       return 1;
> +}
> +
> +/**
> + * Reads the contents of `file` in the `state` directory into `sb`. Returns the
> + * number of bytes read on success, -1 if the file does not exist. If `trim` is
> + * set, trailing whitespace will be removed.
> + */
> +static int read_state_file(struct strbuf *sb, const struct am_state *state,
> +                       const char *file, int trim)
> +{
> +       strbuf_reset(sb);
> +
> +       if (strbuf_read_file(sb, am_path(state, file), 0) >= 0) {
> +               if (trim)
> +                       strbuf_trim(sb);
> +
> +               return sb->len;
> +       }
> +
> +       if (errno == ENOENT)
> +               return -1;
> +
> +       die_errno(_("could not read '%s'"), am_path(state, file));
> +}
> +
> +/**
> + * Loads state from disk.
> + */
> +static void am_load(struct am_state *state)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       if (read_state_file(&sb, state, "next", 1) < 0)
> +               die("BUG: state file 'next' does not exist");
> +       state->cur = strtol(sb.buf, NULL, 10);
> +
> +       if (read_state_file(&sb, state, "last", 1) < 0)
> +               die("BUG: state file 'last' does not exist");
> +       state->last = strtol(sb.buf, NULL, 10);
> +
> +       strbuf_release(&sb);
> +}
> +
> +/**
> + * Removes the am_state directory, forcefully terminating the current am
> + * session.
> + */
> +static void am_destroy(const struct am_state *state)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       strbuf_addstr(&sb, state->dir);
> +       remove_dir_recursively(&sb, 0);
> +       strbuf_release(&sb);
> +}
> +
> +/**
> + * Setup a new am session for applying patches
> + */
> +static void am_setup(struct am_state *state)
> +{
> +       if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
> +               die_errno(_("failed to create directory '%s'"), state->dir);
> +
> +       /*
> +        * NOTE: Since the "next" and "last" files determine if an am_state
> +        * session is in progress, they should be written last.
> +        */
> +
> +       write_file(am_path(state, "next"), 1, "%d", state->cur);
> +
> +       write_file(am_path(state, "last"), 1, "%d", state->last);
> +}
> +
> +/**
> + * Increments the patch pointer, and cleans am_state for the application of the
> + * next patch.
> + */
> +static void am_next(struct am_state *state)
> +{
> +       state->cur++;
> +       write_file(am_path(state, "next"), 1, "%d", state->cur);
> +}
> +
> +/**
> + * Applies all queued mail.
> + */
> +static void am_run(struct am_state *state)
> +{
> +       while (state->cur <= state->last) {
> +
> +               /* TODO: Patch application not implemented yet */

(optional nit, bikeshedding)
In conjunction with the previous patch I just wonder when we put a
TODO and when we want to put a NEEDSWORK, or if we're being
inconsistent here as both issues will be resolved in a later patch
in the series.

> +
> +               am_next(state);
> +       }
> +
> +       am_destroy(state);
> +}
>
>  int cmd_am(int argc, const char **argv, const char *prefix)
>  {
> +       struct am_state state;
> +
> +       const char * const usage[] = {
> +               N_("git am [options] [(<mbox>|<Maildir>)...]"),
> +               NULL
> +       };
> +
> +       struct option options[] = {
> +               OPT_END()
> +       };
>
>         /*
>          * NEEDSWORK: Once all the features of git-am.sh have been
> @@ -25,5 +190,20 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                 setup_work_tree();
>         }
>
> +       git_config(git_default_config, NULL);
> +
> +       am_state_init(&state, git_path("rebase-apply"));
> +
> +       argc = parse_options(argc, argv, prefix, options, usage, 0);
> +
> +       if (am_in_progress(&state))
> +               am_load(&state);
> +       else
> +               am_setup(&state);
> +
> +       am_run(&state);
> +
> +       am_state_release(&state);
> +
>         return 0;
>  }
> --
> 2.5.0.rc0.76.gb2c6e93
>
