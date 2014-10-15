From: Jeff King <peff@peff.net>
Subject: [PATCH v2 23/25] pack-objects: use argv_array
Date: Wed, 15 Oct 2014 18:45:16 -0400
Message-ID: <20141015224516.GW25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXJr-0001ux-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbaJOWpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:45:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:59031 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751033AbaJOWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:45:18 -0400
Received: (qmail 2761 invoked by uid 102); 15 Oct 2014 22:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:45:18 -0500
Received: (qmail 28299 invoked by uid 107); 15 Oct 2014 22:45:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:45:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:45:16 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This saves us from having to bump the rp_av count when we
add new traversal options.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4df9499..b26276b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -22,6 +22,7 @@
 #include "pack-bitmap.h"
 #include "reachable.h"
 #include "sha1-array.h"
+#include "argv-array.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
@@ -2614,8 +2615,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	int all_progress_implied = 0;
-	const char *rp_av[6];
-	int rp_ac = 0;
+	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -2705,24 +2705,24 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
-	rp_av[rp_ac++] = "pack-objects";
+	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
-		rp_av[rp_ac++] = "--objects-edge";
+		argv_array_push(&rp, "--objects-edge");
 	} else
-		rp_av[rp_ac++] = "--objects";
+		argv_array_push(&rp, "--objects");
 
 	if (rev_list_all) {
 		use_internal_rev_list = 1;
-		rp_av[rp_ac++] = "--all";
+		argv_array_push(&rp, "--all");
 	}
 	if (rev_list_reflog) {
 		use_internal_rev_list = 1;
-		rp_av[rp_ac++] = "--reflog";
+		argv_array_push(&rp, "--reflog");
 	}
 	if (rev_list_unpacked) {
 		use_internal_rev_list = 1;
-		rp_av[rp_ac++] = "--unpacked";
+		argv_array_push(&rp, "--unpacked");
 	}
 
 	if (!reuse_object)
@@ -2766,8 +2766,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-		rp_av[rp_ac] = NULL;
-		get_object_list(rp_ac, rp_av);
+		get_object_list(rp.argc, rp.argv);
+		argv_array_clear(&rp);
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
-- 
2.1.2.596.g7379948
