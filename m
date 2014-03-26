From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Wed, 26 Mar 2014 15:31:41 -0700
Message-ID: <xmqqvbv0h9rm.fsf@gitster.dls.corp.google.com>
References: <20140326072215.GA31739@sigill.intra.peff.net>
	<xmqq7g7gkgp6.fsf@gitster.dls.corp.google.com>
	<20140326181300.GA7087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:31:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwMR-0001be-7K
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157AbaCZWbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:31:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074AbaCZWbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:31:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4316078E4E;
	Wed, 26 Mar 2014 18:31:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6GXPgLFTqWEl/jHQ0pdniTyyqGM=; b=vTk6UL
	Eh0tRZKAH9T5y6m5mXChF1JI+rX5ietpShCGYRKn+3Zs2/5kGpxf9MeL1OEhoRRQ
	nhS2bsfvMqYdr5xEE64tJa0pTvol0Q9LErEO06eQHzJkX2wGZTMSGMyNqsp+tmma
	iF/4TdDcjwgeJ99GJ7O71HB3e62D4dmUoom5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+Dnq7ULvt3Mcp5M+hpkk0O+3ePI4yIq
	mJz91OBhSujspMhph1EYUTkfZHFSEHH1P/2Dnphfxz4XRLEIlUm6BsnMwroasayL
	ZvOTM813b1Iue+qQWaJT+rUEPPeqof8TRPgFJmddbXPTapchvtXceD/AJUi+2JGq
	tiWnv96iw0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 268F878E4D;
	Wed, 26 Mar 2014 18:31:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4953678E45;
	Wed, 26 Mar 2014 18:31:44 -0400 (EDT)
In-Reply-To: <20140326181300.GA7087@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Mar 2014 14:13:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68D83680-B536-11E3-AFFC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245248>

Jeff King <peff@peff.net> writes:

> Just looking at the 128-day case again, using bitmaps increased our
> server CPU time _and_ made a much bigger pack. This series not only
> fixes the CPU time regression, but it also drops the server CPU time to
> almost nothing. That's a nice improvement, and it makes perfect sense:
> we are reusing on-disk deltas instead of on-the-fly computing deltas
> against the preferred bases.

True.

> I think we could still add the objects from the tip of the client's HAVE
> list.

That should make the result at least per to the non-bitmap case,
right?

> This patch would still be a CPU win on top of that, because it
> would reduce the number of objects which need a delta search in the
> first place.

Yes.

> So I think the next steps are probably:
>
>   1. Measure the "all objects are preferred bases" approach and confirm
>      that it is bad.

;-)

>   2. Measure the "reused deltas become preferred bases" approach. I
>      expect the resulting size to be slightly better than what I have
>      now, but not as good as v1.9.0's size (but taking less CPU time).

Do you mean "the bases for reused deltas become preferred bases, so
that we can deltify more objects off of them"?

>   3. Measure the "figure out boundaries and add them as preferred bases,
>      like we do without bitmaps" approach. I expect this to behave
>      similarly to v1.9.0.

Yes.

>   4. Combine (2) and (3) and measure them. I'm _hoping_ this will give
>      us the best of both worlds, but I still want to do the individual
>      measurements so we can see where any improvement is coming from.

Sensible.  Thanks.
