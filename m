From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 00:30:53 -0400
Message-ID: <20060629043053.GA32630@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <20060629035849.GA30749@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 06:31:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvoBM-0003ID-Fh
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 06:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWF2Ea4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 00:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWF2Ea4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 00:30:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:22658 "HELO
	peff.net") by vger.kernel.org with SMTP id S932181AbWF2Eaz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 00:30:55 -0400
Received: (qmail 9400 invoked from network); 29 Jun 2006 00:30:33 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 00:30:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 00:30:53 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060629035849.GA30749@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22838>

On Wed, Jun 28, 2006 at 11:58:49PM -0400, Jeff King wrote:

>    about 2.7M. The linux-2.6 cache is 22M.
>    [...]
>  - correctness. Currently the code uses the output of try_delta for
>    negative caching. Should the cache checking be moved inside try_delta
>    instead? This would give more control over which reasons to mark a

I tried moving the cache check/mark to wrap the call to create_delta in
try_delta. The speedup is the same (since all of the CPU time is spent
in create_delta anyway), and the linux-2.6 cache size dropped to 18M.
I also think this is probably more correct (it ignores every reason not
to delta EXCEPT create_delta failing).

The distribution of the window parameter 'j' is similarly uniform:
  44900 j=2
  44907 j=3
  44943 j=1
  45001 j=4
  45014 j=5
  45023 j=6
  45063 j=7
  45158 j=8
  45288 j=9
  45466 j=10

Patch on top of my other one is below.

-Peff

-- >8 --
pack-objects: move delta-cache check/mark closer to create_delta

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-objects.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index 46b9775..83ccc8a 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1014,9 +1014,13 @@ static int try_delta(struct unpacked *tr
 	if (sizediff >= max_size)
 		return 0;
 
+	if (delta_cache_check(src->entry->sha1, trg->entry->sha1))
+		return 0;
 	delta_buf = create_delta(src_index, trg->data, size, &delta_size, max_size);
-	if (!delta_buf)
+	if (!delta_buf) {
+		delta_cache_mark(src->entry->sha1, trg->entry->sha1);
 		return 0;
+	}
 
 	trg_entry->delta = src_entry;
 	trg_entry->delta_size = delta_size;
@@ -1084,21 +1088,14 @@ static void find_deltas(struct object_en
 		j = window;
 		while (--j > 0) {
 			unsigned int other_idx = idx + j;
-			int r;
 			struct unpacked *m;
 			if (other_idx >= window)
 				other_idx -= window;
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (delta_cache_check(n->entry->sha1, m->entry->sha1))
-				continue;
-			r = try_delta(n, m, m->index, depth);
-			if (r < 0)
+			if (try_delta(n, m, m->index, depth) < 0)
 				break;
-			if (r == 0)
-				delta_cache_mark(n->entry->sha1,
-						 m->entry->sha1);
 		}
 		/* if we made n a delta, and if n is already at max
 		 * depth, leaving it in the window is pointless.  we
-- 
1.4.1.rc1.g0458-dirty
