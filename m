From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] refresh_index: mark deletions in porcelain output
Date: Mon, 14 Nov 2011 17:52:08 -0500
Message-ID: <20111114225208.GB3993@sigill.intra.peff.net>
References: <20111114225056.GA27370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:52:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5Nv-00034I-CZ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588Ab1KNWwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:52:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41329
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab1KNWwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:52:10 -0500
Received: (qmail 630 invoked by uid 107); 14 Nov 2011 22:52:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 17:52:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 17:52:08 -0500
Content-Disposition: inline
In-Reply-To: <20111114225056.GA27370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185413>

If you have a deleted file and a porcelain refreshes the
cache, we print:

  Unstaged changes after reset:
  M	file

This is technically correct, in that the file is modified,
but it's friendlier to the user if we further differentiate
the case of a deleted file (especially because this output
looks a lot like "diff --name-status", which would also make
the distinction).

The plumbing version stays as "needs update" for historical
compatibility.

Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index eb3aae3..046cf7e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1103,9 +1103,11 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
 	const char *modified_fmt;
+	const char *deleted_fmt;
 	const char *unmerged_fmt;
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
+	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
@@ -1145,7 +1147,9 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			show_file(modified_fmt, ce->name, in_porcelain, &first, header_msg);
+			show_file((cache_errno == ENOENT ? deleted_fmt :
+				   modified_fmt),
+				  ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
 			continue;
 		}
-- 
1.7.7.3.8.g38efa
