From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ident.c: add support for IPv6
Date: Fri, 30 Oct 2015 11:13:03 -0700
Message-ID: <xmqqtwp8kyxc.fsf@gitster.mtv.corp.google.com>
References: <1446216487-11503-1-git-send-email-gitter.spiros@gmail.com>
	<5633A838.3070801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	peff@peff.net
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEAu-0000Q9-Bb
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760249AbbJ3SNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2015 14:13:13 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751254AbbJ3SNL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2015 14:13:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 352082425A;
	Fri, 30 Oct 2015 14:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ahpip/SXaBQ4
	vKY2BjAV5OHSEpc=; b=LDrKcCRR1gL1VR14UrSh0EkIRZW/m/XJWH/0gerKczvJ
	G89Gjk7rfL3f1ZsIOUbBe2ebufTiYRrAOITgwfgO5W1RqyDkeO2eWYHA85mns8Di
	nOpZqpjzYQNNshiQ/F3+sfLC+BWj5SlkR/r3i831iMH0pdTSjhblMfpIVYMp2D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NwCYS6
	vZs4Rj+3tONzh1HcGIpFi5G3fGUKPNVhkyaMPoxa/DtMyVZmMGv7ZirppnU3CPvc
	a+hpdCl0vff1hQRupJAgbEFMwlyYrHnuvMZEsjmP8QruKJx+NYnGyQ7MENzCLU1V
	ZbXMSwf1tcGIwKL00gudOKMVWg6+2/m0ZWEwE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B9E124259;
	Fri, 30 Oct 2015 14:13:05 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 930E424258;
	Fri, 30 Oct 2015 14:13:04 -0400 (EDT)
In-Reply-To: <5633A838.3070801@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 30 Oct 2015 18:26:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD36A6D0-7F31-11E5-8D28-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280504>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2015-10-30 15.48, Elia Pinto wrote:
>> Add IPv6 support by implementing name resolution with the
> Minor question: How is this related to IPV6?
> Could the header line be written something like
>
> "ident.c: Use getaddrinfo() instead of gethostbyname() if available"
>
> On which systems has the patch been tested ?
> Linux ?
> Mac OS X ?
> Windows ?
> BSD ?
>
> The motivation on which platforms the usage of getaddrinfo() is prefe=
rred
> over gethostbyname() could be helpful to motivate this patch:
> System XYZ behaves bad when gethostbyname() is used.
> Fix it by using getaddrinfo() instead.

gethostbyname() fills a hostent that gives us the official name,
list of aliases, _one_ addrtype (either AF_INET or AF_INET6), and
list of addresses, so if we were asking for the physical addresses,
we may not be able to obtain all addresses for a host with both IPv4
and IPv6 addresses, which may be an issue.

But this function is about learning the official name of the host,
given the result of gethostname().  In that context, does that
"limited to single address family" issue of gethostbyname() still
matter?  I am guessing it doesn't, and I somehow doubt that the
value of this patch is about working around any platform bug.

I think the real reason to favour getaddrinfo() over gethostbyname()
is that the family of functions the latter belongs to is obsolete.
In other codepaths where we need to learn the inet address, we
already use getaddrinfo() if available (i.e. NO_IPV6 is not set),
and gethostbyname() is used only when compiling with NO_IPV6.

Converting this codepath to match that pattern incidentally allows
you to work around a platform bugs like "gethostbyname() is broken
on sysmte XYZ" (which you work around by not saying NO_IPV6), but I
view it as a side effect.

>> +static void add_domainname(struct strbuf *out)
>> +{
>> +	char buf[1024];
>> +	struct addrinfo hints, *ai;
>> +	int gai;
> The scope of these variables can be narrowed, by moving them into the=
 "{" block,
> where they are needed. (Before the memset())
>> +
>> +	if (gethostname(buf, sizeof(buf))) {
>> +		warning("cannot get host name: %s", strerror(errno));
>> +		strbuf_addstr(out, "(none)");
>> +		return;
>> +	}
>> +	if (strchr(buf, '.'))
>> +		strbuf_addstr(out, buf);
>> +	else	{
> Many ' ' between else and '{', one should be enough
>> +		memset (&hints, '\0', sizeof (hints));
>> +		hints.ai_flags =3D AI_CANONNAME;
>> +		if (!(gai =3D getaddrinfo(buf, NULL, &hints, &ai)) && ai && strch=
r(ai->ai_canonname, '.')) {
>> +			strbuf_addstr(out, ai->ai_canonname);
>> +			freeaddrinfo(ai);
>> +		}
>> +		else
> Colud be written in one line as "} else"
>> +			strbuf_addf(out, "%s.(none)", buf);
>> +	}
>> +}
>> +#else /* NO_IPV6 */
