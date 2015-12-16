From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] blame: add support for --[no-]progress option
Date: Wed, 16 Dec 2015 02:47:24 -0500
Message-ID: <CAPig+cTFsZCowqNxmNtr1za+O6KjZmqJBZLGmUFd77rHmD+5pQ@mail.gmail.com>
References: <1449967863-31194-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 08:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a96o6-0000qI-VF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 08:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbbLPHr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 02:47:26 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36519 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbbLPHrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 02:47:25 -0500
Received: by mail-vk0-f52.google.com with SMTP id y187so21283271vka.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 23:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=os9XzuL5MjmulQnMoybJuO4EHEaXPmYRExvxJGOG6Dg=;
        b=TIhMAC+ZXAC+hSpzDI7rADKSVMr82adq6XFPsxnhAZufWXV2OWhPP3jGfqnh096M2N
         VcStmg9MgbtHWLREx8XJ1RM0vCfq9xFZrgfgdH9pXEgbQOvscVDVp8VVF6Zp+jZ9yJ4r
         AzsuoWeUmSetUoVr07ZxF9dw4wQeddpkwFhMzzAu8zAhXSzL6NknJlL/BvgouwOw6G9m
         BeXL1HHxoR6ELii0lM7lDYYOKaq2PDpB9wX6Si5qFBh7Wj3fjkCjEqipo2Y/N+vwSi0f
         0IwM9kgR+vjTjzhsB0wVV7/J1w1PtFU9Ct9RbLuuEPVvMecmdZkSbKsd90PNT7jPJzzL
         wEEg==
X-Received: by 10.31.182.129 with SMTP id g123mr32605806vkf.45.1450252044274;
 Tue, 15 Dec 2015 23:47:24 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 15 Dec 2015 23:47:24 -0800 (PST)
In-Reply-To: <1449967863-31194-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: p_FhD-sKrsfSyXhxO3RZi-8iG3I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282540>

On Sat, Dec 12, 2015 at 7:51 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> --progress can't be used with --incremental or
>  porcelain formats.
>
> git-annotate inherits the option as well
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---

This version seems to address all the issues raised in my reviews of
previous rounds, and the new code is more concise, well-formed, and
easier to follow than earlier attempts. Thanks.

For the sake of other reviewers, recent previous versions and reviews are here:

v6: http://thread.gmane.org/gmane.comp.version-control.git/282305
v5: http://thread.gmane.org/gmane.comp.version-control.git/281677

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 760eab7..02cb684 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -69,6 +69,13 @@ include::line-range-format.txt[]
>         iso format is used. For supported values, see the discussion
>         of the --date option at linkgit:git-log[1].
>
> +--[no-]progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal. This flag
> +       enables progress reporting even if not attached to a
> +       terminal. Can't use `--progress` together with `--porcelain`
> +       or `--incremental`.
> +
>  -M|<num>|::
>         Detect moved or copied lines within a file. When a commit
>         moves or copies a block of lines (e.g. the original file
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index e6e947c..ba54175 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>  [verse]
>  'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
>             [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
> -           [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
> +           [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
> +           [--] <file>
>
>  DESCRIPTION
>  -----------
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 2afe828..e78ca09 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -28,6 +28,7 @@
>  #include "line-range.h"
>  #include "line-log.h"
>  #include "dir.h"
> +#include "progress.h"
>
>  static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
>
> @@ -50,6 +51,7 @@ static int incremental;
>  static int xdl_opts;
>  static int abbrev = -1;
>  static int no_whole_file_rename;
> +static int show_progress;
>
>  static struct date_mode blame_date_mode = { DATE_ISO8601 };
>  static size_t blame_date_width;
> @@ -127,6 +129,11 @@ struct origin {
>         char path[FLEX_ARRAY];
>  };
>
> +struct progress_info {
> +       struct progress *progress;
> +       int blamed_lines;
> +};
> +
>  static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
>                       xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
>  {
> @@ -1746,7 +1753,8 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
>   * The blame_entry is found to be guilty for the range.
>   * Show it in incremental output.
>   */
> -static void found_guilty_entry(struct blame_entry *ent)
> +static void found_guilty_entry(struct blame_entry *ent,
> +                          struct progress_info *pi)
>  {
>         if (incremental) {
>                 struct origin *suspect = ent->suspect;
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
> @@ -1825,6 +1840,8 @@ static void assign_blame(struct scoreboard *sb, int opt)
>                 if (DEBUG) /* sanity */
>                         sanity_check_refcnt(sb);
>         }
> +
> +       stop_progress(&pi.progress);
>  }
>
>  static const char *format_time(unsigned long time, const char *tz_str,
> @@ -2520,6 +2537,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                 OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
>                 OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
>                 OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
> +               OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
>                 OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
>                 OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
>                 OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
> @@ -2555,6 +2573,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>
>         save_commit_buffer = 0;
>         dashdash_pos = 0;
> +       show_progress = -1;
>
>         parse_options_start(&ctx, argc, argv, prefix, options,
>                             PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
> @@ -2579,6 +2598,13 @@ parse_done:
>         DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
>         argc = parse_options_end(&ctx);
>
> +       if (incremental || (output_option & OUTPUT_PORCELAIN)) {
> +               if (show_progress > 0)
> +                       die("--progress can't be used with --incremental or porcelain formats");
> +               show_progress = 0;
> +       } else if (show_progress < 0)
> +               show_progress = isatty(2);
> +
>         if (0 < abbrev)
>                 /* one more abbrev length is needed for the boundary commit */
>                 abbrev++;
> @@ -2828,11 +2854,11 @@ parse_done:
>
>         read_mailmap(&mailmap, NULL);
>
> +       assign_blame(&sb, opt);
> +
>         if (!incremental)
>                 setup_pager();
>
> -       assign_blame(&sb, opt);
> -
>         free(final_commit_name);
>
>         if (incremental)
> --
> 2.6.2
