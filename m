From: Mike Hommey <mh@glandium.org>
Subject: [RFC] Don't expect verify_pack() callers to set pack_size
Date: Sun, 27 Jan 2008 16:01:38 +0100
Message-ID: <1201446098-18868-1-git-send-email-mh@glandium.org>
Cc: spearce@spearce.org
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 27 16:00:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ8zW-0005lF-JY
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 16:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYA0O7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 09:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbYA0O7n
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 09:59:43 -0500
Received: from vuizook.err.no ([85.19.215.103]:40423 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330AbYA0O7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 09:59:42 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JJ8zL-00058A-RA; Sun, 27 Jan 2008 16:00:11 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JJ90s-0004uj-Mx; Sun, 27 Jan 2008 16:01:38 +0100
X-Mailer: git-send-email 1.5.4.rc5.12.gb8680-dirty
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71818>

Since use_pack() will end up populating pack_size if it is not already set,
we can just adapt the code in verify_packfile() such that it doesn't require
pack_size to be set beforehand.

This allows callers not to have to set pack_size themselves, and we can thus
revert changes from 1c23d794.
---

 I'd like some feedback on this change in pack-check.c, that help refactoring
 more efficiently the code in http-*.c.

 http-push.c   |    3 ---
 http-walker.c |    1 -
 pack-check.c  |    8 +++++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/http-push.c b/http-push.c
index b2b410d..be54ed3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -770,14 +770,11 @@ static void finish_request(struct transfer_request *request)
 				request->url, curl_errorstr);
 			remote->can_update_info_refs = 0;
 		} else {
-			off_t pack_size = ftell(request->local_stream);
-
 			fclose(request->local_stream);
 			request->local_stream = NULL;
 			if (!move_temp_to_file(request->tmpfile,
 					       request->filename)) {
 				target = (struct packed_git *)request->userData;
-				target->pack_size = pack_size;
 				lst = &remote->packs;
 				while (*lst != target)
 					lst = &((*lst)->next);
diff --git a/http-walker.c b/http-walker.c
index 2c37868..29f9728 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -783,7 +783,6 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 		return error("Unable to start request");
 	}
 
-	target->pack_size = ftell(packfile);
 	fclose(packfile);
 
 	ret = move_temp_to_file(tmpfile, filename);
diff --git a/pack-check.c b/pack-check.c
index d7dd62b..e7f0126 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -25,7 +25,7 @@ static int verify_packfile(struct packed_git *p,
 	const unsigned char *index_base = p->index_data;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
-	off_t offset = 0, pack_sig = p->pack_size - 20;
+	off_t offset = 0, pack_sig = 0;
 	uint32_t nr_objects, i;
 	int err;
 	struct idx_entry *entries;
@@ -37,14 +37,16 @@ static int verify_packfile(struct packed_git *p,
 	 */
 
 	SHA1_Init(&ctx);
-	while (offset < pack_sig) {
+	do {
 		unsigned int remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
+		if (pack_sig == 0)
+			pack_sig = p->pack_size - 20;
 		if (offset > pack_sig)
 			remaining -= (unsigned int)(offset - pack_sig);
 		SHA1_Update(&ctx, in, remaining);
-	}
+	} while (offset < pack_sig);
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, use_pack(p, w_curs, pack_sig, NULL)))
 		return error("Packfile %s SHA1 mismatch with itself",
-- 
1.5.4.rc5.12.gb8680-dirty
