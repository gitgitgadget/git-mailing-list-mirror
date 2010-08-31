From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 07/17] gettext.c: work around us not using
 setlocale(LC_CTYPE, "")
Date: Tue, 31 Aug 2010 10:18:01 -0500
Message-ID: <20100831151800.GG2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-8-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:19:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqScs-0006Dk-Di
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab0HaPTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:19:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53586 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431Ab0HaPTs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:19:48 -0400
Received: by vws3 with SMTP id 3so5444183vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9HwMiq8eFIg3wwiIvDBIvHkfxaWy3T1C1vjg3oWUzbE=;
        b=JOoiE3mDUPt0tzgzWmRrXM5JmE/xoAou9dakTw60CUIbI5xdLHZDr1LKPjWghXxfYK
         ZebpcUiLf5VQvld30X80NlmjqcAZ4/CY6+hkKoG0Fmy6ddRDycJ3TvzrH2YXzf8W8N+3
         cIUPoaOCapqX87RX0T8wmkjM/sMmrq6f+KF1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nK8GUgptiGdI9UVE623miqmK118qFvyeSKRt2RLDF1P1ulrUNtEUlxESAhuOHwCUnO
         mQcpA4LYQPcOGpDu0ATUSa4anHJSuBjulHarblpgLGShrB1pho3arBuU1yXZsb96VCjx
         4WUEoE0+0rCbBxZgxiRETm0wJsYF44TnJm4G0=
Received: by 10.220.158.11 with SMTP id d11mr564342vcx.91.1283267985127;
        Tue, 31 Aug 2010 08:19:45 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u29sm2881069vcr.25.2010.08.31.08.19.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:19:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283203703-26923-8-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154911>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> In 107880a I removed our use of setlocale(LC_CTYPE, "") because of a
> bug in the GNU C Library [1]

=46uture readers might benefit from a reminder that it is vsnprintf tha=
t
is broken.

Aside, not about this patch: glibc printf can be very convenient for
translators, because of format strings like "%4$s".  Do other common
platforms like FreeBSD and Mingw have something similar?

> --- a/gettext.c
> +++ b/gettext.c
> @@ -17,5 +19,9 @@ extern void git_setup_gettext(void) {
>  	}
> =20
>  	(void)setlocale(LC_MESSAGES, "");
> +	(void)setlocale(LC_CTYPE, "");
> +	charset =3D nl_langinfo(CODESET);
> +	(void)bind_textdomain_codeset("git", charset);
> +	(void)setlocale(LC_CTYPE, "C");

=46or the curious: we cannot use

	setlocale(LC_CTYPE, "");
	charset =3D nl_langinfo(CODESET);
	setlocale(LC_CTYPE, "C");
	bind_textdomain_codeset("git", charset);

because nl_langinfo returns a pointer to a static buffer that might
be wiped out by setlocale() iirc.

Thanks.
