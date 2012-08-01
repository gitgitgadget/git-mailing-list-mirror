From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 20:42:38 -0400
Message-ID: <20120801004238.GA15428@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 02:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwN1V-0000zu-3H
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 02:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab2HAAmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 20:42:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43927 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab2HAAmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 20:42:42 -0400
Received: (qmail 1429 invoked by uid 107); 1 Aug 2012 00:42:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jul 2012 20:42:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2012 20:42:38 -0400
Content-Disposition: inline
In-Reply-To: <7vfw87isx1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202698>

On Tue, Jul 31, 2012 at 01:20:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > A much better hint is to annotate pairs of sha1s, to say "do not bother
> > doing inexact rename correlation on this pair; I promise that they have
> > value N".
> 
> Surely.  And I suspect that the patch to the current codebase to do
> so would be much less impact if you go that way.

Yes. You may remember I wrote a generic caching subsystem last summer
when we were talking about caching commit generations. Plugging in a new
map type to map sha1 pairs to 32-bit integers was pretty simple, and
that gives the basis for a rename cache.

It's fairly unimpressive on git.git. My best-of-five for "git log
--format=%H --raw -M" went from 5.83s to 5.74s, which is pretty much
within the run-to-run noise. The resulting cache was 155K.

However, it's easy to come up with much more pathological cases. I have
a really ugly rename-and-tweak-tags commit on my photo repository, and
those blobs are relatively big. My timings for "git show" on that were:

  before: 49.724s
  after, run 1: 54.904s
  after, run 2:  0.117s

Which is pretty darn nice. The resulting cache is 5.3M (the repository
itself is in the gigabytes, but that's not really relevant; the cache
will obviously scale with the number of paths, not with the size of the
blobs).

It would also work for copies, too, of course. Here are the results of
"git log --format=%H --raw -M -C -C" on git.git:

  before: 1m35s
  after, run 1: 39.7s
  after, run 2: 39.5s

So it does make much more of a difference for copies, which is obvious;
git is doing a lot more work for us to cache. At the same time, our
cache is much bigger: 32M. Yikes.

My cache is fairly naive, in that it literally stores 44 bytes of
<src_sha1, dst_sha1, score> for each entry. At the cost of more
complexity, you could store each src_sha1 once, followed by a set of
<dst_sha1, score> pairs. I also didn't take any special care to avoid
duplicates of <X, Y> and <Y, X> (since presumably these renames would be
commutative). I'm not sure it is necessary, though; I think the copy
machinery already suppresses this when entries are in both source and
destination lists.

So I don't know. It can definitely speed up some operations, but at the
cost of a non-trivial cache on disk. I'll spare you all of the generic
caching infrastructure, but the actual patch to rename looks like this
(just to give a sense of where the hooks go):

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 216a7a4..db70878 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -6,6 +6,7 @@
 #include "diffcore.h"
 #include "hash.h"
 #include "progress.h"
+#include "metadata-cache.h"
 
 /* Table of rename/copy destinations */
 
@@ -137,7 +138,8 @@ static int estimate_similarity(struct diff_filespec *src,
 	 */
 	unsigned long max_size, delta_size, base_size, src_copied, literal_added;
 	unsigned long delta_limit;
-	int score;
+	uint32_t score;
+	struct sha1pair pair;
 
 	/* We deal only with regular files.  Symlink renames are handled
 	 * only when they are exact matches --- in other words, no edits
@@ -175,6 +177,11 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
+	hashcpy(pair.one, src->sha1);
+	hashcpy(pair.two, dst->sha1);
+	if (rename_cache_get(&pair, &score))
+		return score;
+
 	if (!src->cnt_data && diff_populate_filespec(src, 0))
 		return 0;
 	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
@@ -195,6 +202,7 @@ static int estimate_similarity(struct diff_filespec *src,
 		score = 0; /* should not happen */
 	else
 		score = (int)(src_copied * MAX_SCORE / max_size);
+	rename_cache_set(&pair, &score);
 	return score;
 }
 
-Peff
