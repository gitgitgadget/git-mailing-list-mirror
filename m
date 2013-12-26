From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option parsing
Date: Thu, 26 Dec 2013 11:27:10 -0800
Message-ID: <xmqqha9vct0x.fsf@gitster.dls.corp.google.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
	<1387378437-20646-3-git-send-email-pclouds@gmail.com>
	<52B3E8D4.1030805@viscovery.net>
	<20131220070449.GA29717@sigill.intra.peff.net>
	<xmqq38lndxae.fsf@gitster.dls.corp.google.com>
	<CACsJy8A0TAyBoTdyrRDb54j9uoZ0=cOuxgTfFavRiUOpHTV_ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 20:27:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwGaV-0003B1-N3
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 20:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab3LZT1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 14:27:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab3LZT1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 14:27:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDC05AA9A;
	Thu, 26 Dec 2013 14:27:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VjWvca0ntm+0Lvfc0HQx89gMxlI=; b=gF7IGe
	bKWweh5MJOo/K7Yy0br1qukN81xx6O7hzGxJdGcJxoON0H7VMw6HI4dyTLkd23xY
	5SmjoWtSqfVXB8RytnZ9rjUQsVrJiRCXdla8wrOiyfmx0MuLjjmsr00+505EZnX8
	FAoCu8S+u/LxjWwIG+BR/PHgGFA3mTgE1LaEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ahGtvnAGQzP7Wgou3KhuhLQ5iSZSQM5B
	37q5NWOFzBuKw22H17siTAMnWUuOHQ9go2eLwGPMa+Hoki+aPIlC8qRON6P1Flj7
	DCbe5xry89ychCt8QHXU6TX0jKlMWOGqdbp5D3urqBG0EZ9189yb/rkmQkBrJRjV
	DI1kT0ses7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 418625AA99;
	Thu, 26 Dec 2013 14:27:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DC5E5AA98;
	Thu, 26 Dec 2013 14:27:13 -0500 (EST)
In-Reply-To: <CACsJy8A0TAyBoTdyrRDb54j9uoZ0=cOuxgTfFavRiUOpHTV_ag@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 21 Dec 2013 11:44:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B90C49E4-6E63-11E3-BA1C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239708>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Dec 21, 2013 at 4:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>>   /* here we care if we saw the prefix, as above */
>>>   if (parse_prefix(foo, prefix, &the_rest))
>>>       ...
>>>
>>>   /*
>>>    * and here we do not care, and just want to optionally strip the
>>>    * prefix, and take the full value otherwise; we just have to ignore
>>>    * the return value in this case.
>>>    */
>>>   parse_prefix(foo, prefix, &foo);
>>
>> Sounds fine.  I recall earlier somebody wanting to have a good name
>> for this thing, and I think foo_gently is *not* it (the name is
>> about adding a variant that does not die outright to foo that checks
>> and dies if condition is not right).
>>
>>         starts_with(foo, prefix);
>>         strip_prefix(foo, prefix, &foo);
>>
>> perhaps?
>
> I still need consensus on the name here guys, parse_prefix.
> remove_prefix or strip_prefix? If no other opinions i'll go with
> strip_prefix (Jeff's comment before parse_prefix() also uses "strip")

Yup, that comment is where I took "strip" from.  When you name your
thing as "X", using too generic a word "X", and then need to explain
what "X" does using a bit more specific word "Y", you are often
better off naming it after "Y".
