From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/4] commit lists as priority queues
Date: Fri, 20 May 2011 15:03:08 -0700
Message-ID: <7v4o4p2foj.fsf@alter.siamese.dyndns.org>
References: <20110519204851.GA28574@sigill.intra.peff.net>
 <20110519212349.GA28589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 21 00:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNXn2-0005wR-US
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 00:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab1ETWDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 18:03:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab1ETWDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 18:03:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E8FE5786;
	Fri, 20 May 2011 18:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/Ts7+msSGmJB6t1HVcK4RwpWQc0=; b=UXa44Gjljwbz+S6XW61m
	2H3WcL9bMYLM0UUHMnnJoTRJfRUf9vLJnzPMflQKSW+TBBzgQRikFlL1UoMenadP
	LrUgQsbMXMRrynjiFLOtp/bmhJinYLkUV/tb9ZHd91Wo5DJ8DB4Bkc9v39O7qzbt
	rfT/Dm27N84DrXaJ9DU9Iag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gcOevKCVUuYtdC4l6JJHGnazjN87te0ZmgUD0wZhnp9Owl
	FSx/JLaGEChQ622I1pz+fuH3rCQrZSpWWqecNTlxB158wr0Mykgv/LlATFgDNt0M
	sfFDFAHes8UHxamXFapUc5oQP6sHYSOkGVdW4rVBvjMScqxXHLmOd9ZMsxiVE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16B7F5784;
	Fri, 20 May 2011 18:05:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2DEEC5782; Fri, 20 May 2011
 18:05:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40810984-832D-11E0-BF8F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174081>

Jeff King <peff@peff.net> writes:

> ... I also had a feeling we
> could use a faster commit_list in other places, since get_revision is
> all based around the same pop-and-push-the-parents workflow. But after
> spending a few hours on it, it seems that _lots_ of places in the code
> work on the assumption of a linked list (or at least doing very simple
> in-order traversal), and the changes got very ugly very quickly.

I recall looking at the same codepaths a few years ago for different
reasons. get_revision() callchain does a _lot_ of alloc/free, so I
naturally wanted to catch all the allocations and frees to replace them
with a custom allocator that slices from a larger slab. It involved too
many places so I decided it wasn't really worth doing only that change
without other benefit (e.g. lifting the "listness" assumption), and
stopped.

If somebody is interested to tackle it, we would probably need a two step
conversion process. First introduce an abstracted interface that passes
around the "list-as-a-whole" object with a few selected methods (e.g. drop
an element into it at the sorted location and get a "cursor" that points
at it, given a "cursor", grab an element from the list, increment the
"cursor" to point at the next object, etc.), choosing a set just
sufficient to express the patterns of accesses the current codebase makes,
and implement the API over the existing linked-list implementation to
convert all the callers. After making sure this works, update the API
implementation with the queue in this patch.

Or something like that.

> ... And
> performance-wise, it doesn't seem to be a huge problem, mainly because:
>
>   1. We don't tend to put more items in a commit_list than the width of
>      the history graph. So our "n" tends to be in the dozens at most.

I was worried that you may end up with many concurrent traversal going in
a very bushy history (think: traversing from the tip of "next"), but I
agree that it would be in the order of dozens, not thousands.
