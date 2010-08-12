From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: demonstrate a weakness with identical conflicts
 in different files
Date: Wed, 11 Aug 2010 19:50:05 -0700
Message-ID: <7vfwykv92a.fsf@alter.siamese.dyndns.org>
References: <4C629495.60105@viscovery.net>
 <7vmxssvi2t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 04:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjNs4-0008R5-3k
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 04:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759426Ab0HLCuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 22:50:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759384Ab0HLCuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 22:50:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00A7BCC683;
	Wed, 11 Aug 2010 22:50:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oqqYOHqak/u6Pa+QEfyiB8ylnPg=; b=TbDl6s
	uLtyu84xcErUKjy9Js4PgD6pqehGoK7JaWxMV9/QH6XS64moSH4X9pDifKBYIavI
	vynVOBfUw9M4pqyfmgP3w7Ii3WaXbTvGLKUwJM7EHowXJKotxrHkto8B7VssV/WF
	bNJ3aS7Uzf0EFIRdpVlB6+UFc7GMeSg9yQ6BI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h4bTXF+CBPBi06+v6WFz9e85hSj/9AEm
	spvwfYbkocTNUcmN6ff2sa+/RM0mMBOkBJoVbBDNutcFkmZ2E5zwvlPyzKOovw3v
	ZTyi7itX43WGbNr+VKXFwtM4eB8qJ1c0L/Imiq3z199NoC/d8B3VtsxNCFZhHye4
	D4rcy1Hr5RI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CADEECC682;
	Wed, 11 Aug 2010 22:50:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFDF5CC67F; Wed, 11 Aug
 2010 22:50:07 -0400 (EDT)
In-Reply-To: <7vmxssvi2t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 11 Aug 2010 16\:35\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52EB26DA-A5BC-11DF-8CC0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153328>

Junio C Hamano <gitster@pobox.com> writes:

> Hmm, my knee-jerk reaction was that something may be keying off of the
> conflict ids to keep track of which ones are dealt with and which ones are
> yet to be resolved, but I don't recall any part of the implementation that
> would do something like that offhand.  Sorry.

Heh, what was I thinking.  Yes, rr-cache/ database keys off of the
conflict id, so if your repository has more than one contents that produce
exactly the same conflict, say F and G, then, most likely:

 * You see one of them first, say F, record preimage.F and record its
   resolution as postimage.F

 * You encounter conflict G; record it in thisimage, try three-way merge
   between postimage.F and that using preimage.F as the common ancestor.
   If this doesn't work (and it likely doesn't), rerere punts.

Note that this issue can happen even when the trees you are currently
merging have only content derived from G and nothing related to F, as
their resolutions share the same conflict id.

I vaguely recall discussing this with you here and bringing up a possibile
solution for a situation like this; keep sets of <preimage, postimage>
(starting from the current {pre,post}image adding {pre,post}image.1,
{pre,post}image.2 and so on).  When we see a new conflict (after a mergy
operation before "rerere" resolves it), try to run the three-way merge
with it and each pair, and if we don't find anything that successfully
merges, record it as a new half of the pre-post pair, incrementing the
counter, and record a new resolution to complete the new pair for later
use.

We also need to split "thisimage" into multiple ones in case this happens
in a single tree (i.e. contents derived from F and from G are both present
and produce the conflict in the same merge).
