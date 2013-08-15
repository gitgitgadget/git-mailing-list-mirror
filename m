From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating
 to true
Date: Thu, 15 Aug 2013 17:21:03 -0400
Message-ID: <CAPig+cQmdPo4mo69DsDmUURcw+HbxkAoNEqY08qiuJs8S+=bvQ@mail.gmail.com>
References: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 23:21:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA4yl-0002yZ-GC
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab3HOVVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:21:07 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:60253 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab3HOVVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:21:06 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so943928lab.16
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Yh9mkIFJztBKswujHsUMko8X6/84XsJ5T9MAEofSBMk=;
        b=LE8THjjIAEDOQG1yzHz5PkZaHEqPdF80tpg4vQFFOcDvrBk9SoHNuAaAzvGEBN6UtG
         Oak3isWwkXxeVFrBK76sqFjx5UMSBEoy+Ld3jBKqjYCOy0Ppw722RArBM2Nt/qelTMi2
         eZvwE/Ca481sQcuye1iOiLnpRf2VvVbCUrrshraziNjNQqyn3iz3Ui1l8Tjxz4ykaRqt
         0XJ+9h7yWDzivU7ibt2829HD1cy+CwV0LIg7sPJSR+SAnbzRsjfcjnm9DzjSILUBVdqE
         tG2GpRwrfKQro0An0SC1zHiip3jgEkLYJrk/xCmxScKO6vdYk1ORBtWrFEa1+6FYjzaN
         8gVw==
X-Received: by 10.152.5.162 with SMTP id t2mr14856862lat.1.1376601663842; Thu,
 15 Aug 2013 14:21:03 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 15 Aug 2013 14:21:03 -0700 (PDT)
In-Reply-To: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: mBBGdJ8PCf-bZCgKH7j9G1b7E8k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232369>

On Thu, Aug 15, 2013 at 3:37 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> When checking the previous lines in that function, we can deduct that

s/deduct/deduce/

> hsize must always be smaller than (1u<<31), since 506049c7df2c6
> (fix >4GiB source delta assertion failure), because the entries is

s/the entries/entries/ reads a bit better.

> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
> value of 0x3fffffff, which is smaller than (1u<<31), so i will never

s/i/it/

> be larger than 31.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  diff-delta.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 93385e1..54da95b 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -154,8 +154,15 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
>                  */
>                 entries = 0xfffffffeU / RABIN_WINDOW;
>         }
> +
> +       /*
> +        * Do not check i < 31 in the loop, because the assignement
> +        * previous to the loop makes sure, hsize is definitely
> +        * smaller than 1<<31, hence the loop will always stop
> +        * before i exceeds 31 resulting in an infinite loop.
> +        */

This comment echoes the commit message, and indeed the explanation
makes more sense in that context since someone can read the entire
patch to see and understand the actual change. It may have less value
as an in-code comment.

>         hsize = entries / 4;
> -       for (i = 4; (1u << i) < hsize && i < 31; i++);
> +       for (i = 4; (1u << i) < hsize; i++);
>         hsize = 1 << i;
>         hmask = hsize - 1;
>
> --
