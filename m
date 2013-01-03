From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Thu, 03 Jan 2013 07:34:53 -0800
Message-ID: <7vehi2xote.fsf@alter.siamese.dyndns.org>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
 <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
 <20130103083712.GC32377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 16:35:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqmpB-0006NP-4T
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 16:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab3ACPe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 10:34:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab3ACPe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 10:34:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3039ABB8E;
	Thu,  3 Jan 2013 10:34:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DgeZfUrL3PtWuG+senmMHkRz/wc=; b=OpxAmH
	apB9C5FRWQ4RVkdsOTldR5W/UwH7UnRM4UAnKQU2iUW3GLpDFic1GSSSqQK3AO91
	YDwn/NBPOHjccF/ae3Fffj6iBy3wqiWSjxC+XeHCxqm2rcBm8yQWVuxoE2BGb0Ss
	aKDcIMw8n8slOAF6wUCGuOef9VItx4EUNY9qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uTkuCmxWY4BAqhQsSMdqoagA5nmG0TY/
	NHMPzynb5Aau/dA5nO9Nl7eHsRHSr+T2N+Ng9D7lnhPqbwki1eEeEMyWfDY3Ig+N
	GSZABbo57NRtKvPlJ/jBXPvXsWkNWjDHEOZ51aa9IbprE0zx58le1cQoQTViVdB6
	mGcC0b1+DD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C2DBB8D;
	Thu,  3 Jan 2013 10:34:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E58EBB8B; Thu,  3 Jan 2013
 10:34:55 -0500 (EST)
In-Reply-To: <20130103083712.GC32377@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Jan 2013 03:37:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FC21C12-55BB-11E2-8656-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212590>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 01, 2013 at 02:24:46PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > So I think we need to update twoway_merge to recognize unmerged entries,
>> > which gives us two options:
>> >
>> >   1. Reject the merge.
>> >
>> >   2. Throw away the current unmerged entry in favor of the "new" entry
>> >      (when old and new are the same, of course; otherwise we would
>> >      reject).
>> >
>> > I think (2) is the right thing.
>> 
>> As "--reset" in "read-tree --reset -u A B" is a way to say "we know
>> we are based on A and we want to go to B no matter what", I agree we
>> should not reject the merge.
>> 
>> With -m instead of --reset, I am not sure what the right semantics
>> should be, though.
>
> Good point; I was just thinking about the --reset case.
>
> With "-m", though, we could in theory carry over the unmerged entries
> (again, assuming that "old" and "new" are the same; otherwise it is an
> obvious reject). But those entries would be confused with any new
> unmerged entries we create. It seems we already protect against this,
> though: "read-tree -m" will not run at all if you have unmerged entries.
>
> Likewise, "checkout" seems to have similar protections.
>
> So I think it may be a non-issue.

Yeah.  Also earlier in the thread you mentioned three-way case, but
I do not think we ever would want --reset with three trees, so I
think that too is a non-issue for the same reason.

I would still feel safer if we expressed the expectation of
the callee in the code, perhaps like this in the two-way case:

	if (current->ce_flags & CE_CONFLICTED) {
        	if (!o->reset) {
                	... either die or fail ...
		} else {
                	... your fix ...
		}
	}
