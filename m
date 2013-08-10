From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 16:24:48 +0700
Message-ID: <CACsJy8DtiSupsvDgeBXGGnGE06pDxWvYTNrk3bpta9Bwk5MZwg@mail.gmail.com>
References: <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net> <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net> <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 11:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V85Qa-0003Tr-EN
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 11:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968487Ab3HJJZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 05:25:20 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:42918 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968484Ab3HJJZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 05:25:19 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so7300022obb.16
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QkmGJY4LMnhBwOWQQ+OWiEEjWfQitjs7HcRktIiIFsM=;
        b=xxNMyWmhlWyFoGFC3TDBafU3xDGXtNpHUjAdoNgGf2TLG42sSTYF3QWvGL/p49YWmt
         54xlYdncsjvIDKmvphnePNdbosSleqhUH4W0vxUW0es/Ts/GAZGBQ4qU2yNk4P48YMD0
         vwU+p+W8lO0lhKRbcovwPECs8jGi1LKdRvymYj0PnIx+F3eVUss0IfvTwropJ/FWCWDU
         eJbrgIPclbNiw6c1iGbbWnPCc8vHgx1EGcCuLzF8CPGctnX1R33C1hzYkq6vOaEGoyKU
         mJVdtvPSFajlIUf9EVQpnENQyRIvwHyDl9Ed2OOGDS+KazMsel6NvtpECsqbCXniXogT
         zKXw==
X-Received: by 10.60.145.241 with SMTP id sx17mr11472782oeb.57.1376126718378;
 Sat, 10 Aug 2013 02:25:18 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 10 Aug 2013 02:24:48 -0700 (PDT)
In-Reply-To: <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232079>

On Sat, Aug 10, 2013 at 3:42 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>> As Junio mentioned, that is what "--thin" is about; the sender omits the
>> base and the receiver adds it back in ("index-pack --fix-thin").
>
> Yeah, I read about the --thin option. However, it's only for
> network-packs (i.e --stdout; why?). Also, is it turned on by default?
> The documentation says so, but I ran it and found that the value of
> thin is 0 in builtin/push.c:316. What is going on?

--thin is enabled by default for fetch (see
transport.c:transport_get()) but it's only effective when the server
advertises "thin-pack" capability (see protocol-capabilities.txt).
push has --thin turned off by default favoring server resources over
network traffic, see a4503a1 (Make --no-thin the default in git-push
to save server resources - 2007-09-09)
-- 
Duy
