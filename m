From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] refresh_index: make porcelain output more specific
Date: Fri, 18 Nov 2011 06:13:08 -0500
Message-ID: <20111118111308.GC6335@sigill.intra.peff.net>
References: <20111118110938.GA5940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 12:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRMNg-0001Qj-4I
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 12:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab1KRLNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 06:13:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47306
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab1KRLNK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 06:13:10 -0500
Received: (qmail 31362 invoked by uid 107); 18 Nov 2011 11:13:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Nov 2011 06:13:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Nov 2011 06:13:08 -0500
Content-Disposition: inline
In-Reply-To: <20111118110938.GA5940@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185652>

If you have a deleted file and a porcelain refreshes the
cache, we print:

  Unstaged changes after reset:
  M	file

This is technically correct, in that the file is modified,
but it's friendlier to the user if we further differentiate
the case of a deleted file (especially because this output
looks a lot like "diff --name-status", which would also make
the distinction).

Similarly, we can distinguish typechanges ("T") and
intent-to-add files ("A"), both of which appear as just "M"
in the current output.

The plumbing output for all cases remains "needs update" for
historical compatibility.

Signed-off-by: Jeff King <peff@peff.net>
---
This is my deletion and typechange patches squashed together with your
intent-to-add, and using an if/else series instead of the ternary
operator, as you did.

 read-cache.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f19b2f1..27e9fc6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1106,13 +1106,20 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
 	const char *modified_fmt;
+	const char *deleted_fmt;
+	const char *typechange_fmt;
+	const char *added_fmt;
 	const char *unmerged_fmt;
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
+	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
+	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
+	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
+		int changed = 0;
 
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
@@ -1133,10 +1140,12 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
 			continue;
 
-		new = refresh_cache_ent(istate, ce, options, &cache_errno, NULL);
+		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
 		if (new == ce)
 			continue;
 		if (!new) {
+			const char *fmt;
+
 			if (not_new && cache_errno == ENOENT)
 				continue;
 			if (really && cache_errno == EINVAL) {
@@ -1148,7 +1157,17 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			show_file(modified_fmt, ce->name, in_porcelain, &first, header_msg);
+
+			if (cache_errno == ENOENT)
+				fmt = deleted_fmt;
+			else if (ce->ce_flags & CE_INTENT_TO_ADD)
+				fmt = added_fmt; /* must be before other checks */
+			else if (changed & TYPE_CHANGED)
+				fmt = typechange_fmt;
+			else
+				fmt = modified_fmt;
+			show_file(fmt,
+				  ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
 			continue;
 		}
-- 
1.7.7.3.8.g38efa
