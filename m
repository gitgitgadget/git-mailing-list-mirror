From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] parse_color: support 24-bit RGB values
Date: Thu, 20 Nov 2014 12:25:29 -0800
Message-ID: <xmqq8uj539hi.fsf@gitster.dls.corp.google.com>
References: <20141120151418.GA23607@peff.net>
	<20141120152539.GE23680@peff.net>
	<xmqqh9xt3bdx.fsf@gitster.dls.corp.google.com>
	<20141120201026.GA4779@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 21:25:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrYIN-0000EI-Un
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 21:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939AbaKTUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 15:25:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755664AbaKTUZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 15:25:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C255B1EFD9;
	Thu, 20 Nov 2014 15:25:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LuhaqLnwgPW2O10lnXixrsDF7ic=; b=m1lcww
	0lgEfhY8MJUeufvOT/pCG6uJScGY5C1q6TUDf3f36gE2v3xQMSAXdE3NaxKKmvqP
	BKD6E6MgcMBd7BD6JwkpsVM4qtU0P+/guK6vneJEBTP1eaNQEAY92yxuMgLpMsi6
	28Pk33k1gAOdApxvwtD5XBspvKb3+rVM28RhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PK6mgG26eElXI+a/Xaz8dK0RTfdumQYw
	0Ql1BQjyJDorXxx+roy5kpAiKGFlHTDjWAuQlu777rEBAYGMZXC4+hIR0U49EcQe
	6QdDm+X9K984Xps8xKaK0cyi/0+Q5gsu1QalDhCWrLAsDIOBI3hoU9hWXqgkwBXb
	CZSiVFJE+d4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B70C71EFD8;
	Thu, 20 Nov 2014 15:25:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB7641EFC7;
	Thu, 20 Nov 2014 15:25:31 -0500 (EST)
In-Reply-To: <20141120201026.GA4779@peff.net> (Jeff King's message of "Thu, 20
	Nov 2014 15:10:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6023F834-70F3-11E4-91A7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 20, 2014 at 11:44:26AM -0800, Junio C Hamano wrote:
>
>> > @@ -32,10 +32,13 @@ struct color {
>> >  		COLOR_UNSPECIFIED = 0,
>> >  		COLOR_NORMAL,
>> >  		COLOR_ANSI, /* basic 0-7 ANSI colors */
>> > -		COLOR_256
>> > +		COLOR_256,
>> > +		COLOR_RGB
>> >  	} state;
>> >  	/* The numeric value for ANSI and 256-color modes */
>> >  	unsigned char value;
>> > +	/* 24-bit RGB color values */
>> > +	unsigned char red, green, blue;
>> 
>> Do value and rgb have to be both valid at the same time, or is this
>> "we are not wasting a byte by not using a union because it will be
>> in the padding of the outer struct anyway"?
>
> The latter. I started with a union, and then realized that COLOR_ANSI
> and COLOR_256 shared the value, so the union was not saving space and
> just getting in the way (mostly because I had to think of useful names
> for each of the members).
>
> I'd be happy to do it as a union if you think that makes it clearer.
>
> Also, the name "state" should perhaps be "type". It originally
> started as "unspecified or an actual value", which is a state, but
> as I worked, it grew into something more.

I think use of union might be more "kosher", e.g.

	struct color_spec {
        	enum { ... } type;
                union {
                	struct { unsigned char r, g, b; } rgb;
                        unsigned char ansi;
		} u;
	} c;

but it is not like you have an array of these things for each slot,
and with the intervening ".u.<type>" you have to write every time
you refer to these fields, the result is probably much uglier and
harder to read.  So let's only do s/state/type/ and leave these
"ought to be union but that will be uglier" ones as they are.
