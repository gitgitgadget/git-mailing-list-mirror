From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] prune: keep objects reachable from recent objects
Date: Fri, 03 Oct 2014 20:04:09 -0700
Message-ID: <xmqqfvf4k02e.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003203931.GM16293@peff.net>
	<xmqq1tqolt9u.fsf@gitster.dls.corp.google.com>
	<20141004003036.GE17063@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 05:04:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaFe4-0006ZQ-0L
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 05:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbaJDDES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 23:04:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63529 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751986AbaJDDER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 23:04:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DEC810FA4;
	Fri,  3 Oct 2014 23:04:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vbZLg3x+N9sOUpOOhSHHnislioY=; b=SXwdJB
	aMlncKRGkYZwf9LOuGgLLLDpQjWZtHZsccRhasq4TcEhNi498PiWqS3st8d5pX2t
	LpozSn1mfLLSgbZBkJsaF+1iwwFIVU2D6ruYMQ7VATwOK4owb5LsnXlpFd86b7KO
	BQY9kYhvAIv8c/7TGQy0iUcmltPijrHtjTRvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BOWe+HdTofxkYe543SboESkQen9aneoH
	8N5uFUuzqC7xwF4jYAyW2daaVm+hO9DKPRha+XXCTIRl300oVfz/qCbD1+ZqJ5kf
	1+mFH032IQoXNVqZKXdyrOWcBxU7pddNU9cYXxmJGfppBz9rUSlkDaEcLBRWzToE
	3SIQ6zD3PTo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1611A10FA3;
	Fri,  3 Oct 2014 23:04:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9386B10FA2;
	Fri,  3 Oct 2014 23:04:10 -0400 (EDT)
In-Reply-To: <20141004003036.GE17063@peff.net> (Jeff King's message of "Fri, 3
	Oct 2014 20:30:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CE6E734-4B73-11E4-A5CC-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257887>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 03, 2014 at 02:47:57PM -0700, Junio C Hamano wrote:
>
>> With this patch applied, the system will not prune unreachable old
>> objects that are reachable from a recent object (the recent object
>> itself may or may not be reachable but that does not make any
>> difference).  And that is sufficient to ensure the integrity of the
>> repository even if you allow new objects to be created reusing any
>> of these unreachable objects that are left behind by prune, because
>> the reachability check done during prune (with this patch applied)
>> makes sure any object left in the repository can safely be used as a
>> starting point of connectivity traversal.
>
> Your use of "safely" in the last sentence here made me think.
>
> In a repository that has had this patch from the beginning, it should be
> safe to traverse the unreachable but unpruned objects, because the
> property of the repository we are trying to guarantee means that we will
> have all of the referents.
> ...

Another case that may be of interest is to start a dumb HTTP commit
walker to fetch new history and kill it before it manages to
complete the graph and update the refs.  It has the same property as
running hash-objects to create an unconnected cruft object after you
got your repository into a "safe" state, but it would be a lot less
easier to blame the user for the resulting "breakage".

Perhaps the dumb commit walkers outlived their usefulness and we
should start talking about their deprecation and eventual removal at
a later version of Git?
