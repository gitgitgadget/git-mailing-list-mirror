From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tag peeling peculiarities
Date: Fri, 15 Mar 2013 09:28:59 -0700
Message-ID: <7vzjy4vd84.fsf@alter.siamese.dyndns.org>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
 <20130313215800.GA23838@sigill.intra.peff.net>
 <51415516.2070702@alum.mit.edu> <20130314052448.GA2300@sigill.intra.peff.net>
 <5141B475.1000707@alum.mit.edu> <20130314134032.GA9222@sigill.intra.peff.net>
 <5142ADAA.6050503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 15 17:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGXVu-0003pa-BX
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 17:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab3COQ3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 12:29:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab3COQ3B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 12:29:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22C94B80F;
	Fri, 15 Mar 2013 12:29:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gERPyegSehalHuADTeAsUbHl4bE=; b=FyUYMe
	qtbxqhme5Evj971b+Nri+m0KTvHwfhE3Lfykm28Iiq58MwlT7K/50jvecvjWJsuM
	XCN+fPrthbRlq0oqrdBvzG5z89hqDMT4ETHcO0K5VBFvcohe1LpRXsxdZ781BAah
	GVrAKkjyTlnSVWNlDilQjGgkFgE/HPD7eu3II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wSowocsP1W3vvi8wUYyLLTYhmvifR8Ur
	UdbH91QVZpoKz5Is6nLYiGxN1KXPD0rVEP1PGPCXQ7mjNLlxNF9uPF6ZRQiEmLt1
	5dYQ3C9/yj3lLlWGwHLw3VHsoUZTsrRBBTS03Ue36d/I2r5z4nyNVK8fXbeRVwjP
	D/HKVwVO41U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17154B80E;
	Fri, 15 Mar 2013 12:29:01 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 812E5B80D; Fri, 15 Mar 2013
 12:29:00 -0400 (EDT)
In-Reply-To: <5142ADAA.6050503@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 15 Mar 2013 06:12:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 714DF448-8D8D-11E2-AF50-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218251>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> What is stored in ref_value.peeled?  Is it the peeled version of
> ref_value.sha1, or is it the peeled version of the associated refname?
> Because they are not necessarily the same thing: an entry in the packed
> ref_cache *might* be overridden by a loose reference with the same
> refname but a different SHA1 which peels to a different value.

The way it should work is that we look for loose ones first and then
only if we do not find a loose one we use packed one, when asked for
a ref by name.  The .sha1 and .peeled fields for a single ref_entry
struct must be consistent with each other, even though you might
have got a ref_value by reading the packed-refs file and another
ref_value by reading loose one and have both in core.  When you have
both packed and loose, the former should not be used at all, and it
certainly should not be pointed by current_ref.

Stepping back a bit, I suspect that it may be worth evaluating to
see if it still makes sense to keep the current_ref optimization
that was introduced in 0ae91be0e1fa (Optimize peel_ref for the
current ref of a for_each_ref callback, 2008-02-24).  Back then, it
was fairly expensive to find a cached_ref entry by name, because it
was implemented as two linked lists (one for loose, one for packed)
and we would have had to traverse them to answer the question.

Since then, e9c4c11165e4 (refs: Use binary search to lookup refs
faster, 2011-09-29) introduced ref_array to make it more efficient
to find a ref_entry by name, and your more recent series that
includes bc5fd6d3c29f (refs.c: reorder definitions more logically,
2012-04-10) further touched that codepath for enumeration in a
subtree.

I am not sure if that last change helped or hurt the performance of
a single ref lookup, but we can certainly say that the performance
characteristics of read_ref_full() is very different in today's code
and the current_ref optimization may no longer be of much value.
