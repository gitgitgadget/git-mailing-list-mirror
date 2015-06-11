From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/WIP v2 04/19] am: implement patch queue mechanism
Date: Thu, 11 Jun 2015 10:39:50 -0700
Message-ID: <CAGZ79kbLneLygPiDtL+nqwsxdvZEhT95vj0z9MbN0QrqvAmebA@mail.gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:40:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z36SS-0001Fk-09
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 19:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbbFKRjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 13:39:54 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32889 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090AbbFKRjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 13:39:51 -0400
Received: by ykfr66 with SMTP id r66so6002741ykf.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T0L6lV3ab4XhkozqO7eAL0xc+T5dUTikaPhEXpLzJyU=;
        b=OCrMAnc9qlUJJY1qlwjQonN6/qqCO6seJFfqtmvIhCO3ymgNPmnyEB63Jvc12y4gl9
         Vd/cCkEovRfBrxU+IxuPiSEHaYRtwoophy/cPhVYNzbe0X8NcDqmAmQaPhfZ+9nmZBFy
         BRYqWQ3brlzsd9f9aFIxuF/HmXpvnBUAQvSxqB/XAOYY8Y2LvPSS/gDECKxQDNICIeRX
         eNn8Lam960mhm7Nc8UWHuO2jFxr/BT9RaFKgDhOv0ZwlSY2tdnEbVgNqXp7WuAYaLiRG
         YAw75XoHzDE64r3ZKg0G42WvDB+AsrvcxYyNnLa8tLVEdYX3RR3G9jlZ+CVdOhzMiV7G
         3dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T0L6lV3ab4XhkozqO7eAL0xc+T5dUTikaPhEXpLzJyU=;
        b=BzD08oK0oRPr98YiwZpDz/H7UYqYRMxZZ/FopT2PQP1ZUsvHNi3FMYlc9tPQMLm11R
         eiH7VHsH0uEbkg4iBuUwJbchRn9eHElhe3RsCliMD3MnXaL25jfcstDBQt1UKDTr9Woq
         GBD6dw7kUGNms1W/oIPorAhm4mxCRxsd3I6d4zolTR4xv4FWytcXF9kq4z5aCPlh8f8z
         p140wquF5A12GkwPg3lLMnGJCYdK7mwtJs5r5jqOlE0ldSlgL3wzXDOgX/ZYLcaKV6g2
         WLK1yGKQaXTR3pICjfq2fZTTOxz6S5RKu77BEbtv1lluGZQyEWVP82KyrODpikfRzlT4
         m+UA==
X-Gm-Message-State: ALoCoQnco2WrgxLYGVoOZNLY3CkG4S4/GuMpnvM9HHihI3CTl7sgj0hbF7Y6ZkAN9jmoBydNnTMH
X-Received: by 10.170.41.76 with SMTP id 73mr1373994ykj.101.1434044390852;
 Thu, 11 Jun 2015 10:39:50 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Thu, 11 Jun 2015 10:39:50 -0700 (PDT)
In-Reply-To: <1434018125-31804-5-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271442>

