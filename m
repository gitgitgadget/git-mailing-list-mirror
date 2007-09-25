From: Jeff King <peff@peff.net>
Subject: [PATCH] diffcore-rename: cache file deltas
Date: Tue, 25 Sep 2007 15:29:42 -0400
Message-ID: <20070925192941.GA8564@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 21:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaG6r-0004Cm-5s
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbXIYT3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbXIYT3q
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:29:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1675 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbXIYT3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:29:45 -0400
Received: (qmail 19320 invoked by uid 111); 25 Sep 2007 19:29:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Sep 2007 15:29:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2007 15:29:42 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59157>

We find rename candidates by computing a fingerprint hash of
each file, and then comparing those fingerprints. There are
inherently O(n^2) comparisons, so it pays in CPU time to
hoist the (rather expensive) computation of the fingerprint
out of that loop (or to cache it once we have computed it once).

Previously, we didn't keep the filespec information around
because then we had the potential to consume a great deal of
memory. However, instead of keeping all of the filespec
data, we can instead just keep the fingerprint.

This patch implements and uses diff_free_filespec_data_large
to accomplish that goal. We also have to change
estimate_similarity not to needlessly repopulate the
filespec data when we already have the hash.

Practical tests showed 4.5x speedup for a 10% memory usage
increase.

Signed-off-by: Jeff King <peff@peff.net>
---
The implementation is a little less nice than I would like, but I was
trying to be non-invasive. Specifically:

 - the name diff_free_filespec_data_large is horrible, but this is based
   on the fact that diff_free_filespec_data actually does too much (it
   frees the data _and_ some other auxiliary data). And renaming that
   would entail changing many callsites.

 - It seems that a better place to call diffcore_populate_filespec
   (rather than in estimate_similarity) would actually be in
   diffcore_count_changes (when we _know_ that we need to populate the
   contents data).

 - The hash_chars() should arguably be tied into
   diffcore_populate_filespec, which should have more of a "what
   information do you want" interface. I.e., the "size_only" parameter
   could be extended to a bitfield to say "populate this, and I need the
   delta fingerprint, size, actual contents, etc". Then callers could
   just use "populate" before looking at the filespec and it would
   lazily load whatever they needed.

This patch cuts my pathological case from 20 minutes to 2 minutes, which
is a great improvement, but still unusable. However, now I should be
able to get more useful numbers on what else can be sped up.

 diff.c            |    7 ++++++-
 diffcore-rename.c |    7 ++++---
 diffcore.h        |    1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 2216d75..647bcf0 100644
--- a/diff.c
+++ b/diff.c
@@ -1654,7 +1654,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	return 0;
 }
 
-void diff_free_filespec_data(struct diff_filespec *s)
+void diff_free_filespec_data_large(struct diff_filespec *s)
 {
 	if (s->should_free)
 		free(s->data);
@@ -1665,6 +1665,11 @@ void diff_free_filespec_data(struct diff_filespec *s)
 		s->should_free = s->should_munmap = 0;
 		s->data = NULL;
 	}
+}
+
+void diff_free_filespec_data(struct diff_filespec *s)
+{
+	diff_free_filespec_data_large(s);
 	free(s->cnt_data);
 	s->cnt_data = NULL;
 }
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 41b35c3..4fc2000 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -184,7 +184,8 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
-	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
+	if ((!src->cnt_data && diff_populate_filespec(src, 0))
+		|| (!dst->cnt_data && diff_populate_filespec(dst, 0)))
 		return 0; /* error but caught downstream */
 
 
@@ -377,10 +378,10 @@ void diffcore_rename(struct diff_options *options)
 			m->score = estimate_similarity(one, two,
 						       minimum_score);
 			m->name_score = basename_same(one, two);
-			diff_free_filespec_data(one);
+			diff_free_filespec_data_large(one);
 		}
 		/* We do not need the text anymore */
-		diff_free_filespec_data(two);
+		diff_free_filespec_data_large(two);
 		dst_cnt++;
 	}
 	/* cost matrix sorted by most to least similar pair */
diff --git a/diffcore.h b/diffcore.h
index eef17c4..4bf175b 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -48,6 +48,7 @@ extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 
 extern int diff_populate_filespec(struct diff_filespec *, int);
 extern void diff_free_filespec_data(struct diff_filespec *);
+extern void diff_free_filespec_data_large(struct diff_filespec *);
 extern int diff_filespec_is_binary(struct diff_filespec *);
 
 struct diff_filepair {
-- 
1.5.3.2.1061.gc056e-dirty
