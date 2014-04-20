From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/6] run_external_diff: use an argv_array for the command line
Date: Sat, 19 Apr 2014 21:20:52 -0400
Message-ID: <CAPig+cR3AeuZ1ZnkKSocje0Yr2Eb37R2rgM=igEpdf6C5GEsvQ@mail.gmail.com>
References: <20140419191128.GA9266@sigill.intra.peff.net>
	<20140419191706.GA8981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Max L <infthi.inbox@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 20 03:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbgRq-0008RB-Fl
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 03:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbaDTBUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 21:20:54 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:46513 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbaDTBUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 21:20:53 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so2465794ykr.31
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 18:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s5AQGdczIOrXlMZd/VCi7sD7O0dVzzonGOOZGQwyIRo=;
        b=fAGZRAePsldxTaNIzROLePUR+9iQf45PBFrHWRChks8zX6DOVRND9bhQYtRXb+Dgyv
         Sw7DvKiiBS9As4TG+hN7cAn0ZZ0EQM+kn4B0Az95UxN11jbhBOvgjOK4Rj5b1JQvjbpG
         sYHLuLD5pXkqrz9DPe1fGRF0PSVdEDTdTWIO7egRFH8jr5C/O2rygGQyVWtHXiWVX57y
         jZqrGrvTVTp8f1yxT9ey9YzgVClhrzQWBhf2Rn2hvJ1o8A2ETze51Rq161FGnrcYl3Gk
         SUR4BaEfT6166Bj2VEidu/yAV+a7qVAeI3NYv2dCwVdgM69RTWDsH6gT5noB+NVheORh
         xBvw==
X-Received: by 10.236.137.8 with SMTP id x8mr40524690yhi.4.1397956852350; Sat,
 19 Apr 2014 18:20:52 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Sat, 19 Apr 2014 18:20:52 -0700 (PDT)
In-Reply-To: <20140419191706.GA8981@sigill.intra.peff.net>
X-Google-Sender-Auth: OWyw1t8cBLrN-sSg739OeB_6LL4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246544>

On Sat, Apr 19, 2014 at 3:17 PM, Jeff King <peff@peff.net> wrote:
> We currently generate the command-line for the external
> command using a fixed-length array of size 10. But if there
> is a rename, we actually need 11 elements (10 items, plus a
> NULL), and end up writing a random NULL onto the stack.
>
> Rather than bump the limit, let's just an argv_array, which

s/just/just use/

> makes this sort of error impossible.
>
> Noticed-by: Max L <infthi.inbox@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was actually noticed by a GitHub user, who proposed bumping
> the array size to 11:
>
>   https://github.com/git/git/pull/92
>
> Even though this fix is a bigger change, I'd rather do it this way, as
> it is more obviously correct to a reader (and it solves the problem
> forever). I pulled the name/email from that commit, but please let me
> know if you'd prefer to be credited differently.
>
>  diff.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 539997f..b154284 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -16,6 +16,7 @@
>  #include "submodule.h"
>  #include "ll-merge.h"
>  #include "string-list.h"
> +#include "argv-array.h"
>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -2902,9 +2903,8 @@ static void run_external_diff(const char *pgm,
>                               int complete_rewrite,
>                               struct diff_options *o)
>  {
> -       const char *spawn_arg[10];
> +       struct argv_array argv = ARGV_ARRAY_INIT;
>         int retval;
> -       const char **arg = &spawn_arg[0];
>         struct diff_queue_struct *q = &diff_queued_diff;
>         const char *env[3] = { NULL };
>         char env_counter[50];
> @@ -2915,23 +2915,22 @@ static void run_external_diff(const char *pgm,
>                 const char *othername = (other ? other : name);
>                 temp_one = prepare_temp_file(name, one);
>                 temp_two = prepare_temp_file(othername, two);
> -               *arg++ = pgm;
> -               *arg++ = name;
> -               *arg++ = temp_one->name;
> -               *arg++ = temp_one->hex;
> -               *arg++ = temp_one->mode;
> -               *arg++ = temp_two->name;
> -               *arg++ = temp_two->hex;
> -               *arg++ = temp_two->mode;
> +               argv_array_push(&argv, pgm);
> +               argv_array_push(&argv, name);
> +               argv_array_push(&argv, temp_one->name);
> +               argv_array_push(&argv, temp_one->hex);
> +               argv_array_push(&argv, temp_one->mode);
> +               argv_array_push(&argv, temp_two->name);
> +               argv_array_push(&argv, temp_two->hex);
> +               argv_array_push(&argv, temp_two->mode);
>                 if (other) {
> -                       *arg++ = other;
> -                       *arg++ = xfrm_msg;
> +                       argv_array_push(&argv, other);
> +                       argv_array_push(&argv, xfrm_msg);
>                 }
>         } else {
> -               *arg++ = pgm;
> -               *arg++ = name;
> +               argv_array_push(&argv, pgm);
> +               argv_array_push(&argv, name);
>         }
> -       *arg = NULL;
>         fflush(NULL);
>
>         env[0] = env_counter;
> @@ -2940,8 +2939,9 @@ static void run_external_diff(const char *pgm,
>         env[1] = env_total;
>         snprintf(env_total, sizeof(env_total), "GIT_DIFF_PATH_TOTAL=%d", q->nr);
>
> -       retval = run_command_v_opt_cd_env(spawn_arg, RUN_USING_SHELL, NULL, env);
> +       retval = run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env);
>         remove_tempfile();
> +       argv_array_clear(&argv);
>         if (retval) {
>                 fprintf(stderr, "external diff died, stopping at %s.\n", name);
>                 exit(1);
> --
> 1.9.1.656.ge8a0637
