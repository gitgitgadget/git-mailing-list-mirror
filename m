From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Wed, 20 Jan 2016 12:35:56 -0800
Message-ID: <xmqqfuxs56qb.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
	<711209F5-E034-459E-8E85-BF8BC32B2E86@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:36:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzU4-0002ES-4v
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 21:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbcATUgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 15:36:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753856AbcATUf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 15:35:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1EBB3C441;
	Wed, 20 Jan 2016 15:35:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zVB51e6++VoshbKOclAvcl6zxHY=; b=ibsKuF
	E4YA4ZytylOkh9Hmazutt9cXylitaVhk5kBQ50+yMQWp7icyzqlhRu7DiY452UMe
	vuCqArsPeLCwJ6B60vcITQevZqcnplMjXJ/R7NDXcgfAD6RTiBtrGbdVzC704HaG
	+rBCyY/IJHBffeV9ErY6OTbeUFXHemYgv3R10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BYsB6e7uHn1jl+StIGJ515KatoscGrr+
	uhsJSs4JukmZKU1sM86qjrn1Pv1ERDeAK91/QiD2e+iKn7SAVonYyF6fwH9Cqe43
	4Dha7w9rKpP7GC5Qm32qpmtCCvkgBDxlRaT7fjl/eUDM7vfjBpAo0+nhPNgM+4Yd
	AKcNYQfgDyY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9F193C440;
	Wed, 20 Jan 2016 15:35:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E2453C43D;
	Wed, 20 Jan 2016 15:35:57 -0500 (EST)
In-Reply-To: <711209F5-E034-459E-8E85-BF8BC32B2E86@gmail.com> (Lars
	Schneider's message of "Wed, 20 Jan 2016 10:04:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68D319B2-BFB5-11E5-8CD2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284465>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 19 Jan 2016, at 21:00, Junio C Hamano <gitster@pobox.com> wrote:
>
>> IOW, I am confused by the beginning of the log message that says
>> this is taking advantage of "the Travis-CI cache feature".  This
>> improvement looks to me like using the feature of "prove" that
>> allows us to run slower tests first, and does not have much to do
>> with Travis.
>> 
>> You are relying on the assumption that things under $HOME/ is stable
>> while things under t/ (or in our source tree in general) are not,
>> and I think that is a sensible thing to take advantage of, but are
>> we sure that they are running in an environment where "ln -s" would
>> work?  Otherwise, it may be more robust to copy $HOME/.prove to
>> t/.prove before starting to test and then copy it back once the
>> tests are done.
>
> OK, looks like my wording was not ideal. One important thing to know is that 
> $HOME is *not* stable. These TravisCI machines start *always* in a completely 
> clean state.

Ah, that is what I missed.  Travis makes everything transient by
default (which is a sensible thing to do for CI), but it lets you
declare some things are to be made stable, and that is the "cache"
feature you are taking advantage of in Travis.

The log message needs to be clarified in a reroll, but thanks for
clarifying it for me in advance ;-)

That only leaves one question from me: Is 'ln -s' safe enough?
Would copying back and forth make it more robust?

I am guessint the answers are Yes and No, in which case the patch
text can (and should) stay as-is.

Thanks.
