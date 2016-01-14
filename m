From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PREVIEW v3 8/9] checkout-index: there are only two line terminators
Date: Thu, 14 Jan 2016 09:13:54 -0800
Message-ID: <xmqq8u3skrsd.fsf@gitster.mtv.corp.google.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
	<1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452740590-16827-9-git-send-email-gitster@pobox.com>
	<20160114101830.GC30772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 18:14:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJlTI-0005LX-GY
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 18:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbcANRN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 12:13:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755702AbcANRN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 12:13:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46D353AAB6;
	Thu, 14 Jan 2016 12:13:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MCNVvHnmbkiG+VIEo/iS61Aoi9k=; b=HrESiM
	PsOyfqFDAEBkJO1YcRbfgiG3FTW1zhy0rLSU4GvzJOIhFWNZkV9Z/1uTRJ4VEKpD
	Mh85ZOOw9TtC/PuG8yLXCsTVegZnLdTDr/FfNabmbq2E7lBz4BJ5yC3vDCBEfE4Y
	tRWURc3kDiBlPco9SnW9niOfnaKxBVuNtJ8P0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+kRUzG2vWU5nFyCdSgqs+3IORSzg1wa
	tUGx6HKXdCK4+Puwcf69nVC4WT3ScrpVW1bwdYMTFGW11dOc6QTTyHp95FX23YlQ
	Gxuf5BuLYKBr5tBKm8tw8scjdt4okc099zTR7MVTBW8z05STeCKFZqJEWEHMCQZj
	tfcjAG/EYDk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3ED103AAB5;
	Thu, 14 Jan 2016 12:13:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B64913AAB4;
	Thu, 14 Jan 2016 12:13:55 -0500 (EST)
In-Reply-To: <20160114101830.GC30772@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jan 2016 05:18:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31539836-BAE2-11E5-88BF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284068>

Jeff King <peff@peff.net> writes:

> I see that we switch the line termination on the fly in option_parse_z.
> But I'm having trouble seeing how we could actually have mixed inputs.
> We don't actually look at the line-terminator until after all of the
> options are parsed.

I do not think we are aiming for mixed inputs.  What I meant by
"mixed" in my description was a possible future option to allow
input and output using different line termination (e.g. via "-Z"
you would control output line termination, while "-z" only affects
the input line termination).

After this step, there is still one call that is more natural to
have line_termination that is either '\0' or '\n' and that is on the
output side, which calls write_name_quoted_relative() to report the
names of the temporary files that received the file contents to the
standard output.

Of course there is nothing wrong to do

        write_name_quoted_relative(name, prefix, stdout,
				   nul_term_lines ? '\0' : '\n');

though.

And I tend to think that it might even be a good idea to do so.  If
somebody in the future really wants to introduce '-Z', then they can
add a separate "output_line_termination" variable back (and it would
likely be set to '\0' or '\n' via "-z" when "-Z" is not given), but
until then, I agree that a simple bool for "-z" would be better.

> I'm also not sure how "unset" would trigger here. If we have a long
> option, we can use "--no-foo". But there isn't a long option for "-z".
> Is there a way to negate short options?

I do not think there is.  It merely future-proofs against those who
try to add "--nul" as a longer synonym.  They would complain after
they add "--nul" in builtin_checkout_index_options[] as a synonym if
they see "--no-nul" does not negate the effect of an earlier "-z".
