From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff-highlight: match up lines before highlighting
Date: Tue, 3 Nov 2015 16:44:16 -0500
Message-ID: <20151103214416.GC22484@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-4-git-send-email-jonathan.lebon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:44:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtjNP-000773-VL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbbKCVoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:44:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:52314 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932366AbbKCVoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:44:19 -0500
Received: (qmail 2496 invoked by uid 102); 3 Nov 2015 21:44:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 15:44:19 -0600
Received: (qmail 28986 invoked by uid 107); 3 Nov 2015 21:44:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 16:44:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Nov 2015 16:44:16 -0500
Content-Disposition: inline
In-Reply-To: <1446516334-27652-4-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280822>

On Mon, Nov 02, 2015 at 09:05:33PM -0500, Jonathan Lebon wrote:

> As mentioned in the README, one of the current limitations of
> diff-highlight is that it only calculates highlights when the hunk
> contains the same number of removed lines as added lines.
> 
> A further limitation upon this is that diff-highlight assumes that the
> first line removed matches the first line added, similarly with the
> second, the third, etc... As was demonstrated in the "Bugs" section of
> the README, this poses limitations since that assumption does not always
> give the best result.
> 
> With this patch, we eliminate those limitations by trying to match up
> the removed and added lines before highlighting them. This is done using
> a recursive algorithm.

Hmm. So this seems like a reasonable incremental feature. I do think it
is a hack (piled on the hack that is the existing script :) ), and the
right solution is to actually do an LCS diff for each hunk that crosses
line boundaries.

I made some headway on that this summer as part of this discussion:

  http://thread.gmane.org/gmane.comp.version-control.git/271692

It's long, but there's some good stuff in there.  But I think I came to
the conclusion that this really needs to go inside of diff.c itself
(which will also require some heavy refactoring of the whitespace code;
see the referenced thread for details).

But I'm not opposed to an incremental feature like this in the meantime.
The real test for me is: how does it look in practice? These are all
heuristics, so I don't think we have anything better than eyeballing the
output.

Have you looked at a diff of the old/new output on something like
git.git?

> Note that I did not bother with some common optimizations such as
> memoization since the usual number of removed/added lines in a single
> hunk are small. In practice, I have not felt any lag at all during
> paging.

I'd worry less about normal use, and more about hitting some extreme
corner case. Your algorithm looks roughly quadratic in the size of the
hunk. I guess that is canceled out by the max-hunk-size option in the
next patch, though.

I don't think it's easy to make your algorithm non-quadratic, either, as
it inherently relies on pairwise comparisons (and not, say, generating a
fingerprint of each line and sorting them or something like that).

It might be worth memo-izing find_common_* calls, though, as that is
just repeated work (quadratic or not). It should be easy to time.

> +	# prime the loop
> +	my ($besti, $bestj) = ($a_first, $b_first);
> +	my $bestn = calculate_match($a->[$a_first], $b->[$b_first]) + 1;
> +
> +	for (my $i = $a_first; $i < $a_last; $i++) {
> +		for (my $j = $b_first; $j < $b_last; $j++) {
> +			my $n = calculate_match($a->[$i], $b->[$j]);
> +			if ($n < $bestn) {
> +				($besti, $bestj, $bestn) = ($i, $j, $n);
> +			}
> +		}
> +	}
> +
> +	# find the best matches in the lower pairs
> +	match_and_highlight_pairs($a, $a_first, $besti, $b, $b_first, $bestj, $queue);

Hmm, is this actually O(n^3)? We have a quadratic loop, and then we
recurse for the remainder.

If we have two candidates for which calculate_match returns the same
value, how do we break the tie? It looks like we'll just pick the
lowest-numbered match. I'd think we would want to prefer the one with
the closest line number.  But not having thought too hard about it, I
wonder:

  1. Does it actually make a difference which line we pick? The
     interesting bit is how much we highlight, so in that sense do we
     care only about the prefix and suffix sizes?

  2. Do you end up picking the closest line with your algorithm anyway,
     as will tend to match as we go, skipping over only lines that will
     likely have no match?

-Peff
