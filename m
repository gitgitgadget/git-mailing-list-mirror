From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH +warn] Implement https public key pinning
Date: Tue, 16 Feb 2016 13:20:57 -0800
Message-ID: <xmqqr3gcmjwm.fsf@gitster.mtv.corp.google.com>
References: <87y4amcby5.fsf@mitoraj.siccegge.de>
	<20160215140422.GA1747@mitoraj.siccegge.de>
	<xmqqr3gdo8sz.fsf@gitster.mtv.corp.google.com>
	<20160216012210.GB11961@sigill.intra.peff.net>
	<xmqqziv1mjf8.fsf@gitster.mtv.corp.google.com>
	<20160216032818.GB19954@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Egger <christoph@christoph-egger.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 22:21:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVn3X-0003rB-GL
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 22:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbcBPVVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 16:21:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756150AbcBPVVB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 16:21:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C27C845845;
	Tue, 16 Feb 2016 16:20:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G1URlSINbf2Jf5e3cFNIFjmaJZg=; b=FEV7s5
	MRjcqJg1G1TmG2PkRYh5eRncHzWbpAL8Propm2EcEKhyfoTjCkHeygaRLCJzpHdO
	4cIPNmRmgsjmSPIk/Krr9OVKiETdzrpA+v5FgcZoxo9iB/lNPJZptCAy52xAeFuu
	LCa1kyV72ysU/q9QY9SRHuh5YOmZJG6cj7luA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3ip9dZOjosVQe1dw+L0JuPztQji+Y3T
	XWwmEA1Eo323YJZY9kfsEqfbS1aDbuScXXSFUPq/nMUdmtunUxV/YkpEQlBZV0rA
	rcm19xvRbV/Tw/FKNRDDHDB+/eAEdVJxWdPjjffh+dciHtBMSNaOtuIYS2qktUmy
	hbWqR4S4KfI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7FCC045844;
	Tue, 16 Feb 2016 16:20:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D54BC45843;
	Tue, 16 Feb 2016 16:20:58 -0500 (EST)
In-Reply-To: <20160216032818.GB19954@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 15 Feb 2016 22:28:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C3B1128-D4F3-11E5-A500-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286433>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 15, 2016 at 07:19:07PM -0800, Junio C Hamano wrote:
>
>> I suspect that "#else" is too agressive to bail out or something
>> silly like that.
>> 
>> Oh, I think I found it.
>> 
>> @@ -216,6 +219,13 @@ static int http_options(const char *var, const char *value, void *cb)
>>  	if (!strcmp("http.sslcapath", var))
>>  		return git_config_pathname(&ssl_capath, var, value);
>>  #endif
>> +	if (!strcmp("http.pinnedpubkey", var))
>> +#if LIBCURL_VERSION_NUM >= 0x072c00
>> +		return git_config_pathname(&ssl_pinnedkey, var, value);
>> +#else
>> +		warning(_("Public key pinning not supported with cURL < 7.44.0"));
>> +		return 0;
>> +#endif
>> 
>> We are not writing in Python.  Indenting the second line the same
>> way does not make it part of the block.  Of course by inserting the
>> new config in the earlier part of the function, it broke everything
>> that comes after.
>
> Oof. Good eyes. I suspected something funny with the #if, but after
> starting at it for minutes, couldn't see it.
>
> That makes sense, and the fix is obvious.

Yup.  I think I sent a patch already and I followed the "when adding
a new thing to a set, add it at the end unless there is other reason
to place it elsewhere".

Thanks.
