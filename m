From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Tue, 4 Sep 2012 20:06:12 +0700
Message-ID: <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org> <1346544731-938-10-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8sqB-0001Ld-TD
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 15:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954Ab2IDNGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 09:06:45 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:42959 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab2IDNGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 09:06:44 -0400
Received: by qaas11 with SMTP id s11so2742003qaa.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TdyCbo3XIfAMKccwL5IKk1ouxyz6JKxO8upONCO1uwQ=;
        b=KIKa3ocDOpk95n4CHQOYL+OajrurbIgbdZuwEeN8M4cHHBDifLglfPKX06Jid8Rzio
         EU9ubGSxzsAHsjW4OcrcKekdz9OZvyGDJtAi5FV0bTpQVe1WPsJy4Q4h04vJgucqlQnL
         /xrdomserigrIXSkkn88ou364GzukIa7LcOU1rVA5/Xd+HjTPujCAbEN3/wsYk12Dypu
         JT2xOQ1VJoYx7Vxsi9H9/Zw1ZFkKJPfm/lLSXj6gCOADmqetP8trF3tYK/Mh79Ux7fOc
         pbRL3ROAp/6bb5k2RJbLSjO4IUibiYS6R2A198OBNrGx+DrbbK4TuYz3N2bX4FRhBnco
         NSEA==
Received: by 10.224.28.14 with SMTP id k14mr40453543qac.72.1346764003395; Tue,
 04 Sep 2012 06:06:43 -0700 (PDT)
Received: by 10.49.4.6 with HTTP; Tue, 4 Sep 2012 06:06:12 -0700 (PDT)
In-Reply-To: <1346544731-938-10-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204743>

On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -273,7 +273,7 @@ static int add_files(struct dir_struct *dir, int flags)
>                 fprintf(stderr, _(ignore_error));
>                 for (i = 0; i < dir->ignored_nr; i++)
>                         fprintf(stderr, "%s\n", dir->ignored[i]->name);
> -               fprintf(stderr, _("Use -f if you really want to add them.\n"));
> +               fprintf(stderr, _("Use -f if you really want to add them, or git check-ignore to see\nwhy they're ignored.\n"));
>                 die(_("no files added"));
>         }

String too long (> 80 chars).

> +static const char * const check_ignore_usage[] = {
> +"git check-ignore pathname...",
> +"git check-ignore --stdin [-z] < <list-of-paths>",
> +NULL
> +};
> +
> +static const struct option check_ignore_options[] = {
> +       OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
> +       OPT_BOOLEAN('z', NULL, &null_term_line,
> +               "input paths are terminated by a null character"),
> +       OPT_END()
> +};

You may want to mark help strings ("read file names from stdin" and
"input paths... null character") and check_ignore_usage[] for
translation. Just wrap those strings with N_() and you'll be fine. For
similar changes, check out nd/i18n-parseopt-help on branch 'pu'.

> +static void output_exclude(const char *path, struct exclude *exclude)
> +{
> +       char *type = exclude->to_exclude ? "excluded" : "included";
> +       char *bang = exclude->to_exclude ? "" : "!";
> +       char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
> +       printf(_("%s: %s %s%s%s "), path, type, bang, exclude->pattern, dir);

These English words "excluded" and "included" make the translator me
want to translate them. But they could be the markers for scripts, so
they may not be translated. How about using non alphanumeric letters
instead?

> +static void check_ignore(const char *prefix, const char **pathspec)
> +{
> +       struct dir_struct dir;
> +       const char *path;
> +       char *seen = NULL;
> +
> +       /* read_cache() is only necessary so we can watch out for submodules. */
> +       if (read_cache() < 0)
> +               die(_("index file corrupt"));
> +
> +       memset(&dir, 0, sizeof(dir));
> +       dir.flags |= DIR_COLLECT_IGNORED;
> +       setup_standard_excludes(&dir);

You should support ignore rules from files and command line arguments
too, like ls-files. For quick testing.

> +static NORETURN void error_with_usage(const char *msg)
> +{
> +       error("%s", msg);
> +       usage_with_options(check_ignore_usage, check_ignore_options);
> +}

Interesting. We have usage_msg_opt() in parse-options.c, but it's more
verbose. Perhaps this function should be moved to parse-options.c
because it may be useful to other commands as well?
-- 
Duy
