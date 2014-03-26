From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] pack-objects: reuse deltas for thin "have" objects
Date: Wed, 26 Mar 2014 03:23:38 -0400
Message-ID: <20140326072338.GF32193@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>, Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 08:23:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiBd-0006MG-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbaCZHXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:23:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:47402 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753440AbaCZHXk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:23:40 -0400
Received: (qmail 14614 invoked by uid 102); 26 Mar 2014 07:23:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 02:23:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 03:23:38 -0400
Content-Disposition: inline
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245167>

When we calculate the "wants" and "haves" for a pack, we
only add the objects in the boundary commits as preferred
bases. However, we know that every object reachable from the
"haves" could be a preferred base.

We probably don't want to add these to our preferred base
list, because they would clog the delta-search window.
However, there is no reason we cannot reuse an on-disk delta
against such a deep "have" base, avoiding the delta search
for that object altogether.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7950c43..92bd682 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -53,6 +53,7 @@ static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
+static int thin = 0;
 static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
@@ -1419,6 +1420,20 @@ static void check_object(struct object_entry *entry)
 			base_entry->delta_child = entry;
 			unuse_pack(&w_curs);
 			return;
+		} else if(thin && base_ref && bitmap_have(base_ref)) {
+			entry->type = entry->in_pack_type;
+			entry->delta_size = entry->size;
+			/*
+			 * XXX we'll leak this, but it's probably OK
+			 * since we'll exit immediately after the packing
+			 * is done
+			 */
+			entry->delta = xcalloc(1, sizeof(*entry->delta));
+			hashcpy(entry->delta->idx.sha1, base_ref);
+			entry->delta->preferred_base = 1;
+			entry->delta->filled = 1;
+			unuse_pack(&w_curs);
+			return;
 		}
 
 		if (entry->type) {
@@ -2559,7 +2574,6 @@ static int option_parse_ulong(const struct option *opt,
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
-	int thin = 0;
 	int all_progress_implied = 0;
 	const char *rp_av[6];
 	int rp_ac = 0;
-- 
1.9.1.601.g7ec968e
