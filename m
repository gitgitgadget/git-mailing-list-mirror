From: Jeff King <peff@peff.net>
Subject: [PATCH 06/16] reachable: clear pending array after walking it
Date: Fri, 3 Oct 2014 16:24:28 -0400
Message-ID: <20141003202428.GF16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:24:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9P0-0007kS-Is
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbaJCUYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:24:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:54829 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750944AbaJCUYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:24:30 -0400
Received: (qmail 2821 invoked by uid 102); 3 Oct 2014 20:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:24:30 -0500
Received: (qmail 15007 invoked by uid 107); 3 Oct 2014 20:24:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:24:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:24:28 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257856>

We add a number of objects to our "pending" array, and then
process it with a combination of get_revision and walking
the pending array ourselves (to catch any non-commits). The
commits in the pending array are cleaned up automatically by
prepare_revision_walk, but we essentially leak any other
objects (they are technically still reachable from rev_info,
but no callers ever look at them or bother to clean them
up).

This is not a huge deal in practice, as the number of
non-commits tends to be small. However, a future patch will
broaden this considerably. Let's call object_array_clear to
free the memory.

Signed-off-by: Jeff King <peff@peff.net>
---
 reachable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/reachable.c b/reachable.c
index 6f6835b..d99bd31 100644
--- a/reachable.c
+++ b/reachable.c
@@ -131,6 +131,8 @@ static void walk_commit_list(struct rev_info *revs,
 		}
 		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
 	}
+
+	object_array_clear(&revs->pending);
 }
 
 static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-- 
2.1.1.566.gdb1f904
