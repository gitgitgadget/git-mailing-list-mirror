From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] refresh_index: rename format variables
Date: Mon, 14 Nov 2011 17:51:53 -0500
Message-ID: <20111114225153.GA3993@sigill.intra.peff.net>
References: <20111114225056.GA27370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:52:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5Ng-0002wB-6J
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab1KNWv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:51:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41324
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab1KNWvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:51:55 -0500
Received: (qmail 563 invoked by uid 107); 14 Nov 2011 22:52:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 17:52:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 17:51:53 -0500
Content-Disposition: inline
In-Reply-To: <20111114225056.GA27370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185412>

When refreshing the index, for modified (or unmerged) files
we will print "needs update" (or "needs merge") for plumbing,
or a "diff --name-status"-ish line for porcelain.

The variables holding which type of message to show are
named after the plumbing messages. However, as we begin to
differentiate more cases at the porcelain level (with the
plumbing message stayin the same), that naming scheme will
become awkward.

Instead, name the variables after which case we found
(modified or unmerged), not what we will output.

Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5790a91..eb3aae3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1102,11 +1102,11 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
-	const char *needs_update_fmt;
-	const char *needs_merge_fmt;
+	const char *modified_fmt;
+	const char *unmerged_fmt;
 
-	needs_update_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
-	needs_merge_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
+	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
+	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
@@ -1122,7 +1122,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			i--;
 			if (allow_unmerged)
 				continue;
-			show_file(needs_merge_fmt, ce->name, in_porcelain, &first, header_msg);
+			show_file(unmerged_fmt, ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
 			continue;
 		}
@@ -1145,7 +1145,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			show_file(needs_update_fmt, ce->name, in_porcelain, &first, header_msg);
+			show_file(modified_fmt, ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
 			continue;
 		}
-- 
1.7.7.3.8.g38efa
