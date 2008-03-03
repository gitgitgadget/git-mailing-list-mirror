From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v2] Fix random crashes in http_cleanup()
Date: Mon,  3 Mar 2008 20:30:16 +0100
Message-ID: <1204572616-25721-1-git-send-email-mh@glandium.org>
References: <20080303100141.15600.qmail@e81d07a86798f7.315fe32.mid.smarden.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 03 20:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGJY-0002W3-H4
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbYCCT0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 14:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755590AbYCCT0b
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:26:31 -0500
Received: from vuizook.err.no ([194.24.252.247]:55241 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222AbYCCT0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:26:30 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JWGIi-0000BO-1w; Mon, 03 Mar 2008 20:26:22 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JWGMa-0006hK-Kk; Mon, 03 Mar 2008 20:30:16 +0100
X-Mailer: git-send-email 1.5.4.3.368.g272aa.dirty
In-Reply-To: <20080303100141.15600.qmail@e81d07a86798f7.315fe32.mid.smarden.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75976>

For some reason, http_cleanup was running all active slots, which could
lead in situations where a freed slot would be accessed in
fill_active_slots. OTOH, we are cleaning up, which means the caller
doesn't care about pending requests. Just forget about them instead
or running them.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/http.c b/http.c
index 8e554c0..256a5f1 100644
--- a/http.c
+++ b/http.c
@@ -284,23 +284,15 @@ void http_init(struct remote *remote)
 void http_cleanup(void)
 {
 	struct active_request_slot *slot = active_queue_head;
-#ifdef USE_CURL_MULTI
-	char *wait_url;
-#endif
 
 	while (slot != NULL) {
 		struct active_request_slot *next = slot->next;
+		if (slot->curl != NULL) {
 #ifdef USE_CURL_MULTI
-		if (slot->in_use) {
-			curl_easy_getinfo(slot->curl,
-					  CURLINFO_EFFECTIVE_URL,
-					  &wait_url);
-			fprintf(stderr, "Waiting for %s\n", wait_url);
-			run_active_slot(slot);
-		}
+			curl_multi_remove_handle(curlm, slot->curl);
 #endif
-		if (slot->curl != NULL)
 			curl_easy_cleanup(slot->curl);
+		}
 		free(slot);
 		slot = next;
 	}
-- 
1.5.4.3.368.g272aa.dirty

