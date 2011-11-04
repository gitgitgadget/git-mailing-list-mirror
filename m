From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH v3 3/3] http.c: Rely on select instead of tracking whether data was received
Date: Fri,  4 Nov 2011 15:19:27 +0100
Message-ID: <1320416367-28843-4-git-send-email-mika.fischer@zoopnet.de>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Cc: gitster@pobox.com, daniel@haxx.se, peff@peff.net,
	Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 15:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMKd5-0005K4-7k
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 15:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455Ab1KDOUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 10:20:15 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:44621 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab1KDOUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 10:20:05 -0400
Received: from localhost.localdomain (krlh-5f71f726.pool.mediaWays.net [95.113.247.38])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 50813249C2C0;
	Fri,  4 Nov 2011 15:20:03 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.35.gd9f16.dirty
In-Reply-To: <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184772>

Since now select is used with the file descriptors of the http connections,
tracking whether data was received recently (and trying to read more in
that case) is no longer necessary. Instead, always call select and rely on
it to return as soon as new data can be read.

Signed-off-by: Mika Fischer <mika.fischer@zoopnet.de>
---
 http.c |   16 +---------------
 http.h |    1 -
 2 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/http.c b/http.c
index e91a2ab..3c6a00b 100644
--- a/http.c
+++ b/http.c
@@ -4,7 +4,6 @@
 #include "run-command.h"
 #include "url.h"
 
-int data_received;
 int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
@@ -99,13 +98,11 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	struct strbuf *buffer = buffer_;
 
 	strbuf_add(buffer, ptr, size);
-	data_received++;
 	return size;
 }
 
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 {
-	data_received++;
 	return eltsize * nmemb;
 }
 
@@ -642,8 +639,6 @@ void step_active_slots(void)
 void run_active_slot(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
-	long last_pos = 0;
-	long current_pos;
 	fd_set readfds;
 	fd_set writefds;
 	fd_set excfds;
@@ -656,17 +651,9 @@ void run_active_slot(struct active_request_slot *slot)
 
 	slot->finished = &finished;
 	while (!finished) {
-		data_received = 0;
 		step_active_slots();
 
-		if (!data_received && slot->local != NULL) {
-			current_pos = ftell(slot->local);
-			if (current_pos > last_pos)
-				data_received++;
-			last_pos = current_pos;
-		}
-
-		if (slot->in_use && !data_received) {
+		if (slot->in_use) {
 #if LIBCURL_VERSION_NUM >= 0x070f04
 			curl_multi_timeout(curlm, &curl_timeout);
 			if (curl_timeout == 0) {
@@ -1232,7 +1219,6 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		git_SHA1_Update(&freq->c, expn,
 				sizeof(expn) - freq->stream.avail_out);
 	} while (freq->stream.avail_in && freq->zret == Z_OK);
-	data_received++;
 	return size;
 }
 
diff --git a/http.h b/http.h
index 3c332a9..71bdf58 100644
--- a/http.h
+++ b/http.h
@@ -89,7 +89,6 @@ extern void step_active_slots(void);
 extern void http_init(struct remote *remote, const char *url);
 extern void http_cleanup(void);
 
-extern int data_received;
 extern int active_requests;
 extern int http_is_verbose;
 extern size_t http_post_buffer;
-- 
1.7.8.rc0.35.gd9f16.dirty
