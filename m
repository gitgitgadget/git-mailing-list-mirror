From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v1] blame: add support for --[no-]progress option
Date: Sat, 21 Nov 2015 23:27:54 -0600
Message-ID: <CAOc6etbfzrqT4-5dorCAq_=5Oh9wXV4LgRwK9hrEqjmSYHiBEg@mail.gmail.com>
References: <1448169116-32335-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Max A.K." <max@max630.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 06:28:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0NCV-0002IK-4m
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 06:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbbKVF14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 00:27:56 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36424 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbbKVF1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 00:27:55 -0500
Received: by pacdm15 with SMTP id dm15so158027708pac.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 21:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n8axFc9P7LLoo5G/gsNDVLJXumw3qCwyw6rFD7rOCkI=;
        b=mPoXDJFLl2s5YWxm56e7pYktnOJxIIQMPOcA2n+09miky+McYJbjCMqWhddCnLrBA7
         IrC2MLx/moCFnsuW1gRbGzuqK5NexUrBqt5JeYiSYzRkfuv5Gxz5fVWdNIwMalzhcgSv
         nF2AQn5RsrWtCF1lG2hKFz13mG1YLRl4QdrvS2tgET8blgcCu1a88MvQKLDAUixGGJ43
         Q2KExamlLo2dBwspISMIDLvNMl4mw89rVYKz0JigMkpyEx8Xsgz/5WlyZNqT+DMWosEq
         eFvsp9b6u6k3krgIeAYie2AsWmjJi28h8TzExecIEcIpd915srNBHtCQ73dFlVeGBR8O
         nXxw==
X-Received: by 10.66.254.234 with SMTP id al10mr29100087pad.115.1448170075042;
 Sat, 21 Nov 2015 21:27:55 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sat, 21 Nov 2015 21:27:54 -0800 (PST)
In-Reply-To: <1448169116-32335-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281561>

Hey, guys!

Time for some more patch destruction.

On Sat, Nov 21, 2015 at 11:11 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
-static void assign_blame(struct scoreboard *sb, int opt)
+static void assign_blame(struct scoreboard *sb, int opt, int show_progress)

Would it be better to include show_progress as a binary flag in opt
instead of a separate variable?

> +       struct progress * progress = NULL;
> +       int blamed_lines = -1;

I'm wondering if it would be better to save the 'last number used in
progress' inside struct progress so that we could skip blamed_lines.
That would also allow progress itself (as in the API) to avoid
printing duplicated progress values. In my case, I'm going through a
number of cycles where _I think_ I might have the same number of
blamed lines detected. To avoid asking to do a new progress print out
with the same value, I'm checking the value I had used last time. If
progress took care of that check up, this variable would go for good
and I would just ask progress to print with the current value (no
matter if it's duplicate or an increased value).

> +
> +       if (show_progress) {
> +               progress = start_progress(_("Blaming lines"), sb->num_lines);
> +       }

Already noticed I can get rid of the curly brackets.

>
>         while (commit) {
>                 struct blame_entry *ent;
> @@ -1822,9 +1838,21 @@ static void assign_blame(struct scoreboard *sb, int opt)
>                 }
>                 origin_decref(suspect);
>
> +               if (progress) {
> +                       int current_blamed_lines = count_blamed_lines(sb);
> +                       if (current_blamed_lines > blamed_lines) {
> +                               blamed_lines = current_blamed_lines;
> +                               display_progress(progress, blamed_lines);
> +                       }
> +               }
> +
>                 if (DEBUG) /* sanity */
>                         sanity_check_refcnt(sb);
>         }
> +
> +       if (progress) {
> +               stop_progress(&progress);
> +       }
>  }
>

It first I tried to detect how many revisions where going to be
checked so that I could report progress on them but I found extracting
information from scoreboard a little tricky (to be read: I could not
extract anything out of it). Then I though of counting lines and it
works so.... (same thing with the curly brackets).


> +       assign_blame(&sb, opt, show_progress);
> +
>         if (!incremental)
>                 setup_pager();
>
> -       assign_blame(&sb, opt);
> -

setup_pager() was breaking progress so I moved it _after_
assign_blame() and it seems to behave. Hope that's not a problem.

Looking forward to your feedback.
