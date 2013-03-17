From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fix unparsed object access in upload-pack
Date: Sat, 16 Mar 2013 23:17:18 -0700
Message-ID: <7vk3p6sg7l.fsf@alter.siamese.dyndns.org>
References: <20130316102428.GA29358@sigill.intra.peff.net>
 <7v7gl6txl3.fsf@alter.siamese.dyndns.org>
 <20130317054039.GA16070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 17 07:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6us-0008Nm-3V
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 07:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab3CQGRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 02:17:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab3CQGRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 02:17:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0828AA755;
	Sun, 17 Mar 2013 02:17:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nUmddIrrAQxyB1CPfWVEeT0IKuI=; b=hpNC9e
	8Rq9lXOO82aj2eu8ku1RHPTXKe8pMmtGFqgez95xJbV6REMOWYeYBVA8exGrOWPz
	k1nVlnKHWqNJQgN/7dlBY+GsBvKArZKZG8JzmKh8uozeqOErxcizf0XCyxMrcsGU
	WRLSt0wzD82mY8XKoIJaIvImhY73dM1KYY6Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZtvNOvMZJDvhys21kAlqm1XH5QHNKKwR
	nKGpWQ0/EBPcIttioim8dO+s4ld0oSfO3X6xU+Q7FVkn0L2iG8FoRpD92NopnQcV
	USUiV0thvRGEUUj6dmCwa/Ipnf+clOKNYIaxiWbb03GKVLQiHtUmWSjqFEGJAGV9
	2dyjF9Tdubc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1192A754;
	Sun, 17 Mar 2013 02:17:20 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60239A753; Sun, 17 Mar 2013
 02:17:20 -0400 (EDT)
In-Reply-To: <20130317054039.GA16070@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 17 Mar 2013 01:40:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53250BDA-8ECA-11E2-8AC2-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218340>

Jeff King <peff@peff.net> writes:

>> >   [3/3]: upload-pack: load non-tip "want" objects from disk
>> >
>> >     While investigating the bug, I found some weirdness around the
>> >     stateless-rpc check_non_tip code. As far as I can tell, that code
>> >     never actually gets triggered. It's not too surprising that we
>> >     wouldn't have noticed, because it is about falling back due to a
>> >     race condition. But please sanity check my explanation and patch.
>> 
>> Thanks. That fall-back is Shawn's doing and I suspect that nobody is
>> exercising the codepath (he isn't).
>
> I almost wonder if we should cut it out entirely. It is definitely a
> possible race condition, but I wonder if anybody actually hits it in
> practice (and if they do, the consequence is that the fetch fails and
> needs to be retried). As far as I can tell, the code path has never
> actually been followed, and I do not recall ever seeing a bug report or
> complaint about it (though perhaps it happened once, which spurred the
> initial development?).

If you run multiple servers serving the same repository at the same
URL with a small mirroring lag, one may observe a set of refs from
one server, that are a tad older than the other server you actually
fetch from.  k.org may have such an arrangement, but does GitHub
serve the same repository on multiple machines without tying the
same client to the same backend?
