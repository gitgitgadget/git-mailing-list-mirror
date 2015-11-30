From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] Add git-grep threads param
Date: Mon, 30 Nov 2015 14:31:56 -0500
Message-ID: <CAPig+cQZVgPfjwEsA+iDjvJu_gMtz65TA9ZUt3nTT1VhQxRk9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"john@keeping.me.uk" <john@keeping.me.uk>,
	"peff@peff.net" <peff@peff.net>,
	Victor Leschuk <vleschuk@gmail.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:32:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3UB7-0000L5-SJ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbbK3Tb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:31:58 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34907 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbK3Tb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:31:57 -0500
Received: by vkha189 with SMTP id a189so108789344vkh.2
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=2eBt9d5L5NNpwTRjlPtvghvy4SpNVBG1fHFJH1eTnsA=;
        b=qURmxvpA6XVOIncI4SbQAIw8LZI/44+XBs6qnyjf0RJyZWMzqf7rNzamJoTetllDLH
         9c+V/vfYWu5Ylc4ttap0Yz05gRcXcBm9/3N1PnSo7etcCXHaUjG6wcUhPTWePALyG/en
         NqQ/VFvM0wrtE0fC3t/WH930Ibc7yM+XUGUJWe2j/n76Ji5WJOxh/XBg8F2JrgL26ktI
         LddyzS+Oopi/rs2YBeLBYtC8qicfOZBJYnA+Kach+7WXbSGEGF6N2lpq9cWdP/ufjUTp
         fnVLZJ/U1kd1fFJzoqqT4H0knBjbnT9Y4DHxwBSsdpwCZB49ldect2XB74qEpxFwxywB
         kaNQ==
X-Received: by 10.31.58.74 with SMTP id h71mr55078057vka.151.1448911916571;
 Mon, 30 Nov 2015 11:31:56 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 30 Nov 2015 11:31:56 -0800 (PST)
X-Google-Sender-Auth: IDSAIF17T20Tix53jPIjSYagtbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281817>

On Mon, Nov 16, 2015 at 8:11 AM, Victor Leschuk
<vleschuk@accesssoftek.com> wrote:
> "git grep" can now be configured (or told from the command line)
>  how many threads to use when searching in the working tree files.
>
>  Changes to default behavior: number of threads now doesn't depend
>  on online_cpus(), e.g. if specific number is not configured
>  GREP_NUM_THREADS_DEFAULT (8) threads will be used even on 1-core CPU.

It's good that this behavior change (no longer consulting
online_cpus()) is now mentioned[1] in the commit message, however,
it's also important for people to understand why this change was made,
but such explanation is missing here. It's important to justify the
change in the commit message itself since only a few people were
involved in the mailing list discussion which led to the change, and
even those people may forget the reasoning at some point.

Moreover, this change (dropping online_cpus()) is sufficiently
significant and distinct from the overall purpose of the present patch
(adding --threads and 'grep.threads') that it really deserves its own
separate patch (as hinted by [1]), which would turn this into a
2-patch series.

[1]: http://article.gmane.org/gmane.comp.version-control.git/281133/

> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1447,6 +1447,13 @@ grep.extendedRegexp::
> +grep.threads::
> +       Number of grep worker threads, use it to tune up performance on
> +       your machines. Leave it unset (or set to 0) for default behavior,
> +       which for now is using 8 threads for all systems.

You could drop "for now", which is redundant with the sentence which follows.

> +       Default behavior can be changed in future versions
> +       to better suit hardware and circumstances.

"may change" might read better than "can be changed".

>  gpg.program::
>         Use this custom program instead of "gpg" found on $PATH when
>         making or verifying a PGP signature. The program must support the
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> @@ -53,6 +54,13 @@ grep.extendedRegexp::
> +grep.threads::
> +       Number of grep worker threads, use it to tune up performance on
> +       your machines. Leave it unset (or set to 0) for default behavior,
> +       which for now is using 8 threads for all systems.
> +       Default behavior can be changed in future versions
> +       to better suit hardware and circumstances.

Same comments as above.

> @@ -227,6 +235,13 @@ OPTIONS
> +--threads <num>::
> +       Number of grep worker threads, use it to tune up performance on
> +       your machines. Leave it unset (or set to 0) for default behavior,
> +       which for now is using 8 threads for all systems.
> +       Default behavior can be changed in future versions
> +       to better suit hardware and circumstances.

Ditto.

Would it make more sense just to have the detailed description in one
place and then reference it from the other places rather than
repeating in all places?

> diff --git a/builtin/grep.c b/builtin/grep.c
> @@ -262,10 +265,19 @@ static int wait_all(void)
> +static int grep_threads_config(const char *var, const char *value, void *cb)
> +{
> +       if (!strcmp(var, "grep.threads"))
> +               num_threads = git_config_int(var, value); /* Sanity check of value will be perfomed later */

Nit: This is a pretty wide line. Perhaps the comment could be moved to
its own line to stay below 80 columns?

> +       return 0;
> +}
> +
>  static int grep_cmd_config(const char *var, const char *value, void *cb)
>  {
>         int st = grep_config(var, value, cb);
> -       if (git_color_default_config(var, value, cb) < 0)
> +       if (grep_threads_config(var, value, cb) < 0)
> +               st = -1;
> +       else if (git_color_default_config(var, value, cb) < 0)
>                 st = -1;

Nit: Custom is to add new cases following existing ones, which would
give you a less noisy diff.

>         return st;
>  }
> @@ -832,14 +846,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         }
>
>  #ifndef NO_PTHREADS
> -       if (list.nr || cached || online_cpus() == 1)
> -               use_threads = 0;
> +       if (list.nr || cached)
> +               num_threads = 0; /* Can not multi-thread object lookup */
> +       else if (num_threads == 0)
> +               num_threads = GREP_NUM_THREADS_DEFAULT; /* User didn't specify value, or just wants default behavior */

Nit: Overly wide line.

> +       else if (num_threads < 0)
> +               die("Invalid number of threads specified (%d)", num_threads);

If you validate the value earlier, rather than delaying it until here,
you can give a more useful error message which would state whence the
bad value arose (config vs. command-line). This may or may not be a
worthwhile improvement.

>  #else
> -       use_threads = 0;
> +       num_threads = 0;
>  #endif
>
>  #ifndef NO_PTHREADS
> -       if (use_threads) {
> +       if (num_threads) {
>                 if (!(opt.name_only || opt.unmatch_name_only || opt.count)
>                     && (opt.pre_context || opt.post_context ||
>                         opt.file_break || opt.funcbody))
