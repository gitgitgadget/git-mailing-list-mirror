Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 31436 invoked by uid 107); 22 Feb 2010 19:56:16 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 22 Feb 2010 14:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab0BVTzy (ORCPT <rfc822;peff@peff.net>);
	Mon, 22 Feb 2010 14:55:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab0BVTzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 14:55:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 040CF9CD5F;
	Mon, 22 Feb 2010 14:55:50 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HtcgMA1ovPHKfDOPy2IciajP0hY=; b=m4BKaq
	LWWuEcwBQ5By119Ygz0w/s33ONjJUY9lPC4y43r3JZeiIYE664W9y1sg10aGY8Fb
	u08+nRGqt3gusbxJb9UihKV1Gp0gvqOBx5Nj/6woVQAFKJ4hqLsBUzVlosQjOJTQ
	vheXBb1XMcuqpxX1l9fDbKicpTHTBqINf00dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HtWZ3+kCbniuijHDiwlV/slRYBhLLaI5
	7rJ2H1fHj3GoXe9lAfxOPYViy11Z/ZvBqeDJEBJ6V/gywjuU7lOdESUtVwCAM9rf
	decWsTwUfXNrMzqICzowanHPXdHJKeo6g4BanQDM91hhGueGQEEi5TBOiy4Gu+DE
	ThB5kY14fH4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D00AC9CD5E;
	Mon, 22 Feb 2010 14:55:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BD5E9CD5D; Mon, 22 Feb
 2010 14:55:45 -0500 (EST)
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
 <7v635p4z26.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002220034540.1946@xanadu.home>
 <7v8walyesu.fsf@alter.siamese.dyndns.org>
 <7v4ol9vl0l.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002221233000.1946@xanadu.home>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 22 Feb 2010 11:55:43 -0800
In-Reply-To: <alpine.LFD.2.00.1002221233000.1946@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 22 Feb 2010 12\:36\:39 -0500 \(EST\)")
Message-ID: <7vmxz1dozk.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 453351B2-1FEC-11DF-BAFE-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

>> Having said all that, I like your approach better.  It is not worth paying
>> the price of unnecessary memcpy(3) that would _only_ help catching the
>> insanely artificial test case, but your patch strikes a good balance of
>> small overhead to catch the easier-to-trigger (either by stupidity, malice
>> or mistake) cases.
>
> I think it also catches the bad RAM case which is probably more common 
> too.

That is true; a broken RAM that returns unstable values will yield
different values between the time the first hash runs and the time the
deflate loop runs will trigger the safety.
