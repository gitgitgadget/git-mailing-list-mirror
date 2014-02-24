From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] log: handle integer overflow in timestamps
Date: Mon, 24 Feb 2014 12:21:33 -0800
Message-ID: <xmqqeh2s8do2.fsf@gitster.dls.corp.google.com>
References: <20140224073348.GA20221@sigill.intra.peff.net>
	<20140224074637.GD9969@sigill.intra.peff.net>
	<xmqqsir88f4n.fsf@gitster.dls.corp.google.com>
	<20140224195829.GA11940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI222-0003Hx-NG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbaBXUVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:21:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbaBXUVh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:21:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A526E2F0;
	Mon, 24 Feb 2014 15:21:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=21m2V21jMukGh1oBTUFeahcEtqo=; b=D8gcGw
	QbbSkH5GNBN67yQPB7pt6HTMSs2G4cF0hhAMEdFMKK31mrWldFD/84frmZDyArJQ
	RohZ0DAx6vPlnlhpgq5qTsN/rLQ13R1Lhbg8pDGrmiLqBUKazsvx4+h7UiLLPJ+A
	E+yragGMhOo3IYNlJNgLzyqK6ZxN9aPOqxd10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q+rpRzdLEyvVz46yFGSsQtIR4ObdMLCV
	Lmcxj4aCjw89uZbImhOmMGuVFeXTZwzbH9Ajv5mhyp81jX80zDpAc5vQe3JG0gOa
	EdS5ARKWI/HcNkVpyD80R8+y87L8bDq2WJKskOBGQC8JxbbW2GVqK+ogCRH0RDCa
	H+DwJCFI1nA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F09136E2EF;
	Mon, 24 Feb 2014 15:21:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4846E6E2ED;
	Mon, 24 Feb 2014 15:21:36 -0500 (EST)
In-Reply-To: <20140224195829.GA11940@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2014 14:58:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42845250-9D91-11E3-9DC7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242640>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 24, 2014 at 11:50:00AM -0800, Junio C Hamano wrote:
>
>> > We also recognize overflow in the timezone field, which
>> > could produce nonsensical results. In this case we show the
>> > parsed date, but in UTC.
>> 
>> Both are good measures to fallback to sanity, but why is that
>> if/else?  In other words...
>> 
>> > +	if (date_overflows(date))
>> > +		date = 0;
>> > +	else {
>> > +		if (ident->tz_begin && ident->tz_end)
>> > +			tz = strtol(ident->tz_begin, NULL, 10);
>> > +		if (tz == LONG_MAX || tz == LONG_MIN)
>> > +			tz = 0;
>> > +	}
>> 
>> ... don't we want to fix an input having a bogus timestamp and also
>> a bogus tz recorded in it?
>
> If there is a bogus timestamp, then we do not want to look at tz at all.
> We leave it at "0", so that we get a true sentinel:

Ah, OK, I missed the initialization to 0 at the beginning.

It might have been more clear if "int tz" declaration were left
uninitialized, and the variable were explicitly cleared to 0 in the
"date-overflows" error codepath, but it is not a big deal.

Thanks for clarification.
