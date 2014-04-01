From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] date: recognize bogus FreeBSD gmtime output
Date: Tue, 01 Apr 2014 12:08:19 -0700
Message-ID: <xmqq7g7827h8.fsf@gitster.dls.corp.google.com>
References: <20140401073848.GA22023@sigill.intra.peff.net>
	<20140401074251.GA22550@sigill.intra.peff.net>
	<533AFA86.2090905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:08:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV42t-0001Ip-8h
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaDATIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Apr 2014 15:08:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbaDATIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 15:08:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0183785DA;
	Tue,  1 Apr 2014 15:08:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=K1t5zDDVA76Z
	2hbva8sC5Db1vSs=; b=pEOqCcqtkY9s5YPTN5kiCU1qgYqjobykSJWeaW/SapnA
	D/LitB+Jkkij2voc6cgpSCnxFgoavezM7ms+sdQVP/5gdq9FsGclcTKndLtBBuQk
	jyVN3rhe3ySFw4ip6vx72bqzE83u8s+V97GF/5kDPThdZ+602IN2AL/poeq1uxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ouyxym
	ZPY3Faz2wUBrD+oAPUyt95hxpfbZZaUxR///DRb22gYhNqhXJ0vKwCnBCIliJBtb
	PJ/L29lkqKWho12BWJYf7YBiiFaDWiL5Uhvgrx5fHxVBYD6nUTAnbSLGEUj2uIXX
	+10xoQi/ltOfEl89mbJRoUXgIdzPIlYIlFt0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA445785D9;
	Tue,  1 Apr 2014 15:08:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39F07785D2;
	Tue,  1 Apr 2014 15:08:21 -0400 (EDT)
In-Reply-To: <533AFA86.2090905@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 01
	Apr 2014 19:42:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FDBA87DC-B9D0-11E3-826F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245622>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 01.04.2014 09:42, schrieb Jeff King:
>> diff --git a/compat/gmtime.c b/compat/gmtime.c
>> new file mode 100644
>> index 0000000..ffcabf4
>> --- /dev/null
>> +++ b/compat/gmtime.c
>> @@ -0,0 +1,26 @@
>> +#include "../git-compat-util.h"
>> +#undef gmtime
>> +#undef gmtime_r
>> +
>> +struct tm *git_gmtime(const time_t *timep)
>> +{
>> +	static struct tm result;
>> +	return git_gmtime_r(timep, &result);
>> +}
>> +
>> +struct tm *git_gmtime_r(const time_t *timep, struct tm *result)
>> +{
>> +	struct tm *ret;
>> +
>> +	ret =3D gmtime_r(timep, result);
>> +
>> +	/*
>> +	 * Rather than NULL, FreeBSD gmtime will return a "struct tm" with=
 all
>> +	 * fields zeroed. Since "mday" cannot otherwise be zero, we can te=
st
>> +	 * this very quickly.
>> +	 */
>> +	if (ret && !ret->tm_mday)
>> +		ret =3D NULL;
>> +
>> +	return ret;
>> +}
>
> http://pubs.opengroup.org/onlinepubs/009695399/functions/gmtime.html
> says that errno shall be set on error and only mentions EOVERFLOW as =
a
> possible error code.

So are you saying we should set EOVERFLOW ourselves, or does FreeBSD
set EOVERFLOW for us in this case and we do not have to worry?
