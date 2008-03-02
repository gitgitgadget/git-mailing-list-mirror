From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix random crashes in http_cleanup()
Date: Sun,  2 Mar 2008 21:28:33 +0100
Message-ID: <1204489713-8696-1-git-send-email-mh@glandium.org>
References: <20080302200309.GA2070@glandium.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 21:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVukN-0006jM-P4
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 21:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbYCBUYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 15:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbYCBUYr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 15:24:47 -0500
Received: from vuizook.err.no ([194.24.252.247]:52840 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbYCBUYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 15:24:46 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVujc-00076A-Vt; Sun, 02 Mar 2008 21:24:43 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVunR-0002Gj-1G; Sun, 02 Mar 2008 21:28:33 +0100
X-Mailer: git-send-email 1.5.4.3.368.g272aa.dirty
In-Reply-To: <20080302200309.GA2070@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75835>

For some reason, http_cleanup was running all active slots, which could
lead in situations where a freed slot would be accessed in
fill_active_slots. OTOH, we are cleaning up, which means the caller
doesn't care about pending requests. Just forget about them instead
or running them.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 > Now, why do we need to run slots when cleaning up ?

 I just think we don't care, so this fix should be okay.

 http.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 5925d07..9683e46 100644
--- a/http.c
+++ b/http.c
@@ -287,17 +287,12 @@ void http_cleanup(void)
 
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

