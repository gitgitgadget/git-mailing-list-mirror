From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V2 6/6] WIP/RFC/entry.c: fix a memleak
Date: Fri, 27 Mar 2015 19:32:11 -0400
Message-ID: <CAPig+cSHntg6KwZr3h6nhO7AK0v+FcbVAA4b_kvHdEg_=9o_eg@mail.gmail.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
	<1427495569-10863-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 00:32:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybdjd-0002Ws-TT
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 00:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbC0XcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 19:32:13 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:33227 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbC0XcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 19:32:12 -0400
Received: by labto5 with SMTP id to5so81919898lab.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 16:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FI0w36VsNF3fXKUp57C4w7s1dR0DxbFChd7tb5DluSE=;
        b=m5gnyRbpWGU/WLy7fMTmqtyfHsLn5IFAaHCL9QbKalQES8kV4Bg3SWXXcAeg2hB1WA
         INSTbVZXfw/GHAM/9tpMsJPOcdUnrolFmHOb3KnmO5FuEGUjwxJzA4WrQExVCuHiqufn
         SaSKDc4IBKARuUbZJ6O7DM7EtASDDFE+T7RjwRQdGgevr136QItJWnz32QMT+I+TZYNQ
         tboPTFIukvovafTqUDR9h12FMEWVy+n45/5w1DObPyh/uMWxP0eh3hiP5wXEzVbldzei
         UdBMfhOjQwTOe7eZGvzmZgORctdOpf4C+7G25Q6RTzy/UxIq0zVjjmwg0OLq3yt3T7L0
         PTCg==
X-Received: by 10.112.198.40 with SMTP id iz8mr5763617lbc.101.1427499131163;
 Fri, 27 Mar 2015 16:32:11 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 27 Mar 2015 16:32:11 -0700 (PDT)
In-Reply-To: <1427495569-10863-7-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: Zy7HKX0XNsejYaQm6ulsxWA-NvM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266404>

On Fri, Mar 27, 2015 at 6:32 PM, Stefan Beller <sbeller@google.com> wrote:
> I  observe that filter is going out of scope, but the
> implementation proposed in this patch produces just a
> crash instead of any helpful fix.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/entry.c b/entry.c
> index 1eda8e9..5383001 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -152,8 +152,10 @@ static int write_entry(struct cache_entry *ce,
>                 if (filter &&
>                     !streaming_write_entry(ce, path, filter,
>                                            state, to_tempfile,
> -                                          &fstat_done, &st))
> +                                          &fstat_done, &st)) {
> +                       free_stream_filter(filter);

Aside from the crash you are seeing, this is a bogus fix anyway.
You're only freeing 'filter' if it was allocated _and_ if
streaming_write_entry() returned 0. I would guess your intention was
to free 'filter' regardless of the result of streaming_write_entry().

>                         goto finish;
> +               }
>         }
>
>         switch (ce_mode_s_ifmt) {
> --
> 2.3.0.81.gc37f363
