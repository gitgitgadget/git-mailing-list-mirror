From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] log: handle integer overflow in timestamps
Date: Mon, 24 Feb 2014 13:01:57 -0800
Message-ID: <xmqqy5106x8a.fsf@gitster.dls.corp.google.com>
References: <20140224073348.GA20221@sigill.intra.peff.net>
	<20140224074637.GD9969@sigill.intra.peff.net>
	<xmqqsir88f4n.fsf@gitster.dls.corp.google.com>
	<20140224195829.GA11940@sigill.intra.peff.net>
	<xmqqeh2s8do2.fsf@gitster.dls.corp.google.com>
	<20140224203709.GA25506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 22:02:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI2fD-0002B1-6C
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 22:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbaBXVCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 16:02:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565AbaBXVCF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 16:02:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B01B6F4FD;
	Mon, 24 Feb 2014 16:02:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hwih8ocgmmjFPc7jV+6sNAm0SFY=; b=mkxJP8
	ZoHtuJoLVH2vZhuZ5gor8MI/6cfweOnikvVy4EUL5iUjkfgvDUaf011x478hNTg4
	STCCh+5nXNRh1ZwSdYU0TtuhvnrZz1X/Hfbpt/aU0xhgH0uLrOe3cH97Zz6qlVkY
	HmBOAVz4TT0BfKSwBFWaASn/2nnQvLh1R63OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n5PqAOJs3IOMzVHi4vAdk8Tv5WPAmf3O
	+AhXrHQEyVsRxInzuy1IMO/tsmwBf1SSIGe1woZynJUMKRYL3teu6PU1fbNu5pSg
	prliYV6pv+6F4Y4y/yqqWYis5ZyF+UucD4fR3fbjgliAyiEqkWqb9s1af6N0fyy2
	Wj7yfswNDMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54B086F4FC;
	Mon, 24 Feb 2014 16:02:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C81B6F4FA;
	Mon, 24 Feb 2014 16:01:59 -0500 (EST)
In-Reply-To: <20140224203709.GA25506@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2014 15:37:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6B5B74C-9D96-11E3-A1EC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242647>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 24, 2014 at 12:21:33PM -0800, Junio C Hamano wrote:
>
>> >> > +	if (date_overflows(date))
>> >> > +		date = 0;
>> >> > +	else {
>> >> > +		if (ident->tz_begin && ident->tz_end)
>> >> > +			tz = strtol(ident->tz_begin, NULL, 10);
>> >> > +		if (tz == LONG_MAX || tz == LONG_MIN)
>> >> > +			tz = 0;
>> >> > +	}
>> >> 
>> >> ... don't we want to fix an input having a bogus timestamp and also
>> >> a bogus tz recorded in it?
>> >
>> > If there is a bogus timestamp, then we do not want to look at tz at all.
>> > We leave it at "0", so that we get a true sentinel:
>> 
>> Ah, OK, I missed the initialization to 0 at the beginning.
>> 
>> It might have been more clear if "int tz" declaration were left
>> uninitialized, and the variable were explicitly cleared to 0 in the
>> "date-overflows" error codepath, but it is not a big deal.
>
> It might be, but I think it would end up cumbersome.
> ...
> So I'd be in favor of keeping it as-is, but feel free to mark it up if
> you feel strongly.

I'd be in favor of keeping it as-is.
