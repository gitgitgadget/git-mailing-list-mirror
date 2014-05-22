From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 14:34:54 -0700
Message-ID: <xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
References: <1400775763.1933.5.camel@stross>
	<CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	<1400782642.18134.8.camel@stross>
	<20140522183930.GB1167@sigill.intra.peff.net>
	<1400785669.18134.21.camel@stross>
	<20140522190959.GA18785@sigill.intra.peff.net>
	<20140522193030.GA22383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 23:35:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnado-0003Em-4d
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 23:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbaEVVfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 17:35:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63714 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbaEVVfA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 17:35:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE8A51AD87;
	Thu, 22 May 2014 17:34:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YtZicx+T+4ZubPzWoykUlgIQbDw=; b=iJaybp
	hBLSe4vdedy8NNl1H8qJxuBMStByff7BcjfbkN3Lg2W8BrdmS0GkpZ/s279JkNUe
	VFMHM5rhN0fyHqJ7FzoII9cV4qymjjjt+wpPO57+h0DYjmJ6bG0fuV+WA6NsCNU/
	xJdfWX9/KkfkmgpajsrAIgyllF9MrFnHolZI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UIKQ4m5ENnKaVzlRVGmKAHoM38vMJuIw
	1H/YTkQG9xL7ygPGuQnja83VNjx5B9oKikodkpb4O7iYIYn99Y8RzqOFcQoTliau
	Y4DuCQc1mZ588uxTgm3R7pbUiFJQYLrJXRUNihqzaCNMN0xsDX/7ujKlkp96yWKZ
	k01BugI9b/0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E24841AD85;
	Thu, 22 May 2014 17:34:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 048AC1AD7F;
	Thu, 22 May 2014 17:34:55 -0400 (EDT)
In-Reply-To: <20140522193030.GA22383@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 May 2014 15:30:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EAE5A934-E1F8-11E3-AEEB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249946>

Jeff King <peff@peff.net> writes:

> [+cc Junio for cache-tree expertise]
> ...
> We never call reset_index now, because we handle it via diff.  We could
> call prime_cache_tree in this case, but I'm not sure if that is a good
> idea, because it primes it from scratch (and so it opens up all those
> trees that we are trying to avoid touching). I'm not sure if there's an
> easy way to update it incrementally; I don't know the cache-tree code
> very well.

The cache-tree is designed to start in a well-populated state,
allowing you to efficiently smudge the part you touched by
invalidating while keeping the parts you haven't touched intact.

What is missing in its API is a more fine-grained support to let us
say "it has degraded too much and we need to bring it into a
well-populated state again for it to be truly useful as an
optimization."  There are only two modes of support to revive a
degraded cache-tree, one being write_cache_as_tree(), in which case
we have to compute necessary tree object names anyway (so there is
no point discarding the result of the computation), and the other
being calls to prime-cache-tree, in which we happen to know that the
whole index contents must match the whole tree structure represented
by one tree object.

Both aim to restore the cache-tree into a fully-populated state, and
there is no support to populate it "well enough" by doing anything
incremental.  You can call write-tree side incremental, because it
does reuse what is still valid without recomputing tree objects for
them---but the result is a fully-populated state.

Adding a more fine-grain support is not against the overall design,
but it was unclear what such additional API functions should look
like, and where we can call them safely, at least back when we were
actively improving it.  Two that comes to my mind are:

 - We know that the subtrees down in this directory are degraded too
   much; write-tree only the subtrees that correspond to this
   directory without restoring other parts of the tree.

 - We just populated the index with the subtrees in this directory
   and know that they should match the tree hierarchy exactly.
   prime-cache-tree only the parts without affecting other parts of
   the tree.

As with calls to existing (whole-tree) prime-cache-tree, the latter
is an error-prone optimization---I think we had cases where we said
"after this operation, we know that the index must exactly match the
tree we used to muck with the index" and added a call, and later
discovered that "must exactly match" was not true.

The former forces recomputation, so there is much less safety
concern.
