From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] checkout: add --progress option
Date: Sun, 1 Nov 2015 12:52:57 -0500
Message-ID: <CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
References: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 18:53:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZswoS-0000RB-45
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 18:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbbKARw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 12:52:59 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35733 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbbKARw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 12:52:58 -0500
Received: by vkfw189 with SMTP id w189so73407192vkf.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kgY4cfQHWR9VyfaY1npL7Nw6hNHo5n+UWxAvyLv3kNI=;
        b=tkcELYe0Jpe48hhZtbGAIknU9SnDGuaSEeT/YCY/AtcFDaVl5iKbfa5VjRsLlEgA2w
         DSIlB2xUiKF4SP7QnGtl7+W8V7bfzQ7kgfPTySOsOnBU35zrRuYvC9mENq61aBqfp5Aw
         R2q0pv7Cxw3ZuGRjtPu4HbtosXzaH4lQTzaD8QpVHwWZRDu4l2W7nO/61f2T3uadC3NB
         W6v2M+Gm8UhpG5Pp3p5qOcHRWJHwTd9VFJx3rY3nYp93k9lTgUIFE2IYb2N++bVzMYyx
         FL2N7LEFFf9ujuKJoVFNyvw1xdqC3T6pc+La/ClJg7zWvhuhv02daOPAJ3IAeJjOGS8E
         0SCQ==
X-Received: by 10.31.56.75 with SMTP id f72mr12639499vka.115.1446400377660;
 Sun, 01 Nov 2015 09:52:57 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 09:52:57 -0800 (PST)
In-Reply-To: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: J02WrefTNquWkwPGfxNb6sGrZHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280641>

On Sun, Nov 1, 2015 at 12:47 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Under normal circumstances, and like other git commands,
> git checkout will write progress info to stderr if
> attached to a terminal. This option allows progress
> to be forced even if not using a terminal. Also,
> progress can be skipped if using option --no-progress.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index e269fb1..93ba35a 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -107,6 +107,12 @@ OPTIONS
>  --quiet::
>         Quiet, suppress feedback messages.
>
> +--progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless -q
> +       is specified. This flag forces progress status even if the
> +       standard error stream is not directed to a terminal.

What this kind of implies, but neglects to say explicitly, is that the
logic implemented by this patch also overrides --quiet. It probably
should say so explicitly.

I realize that this text was copied from elsewhere (likely from
git-clone.txt), but git-checkout.txt does try to do a bit better job
with formatting, so it might be a good idea to quote -q with backticks
(`-q` or `--quiet`).

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bc703c0..c3b8e5d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1163,6 +1165,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         memset(&new, 0, sizeof(new));
>         opts.overwrite_ignore = 1;
>         opts.prefix = prefix;
> +       opts.show_progress = -1;
>
>         gitmodules_config();
>         git_config(git_checkout_config, &opts);
> @@ -1172,6 +1175,25 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options, checkout_usage,
>                              PARSE_OPT_KEEP_DASHDASH);
>
> +       /*
> +        * Final processing of show_progress
> +        * - User selected --progress: show progress
> +        * - user selected --no-progress: skip progress
> +        * - User didn't specify:
> +        *     (check rules in order till finding the first matching one)
> +        *     - user selected --quiet: skip progress
> +        *     - stderr is connected to a terminal: show progress
> +        *     - fallback: skip progress
> +        */

It takes longer to read and digest this comment block than it does to
comprehend the actual logic in code, which is pretty clear in its
current form. Comment blocks which merely repeat easily digested code
add little, if any, value, so it might be worthwhile to drop the
comment altogether.

> +       if (opts.show_progress < 0) {
> +               /* user didn't specify --[no-]progress */

Here, also, consider dropping the comment which merely repeats what
the code already states clearly.

> +               if (opts.quiet) {
> +                       opts.show_progress = 0;
> +               } else {
> +                       opts.show_progress = isatty(2);
> +               }

Style: drop unnecessary braces

> +       }
> +
>         if (conflict_style) {
>                 opts.merge = 1; /* implied */
>                 git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> --
> 2.6.1
