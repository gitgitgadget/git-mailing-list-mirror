From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 2/4] abbrev_sha1_in_line: don't leak memory
Date: Wed, 30 Mar 2016 13:35:50 -0400
Message-ID: <CAPig+cQ92gY=A_mtToe=gb2jPBHTJKZ7DcjYL+E6t1QFbdYuWA@mail.gmail.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:36:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alK28-0005Ha-Us
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbcC3Rfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:35:52 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33462 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbcC3Rfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:35:51 -0400
Received: by mail-vk0-f49.google.com with SMTP id k1so70700933vkb.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pH6ALl6tGJhVnrzwLB4nMOaEXUk/gvTnM5zFKP57iww=;
        b=VDVyWLqKWfR1R/K6gi2sGkeBbOp0IwuIgAtd+lR/EO1/Gy1T0WudvNjzFhmGEP0e1J
         ZVfxjCtdc8cOwy80llBvVj678pkuUE71DSypWleOCOLdAbtumIYt4tNxRY22YzxH1giX
         a6JzYHPgfLbodxspFDuYn3laPmzFhpmcCUhK0C3dY7x3rLjTHMt/M5y2VRu/a/ES+RXC
         kqDky6tlEQJbEmsKlsPZL4HsCImqEYkGucXlC9NdfBtvmRCHTFTVPn31dcq1tLSSdmXT
         wv0D8I6RAH3C6tUgCFIhbPRnLZnYs6iNdCjGISsbrJOgTsjQ0+JYU2f2+1xArGJUCsp4
         DXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pH6ALl6tGJhVnrzwLB4nMOaEXUk/gvTnM5zFKP57iww=;
        b=B/qQWCNSE1Lsq/OUnBshd3BJ8O6lyi+ur0GbdXt88jYhVo+D9wPFf4NmnZU+UpTmpo
         QckQT6ts367UYTS7d1k7ytO+m86aAes/niHKXQ+erP/0C+TwRBPDmkx1w0W5YJl2glTo
         N3oAIUyC4SLdxzfPd0mdXGKCeqMzrjwYo9kYw5PhtCIWrbho/fgNtlbKMD7qQxxzOpqm
         qxdQCxJQVnWLtJ4709sNS8KdjwcNNi8DVp7kJniHS9bukfOB0IOB9y32qGSjlIEoPiUh
         aw1L/zZCKSipQRW18EzMy8k+bIa2GdHESW6W3b/XZPYyP/EJFL0unNzGQqd8/qWNr6Aa
         JaUA==
X-Gm-Message-State: AD7BkJLHFzsDtFM1+6JYFTzKVhZs1pqksJfZnGGADDrVQwwYCyXUMW2nzn5J4gHyHekJURGvQzWIHZA+3zFL1g==
X-Received: by 10.31.150.76 with SMTP id y73mr6004328vkd.84.1459359350868;
 Wed, 30 Mar 2016 10:35:50 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 30 Mar 2016 10:35:50 -0700 (PDT)
In-Reply-To: <1459357518-14913-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: LAbseXYvjWZDngqQAfHnwM2HzgI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290329>

On Wed, Mar 30, 2016 at 1:05 PM, Stefan Beller <sbeller@google.com> wrote:
> `split` is of type `struct strbuf **`, which we have a dedicated free
> function for, which takes care of freeing all related memory.

I think it's important to explain that 'split' and each split[]
element were being leaked (despite the existing strbuf_release()) as
justification for why this change is beneficial.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  wt-status.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index ef74864..1ea2ebe 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1063,9 +1063,7 @@ static void abbrev_sha1_in_line(struct strbuf *line)
>                                 strbuf_addf(line, "%s", split[i]->buf);
>                 }
>         }
> -       for (i = 0; split[i]; i++)
> -               strbuf_release(split[i]);
> -
> +       strbuf_list_free(split);
>  }
