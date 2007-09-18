From: Jeff King <peff@peff.net>
Subject: diffcore-rename performance mode
Date: Tue, 18 Sep 2007 04:23:22 -0400
Message-ID: <20070918082321.GA9883@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:24:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYNF-0000O4-98
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbXIRIX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbXIRIX3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:23:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3929 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbXIRIX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:23:27 -0400
Received: (qmail 25844 invoked by uid 111); 18 Sep 2007 08:23:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Sep 2007 04:23:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2007 04:23:22 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58544>

[this is a resend of some comments I made deep in another thread on
rename limiting; I wanted to get your comments, Junio, but I was afraid
you didn't see it buried in the mess. If you have already read it and
have nothing to say, just tell me to shut up.

I was able to get 1000% speedup on a (perhaps pathological) diff, and I
suspect there may be more speedups possible in the spanhash lookups. So
I think it's worth pursuing.]


Hmm. Actually, doing some profiling, it looks like about 75% of the time
is spent not in the O(n^2) comparison, but in generating the hash
fingerprints of each file.

There seems to be a serious performance problem in diffcore-rename.
There is infrastructure to cache the "cnt_data" member of each filespec,
but it never gets used because we immediately free the filespec data
after use. Oops.

With this patch:

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6bde439..531a844 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -362,10 +362,7 @@ void diffcore_rename(struct diff_options *options)
 			m->score = estimate_similarity(one, two,
 						       minimum_score);
 			m->name_score = basename_same(one, two);
-			diff_free_filespec_data(one);
 		}
-		/* We do not need the text anymore */
-		diff_free_filespec_data(two);
 		dst_cnt++;
 	}
 	/* cost matrix sorted by most to least similar pair */

My 20-minute diff becomes a 2-minute diff. The downside is that the
memory usage is much increased (for obvious reasons, it should increase
by the dataset size, since we are keeping pointers to the data around --
in my case, around 1G extra).  However, keeping around _just_ the
cnt_data caused only about 100M of extra memory consumption (and gave
the same performance boost).

Of course, 2 minutes for a git-status is still way too slow, so there we
might still need a limiter. It also looks like 57% of my time is spent
in spanhash_find, and another 29% in diffcore_count_changes.

The spanhash data structure is a bit confusing. At first, it looked like
we were doing a linear search for a matching hash, but it's not quite,
since we seem to start at some magic spot based on the hashval we're
looking up.

But it seems to be an array of (hash, count) pairs for each file. Is
there a reason not to use a hash table mapping hash -> count? That would
make insertion and lookup O(1), presumably at the cost of a bit more
memory (since each filespec would have the full table).

Junio, can you shed some light on that decision?

-Peff
