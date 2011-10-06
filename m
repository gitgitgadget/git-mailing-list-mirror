From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper
 functions everywhere
Date: Thu, 6 Oct 2011 11:14:23 -0500
Message-ID: <CA+sFfMf8_7ccC9kjEq=2NrehVgS=ahnQA8VibEF10VaULot7=A@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
	<1316051979-19671-1-git-send-email-drafnel@gmail.com>
	<1316051979-19671-3-git-send-email-drafnel@gmail.com>
	<4E71A0C7.8080602@viscovery.net>
	<CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>
	<CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com>
	<CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
	<4E8D4812.9090102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "peff@peff.net" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>,
	"bharrosh@panasas.com" <bharrosh@panasas.com>,
	"trast@student.ethz.ch" <trast@student.ethz.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqab-00026G-SA
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046Ab1JFQOZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:14:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55891 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965067Ab1JFQOY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 12:14:24 -0400
Received: by iakk32 with SMTP id k32so3124625iak.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5XGRrVdeNYzMEeJrzb/fjjLUxc7DDB+nN1XLO5w1Z8c=;
        b=ZWKoSqstE5sKqhMUXFq8zx3NgH5URw9irp3A/W/IJMg2fOf0fn58V+MexCrekaezx5
         28AqfsQxAbdIjT2gPjLJRy2IzvvnGq1KdcdZ6M5NcsQA24UXBuw2fTWL5TDU8TP2YWT5
         5AsSBWQfKMPQLjNl8i6BxAVqURtWqv+RscyFM=
Received: by 10.231.82.2 with SMTP id z2mr1508072ibk.67.1317917663722; Thu, 06
 Oct 2011 09:14:23 -0700 (PDT)
Received: by 10.231.207.75 with HTTP; Thu, 6 Oct 2011 09:14:23 -0700 (PDT)
In-Reply-To: <4E8D4812.9090102@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182966>

[removed Alexey Shumkin from cc]

On Thu, Oct 6, 2011 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Am 10/6/2011 4:00, schrieb Brandon Casey:
>> [resend without html bits added by "gmail offline"]
>> On Wed, Oct 5, 2011 at 7:53 PM, Brandon Casey <drafnel@gmail.com> wr=
ote:
>>> On Thursday, September 15, 2011, Brandon Casey wrote:
>>>>
>>>> On Thu, Sep 15, 2011 at 1:52 AM, Johannes Sixt <j.sixt@viscovery.n=
et>
>>>>> There is a danger that the high-level die() routine (which is use=
d by
>>>>> the
>>>>> x-wrappers) uses one of the low-level compat/ routines. IOW, in t=
he case
>>>>> of errors, recursion might occur. Therefore, I would prefer that =
the
>>>>> compat/ routines do their own error reporting (preferably via ret=
urn
>>>>> values and errno).
>>>>
>>>> Thanks. =C2=A0Will do.
>>>
>>> Hi Johannes,
>>> I have taken a closer look at the possibility of recursion with res=
pect to
>>> die() and the functions in compat/. =C2=A0It appears the risk is on=
ly related to
>>> vsnprintf/snprintf at the moment. =C2=A0So as long as we avoid call=
ing xmalloc et
>>> al from within snprintf.c, I think we should be safe from recursion=
=2E
>>> I'm inclined to keep the additions to mingw.c and win32/syslog.c si=
nce they
>>> both already use the x-wrappers or strbuf, even though they could e=
asily be
>>> worked around. =C2=A0The other file that was touched is compat/qsor=
t, which
>>> returns void and doesn't have a good alternative error handling pat=
h. =C2=A0So,
>>> I'm inclined to keep that one too.
>
> I'm fine with keeping the change to mingw.c (getaddrinfo related) and
> qsort: both are unlikely to be called from die().
>
> But syslog() *is* called from die() in git-daemon, and it would be be=
tter
> to back out the other offenders instead of adding to them.

Ah.  Yes, you're right.  x-wrappers should not be used in syslog.c and
the use of strbuf's should be replaced.

Thanks,
-Brandon
