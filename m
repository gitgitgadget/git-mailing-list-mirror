From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] strbuf: add xstrdup_fmt helper
Date: Thu, 19 Jun 2014 18:52:39 +0200
Message-ID: <53A31557.8070901@web.de>
References: <20140618200000.GA22994@sigill.intra.peff.net> <20140618200133.GA23057@sigill.intra.peff.net> <xmqq7g4dj1cn.fsf@gitster.dls.corp.google.com> <20140619090532.GB1009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 18:53:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxfaI-0006LL-M5
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 18:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474AbaFSQxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2014 12:53:04 -0400
Received: from mout.web.de ([212.227.17.12]:55836 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932775AbaFSQw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 12:52:59 -0400
Received: from [192.168.178.27] ([79.253.184.31]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M0yiR-1Wil1i1635-00v7RK; Thu, 19 Jun 2014 18:52:57
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140619090532.GB1009@sigill.intra.peff.net>
X-Provags-ID: V03:K0:EIRjBW7a7Jlx7XkKVNpMXukBs3hnE4q4x6b/KNFERd3KBqYPDm8
 4INzqUK+LntaXLPs8X2a6K+X7DQe2y5/plIiS8c8JX9850TpXAQ90YWKGvGDI1cPhVNql4n
 W0hNC9XcgJVUetEKN51UMPTRsP+j6fnJ+LIXPO2XglWnSILAo9a9SpVnxvdUozo2iJuJLIu
 /tWT5GAeH0Db1Inmu2fdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252166>

Am 19.06.2014 11:05, schrieb Jeff King:
> On Wed, Jun 18, 2014 at 03:32:08PM -0700, Junio C Hamano wrote:
>
>>>    str =3D xstrdup_fmt(fmt, some, args);
>>> ---
>>> I'm open to suggestions on the name. This really is the same thing
>>> conceptually as the GNU asprintf(), but the interface is different =
(that
>>> function takes a pointer-to-pointer as an out-parameter, and return=
s the
>>> number of characters return).
>>
>> Naming it with anything "dup" certainly feels wrong.  The returned
>> string is not a duplicate of anything.
>
> I was somewhat inspired by "mkpathdup" and friends. It is quite simia=
lr
> to mkpathdup, except that it is not limited to paths (and does not do
> any path-specific munging). I agree something with "printf" in the na=
me
> is probably more descriptive, though.
>
>> I wonder if our callers can instead use asprintf(3) with its
>> slightly more quirky API (and then we supply compat/asprintf.c for
>> non-GNU platforms).  Right now we only have three call sites, but if
>> we anticipate that "printf-like format into an allocated piece of
>> memory" will prove be generally useful in our code base, following
>> an API that other people already have established may give our
>> developers one less thing that they have to learn.
>
> I considered that, but I do find asprintf's interface unnecessarily
> annoying (you can't return a value directly, and you run afoul of con=
st
> issues when passing pointers to pointers). As you noted, it's not _to=
o_
> bad, but we really get nothing from the integer return type. AFAICT, =
it
> helps with:
>
>    1. You know how many characters are in the string. If you cared ab=
out
>       that here, you would just use a strbuf directly, which is much =
more
>       flexible.
>
>    2. The error handling is different. But our x-variant would just d=
ie()
>       on errors anyway, so we do not care.
>
> So modeling after asprintf feels like carrying around unnecessary
> baggage (and I am not convinced asprintf is in wide enough use, nor t=
hat
> the function is complicated enough to care about developer familiarit=
y).
> Part of me is tempted to call it xasprintf anyway, and use our own
> interface. GNU does not get to squat on that useful name. ;)
>
> That is probably unnecessarily confusing, though.
>
>> As usual, I would expect we would have xasprintf wrapper around it
>> to die instead of returning -1 upon allocation failure.
>
> Would it be crazy to just call it xprintf? By our current scheme that
> would be "a wrapper for printf", which means it is potentially
> confusing.
>
> Literally any other unused letter would be fine. dprintf for detach? =
I
> dunno.

I agree that "dup" doesn't fit and that potential callers don't need th=
e=20
length of the generated string (or should use strbuf otherwise).

Including "print" in the name is not necessary, though -- die(), error(=
)=20
and friends work fine without them.

What about simply removing the "dup_" part and using xstrfmt?

Ren=C3=A9
