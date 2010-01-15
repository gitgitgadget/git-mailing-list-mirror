From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 10:16:13 -0800
Message-ID: <7vmy0f1bf6.fsf@alter.siamese.dyndns.org>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix>
 <op.u6haiiiog402ra@nb-04> <7vvdf33onp.fsf@alter.siamese.dyndns.org>
 <20100115140048.GB30986@rm.endoftheinternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:16:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqik-0004NC-Iq
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab0AOSQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958Ab0AOSQX
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:16:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab0AOSQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:16:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D15291975;
	Fri, 15 Jan 2010 13:16:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hyTFuXquHFmPwovtSBxHBt6d66Y=; b=rBacFt
	Igr64uCZsrq/Ro1UvFjVmhi6JqxMzk0KbEPKMLgk/UjXSG2bn1UWkhYUNMIJg/7r
	6GfxC0230HPGvb36kppjojbDnTm/I60/pqWNCA05LiCq/gswqqBSbH5X9L4M0EBY
	08Q4XmtgZqS5bKgNav983+cDlt+KzALxOPprA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kf8rVfo2zP9O3hWF3ozAfGn+rQ4TupiD
	BQd7ie0ERMF9C+z1aKH6p7gsL3msQTK+7km2B0zxZWKLTO1S5YMgiei8p6wD8/GJ
	DQdmGOp3jzbAAxit26FFeAJsMvWhi03O/DVvhTUP+KPqAjFbHfojRcMuijkMekZ2
	65q9QV7KTaM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCA8791973;
	Fri, 15 Jan 2010 13:16:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 022E091972; Fri, 15 Jan
 2010 13:16:14 -0500 (EST)
In-Reply-To: <20100115140048.GB30986@rm.endoftheinternet.org> (Rudolf
 Polzer's message of "Fri\, 15 Jan 2010 15\:00\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13B2FEBA-0202-11DF-BCF5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137091>

Rudolf Polzer <divVerent@alientrap.org> writes:

> On Thu, Jan 14, 2010 at 09:47:22PM -0800, Junio C Hamano wrote:
>> I have a feeling that it is more appropriate to have the additional code
>> in transport_push(), which gets ls-remote information, runs match_refs()
>> and finally calls transport->push_refs().  I think the extra branch
>> configuration would fit better inside the if block immediately after all
>> that happens, i.e.
>> 
>> 	if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
>> 		struct ref *ref;
>> 		for (ref = remote_refs; ref; ref = ref->next)
>> 			update_tracking_ref(transport->remote, ref, verbose);
>> +		if (flags & TRANSPORT_PUSH_RECONFIGURE_FORK)
>> +			configure_forked_branch(...);
>> 	}
>> 
>> in transport.c
>
> I thought about this place when making my patch, but didn't put it there
> because this function is not called in the rsync protocol (which defines
> transport->push).

That's not a very good reasoning.  Instead of punishing well behaved
transport that defines push_ref, punish _only_ the transports that does
not define it (see the paragraph at the end of this message).

> But well. Why bother with this, if this feature was rejected before already
> anyway.

Read the thread Nana quoted for you again; I nor anybody ever _rejected_
the ultimate goal, even though I said that the justifications were not
sufficiently convincing for the previous implementation attempts.

I think Ilari's patch is done right and can be extended by anybody who
cares about rsync transport to call an extra ls-remote in the "does this
one lack push_ref but know how to push" codepath.
