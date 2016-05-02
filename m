From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 25/29] refs: resolve symbolic refs first
Date: Mon, 02 May 2016 11:06:56 -0700
Message-ID: <xmqq37q0uyf3.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<a33272db057ac6327cc0c87c002473c89ffcca6b.1461768690.git.mhagger@alum.mit.edu>
	<1461886803.4123.14.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:07:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIFL-0003rm-Fq
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbcEBSHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:07:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754684AbcEBSG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:06:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73D6116792;
	Mon,  2 May 2016 14:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aVV1zFIFygCpq0kWJGNwVPM7bhE=; b=b0hs/2
	YVJt8BNy7KJTk/YP2x9sDhlOCGpWYA1U0B//loq6ij1gALXwp+fzrlHvsVCu/wNU
	1FxUUPs06HEnN4pu347h5if8+HOtmse4xoKiHUCwARYfm69m3KaT2jTFrFl/LaQg
	FtguSnRFc14NB5/veEBbTPJV+n1hhRPMg7ArU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RX95U0y0tgFlwsIeb5qoU/lmvqgN8PQC
	ORNEBpo05vGx3S05rAwN9R6MPmFsH5Znq36h5sVbpM3C0qdO5Peznxrxma0KGi/v
	zcwU7ygDu72ONQVJ+UD7Ckdqls5NESTmQfShIN4vDE5CF+ArdrEi3c536zafHs2x
	5dRw78qWKh8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C77216791;
	Mon,  2 May 2016 14:06:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4D5E16790;
	Mon,  2 May 2016 14:06:57 -0400 (EDT)
In-Reply-To: <1461886803.4123.14.camel@twopensource.com> (David Turner's
	message of "Thu, 28 Apr 2016 19:40:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9024252-1090-11E6-BCD6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293255>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2016-04-27 at 18:57 +0200, Michael Haggerty wrote:
> +retry:
> ...
>> +		if (--attempts_remaining > 0)
>> +			goto retry;
>
> could this be a loop instead of using gotos?

It could be, but given that there are many such exit points, I do
not think an added level of indentation with while() loop is
particularly a good way to go.

Unless that big body of code that is looped around by implicit "goto
retry" is made into a helper function to perform one round of attempt,
which may result in one of success, temporary failure, final failure.
Then we could do:

	int attempts_remaining = N;
        int failed_hard = 0;
        while (!failed_hard && attempts_remaining--)
        	failed_hard = attempt();
	
and the end result _may_ become easier to read (even though I have
to think for a second what the correct code should look like that
comes after the loop).
