From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] commit: provide a fast multi-tip contains function
Date: Tue, 01 Jul 2014 12:14:08 -0700
Message-ID: <xmqqoax8x56n.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234730.GF23146@sigill.intra.peff.net>
	<xmqqtx774i1r.fsf@gitster.dls.corp.google.com>
	<xmqqha374gx3.fsf@gitster.dls.corp.google.com>
	<xmqqwqbxvtaa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 21:14:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X23VU-0006pJ-M4
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 21:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbaGATOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 15:14:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62843 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932353AbaGATOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 15:14:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5932E25ACA;
	Tue,  1 Jul 2014 15:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HCiahCzIY19jY3nI2EbbixPcVFw=; b=pS1DO6
	vfTzyuk4MiY9mCuYau97IAehaI7/5jNEOidA4iud62cVRl3ifr0/mwqQNmtRyNX1
	1KZcH/h+p0zESDoFUshyuCk/TVSnLoQjVPVYqhI+A4pSE7dZAGphf1wMLoAVX70B
	XyOUwgw2HU808OEcIvkxm79Tg0jeAHU1Dfi48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t5EzAVtt+/OHofE2AJzu8v12d7FSpKuB
	Wga0Zm9uVc8sIEawwnvUQqSMunlP/e3nWttDsMvS2oQv7n6phJxFvzmG2jmFvt8Z
	dA+MvOxxyJVPZEfRKDCpkAjDXoIB7tZ6lSKRxrExx09+Gqy+DOrVkow/LyY7CLlR
	Iveqz0CuIMM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D98D25AC9;
	Tue,  1 Jul 2014 15:14:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 671DD25AC1;
	Tue,  1 Jul 2014 15:13:59 -0400 (EDT)
In-Reply-To: <xmqqwqbxvtaa.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 01 Jul 2014 11:16:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAE590C4-0153-11E4-8D06-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252735>

Junio C Hamano <gitster@pobox.com> writes:

> I forgot about the other direction, i.e. "branch --merged $commit".
> Since I do "git branch --no-merged pu" fairly often, I care about
> its performance ;-)
>
> We paint $commit as Left, and tips of all the branches as Right.  We
> try to paint down from $commit but the traversal cannot terminate if
> it reaches a commit that is reachable from one Right ref---we may
> find that we can reach more Right refs by following its ancestor.
> We can stop when we paint Right bits fully, of course, but I wonder
> if we can do better than that.
>
> Suppose we just painted a commit with L and Rn bit (i.e. the commit
> is a common ancestor of the $commit and one branch).  We know that
> traversing down from there will never reach the tip of the branch
> whose color is Rn (otherwise we will have a cycle from that commit
> back to the tip of the branch), so if the reason we are continuing
> the traversal is to prove that the tip of the branch Rn is reachable
> (or unreachable) from $commit, there is no reason to continue
> digging from there.  Can we exploit that to terminate the traversal
> earlier?

I forgot to mention this case because with "branch --no-merged pu"
it never happens, but another clue we can terminate traversal earier
with is when $commit is found to be an ancestor of some Right
commits.  Then we can start ignoring Rn bits for these Right commits
that can reach the Left one, as we know they can never be reached
from the Left.  That is, the last sentence in the paragraph ...

> When we encounter a new commit that is painted with L bit and some
> but not necessarily all R bits, we propagate the bits and check the
> R bits.  Some of the commits in Right set that correspond to R bits
> may have been painted in L (i.e. we found branches that are merged
> to $commit), and digging further from this commit will not give us
> any new information.  Other commits are not painted in L (i.e. we do
> not yet know if $commit merges these branches), so we may need to
> keep digging.  So perhaps we can stop if a commit is painted in L
> and also has all the R bits that correspond to Right commits that
> are not yet proven reachable from $commit (i.e. not painted in L)?

... will be more like "ignore Rn bits for Right commits that are
painted in L (i.e. they are reachable from L) or the Left commit is
painted with (i.e. they reach L)".
