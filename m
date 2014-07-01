From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] commit: provide a fast multi-tip contains function
Date: Tue, 01 Jul 2014 11:16:29 -0700
Message-ID: <xmqqwqbxvtaa.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234730.GF23146@sigill.intra.peff.net>
	<xmqqtx774i1r.fsf@gitster.dls.corp.google.com>
	<xmqqha374gx3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 20:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X22bi-00040k-4d
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 20:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495AbaGASQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 14:16:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57114 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758467AbaGASQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 14:16:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89D392482D;
	Tue,  1 Jul 2014 14:16:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDBXhDZauNmFpJuhDloelEBQ7cA=; b=GHoP2F
	PYQmg37YzF2YJgRQi+hjiVT2lnWpwHlBVBMznzhVnzrQsTmIYkB3DRamkkYiZw62
	BEsGDoe3Qg7Sp+SkcO4wlh8EIvp7Esuf/6s2Pn5lfh7o5e/fjP1iQlHXY+sKNh0T
	/eRGVJS2zCjm3Ryda3a638KKao+n0E+bjzGz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xxJny0TvEFQn4YuMQF3dDSliZI+ZUxkq
	5IhAeZT8R+Jg9kf6SrsXjNn3gQlHgpe3FdcIjD7hvFtd35g8Wk+tE/t9t/UGnHJc
	Tf+nXWncxFrbsGnGjI0Tcv+H+D+DOf++l0GukFC3oNWN2dtZJk0SmbNc6eIqCRpx
	ymJ96cUIN0M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EFDD2482C;
	Tue,  1 Jul 2014 14:16:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 89DA724825;
	Tue,  1 Jul 2014 14:16:20 -0400 (EDT)
In-Reply-To: <xmqqha374gx3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Jun 2014 12:19:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CD41B7D4-014B-11E4-A13C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252733>

Junio C Hamano <gitster@pobox.com> writes:

> If you are trying to do "branch --with $commit", what you would want
> is not exactly "paint-down-to-common(all branches, $commit)", but
> something that paints down to $commit from all branches, with an
> optimization that cuts off the traversal at a commit that is
> reachable from $commit.  If a traversal from branch B reached such a
> commit that is reachable from $commit, you can stop the traversal
> because propagating the bit for B further down to its parents will
> not reach the $commit you are interested in.

I forgot about the other direction, i.e. "branch --merged $commit".
Since I do "git branch --no-merged pu" fairly often, I care about
its performance ;-)

We paint $commit as Left, and tips of all the branches as Right.  We
try to paint down from $commit but the traversal cannot terminate if
it reaches a commit that is reachable from one Right ref---we may
find that we can reach more Right refs by following its ancestor.
We can stop when we paint Right bits fully, of course, but I wonder
if we can do better than that.

Suppose we just painted a commit with L and Rn bit (i.e. the commit
is a common ancestor of the $commit and one branch).  We know that
traversing down from there will never reach the tip of the branch
whose color is Rn (otherwise we will have a cycle from that commit
back to the tip of the branch), so if the reason we are continuing
the traversal is to prove that the tip of the branch Rn is reachable
(or unreachable) from $commit, there is no reason to continue
digging from there.  Can we exploit that to terminate the traversal
earlier?

When we encounter a new commit that is painted with L bit and some
but not necessarily all R bits, we propagate the bits and check the
R bits.  Some of the commits in Right set that correspond to R bits
may have been painted in L (i.e. we found branches that are merged
to $commit), and digging further from this commit will not give us
any new information.  Other commits are not painted in L (i.e. we do
not yet know if $commit merges these branches), so we may need to
keep digging.  So perhaps we can stop if a commit is painted in L
and also has all the R bits that correspond to Right commits that
are not yet proven reachable from $commit (i.e. not painted in L)?
