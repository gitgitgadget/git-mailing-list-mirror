From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] commit: allow editing the commit message even in shared repos
Date: Thu, 07 Jan 2016 13:35:53 -0800
Message-ID: <xmqq8u413wee.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<cover.1452085713.git.johannes.schindelin@gmx.de>
	<38701d9358765af334ce405eb4a29f0063dae670.1452085713.git.johannes.schindelin@gmx.de>
	<20160107124117.GA14421@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:36:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHIDw-00081v-CC
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 22:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbcAGVf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 16:35:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753040AbcAGVfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 16:35:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3D523AF46;
	Thu,  7 Jan 2016 16:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DxiwzVOizde+2eLvWf2vl7uo57w=; b=I4i1Pg
	TXKHwJxD5RTCLBzQAlDJYhc9vgbRj8ur9rz1Burl7SctfL7mFpewm7HhI0/mKeEG
	kuRjersv5Mr1QuY5rXVBhDD2kRUfikPoFtmIsbTIAM1pzK2zZOWMYyQj7q9ULKro
	jsTnixB4Jq6oneSvSDJipIzOJiyXSQFerrmgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWhNqgHR2Cm3zUlKbRJdJiiOsQyaljei
	8r4kG0BE8ugF+3Sb3ldXJWtBBUfCQ6k/RF9F0FKEq9rt5QeT/DsoEE3XhWZYYh7H
	ea05dIrg6y+rr1TOKEXpcQcs/Mef2Joz0vKjN4Kzc8KWOqq1Pge4v2m4wiQKbIMc
	7OPVo1pIxi8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC3CC3AF45;
	Thu,  7 Jan 2016 16:35:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2244C3AF43;
	Thu,  7 Jan 2016 16:35:54 -0500 (EST)
In-Reply-To: <20160107124117.GA14421@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 7 Jan 2016 07:41:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A15DD670-B586-11E5-9137-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283509>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 06, 2016 at 02:09:43PM +0100, Johannes Schindelin wrote:
>
>> It was pointed out by Yaroslav Halchenko that the file containing the
>> commit message is writable only by the owner, which means that we have
>> to rewrite it from scratch in a shared repository.
>> [...]
>> diff --git a/wrapper.c b/wrapper.c
>> index b43d437..29a45d2 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -391,6 +391,19 @@ FILE *xfdopen(int fd, const char *mode)
>>  	return stream;
>>  }
>>  
>> +FILE *fopen_for_writing(const char *path)
>> +{
>> +	FILE *ret = fopen(path, "w");
>> +
>> +	if (!ret && errno == EPERM) {
>> +		if (!unlink(path))
>> +			ret = fopen(path, "w");
>> +		else
>> +			errno = EPERM;
>> +	}
>> +	return ret;
>> +}
>
> Thanks, this looks good to me. Having seen the implementation, it really
> is just "try harder to fopen()".  I guess calling it "fopen_me_harder()"
> would be too obscure. :)

obscure or you meant some other obsxxxx?  fopen_harder() does not
sound too bad, but fopen_for_writing() is OK to me.

And its use in this patch looks sensible.

Thanks.
