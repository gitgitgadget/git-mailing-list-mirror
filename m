From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-rename: cache file deltas
Date: Tue, 25 Sep 2007 14:29:07 -0700
Message-ID: <7vy7eu4eos.fsf@gitster.siamese.dyndns.org>
References: <20070925192941.GA8564@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 23:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaHy4-0001jK-Id
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 23:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbXIYV3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbXIYV3L
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 17:29:11 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62067 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbXIYV3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 17:29:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070925212909.WPPQ27287.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 25 Sep 2007 17:29:09 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id slV71X00X1gtr5g0000000; Tue, 25 Sep 2007 17:29:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59175>

Jeff King <peff@peff.net> writes:

> We find rename candidates by computing a fingerprint hash of
> each file, and then comparing those fingerprints. There are
> inherently O(n^2) comparisons, so it pays in CPU time to
> hoist the (rather expensive) computation of the fingerprint
> out of that loop (or to cache it once we have computed it once).
>
> Previously, we didn't keep the filespec information around
> because then we had the potential to consume a great deal of
> memory. However, instead of keeping all of the filespec
> data, we can instead just keep the fingerprint.
>
> This patch implements and uses diff_free_filespec_data_large
> to accomplish that goal. We also have to change
> estimate_similarity not to needlessly repopulate the
> filespec data when we already have the hash.
>
> Practical tests showed 4.5x speedup for a 10% memory usage
> increase.
>
> Signed-off-by: Jeff King <peff@peff.net>

Very nice.

> The implementation is a little less nice than I would like, but I was
> trying to be non-invasive. Specifically:
>
>  - the name diff_free_filespec_data_large is horrible, but this is based
>    on the fact that diff_free_filespec_data actually does too much (it
>    frees the data _and_ some other auxiliary data). And renaming that
>    would entail changing many callsites.

True.  But we can rename it to diff_file_filespec_blob() and
that would perfectly well describe what it does.  Will do so
when applying if it is Ok to you.

>  - It seems that a better place to call diffcore_populate_filespec
>    (rather than in estimate_similarity) would actually be in
>    diffcore_count_changes (when we _know_ that we need to populate the
>    contents data).
>
>  - The hash_chars() should arguably be tied into
>    diffcore_populate_filespec, which should have more of a "what
>    information do you want" interface. I.e., the "size_only" parameter
>    could be extended to a bitfield to say "populate this, and I need the
>    delta fingerprint, size, actual contents, etc". Then callers could
>    just use "populate" before looking at the filespec and it would
>    lazily load whatever they needed.

Both good points, but I agree with you that it is wise to do
that with a follow-up patch.
