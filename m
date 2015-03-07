From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 10/10] apply: convert threeway_stage to object_id
Date: Sat,  7 Mar 2015 23:24:05 +0000
Message-ID: <1425770645-628957-11-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO59-0001cR-3t
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbbCGXY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:27 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49827 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181AbbCGXYT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:19 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 341602808F;
	Sat,  7 Mar 2015 23:24:19 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265013>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 65b97ee..75c5342 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -208,7 +208,7 @@ struct patch {
 	struct patch *next;
 
 	/* three-way fallback result */
-	unsigned char threeway_stage[3][20];
+	struct object_id threeway_stage[3];
 };
 
 static void free_fragment_list(struct fragment *list)
@@ -3424,11 +3424,11 @@ static int try_threeway(struct image *image, struct patch *patch,
 	if (status) {
 		patch->conflicted_threeway = 1;
 		if (patch->is_new)
-			hashclr(patch->threeway_stage[0]);
+			hashclr(patch->threeway_stage[0].sha1);
 		else
-			hashcpy(patch->threeway_stage[0], pre_sha1);
-		hashcpy(patch->threeway_stage[1], our_sha1);
-		hashcpy(patch->threeway_stage[2], post_sha1);
+			hashcpy(patch->threeway_stage[0].sha1, pre_sha1);
+		hashcpy(patch->threeway_stage[1].sha1, our_sha1);
+		hashcpy(patch->threeway_stage[2].sha1, post_sha1);
 		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
 	} else {
 		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
@@ -4184,14 +4184,14 @@ static void add_conflicted_stages_file(struct patch *patch)
 
 	remove_file_from_cache(patch->new_name);
 	for (stage = 1; stage < 4; stage++) {
-		if (is_null_sha1(patch->threeway_stage[stage - 1]))
+		if (is_null_oid(&patch->threeway_stage[stage - 1]))
 			continue;
 		ce = xcalloc(1, ce_size);
 		memcpy(ce->name, patch->new_name, namelen);
 		ce->ce_mode = create_ce_mode(mode);
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
-		hashcpy(ce->sha1, patch->threeway_stage[stage - 1]);
+		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].sha1);
 		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
 			die(_("unable to add cache entry for %s"), patch->new_name);
 	}
-- 
2.2.1.209.g41e5f3a
