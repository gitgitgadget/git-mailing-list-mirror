From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] diffcore-break: free filespec data as we go
Date: Mon, 16 Nov 2009 10:56:25 -0500
Message-ID: <20091116155625.GA30777@coredump.intra.peff.net>
References: <20091116155331.GA30719@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 16:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA3wS-0006mp-Tf
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 16:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbZKPP4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 10:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZKPP4Y
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 10:56:24 -0500
Received: from peff.net ([208.65.91.99]:54021 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbZKPP4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 10:56:20 -0500
Received: (qmail 16971 invoked by uid 107); 16 Nov 2009 16:00:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Nov 2009 11:00:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2009 10:56:25 -0500
Content-Disposition: inline
In-Reply-To: <20091116155331.GA30719@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133012>

As we look at each changed file and consider breaking it, we
load the blob data and make a decision about whether to
break, which is independent of any other blobs that might
have changed. However, we keep the data in memory while we
consider breaking all of the other files. Which means that
both versions of every file you are diffing are in memory at
the same time.

This patch instead frees the blob data as we finish with
each file pair, leading to much lower memory usage.

Signed-off-by: Jeff King <peff@peff.net>
---
As I noted in the cover letter, this can actually slow things down
slightly for some pathological cases, but I think the reduced memory
consumption is worth it. I couldn't come up with a real-world case where
it made any difference to the speed.

One other thing where _thought_ I might cause a slowdown was in fetching
the blobs for doing patch generation. But it turns out we drop the blobs
already after the diffcore merge, so they weren't living that long
anyway.

 diffcore-break.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index d7097bb..15562e4 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -204,12 +204,16 @@ void diffcore_break(int break_score)
 				dp->score = score;
 				dp->broken_pair = 1;
 
+				diff_free_filespec_data(p->one);
+				diff_free_filespec_data(p->two);
 				free(p); /* not diff_free_filepair(), we are
 					  * reusing one and two here.
 					  */
 				continue;
 			}
 		}
+		diff_free_filespec_data(p->one);
+		diff_free_filespec_data(p->two);
 		diff_q(&outq, p);
 	}
 	free(q->queue);
-- 
1.6.5.2.187.g29317
