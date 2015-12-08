From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] blame: add support for --[no-]progress option
Date: Tue, 8 Dec 2015 03:22:32 -0500
Message-ID: <CAPig+cTQdnrHZWJDD6fqu_mQSJQv3oTz9_0Cu8j1aksUiq0FbQ@mail.gmail.com>
References: <1448426165-5139-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 09:22:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6DXi-0003fm-9g
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 09:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbbLHIWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 03:22:34 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34204 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbbLHIWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 03:22:33 -0500
Received: by vkbs1 with SMTP id s1so7555193vkb.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 00:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cafMQ7SayqVILHkxF56xQOcMey6m1wT+3Sw8cVIRBTw=;
        b=O9A2XF6WC7uYF6Y96UBIPYWGlQs3dqgiF8QhZ7Z300+kevvbPtQ7m5czyTwD+q0SV1
         JU6dSXuSQip1/yv+xGxNf2do3c6ZNoZmTbLIiANxW9nSAvM4zIm1r80Hj3VuRF4Xekk0
         5ao875YDu3x9B8SAcDHh3psUQZjnhdL+R6fjYomYixvBvyKK67v2hjDEqIjUUJDkPgXg
         MIfs446D/B246B7vurJ4W36TywGOy4TB0VQi9gCjeq1/7prjdZWdMlIO5dnteXnA9DVB
         XQA1o2fA+OzJ+tUKcMH20ssia9VzPesBr/SbRjLv3L2kfs2zucLne3EFJa3/zaAeUgq4
         GlCg==
X-Received: by 10.31.52.82 with SMTP id b79mr2194039vka.84.1449562952283; Tue,
 08 Dec 2015 00:22:32 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 8 Dec 2015 00:22:32 -0800 (PST)
In-Reply-To: <1448426165-5139-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: dF_CcWIzxltfKRLinpJ5VHBZ7Ls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282150>

On Tue, Nov 24, 2015 at 11:36 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> * created struct progress_info in builtin/blame.c
>   this struct holds the information used to display progress so
>   that only one additional parameter is passed to
>   found_guilty_entry().

Commit messages typically are composed of proper sentences and
paragraphs rather than bullets points. Also, write in imperative mood:
"Create progress_info..."

In this case, though, the information in this bullet point isn't all
that interesting for the commit message since it's a detail of
implementation easily gleaned by reading the patch itself. There's
nothing particularly tricky about it, thus it doesn't really deserve
to be called out as special in the commit message.

What might be more interesting and deserve mention in the commit
message is how this new option interacts with porcelain and
incremental modes and why the choice was made.

More below...

> * --[no-]progress option is also inherited by git-annotate.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> @@ -69,6 +69,13 @@ include::line-range-format.txt[]
>         iso format is used. For supported values, see the discussion
>         of the --date option at linkgit:git-log[1].
>
> +--[no-]progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal. This flag
> +       enables progress reporting even if not attached to a
> +       terminal. Progress information won't be displayed if using
> +       `--porcelain` or `--incremental`.

Is silently ignoring --progress a good idea when combined with
--porcelain or --incremental, or would it be better to error out with
a "mutually exclusive options" diagnostic? (Genuine question.)

> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>  [verse]
>  'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
>             [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
> -           [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
> +           [--[no-]progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]

Hmm, is [--[no-]progress] common in Git documentation? (Genuine
question.) For the synopsis, I'd have expected to see only
[--progress] and leave it to the more detailed description of the
option to mention the possibility of negation (but I haven't
double-checked other documentation, so my expectation may be skewed).

>  DESCRIPTION
>  -----------
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -127,6 +129,11 @@ struct origin {
> +struct progress_info {
> +       struct progress *progress;
> +       int blamed_lines;
> +};
> @@ -1746,7 +1753,8 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
> -static void found_guilty_entry(struct blame_entry *ent)
> +static void found_guilty_entry(struct blame_entry *ent,
> +                          struct progress_info *pi)
> @@ -1758,6 +1766,8 @@ static void found_guilty_entry(struct blame_entry *ent)
> +       if (pi)
> +               display_progress(pi->progress, pi->blamed_lines += ent->num_lines);

This is updating of 'blamed_lines' is rather subtle and easily
overlooked. Splitting it out as a separate statement could improve
readability:

    pi->blamed_lines += ent->num_lines;
    display_progress(pi->progress, pi->blamed_lines);

>  }
> @@ -1768,6 +1778,16 @@ static void assign_blame(struct scoreboard *sb, int opt)
>  {
>         struct rev_info *revs = sb->revs;
>         struct commit *commit = prio_queue_get(&sb->commits);
> +       struct progress_info *pi = NULL;
> +
> +       if (show_progress) {
> +               pi = malloc(sizeof(*pi));
> +               if (pi) {

xmalloc(), unlike malloc(), will die() upon allocation failure which
would allow you to avoid the "if (pi)" conditional.

> +                       pi->progress = start_progress_delay(_("Blaming lines"),
> +                                                           sb->num_lines, 50, 1);
> +                       pi->blamed_lines = 0;
> +               }
> +       }
>
>         while (commit) {
>                 struct blame_entry *ent;
> @@ -1809,7 +1829,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
>                         suspect->guilty = 1;
>                         for (;;) {
>                                 struct blame_entry *next = ent->next;
> -                               found_guilty_entry(ent);
> +                               found_guilty_entry(ent, pi);
>                                 if (next) {
>                                         ent = next;
>                                         continue;
> @@ -1825,6 +1845,11 @@ static void assign_blame(struct scoreboard *sb, int opt)
>                 if (DEBUG) /* sanity */
>                         sanity_check_refcnt(sb);
>         }
> +
> +       if (pi) {
> +               stop_progress(&pi->progress);
> +               free(pi);
> +       };

Style: drop semi-colon following closing brace

Overall, use of malloc/free for the progress_info struct seems to
makes the code more complex rather than less. It's not clear why you
don't just use a 'struct progress_info' directly, which would lift the
burden of freeing the allocated structure, and allow you to drop the
conditional around stop_progress() since NULL progress is accepted. In
other words, something like this (completely untested):

    struct progress_info pi = { NULL, 0 };
    if (show_progress) {
        pi.progress = start_progress_delay(...);
    ...
    found_guilty_entry(ent, &pi);
    ...
    stop_progress(&pi.progress)

which is more concise and less likely to leak resources. The code
within found_guilty_entry() is also simplified since you can drop the
"if (pi)" conditional entirely. This works because it's safe to call
display progress with NULL):

    pi->blamed_lines += ent->num_lines;
    display_progress(pi->progress, pi->blamed_lines);

>  }
>
>  static const char *format_time(unsigned long time, const char *tz_str,
> @@ -2579,6 +2606,11 @@ parse_done:
>         DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
>         argc = parse_options_end(&ctx);
>
> +       if (incremental || (output_option & OUTPUT_PORCELAIN))
> +               show_progress = 0;
> +       else if (show_progress < 0)
> +               show_progress = isatty(2);
> +
