From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 02/19] parse-options-cb: implement parse_opt_pass_argv_array()
Date: Wed, 3 Jun 2015 09:56:39 -0700
Message-ID: <CAGZ79kbGN6fxCPsARp3fAioi73vsddqLAKTOi9Kmd2DCcWhizA@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:57:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Byd-0004zp-4a
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 18:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbbFCQ5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 12:57:05 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35701 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932776AbbFCQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 12:56:40 -0400
Received: by qgg60 with SMTP id 60so6463215qgg.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Gho9327MrK+X5hydzUTmc0HBxuII/qbWRCVIlCbWQzI=;
        b=S7U763685+8uEmB0baDdHLlYrDMkOUMHY3sBoogIC02FdV99ehfkq4gh5tBXtTSxSY
         tOIQFyJw2hktu5YuM7UL1pS8KR2iSV0NQPIVtKDb/aRIjw3n8yCf3RIVUGax7ga5SOcp
         M83Ewk9iBf+gWm0u0ewHc3iwmRbr3BJ8bNZ/k0lAUpZk8GYLqre9F3VuqNQsYW1iFrzG
         MBjcTs1dNUOjFxpKUs16+RUahjMyzJlsBLzz5f3u0GI8+OsXOPviWCMKLuxey58jERgc
         dAZ/ToWgCtmcFKzeV39InzNO++jD39eAsx3izIlsY1OfEfrT5eCleUzgbE7ofI0D6OQ1
         Dkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Gho9327MrK+X5hydzUTmc0HBxuII/qbWRCVIlCbWQzI=;
        b=Lyh2bV5gSADewQ5WDrGfU8zgQeR24IgweuckNyDSo6e2hx8pbnbGbQuwglnklG38/7
         DVgMVavUAN0MjAbYRWlxk9Y5pGUhU/ic8f++2b99/CTG6gCNU0Dr6h7FzqKpXpxhwuHE
         T69wFf8q9NFy1ZFVYAjhuQBssEgF4NT/bpEZLJ4VeQU0zpjJyV4XtPJNUb7BXEQpYKUR
         GBnFXTzCgtNckUTSXRB+hwCKDf3Bndzy0ZMLDUznuaJ9+Ui5yGL/e0iXBrdEdyHJ0m5l
         ftdQ1j1Wq7ul6qgVazQFFOUJ+3JuKV0AmON5AKSt85sjaRs3RhrFTDACxgCRdkHeUp0z
         uxlA==
X-Gm-Message-State: ALoCoQnAEImbicSl/m/Cg7q8a2bi4DzjdgEzDya+mfBGzEMK4MTpTXXd8fs2B69EvxhvsO3e5CnK
X-Received: by 10.55.19.197 with SMTP id 66mr61244981qkt.24.1433350599299;
 Wed, 03 Jun 2015 09:56:39 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 3 Jun 2015 09:56:39 -0700 (PDT)
In-Reply-To: <1433314143-4478-3-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270699>

On Tue, Jun 2, 2015 at 11:48 PM, Paul Tan <pyokagan@gmail.com> wrote:
> Certain git commands, such as git-pull, are simply wrappers around other
> git commands like git-fetch, git-merge and git-rebase. As such, these
> wrapper commands will typically need to "pass through" command-line
> options of the commands they wrap.
>
> Implement the parse_opt_pass_argv_array() parse-options callback, which
> will reconstruct all the provided command-line options into an
> argv_array, such that it can be passed to another git command. This is
> useful for passing command-line options that can be specified multiple
> times.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v2
>
>     * This function is a requirement for the rewrite of git-am to handle
>       passing git-apply's options to git-apply. Since it would be
>       implemented anyway I thought it would be good if git-pull could take
>       advantage of it as well to handle --strategy and --strategy-option.
>
>  parse-options-cb.c | 32 ++++++++++++++++++++++++++++++++
>  parse-options.h    |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 5b1dbcf..7330506 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -4,6 +4,7 @@
>  #include "commit.h"
>  #include "color.h"
>  #include "string-list.h"
> +#include "argv-array.h"
>
>  /*----- some often used options -----*/
>
> @@ -163,3 +164,34 @@ int parse_opt_pass_strbuf(const struct option *opt, const char *arg, int unset)
>
>         return 0;
>  }
> +
> +/**
> + * For an option opt, recreate the command-line option, appending it to
> + * opt->value which must be a argv_array. This is useful when we need to pass
> + * the command-line option, which can be specified multiple times, to another
> + * command.
> + */
> +int parse_opt_pass_argv_array(const struct option *opt, const char *arg, int unset)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       struct argv_array *opt_value = opt->value;
> +
> +       if (opt->long_name) {
> +               strbuf_addstr(&sb, unset ? "--no-" : "--");
> +               strbuf_addstr(&sb, opt->long_name);
> +               if (arg) {
> +                       strbuf_addch(&sb, '=');
> +                       strbuf_addstr(&sb, arg);
> +               }
> +       } else if (opt->short_name && !unset) {
> +               strbuf_addch(&sb, '-');
> +               strbuf_addch(&sb, opt->short_name);
> +               if (arg)
> +                       strbuf_addstr(&sb, arg);
> +       } else
> +               return -1;
> +
> +       argv_array_push(opt_value, sb.buf);
> +       strbuf_release(&sb);
> +       return 0;
> +}
> diff --git a/parse-options.h b/parse-options.h
> index 1d21398..b663f87 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -225,6 +225,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
>  extern int parse_opt_string_list(const struct option *, const char *, int);
>  extern int parse_opt_noop_cb(const struct option *, const char *, int);
>  extern int parse_opt_pass_strbuf(const struct option *, const char *, int);
> +extern int parse_opt_pass_argv_array(const struct option *, const char *, int);
>
>  #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
>  #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
> --
> 2.1.4
>

This patch looks very similar to the first one, so I wonder if the
combination of these
could be written as:

static int parse_opt_pass_strbuf_internal(const struct option *opt,
const char *arg, int unset, struct strbuf *sb)
{
       if (opt->long_name) {
               strbuf_addstr(sb, unset ? "--no-" : "--");
               strbuf_addstr(sb, opt->long_name);
               if (arg) {
                       strbuf_addch(sb, '=');
                       strbuf_addstr(sb, arg);
               }
       } else if (opt->short_name && !unset) {
               strbuf_addch(sb, '-');
               strbuf_addch(sb, opt->short_name);
               if (arg)
                       strbuf_addstr(sb, arg);
       } else
               return -1;
      return 0;
}

/**
 * For an option opt, recreates the command-line option in opt->value which
 * must be an strbuf. This is useful when we need to pass the command-line
 * option to another command.
 */
int parse_opt_pass_strbuf(const struct option *opt, const char *arg, int unset)
{
       struct strbuf *sb = opt->value;
       strbuf_reset(sb);
       return parse_opt_pass_strbuf_internal(...);
}

/**
 * For an option opt, recreate the command-line option, appending it to
 * opt->value which must be a argv_array. This is useful when we need to pass
 * the command-line option, which can be specified multiple times, to another
 * command.
 */
int parse_opt_pass_argv_array(const struct option *opt, const char
*arg, int unset)
{
       struct strbuf sb = STRBUF_INIT;
       struct argv_array *opt_value = opt->value;

       int ret = parse_opt_pass_strbuf_internal(...)

       argv_array_push(opt_value, sb.buf);
       strbuf_release(&sb);
       return 0;
}
