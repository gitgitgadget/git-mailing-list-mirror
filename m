From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] diffcore-break: save cnt_data for other phases
Date: Thu, 19 Nov 2009 10:22:34 -0500
Message-ID: <20091119152234.GA6877@coredump.intra.peff.net>
References: <20091116155331.GA30719@coredump.intra.peff.net>
 <20091116160202.GB30777@coredump.intra.peff.net>
 <7vvdhanp4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 16:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB8qR-0006fp-Vo
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 16:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbZKSPWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 10:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756651AbZKSPWd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 10:22:33 -0500
Received: from peff.net ([208.65.91.99]:33218 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613AbZKSPWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 10:22:31 -0500
Received: (qmail 19249 invoked by uid 107); 19 Nov 2009 15:26:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Nov 2009 10:26:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2009 10:22:34 -0500
Content-Disposition: inline
In-Reply-To: <7vvdhanp4v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133233>

On Mon, Nov 16, 2009 at 01:20:00PM -0800, Junio C Hamano wrote:

> The change looks correct, but I initially got worried about your change
> interacts badly with this part in estimate_similarity() around line 176:
> 
> 	if (!src->cnt_data && diff_populate_filespec(src, 0))
> 		return 0;
> 	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
> 		return 0;
> 
> I think the reason why it (not your patch but the original code) felt a
> bit brittle is because the above if() statements know too much about the
> internal of d-c-c (namely, it never looks at src->data when src->cnt_data
> is already available, so it is safe to leave src->data NULL).

No, I am counting on those lines to actually optimize out the count
later on. But I agree it is a bit brittle. Probably a better design
would have been for diffcore_count_changes to simply call a new
"diff_filespec_hash", which would assign to the cnt_data member and
perform any optimizations, just as we do already with
diff_populate_filespec and the actual blob contents.

I don't know if it is worth refactoring though. This is a pretty static
part of the code these days, and what is there now is working.

> The same logic suggests that the loop to build the matrix in
> diffcore_rename() could free two->data at the end of the innermost loop.
> 
> We currently loop this way (around ll. 505-530):
> 
> 	for each two (i.e. rename destination candidate):
>         	for each one (i.e. rename source candidate):
>                 	compute and record how similar one and two are
> 			free one->data
> 		free two->data
> 
> After computing how similar "one" and something else is only once, we have
> one->cnt_data so we won't need one->data (the same fact is exploited by
> your patch for optimization), and that is why freeing one->data in the
> innermost loop does not result in constant re-reading of the same blob
> data when we iterate more than one rename destination.  But the same logic
> applies to "two" and we should be able to free the blob data early to
> reduce the memory pressure.
> 
> I dunno if it would give us measurable performance benefit, though.
> 
> Here is the idea on top of your patch, but I think it can be applied
> independently.

With your patch, I shaved 0.2 seconds off of a 46-second rename
detection (one of my pathological "rename and tweak the tags on a bunch
of photos" commits). To be fair, though, that commit is now quite old,
so some of that CPU time was spent assembling delta chains.

It should also relieve memory pressure for large repositories, though
that is not nearly as big an issue for renames as for breaks, as we tend
to have many fewer candidates.

I think it is worth applying.  Though perhaps the free-ing should simply
happen in estimate_similarity, which is the function that actually
populates the filespec.

Also, I don't see where we ever actually free the cnt_data. After we run
the whole O(n^2) loop, we should be able to drop cnt_data entirely. I
think in practice it doesn't matter all that much, since it isn't that
big, and afterwards we just generate the patch and exit (unless we are
doing diffcore-break, too, which will actually free all of the data).

-Peff
