From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 16:50:15 +0700
Message-ID: <CACsJy8CPM2jwWu0g+mamnA89UtWR=3B=8Q+j2mu-CMB=TRm7Og@mail.gmail.com>
References: <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net> <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net> <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
 <CACsJy8DtiSupsvDgeBXGGnGE06pDxWvYTNrk3bpta9Bwk5MZwg@mail.gmail.com> <20130810094339.GB2518@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 11:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V85ow-00034W-4g
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 11:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968526Ab3HJJuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 05:50:46 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:33452 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968520Ab3HJJup (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 05:50:45 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so7819140oah.6
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LSjs4jobHdyTwxSitmd02feH1BQNikCiPCMLOGprQhI=;
        b=LZDlYUDJMFL23cEm/tqjbj0SokFqX4X9c95+rre25T91reg6Kn+fuBk2jw0hNiciF0
         ZE0/0ekyOPPnNtWf/6DPnReZA7SCio080Qdi+iAT5u4rd8SOxpCxnNb83TKLt23cXasO
         XOFZpsoCNZQseZBa5w4H4SX6/ZW3jmjL+LI40w/AHomslr8x8Dyd48Ky+i+d+AH9MQyr
         fpuzpZ/Av6lLl0p0yq2BN9tgpNapr9ZteosPn49KLLBFBgLVyPQiezy/zGYf4p+NRYqs
         OLaoHW5EaxPLoIYAy8FcRqSVfjE/Hs8kbgXXr6h0Z6PK+stVkW0X/SchW4IVybJN7rqG
         Kiag==
X-Received: by 10.60.143.68 with SMTP id sc4mr11679474oeb.24.1376128245129;
 Sat, 10 Aug 2013 02:50:45 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 10 Aug 2013 02:50:15 -0700 (PDT)
In-Reply-To: <20130810094339.GB2518@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232084>

On Sat, Aug 10, 2013 at 4:43 PM, Jeff King <peff@peff.net> wrote:
>> push has --thin turned off by default favoring server resources over
>> network traffic, see a4503a1 (Make --no-thin the default in git-push
>> to save server resources - 2007-09-09)
>
> Hmm. I don't think that is the case anymore.
>
> If I do:
>
>   git init parent &&
>   (cd parent && seq 1 10000 >file &&
>    git add file && git commit -m base
>   ) &&
>   git clone parent child &&
>   cd child && seq 1 10001 >file &&
>   git commit -a -m more &&
>   GIT_TRACE=1 git push origin HEAD:foo
>
> I see:
>
>   trace: run_command: 'pack-objects' '--all-progress-implied' '--revs'
>     '--stdout' '--thin' '--delta-base-offset' '--progress'
>

Right. transport_get() is also run for push and it sets
smart_options->thin = 1 unconditionally. Thanks for correcting.
-- 
Duy
