From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] Remove the requirement opaquelocktoken uri scheme
Date: Fri, 19 Dec 2008 04:51:31 +0300
Message-ID: <1229651491-23060-1-git-send-email-catap@catap.ru>
Cc: gitster@pobox.com, "Kirill A. Korinskiy" <catap@catap.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 02:53:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDUYk-0008PU-81
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 02:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbYLSBw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 20:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbYLSBw1
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 20:52:27 -0500
Received: from void.catap.ru ([213.248.54.140]:45196 "EHLO void.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbYLSBw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 20:52:27 -0500
Received: (qmail 1260 invoked from network); 19 Dec 2008 01:52:25 -0000
Received: from catap.dialup.corbina.ru (HELO mx3.catap.ru) (85.21.143.245)
  by void.catap.ru with ESMTPS (AES256-SHA encrypted); 19 Dec 2008 01:52:25 -0000
Received: from localhost
	([127.0.0.1] helo=satellite.home.catap.ru ident=catap)
	by mx3.catap.ru with esmtp (Exim 4.63)
	(envelope-from <catap@catap.ru>)
	id 1LDUXQ-0001cp-6s; Fri, 19 Dec 2008 04:52:24 +0300
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LDUWZ-00060m-ED; Fri, 19 Dec 2008 04:51:31 +0300
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103528>

Server can use any URI for token by rfc 4918 section 6.5 paragraph five

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 http-push.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5cecef434a7740a3f853462978c3e071b4da7e74..7c6460919bf3eba10c46cede11ffdd9c53fd2dd2 100644
--- a/http-push.c
+++ b/http-push.c
@@ -595,7 +595,7 @@ static int refresh_lock(struct remote_lock *lock)
 	lock->refreshing = 1;
 
 	if_header = xmalloc(strlen(lock->token) + 25);
-	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
+	sprintf(if_header, "If: (<%s>)", lock->token);
 	sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
 	dav_headers = curl_slist_append(dav_headers, if_header);
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
@@ -1120,10 +1120,8 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 				lock->timeout =
 					strtol(ctx->cdata + 7, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
-			if (!prefixcmp(ctx->cdata, "opaquelocktoken:")) {
-				lock->token = xmalloc(strlen(ctx->cdata) - 15);
-				strcpy(lock->token, ctx->cdata + 16);
-			}
+			lock->token = xmalloc(strlen(ctx->cdata) + 1);
+			strcpy(lock->token, ctx->cdata);
 		}
 	}
 }
@@ -1308,7 +1306,7 @@ static int unlock_remote(struct remote_lock *lock)
 	int rc = 0;
 
 	lock_token_header = xmalloc(strlen(lock->token) + 31);
-	sprintf(lock_token_header, "Lock-Token: <opaquelocktoken:%s>",
+	sprintf(lock_token_header, "Lock-Token: <%s>",
 		lock->token);
 	dav_headers = curl_slist_append(dav_headers, lock_token_header);
 
@@ -1722,7 +1720,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 	struct curl_slist *dav_headers = NULL;
 
 	if_header = xmalloc(strlen(lock->token) + 25);
-	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
+	sprintf(if_header, "If: (<%s>)", lock->token);
 	dav_headers = curl_slist_append(dav_headers, if_header);
 
 	strbuf_addf(&out_buffer.buf, "%s\n", sha1_to_hex(sha1));
@@ -1941,7 +1939,7 @@ static void update_remote_info_refs(struct remote_lock *lock)
 		  add_remote_info_ref, &buffer.buf);
 	if (!aborted) {
 		if_header = xmalloc(strlen(lock->token) + 25);
-		sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
+		sprintf(if_header, "If: (<%s>)", lock->token);
 		dav_headers = curl_slist_append(dav_headers, if_header);
 
 		slot = get_active_slot();
-- 
1.5.6.5
