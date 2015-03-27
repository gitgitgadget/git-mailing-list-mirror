From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V2 4/6] wt-status.c: fix a memleak
Date: Fri, 27 Mar 2015 19:16:08 -0400
Message-ID: <CAPig+cT8_0+tgcDa4yOPgOLUA8Xtwa26JhMWo84c-J3_bjbTfw@mail.gmail.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
	<1427495569-10863-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	knittl89+git@googlemail.com, Xin Jiang <worldhello.net@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 00:16:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbdU8-0006Xr-V6
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 00:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbbC0XQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 19:16:12 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35367 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbC0XQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 19:16:10 -0400
Received: by lbdc10 with SMTP id c10so19717967lbd.2
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lWll8/avZ+qFd/BpNOEsyX/bA9zD7chpBMMZGxMwRrQ=;
        b=vo0ENUCmpuTVVQjNSwcf2ltM6upnSJteVCx9o9mRj/JOiZ1ciJLPCADeoXNk9ygXRG
         KkJOxxOeNK9P9w60ztHX2mtu4bVANxqHT6Vd4xPCCMnjAaA0Lg15mEQWceUUkNcEAt2M
         CuFQqZ2gMJ6lhNVMnVwPgeS+KrBdWqopOpHYRFkcbPCTeas0vH25yet+efCAPW8x3yeK
         LaKyC9f4WLGla146AtMn0BGIz25DlMTtqG1qlUEQ0ySVsje93YfFjXZlY1j/Al8Kh0Vp
         sA/JJrtsOqdsVG48TuN0msEkKPpCs//hDnSTgvR+W0GJliW0hiNTA9ufvVZuR2quhFVh
         4uEA==
X-Received: by 10.152.26.169 with SMTP id m9mr19654773lag.45.1427498169011;
 Fri, 27 Mar 2015 16:16:09 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 27 Mar 2015 16:16:08 -0700 (PDT)
In-Reply-To: <1427495569-10863-5-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 3J9x0HKJaH1A9zkr9P7Hy8POyKc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266402>

On Fri, Mar 27, 2015 at 6:32 PM, Stefan Beller <sbeller@google.com> wrote:
> In any code path of shorten_unambiguous_ref the return value is a
> xstrdup(some string), so it is safe to free the variable `base`
> in any codepath.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  wt-status.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/wt-status.c b/wt-status.c
> index 853419f..9d2a349 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1576,6 +1576,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>
>         color_fprintf(s->fp, header_color, "]");
>         fputc(s->null_termination ? '\0' : '\n', s->fp);
> +
> +       free((char *)base);

There's an early 'return' before this point (at line 1560) which will
leak 'base', so this is an unreliable fix.  A better solution would be
to free(base) immediately after it's final use (before the early
'return').

>  }
>
>  void wt_shortstatus_print(struct wt_status *s)
> --
> 2.3.0.81.gc37f363
