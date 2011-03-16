From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] compat: make gcc bswap an inline function
Date: Wed, 16 Mar 2011 12:44:42 -0700
Message-ID: <7v8vwe97f9.fsf@alter.siamese.dyndns.org>
References: <20110316024959.GA24932@elie> <20110316065256.GA5988@elie>
 <20110316070049.GC5988@elie> <4D808126.8070706@viscovery.net>
 <20110316093108.GB7886@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzweV-0006kk-W7
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 20:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681Ab1CPTo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 15:44:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab1CPToz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 15:44:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A32C5440C;
	Wed, 16 Mar 2011 15:46:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KCeUyhleoCKaOPpqYoqK4QQHrpA=; b=pAyut5
	kSR29aaEKLvJk601EjtuexAyI6/M2Z+lUv1ru1f85uw/Os0liDm6j1U9+KHNshEg
	mqdZw59Ou8kr7wdJ1hrKCw5cyb0H4c38eFLtu262nYG/iGTeMhGR2t6jo3DjkD5l
	kKcBizZoSas0euGG72hsuQ/OifcqTDE2BAjhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JXNWRZCQ7viI4+evykTGORVpE8QdNDiF
	C1mYX69fRWOlB6BErdl6gezP3XFs+Zfw35ac378fUSSd0LzV9xOF68EWbAIthrOA
	BiFyc2rk6unbOJm/0dCFOuUQwQ3bN04sWz4g+SIpwtGcdXvHvvwa2afjEnkyPZRg
	mdAH/taE3bs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E8C9440A;
	Wed, 16 Mar 2011 15:46:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4C1334409; Wed, 16 Mar 2011
 15:46:18 -0400 (EDT)
In-Reply-To: <20110316093108.GB7886@elie> (Jonathan Nieder's message of "Wed,
 16 Mar 2011 04:31:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12086552-5006-11E0-B121-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169184>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Sixt wrote:
>> Am 3/16/2011 8:00, schrieb Jonathan Nieder:
>
>>> +static inline uint32_t git_bswap32(uint32_t x)
>>> +{
>>> +	uint32_t result;
>>> +	if (__builtin_constant_p(x))
>>
>> Can this predicate ever be true? Isn't it false even if the function is
>> inlined?
>
> It's true if x is a constant.
> ... demonstration ...

And this trivial function:

    int f(void) {
            return git_bswap32(0x01000000);
    }

compiles down to:

    .globl f
            .type   f, @function
    f:
    .LFB2:
            .cfi_startproc
            movl    $1, %eax
            ret
            .cfi_endproc

on my amd64, with -Os, -O1, or -O2 (gcc 4.4.5). Of course -O0 gives a true
call to git_bswap32() and leaves the definitions of two helper functions
in the object, but that is to be expected.