On Thu, Jun 11, 2015 at 3:21 AM, Paul Tan <pyokagan@gmail.com> wrote:
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
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v2
>
>     * Declare struct am_state as static
>
>  builtin/am.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 0ccbe33..f061d21 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -6,6 +6,154 @@
>  #include "cache.h"
>  #include "builtin.h"
>  #include "exec_cmd.h"
> +#include "parse-options.h"
> +#include "dir.h"
> +
> +struct am_state {

Did you mean to declare all the functions below to be static or the
struct as well?
Reading further, you declared it static below. I thought maybe it'd be
useful to have definition
and declaration up here, but having all declarations further below may
be even better.



> +       /* state directory path */
> +       struct strbuf dir;
> +
> +       /* current and last patch numbers, 1-indexed */
> +       int cur;
> +       int last;
> +};
> +
> +/**
> + * Initializes am_state with the default values.
> + */
> +static void am_state_init(struct am_state *state)
> +{
> +       memset(state, 0, sizeof(*state));
> +
> +       strbuf_init(&state->dir, 0);
> +}
> +
> +/**
> + * Release memory allocated by an am_state.
> + */
> +static void am_state_release(struct am_state *state)
> +{
> +       strbuf_release(&state->dir);
> +}
> +
> +/**
> + * Returns path relative to the am_state directory.
> + */
> +static inline const char *am_path(const struct am_state *state, const char *path)
> +{
> +       return mkpath("%s/%s", state->dir.buf, path);
> +}
> +
> +/**
> + * Returns 1 if there is an am session in progress, 0 otherwise.
> + */
> +static int am_in_progress(const struct am_state *state)
> +{
> +       struct stat st;
> +
> +       if (lstat(state->dir.buf, &st) < 0 || !S_ISDIR(st.st_mode))
> +               return 0;
> +       if (lstat(am_path(state, "last"), &st) || !S_ISREG(st.st_mode))
> +               return 0;
> +       if (lstat(am_path(state, "next"), &st) || !S_ISREG(st.st_mode))
> +               return 0;
> +       return 1;
> +}
> +
> +/**
> + * Reads the contents of `file`. The third argument can be used to give a hint
> + * about the file size, to avoid reallocs. Returns number of bytes read on
> + * success, -1 if the file does not exist. If trim is set, trailing whitespace
> + * will be removed from the file contents.
> + */
> +static int read_state_file(struct strbuf *sb, const char *file, size_t hint, int trim)
> +{
> +       strbuf_reset(sb);
> +       if (strbuf_read_file(sb, file, hint) >= 0) {
> +               if (trim)
> +                       strbuf_rtrim(sb);
> +
> +               return sb->len;
> +       }
> +
> +       if (errno == ENOENT)
> +               return -1;
> +
> +       die_errno(_("could not read '%s'"), file);
> +}
> +
> +/**
> + * Loads state from disk.
> + */
> +static void am_load(struct am_state *state)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       read_state_file(&sb, am_path(state, "next"), 8, 1);
> +       state->cur = strtol(sb.buf, NULL, 10);
> +
> +       read_state_file(&sb, am_path(state, "last"), 8, 1);
> +       state->last = strtol(sb.buf, NULL, 10);
> +
> +       strbuf_release(&sb);
> +}
> +
> +/**
> + * Remove the am_state directory.
> + */
> +static void am_destroy(const struct am_state *state)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       strbuf_addstr(&sb, state->dir.buf);
> +       remove_dir_recursively(&sb, 0);
> +       strbuf_release(&sb);
> +}
> +
> +/**
> + * Setup a new am session for applying patches
> + */
> +static void am_setup(struct am_state *state)
> +{
> +       if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
> +               die_errno(_("failed to create directory '%s'"), state->dir.buf);
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
> + * Applies all queued patches.
> + */
> +static void am_run(struct am_state *state)
> +{
> +       while (state->cur <= state->last)
> +               am_next(state);
> +
> +       am_destroy(state);
> +}
> +
> +static struct am_state state;
> +
> +static const char * const am_usage[] = {
> +       N_("git am [options] [(<mbox>|<Maildir>)...]"),
> +       NULL
> +};
> +
> +static struct option am_options[] = {
> +       OPT_END()
> +};
>
>  int cmd_am(int argc, const char **argv, const char *prefix)
>  {
> @@ -16,5 +164,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                         die_errno("could not exec %s", path);
>         }
>
> +       git_config(git_default_config, NULL);
> +
> +       am_state_init(&state);
> +       strbuf_addstr(&state.dir, git_path("rebase-apply"));
> +
> +       argc = parse_options(argc, argv, prefix, am_options, am_usage, 0);
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
> 2.1.4
>
