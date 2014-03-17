From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 16:07:00 -0700
Message-ID: <xmqqd2hka0h7.fsf@gitster.dls.corp.google.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
	<1395093144-6786-2-git-send-email-quintus.public@gmail.com>
	<xmqqob14a14s.fsf@gitster.dls.corp.google.com>
	<20140317230139.GB19578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:07:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgch-0003Yq-UW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbaCQXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 19:07:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbaCQXHD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 19:07:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C878C757EC;
	Mon, 17 Mar 2014 19:07:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rBLNZhZwJrW5O9Gv6yBKb++crg=; b=Q5nTdl
	jc8RQYuDSq7Qq4gEAUhisC8WdVrEfsOqKerHBlU+d2Hk56DY4cNRfSaYbHhffAhA
	YOJXpU5ZQ6oOBjYZCWuk3xC3ZLGleQ4Pt+5YpuUljwvZWL4Eg0KAqPHXuPz6NDuN
	VvgO9vdnyM48ae9X/p/ywEPpGU9Da2/Pn8WZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbucwyK4lPWeZqlnUxA9R55FXGGoi3jd
	SPLhXIKW8kDuAezU07Wc90Xl10zTSt1IyhdTrP4VEOTFje/aJL4Lc6PmWZ84XYPc
	npTdeWH+YExM61NG+JB+qALUsm09H/iKWbE9MAgPsbWSSNCvEV2zolY0W7zjD/co
	CS2cH4tdB70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA33F757EB;
	Mon, 17 Mar 2014 19:07:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E0AE757EA;
	Mon, 17 Mar 2014 19:07:01 -0400 (EDT)
In-Reply-To: <20140317230139.GB19578@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 17 Mar 2014 19:01:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D968779E-AE28-11E3-97F8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244310>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 17, 2014 at 03:52:51PM -0700, Junio C Hamano wrote:
>
>> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> > index 3e1d5c3..4135980 100644
>> > --- a/builtin/for-each-ref.c
>> > +++ b/builtin/for-each-ref.c
>> > @@ -193,7 +193,7 @@ static int verify_format(const char *format)
>> >  		at = parse_atom(sp + 2, ep);
>> >  		cp = ep + 1;
>> >  
>> > -		if (!memcmp(used_atom[at], "color:", 6))
>> > +		if (starts_with(used_atom[at], "color:"))
>> >  			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
>> >  	}
>> >  	return 0;
>> 
>> Good.
>
> Actually, I found this one confusing. We are looking for "color:", but
> if we find it, we _don't_ skip past and look at what comes after.
> Instead, we compare the whole string. Which works because color_reset
> actually contains "color:reset", and we end up just re-comparing the
> first bit of the string. So the memcmp here is redundant, and this can
> simply become:
>
>   need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
>
> Or am I missing something?

What if used_atom[at] is not related to color at all?  We do not
want to touch the variable.
