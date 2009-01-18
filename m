From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 01/12] Don't expect verify_pack() callers to set pack_size
Date: Sun, 18 Jan 2009 09:04:26 +0100
Message-ID: <1232265877-3649-2-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfm-0001kf-3x
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbZARIEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758680AbZARIEu
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:50 -0500
Received: from vuizook.err.no ([85.19.221.46]:42436 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051AbZARIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:45 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe5-0002ER-UY; Sun, 18 Jan 2009 09:04:40 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000y4-88; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-1-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106150>

Since use_pack() will end up populating pack_size if it is not already set,
we can just adapt the code in verify_packfile() such that it doesn't require
pack_size to be set beforehand.

This allows callers not to have to set pack_size themselves, and we can thus
revert changes from 1c23d794 (Don't die in git-http-fetch when fetching packs).

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c   |    3 ---
 http-walker.c |    1 -
 pack-check.c  |    8 +++++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/http-push.c b/http-push.c
index a4b7d08..e69179b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -771,14 +771,11 @@ static void finish_request(struct transfer_request *request)
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
index 7271c7d..0139d1e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -785,7 +785,6 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 		return error("Unable to start request");
 	}
 
-	target->pack_size = ftell(packfile);
 	fclose(packfile);
 
 	ret = move_temp_to_file(tmpfile, filename);
diff --git a/pack-check.c b/pack-check.c
index 90c33b1..166ca70 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -49,7 +49,7 @@ static int verify_packfile(struct packed_git *p,
 	const unsigned char *index_base = p->index_data;
 	git_SHA_CTX ctx;
 	unsigned char sha1[20], *pack_sig;
-	off_t offset = 0, pack_sig_ofs = p->pack_size - 20;
+	off_t offset = 0, pack_sig_ofs = 0;
 	uint32_t nr_objects, i;
 	int err = 0;
 	struct idx_entry *entries;
@@ -61,14 +61,16 @@ static int verify_packfile(struct packed_git *p,
 	 */
 
 	git_SHA1_Init(&ctx);
-	while (offset < pack_sig_ofs) {
+	do {
 		unsigned int remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
+		if (!pack_sig_ofs)
+			pack_sig_ofs = p->pack_size - 20;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
 		git_SHA1_Update(&ctx, in, remaining);
-	}
+	} while (offset < pack_sig_ofs);
 	git_SHA1_Final(sha1, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (hashcmp(sha1, pack_sig))
-- 
1.6.1.141.gb32a
