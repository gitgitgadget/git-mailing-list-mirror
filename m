From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] diffcore-break: save cnt_data for other phases
Date: Mon, 16 Nov 2009 11:02:02 -0500
Message-ID: <20091116160202.GB30777@coredump.intra.peff.net>
References: <20091116155331.GA30719@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 17:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA41q-00019g-Rh
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 17:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZKPQB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 11:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbZKPQB6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 11:01:58 -0500
Received: from peff.net ([208.65.91.99]:45683 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbZKPQB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 11:01:57 -0500
Received: (qmail 17003 invoked by uid 107); 16 Nov 2009 16:05:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Nov 2009 11:05:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2009 11:02:02 -0500
Content-Disposition: inline
In-Reply-To: <20091116155331.GA30719@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "break" phase works by counting changes between two
blobs with the same path. We do this by splitting the file
into chunks (or lines for text oriented files) and then
keeping a count of chunk hashes.

The "rename" phase counts changes between blobs at two
different paths. However, it uses the exact same set of
chunk hashes (which are immutable for a given sha1).

The rename phase can therefore use the same hash data as
break. Unfortunately, we were throwing this data away after
computing it in the break phase. This patch instead attaches
it to the filespec and lets it live through the rename
phase, working under the assumption that most of the time
that breaks are being computed, renames will be too.

We only do this optimization for files which have actually
been broken, as those ones will be candidates for rename
detection (and it is a time-space tradeoff, so we don't want
to waste space keeping useless data).

Signed-off-by: Jeff King <peff@peff.net>
---
Note the two assumptions above:

  1. If we are running break, we will probably run rename detection.

  2. We are not looking for inexact copies, which could re-use data even
     for non-broken pairs.

We could test both of those assumptions by peeking at the other
diff_options that have been set up, but that would involve some code
restructuring. I'm also not sure it is worth it.

For (1), if we don't do rename detection, the next thing we will do is
the diffcore merge, which will then free the data anyway. So we are
really just carrying around the extra cnt_data through the break, and it
is much smaller than the actual blob data.

For (2), keep in mind that this is just a heuristic. We may not have any
good rename candidates anyway, or we may find an exact rename. So it is
just a guess as to which data might be useful. Keeping all the data for
all pairs, broken or not, may be pushing us too far along the time-space
tradeoff.

 diffcore-break.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 15562e4..3a7b60a 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -69,7 +69,7 @@ static int should_break(struct diff_filespec *src,
 		return 0; /* we do not break too small filepair */
 
 	if (diffcore_count_changes(src, dst,
-				   NULL, NULL,
+				   &src->cnt_data, &dst->cnt_data,
 				   0,
 				   &src_copied, &literal_added))
 		return 0;
@@ -204,8 +204,8 @@ void diffcore_break(int break_score)
 				dp->score = score;
 				dp->broken_pair = 1;
 
-				diff_free_filespec_data(p->one);
-				diff_free_filespec_data(p->two);
+				diff_free_filespec_blob(p->one);
+				diff_free_filespec_blob(p->two);
 				free(p); /* not diff_free_filepair(), we are
 					  * reusing one and two here.
 					  */
-- 
1.6.5.2.187.g29317
