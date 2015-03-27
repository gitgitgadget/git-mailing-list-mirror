From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V2 1/6] shallow: fix a memleak
Date: Fri, 27 Mar 2015 19:01:15 -0400
Message-ID: <CAPig+cTpVwKG+6uK0HCyPUt0qKc7R6qWnLgVr8C9kodW4j2krg@mail.gmail.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
	<1427495569-10863-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 00:01:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbdFh-0003Ge-Kl
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 00:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbbC0XBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 19:01:17 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:34511 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbbC0XBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 19:01:16 -0400
Received: by lagg8 with SMTP id g8so81360079lag.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=os9ogHB+q4o8HOkIChmBwwFXOdf7ONPq5IF2SjIJZvo=;
        b=QCLTYFwOUpoBszYxSk56Gn7sGWwtZkwGbEgpwRVXcRErIT/FiEYXCaEHeYjB9BvSIR
         yx1NJlTZRGj0Il6bxPHuFWdW/JqQYpYpmbopa4nkzaG+09StZz5l4UtTtyuR6kFuKYMC
         uDFTQIMXLW03mcPT0t/1+D6zb0YgIj0nkiCnCwTqQZT0k3JGRuYGK2NrljHfQuGI0tF5
         vJ6SwXpKk8/tyZpHDgAxWMSgKggZ3yGjtAuOL2arxyr+17cLTvP0q8gY+kG6cdsLPjq4
         E2Hc7UmjLhmS7UA4gamjPSmgyA4C8I7sBiG3mAA04XBGoM+9MI+OPjEsLfMP/crRGJiY
         FF2g==
X-Received: by 10.112.198.40 with SMTP id iz8mr5689734lbc.101.1427497275120;
 Fri, 27 Mar 2015 16:01:15 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 27 Mar 2015 16:01:15 -0700 (PDT)
In-Reply-To: <1427495569-10863-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 7XeAiPg25oq2fIXg8uGnKqdK-q0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266401>

On Fri, Mar 27, 2015 at 6:32 PM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/shallow.c b/shallow.c
> index d8bf40a..f8b0458 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -416,7 +416,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
>         uint32_t *bitmap = paint_alloc(info);
>         struct commit *c = lookup_commit_reference_gently(sha1, 1);
>         if (!c)
> -               return;
> +               goto out;

Rather than slapping on a band-aid, a cleaner fix would be to move the
allocation of 'tmp' below this conditional since 'tmp' is never used
before the point of this early return.

Perhaps also move allocation of 'bitmap' below the early return (if
you find that it's safe to do so).

>         memset(bitmap, 0, bitmap_size);
>         bitmap[id / 32] |= (1 << (id % 32));
>         commit_list_insert(c, &head);
> @@ -471,7 +471,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
>                 if (o && o->type == OBJ_COMMIT)
>                         o->flags &= ~SEEN;
>         }
> -
> +out:
>         free(tmp);
>  }
