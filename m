From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] read-cache: let refresh_cache_ent pass up changed flags
Date: Mon, 14 Nov 2011 17:52:45 -0500
Message-ID: <20111114225245.GC3993@sigill.intra.peff.net>
References: <20111114225056.GA27370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:52:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5OV-0003Np-Fl
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab1KNWwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:52:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41333
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab1KNWwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:52:47 -0500
Received: (qmail 663 invoked by uid 107); 14 Nov 2011 22:52:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 17:52:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 17:52:45 -0500
Content-Disposition: inline
In-Reply-To: <20111114225056.GA27370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185414>

This will enable refresh_cache to differentiate more cases
of modification (such as typechange) when telling the user
what isn't fresh.

Signed-off-by: Jeff King <peff@peff.net>
---
There's only a single layer of call-stack to modify, and there's only
one other caller, so it turned out to be a pretty minor change.

 read-cache.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 046cf7e..83fb19c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1001,7 +1001,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
  */
 static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 					     struct cache_entry *ce,
-					     unsigned int options, int *err)
+					     unsigned int options, int *err,
+					     int *changed_ret)
 {
 	struct stat st;
 	struct cache_entry *updated;
@@ -1033,6 +1034,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 	}
 
 	changed = ie_match_stat(istate, ce, &st, options);
+	if (changed_ret)
+		*changed_ret = changed;
 	if (!changed) {
 		/*
 		 * The path is unchanged.  If we were told to ignore
@@ -1132,7 +1135,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
 			continue;
 
-		new = refresh_cache_ent(istate, ce, options, &cache_errno);
+		new = refresh_cache_ent(istate, ce, options, &cache_errno, NULL);
 		if (new == ce)
 			continue;
 		if (!new) {
@@ -1161,7 +1164,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
 {
-	return refresh_cache_ent(&the_index, ce, really, NULL);
+	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
 }
 
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
-- 
1.7.7.3.8.g38efa
