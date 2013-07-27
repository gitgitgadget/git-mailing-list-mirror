From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtins: search builtin commands via binary search.
Date: Fri, 26 Jul 2013 20:26:59 -0400
Message-ID: <CAPig+cRO4tBi21zPpw3i+9E3xvvJQDmc=CFU5Xyy7zhoJi1Fhg@mail.gmail.com>
References: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 02:27:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2sLj-0006ot-II
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 02:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758340Ab3G0A1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 20:27:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40241 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301Ab3G0A1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 20:27:01 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2980710lbi.33
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=+cuQS++Z4e583HMA9m3PTpW/+eGPXn1aYLLU3dAZ+z8=;
        b=TqRVQz8NFjfdR1Dj+KMf4SiJ/bCQJ8vtVunAUuTMJF40nnCqX7CUYVNLLtMmrfpf/W
         XPkz1Ge0Kt17uqXC+Lx50ZRVIshOGYXcHJjKwd9EZQWvPls59N6ZxCwSFdjRFEZl2RBC
         W9QRG03AJTUq0U3vexMIyuuUpQhUzoABZLMQxiAvqUXHCmbrulLgST+rHe82W+5IjBjY
         pUJuhAtiYrwjGoApnjGUemrRAdjtCKMs/n53r5URjgqL3Auxb37v8HSDqLX9JIfmoNr3
         VcoI4kTFEXpFNPYsVpDONOUbtGFHv7VxeCynBl5E2bt4wlcs0D/mmV1DgUy1A0pVt00T
         5gvg==
X-Received: by 10.112.97.132 with SMTP id ea4mr21095734lbb.80.1374884819543;
 Fri, 26 Jul 2013 17:26:59 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Fri, 26 Jul 2013 17:26:59 -0700 (PDT)
In-Reply-To: <1374871850-24323-1-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: Fni5RiA0mLGu1T4ck35EVmGbhXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231220>

On Fri, Jul 26, 2013 at 4:50 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> There are currently 115 commands built into the git executable.
> Before this commit, it was iterated over these commands in a linear
> order, i.e. each command was checked.
>
> As it turns out the commands are already sorted alphabetically, it is easy
> to perform a binary search instead of linear searching.
> This results in 7 lookups in the worst case.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  git.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/git.c b/git.c
> index 2025f77..0d7a9b5 100644
> --- a/git.c
> +++ b/git.c
> @@ -309,9 +309,18 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>         return 0;
>  }
>
> +static int compare_internal_command(const void *a, const void *b) {
> +       /* The first parameter is of type char* describing the name,
> +          the second is a struct cmd_struct */
> +       const char *name = (const char*)a;
> +       const struct cmd_struct *cmd_struct = (struct cmd_struct*)b;

Comments typically exist to elucidate something non-obvious in the
code, however, in this case the code and comment say the same thing,
making the comment redundant. Such redundancy can make code harder to
read since the reader has to take extra time to figure out if the
comment is really explaining something not obvious in the code. Thus,
this comment can be removed without loss of clarity.

> +       return strcmp(name, cmd_struct->cmd);
> +}
> +
>  static void handle_internal_command(int argc, const char **argv)
>  {
>         const char *cmd = argv[0];
> +       /* commands must be sorted alphabetically */
>         static struct cmd_struct commands[] = {

This new comment, on the other hand does explain something not obvious
at this point in the code.

>                 { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>                 { "annotate", cmd_annotate, RUN_SETUP },
> @@ -447,12 +456,12 @@ static void handle_internal_command(int argc, const char **argv)
>                 argv[0] = cmd = "help";
>         }
>
> -       for (i = 0; i < ARRAY_SIZE(commands); i++) {
> -               struct cmd_struct *p = commands+i;
> -               if (strcmp(p->cmd, cmd))
> -                       continue;
> +       struct cmd_struct *p = (struct cmd_struct *)bsearch(cmd, commands,
> +                               ARRAY_SIZE(commands), sizeof(struct cmd_struct),
> +                               compare_internal_command);

Since this will break down if the commands[] array becomes unsorted,
it would make sense to protect against such a failure. For instance,
you could add a check in Makefile which triggers when git.c is edited.
It might do something like this:

  awk '/cmd_struct commands/,/};/ { if (match($2,/"/)) print $2 }'
    <git.c >builtin.actual &&
  sort <builtin.actual >builtin.expect &&
  cmp -s builtin.expect builtin.actual &&
  rm builtin.expect builtin.actual

> +
> +       if (p)
>                 exit(run_builtin(p, argc, argv));
> -       }
>  }
>
>  static void execv_dashed_external(const char **argv)
> --
