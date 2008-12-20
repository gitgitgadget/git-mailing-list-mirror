From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] Remove the requirement opaquelocktoken uri scheme
Date: Sat, 20 Dec 2008 09:19:46 +0300
Message-ID: <1229753986-5193-1-git-send-email-catap@catap.ru>
References: <7vljucbows.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, catap@catap.ru
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 07:25:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDvGv-0006rG-Qo
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 07:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYLTGUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 01:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYLTGUs
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 01:20:48 -0500
Received: from void.catap.ru ([213.248.54.140]:56755 "EHLO void.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbYLTGUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 01:20:47 -0500
Received: (qmail 21672 invoked from network); 20 Dec 2008 06:20:44 -0000
Received: from catap.dialup.corbina.ru (HELO mx3.catap.ru) (85.21.143.245)
  by void.catap.ru with ESMTPS (AES256-SHA encrypted); 20 Dec 2008 06:20:44 -0000
Received: from localhost
	([127.0.0.1] helo=satellite.home.catap.ru ident=catap)
	by mx3.catap.ru with esmtp (Exim 4.63)
	(envelope-from <catap@catap.ru>)
	id 1LDvCb-0004zt-2w; Sat, 20 Dec 2008 09:20:41 +0300
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LDvBi-0001ND-UA; Sat, 20 Dec 2008 09:19:46 +0300
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <7vljucbows.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103622>

The program flow of pushing over http is:

 - call lock_remote() to issue a DAV_LOCK request to the server to lock
   info/refs and branch refs being pushed into; handle_new_lock_ctx() is
   used to parse its response to populate "struct remote_lock" that is
   returned from lock_remote();

 - send objects;

 - call unlock_remote() to drop the lock.

The handle_new_lock_ctx() function assumed that the server will use a
lock token in opaquelocktoken URI scheme, which may have been an Ok
assumption under RFC 2518, but under RFC 4918 which obsoletes the older
standard it is not necessarily true.

This resulted in push failure (often resulted in "cannot lock existing
info/refs" error message) when talking to a server that does not use
opaquelocktoken URI scheme.

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
