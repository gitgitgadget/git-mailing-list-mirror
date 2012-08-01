From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 23:01:27 -0700
Message-ID: <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
 <20120801004238.GA15428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 01 08:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwS00-0002qT-5o
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 08:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab2HAGBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 02:01:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab2HAGBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 02:01:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E3AB99CA;
	Wed,  1 Aug 2012 02:01:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z0tiKpPyAL6YikazYfK9cYksvxQ=; b=ZUoXyI
	Yr9FMDbxAaAtdI8WZsqdHwGdZx7ZjF17wR5ts3V/7SZeXB2IIU6BNFV9zy2kT9Pt
	4L0kS4OxZ8FAcbbIfN6cwx0bRubOp4yI6rwx551374K1dygsHx+01NDaM4+jrGkv
	DF5vGlHhvITD51WZDUhUdwzECCldGhFIsyPGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DO7o+xAzYmoXItuiNfsK5IuTsmwX9L5h
	dog49H6dk5zWnPNtqaEI+POhSlnyd1CQ5GbDrorAEUl2aJYoWba3pwlryUU1n6zE
	s9q9u1gz9YSOjWX6Wdh0jn+uqE8EGzq9bYRiaAiQi6HKd/ytzhXfSgTwaKNn/StB
	4zrlf4pECPA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A31A99C9;
	Wed,  1 Aug 2012 02:01:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8607199C7; Wed,  1 Aug 2012
 02:01:28 -0400 (EDT)
In-Reply-To: <20120801004238.GA15428@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 Jul 2012 20:42:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 559E20A2-DB9E-11E1-86B2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202703>

Jeff King <peff@peff.net> writes:

> @@ -175,6 +177,11 @@ static int estimate_similarity(struct diff_filespec *src,
>  	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
>  		return 0;
>  
> +	hashcpy(pair.one, src->sha1);
> +	hashcpy(pair.two, dst->sha1);
> +	if (rename_cache_get(&pair, &score))
> +		return score;
> +

Random thoughts.

Even though your "rename cache" could be used to reject pairing that
the similarity estimator would otherwise give high score, I would
imagine that in practice, people would always use the mechanism to
boost the similarity score of desired pairing.  This conjecture has
a few interesting implications.

 - As we track of only the top NUM_CANDIDATE_PER_DST rename src for
   each dst (see record_if_better()), you should be able to first
   see if pairs that have dst exist in your rename cache, and
   iterate over the <src,dst> pairs, filling m[] with srcs that
   appear in this particular invocation of diff.

 - If you find NUM_CANDIDATE_PER_DST srcs from your rename cache,
   you wouldn't have to run estimate_similarity() at all, but that
   is very unlikely.  We could however declare that user configured
   similarity boost always wins computed ones, and skip estimation
   for a dst for which you find an entry in the rename cache.

 - As entries in rename cache that record high scores have names of
   "similar" blobs, pack-objects may be able to take advantage of
   this information.

 - If you declare blobs A and B are similar, it is likely that blobs
   C, D, E, ... that are created by making a series of small tweaks
   to B are also similar.  Would it make more sense to introduce a
   concept of "set of similar blobs" instead of recording pairwise
   scores for (A,B), (A,C), (A,D), ... (B,C), (B,D), ...?  If so,
   the body of per-dst loop in diffcore_rename() may become:

	if (we know where dst came from)
		continue;
	if (dst belongs to a known blob family) {
		for (each src in rename_src[]) {
			if (src belongs to the same blob family as dst)
				record it in m[];
                }
	}
	if (the above didn't record anything in m[]) {
        	... existing estimate_similarity() code ...
	}

Regarding your rename-and-tweak-exif photo sets, is the issue that
there are too many rename src/dst candidates and filling a large
matrix takes a lot of time, or tweaking exif makes the contents
unnecessarily dissimilar and causes the similarity detection to
fail?  As we still have the pathname in this codepath, I am
wondering if we would benefit from custom "content hash" that knows
the nature of payload than the built-in similarity estimator, driven
by the attribute mechanism (if the latter is the case, that is).
