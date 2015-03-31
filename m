From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 1/6] shallow: fix a memleak
Date: Mon, 30 Mar 2015 22:52:58 -0400
Message-ID: <CAPig+cRi9L+bEJsjFdihLQJjb38Bg500=sZ+w4FubR5f3=n-bQ@mail.gmail.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
	<1427764931-27745-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 04:53:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcmIe-0006f2-HM
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 04:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbbCaCxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 22:53:00 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36502 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbCaCw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 22:52:59 -0400
Received: by labe2 with SMTP id e2so2708993lab.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dUhJUhpWyTZXOCwfu/jmt0URFHqekYx3Txlm/u/pgPI=;
        b=v1/O33TzCj7wF/xtRy/3ugF4QqdlQSV18HcFHdhcvqacFaDtHPGTQN5FDykfoDgywC
         n2xB+PDe566n8Iyc3mKIRqjri18xRjS1Sc26gNfLiQpcbPkoH8qbINuu6QdbpzwaSNHR
         c0cOtMMMYvZFoqD8+HLOIBY4B1NmhhnkQYPB/lMrvF0czcfbLc0lHF82xIGjoD8Y54zE
         c9WRdqFvyuDn7PCvm4DisfXh6qh0gxOuReFoQk5lW1B41xtNdhucwb0OMpJOW0SlBzuH
         Y/q+bpD/+J5/z0+CzUkYV0MbbNjzF7rbxC+sqcJ4mqTkAe8NVxCp9f9NbRNCfI5qqqNO
         MBTA==
X-Received: by 10.112.173.41 with SMTP id bh9mr28630132lbc.107.1427770378068;
 Mon, 30 Mar 2015 19:52:58 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 30 Mar 2015 19:52:58 -0700 (PDT)
In-Reply-To: <1427764931-27745-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: Z1zqfpquNnefimEYcQXh-9Pkacs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266505>

On Mon, Mar 30, 2015 at 9:22 PM, Stefan Beller <sbeller@google.com> wrote:
> shallow: fix a memleak
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/shallow.c b/shallow.c
> index d8bf40a..11d5c4e 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -412,11 +412,12 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
>         struct commit_list *head = NULL;
>         int bitmap_nr = (info->nr_bits + 31) / 32;
>         int bitmap_size = bitmap_nr * sizeof(uint32_t);
> -       uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
> -       uint32_t *bitmap = paint_alloc(info);
> +       uint32_t *tmp, *bitmap;
>         struct commit *c = lookup_commit_reference_gently(sha1, 1);
>         if (!c)
>                 return;
> +       tmp = xmalloc(bitmap_size); /* to be freed before return */
> +       bitmap = paint_alloc(info);

You've made two unrelated changes in this patch, only one of which is
a fix for the memory leak mentioned by the commit message.

The 'tmp' change fixes the memory leak. The 'bitmap' change, however,
merely avoids doing work unnecessarily in the "early return" case.
Since 'bitmap' gets released by the caller of paint_down() when the
paint_info structure is freed, it is misleading to claim that that
particular change is a "memleak" fix.

Either split the two changes into separate patches or augment the
commit message to say something along the lines of:

    While here, also avoid unnecessarily allocating 'bitmap' within
    paint_info in the early-return case.

>         memset(bitmap, 0, bitmap_size);
>         bitmap[id / 32] |= (1 << (id % 32));
>         commit_list_insert(c, &head);
> --
> 2.3.0.81.gc37f363
