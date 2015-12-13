From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 19:17:12 -0500
Message-ID: <CAPig+cQq2Y0m0UJVCMb-9B8qrGNXV7ecf5hDETdgX5w4oUuAvw@mail.gmail.com>
References: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:17:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7uML-0004nz-70
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbbLMARO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:17:14 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34555 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbLMARN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:17:13 -0500
Received: by vkgj66 with SMTP id j66so39491729vkg.1
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i5vCwBYXxJTG8xt8ap360Hzf0wRLbHriYK6PwelIk2I=;
        b=pyTI7PkkDSPaV8/YBty/TVYMMAP8HbSD1JS2MJ5OcpaLMfTuHjNTYsDKI6p4XKY43j
         4xdUGroLWCrusNg5OlgfQ6NdDw2NeedmJlCvlIH8NCJuh4DBjG2AdSebvuNtN/+/AjyJ
         qbuVMj/KIL7WdPDYAGt6jnmEmGj0v8CE0iFWOaEkz7Ok57ikgBUcV299t/jD+fmdboTB
         BBMKAIXu9yCE9SojK43JoqOAO8dSxfDKjNcbzIzqsasALzbMhxagEdzFiT4HI/S4vXnf
         C1OoKfDbfSES2ppNps2BlP1EdQsi5kLtdxeXT/P+vv0PXggv054zwaGPLZWbRmbrwYmS
         xzTg==
X-Received: by 10.31.56.18 with SMTP id f18mr17410107vka.19.1449965832637;
 Sat, 12 Dec 2015 16:17:12 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 16:17:12 -0800 (PST)
In-Reply-To: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: ihGTHbGlfYXnlorWL_BTS9WDx-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282307>

On Sat, Dec 12, 2015 at 6:57 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> --progress can't be used with --incremental or
>  porcelain formats.
>
> git-annotate inherits the option as well
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---

Right here below the "---" line would be a good place to explain what
changed since the previous version. As an aid for reviewers, it's also
helpful to provide a link to the previous round, like this[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/281677

>  Documentation/blame-options.txt |  7 +++++++
>  Documentation/git-blame.txt     |  3 ++-
>  builtin/blame.c                 | 35 +++++++++++++++++++++++++++++++----
>  3 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> @@ -69,6 +69,13 @@ include::line-range-format.txt[]
> +--[no-]progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal. This flag
> +       enables progress reporting even if not attached to a
> +       terminal. Progress information won't be displayed if using
> +       `--porcelain` or `--incremental`.

The actual implementation (below) actively forbids --progress with
--porcelain or --incremental, so the final sentence is misleading.
Perhaps say instead that "--progress is incompatible with --porcelain
and --incremental".

More below...

> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -127,6 +129,11 @@ struct origin {
> +struct progress_info {
> +       struct progress *progress;
> +       int blamed_lines;
> +};
> +
> @@ -1758,6 +1766,8 @@ static void found_guilty_entry(struct blame_entry *ent)
>                 write_filename_info(suspect->path);
>                 maybe_flush_or_die(stdout, "stdout");
>         }
> +       pi->blamed_lines += ent->num_lines;
> +       display_progress(pi->progress, pi->blamed_lines);
>  }
>
>  /*
> @@ -1768,6 +1778,11 @@ static void assign_blame(struct scoreboard *sb, int opt)
>  {
>         struct rev_info *revs = sb->revs;
>         struct commit *commit = prio_queue_get(&sb->commits);
> +       struct progress_info pi = { NULL, 0 };
> +
> +       if (show_progress)
> +               pi.progress = start_progress_delay(_("Blaming lines"),
> +                                                  sb->num_lines, 50, 1);
>
>         while (commit) {
>                 struct blame_entry *ent;
> @@ -1809,7 +1824,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
>                         suspect->guilty = 1;
>                         for (;;) {
>                                 struct blame_entry *next = ent->next;
> -                               found_guilty_entry(ent);
> +                               found_guilty_entry(ent, &pi);
>                                 if (next) {
>                                         ent = next;
>                                         continue;
> @@ -1825,6 +1840,9 @@ static void assign_blame(struct scoreboard *sb, int opt)
>                 if (DEBUG) /* sanity */
>                         sanity_check_refcnt(sb);
>         }
> +
> +       if (pi.progress)
> +               stop_progress(&pi.progress);

As noted in the v5 review[2], stop_progress() itself handles NULL
'struct progress' gracefully, so the 'if (pi.progress)' conditional is
unnecessary, thus the code can be simplified further to merely:

    stop_progress(&pi.progress);

Other than this nit, the implementation is now much cleaner and easier
to follow.

[2]: http://article.gmane.org/gmane.comp.version-control.git/282150

>  }
>
>  static const char *format_time(unsigned long time, const char *tz_str,
> @@ -2555,6 +2574,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>
>         save_commit_buffer = 0;
>         dashdash_pos = 0;
> +       show_progress = -1;
>
>         parse_options_start(&ctx, argc, argv, prefix, options,
>                             PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
> @@ -2579,6 +2599,13 @@ parse_done:
>         DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
>         argc = parse_options_end(&ctx);
>
> +       if (incremental || (output_option & OUTPUT_PORCELAIN)) {
> +               if (show_progress > 0)
> +                       die("--progress can't be used with --incremental or porcelain formats");
> +               show_progress = 0;
> +       } else if (show_progress < 0)
> +               show_progress = isatty(2);

The 'show_progress = 0' seems unnecessary. What if you did something
like this instead?

    if (show_progress > 0 && (incremental ||
            (output_option & OUTPUT_PORCELAIN)))
        die("--progress can't be used with...");
    else if (show_progress < 0)
        show_progress = isatty(2);

>         if (0 < abbrev)
>                 /* one more abbrev length is needed for the boundary commit */
>                 abbrev++;
