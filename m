From: Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http-push: refactor lock-related headers creation for curl 
	requests
Date: Sat, 24 Jan 2009 10:00:22 +0800
Message-ID: <be6fef0d0901231800t6943b01dwbca976d5e9f3397@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 03:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXqS-0003TA-Ut
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 03:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbZAXCA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 21:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbZAXCAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 21:00:25 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:57589 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbZAXCAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 21:00:23 -0500
Received: by wa-out-1112.google.com with SMTP id v33so100966wah.21
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 18:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=u8wDX4qZcNpM+2x4ENO5hPnCmsZVFpTliuB0fIF9J6k=;
        b=FEn+139q/VcO8mBNL/+nsxM5Q2gjz6KPpD+kl+0QgyPcSsfV5eeJ+0DALSqltaNxbI
         BZhWJciAXbpyTAfhS/okWHo4ZXGQOv8GQqfxltWKSCyuhYXlH1a02TL90wcCZkmcP+AM
         kp+Grc2zwbsGkFTmzZFtNK5+4TTTFjmE93s9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ZtUIggo7HahMNQOEj03RDRb1Zk1iRj9pmM4xbV8gfJk1IJ/XC1e3oH6xnGyGwf8f/o
         iiGC4MNLM/YxlhxeYeuX2bx1HbyOlaB7dSJyqPhWFlFfg09kFNPT0LbH5q1RoOJyVMqh
         6/+TZC2FfM6xboQkPPO2M+NZpI7NqjA3XFGzk=
Received: by 10.114.130.8 with SMTP id c8mr1229316wad.15.1232762422082; Fri, 
	23 Jan 2009 18:00:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106946>

Currently, DAV-related headers (more specifically, headers related to
the lock token, namely, If, Lock-Token, and Timeout) for curl requests
are created and allocated individually, eg a "if_header" variable for
the "If: " header, a "timeout_header" variable for the "Timeout: "
header.

This patch provides a new function ("get_dav_token_headers") that
creates these header, saving methods from allocating memory, and from
issuing a "curl_slist_append" call.

In part, this patch also addresses the fact that commit 753bc91
(Remove the requirement opaquelocktoken uri scheme) did not update
memory allocations for DAV-related headers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   68 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/http-push.c b/http-push.c
index cb5bf95..eca4a8e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -177,6 +177,37 @@ struct remote_ls_ctx
 	struct remote_ls_ctx *parent;
 };

+/* get_dav_token_headers options */
+enum dav_header_flag {
+	DAV_HEADER_IF = (1u << 0),
+	DAV_HEADER_LOCK = (1u << 1),
+	DAV_HEADER_TIMEOUT = (1u << 2)
+};
+
+static struct curl_slist *get_dav_token_headers(struct remote_lock
*lock, enum dav_header_flag options) {
+	struct strbuf buf = STRBUF_INIT;
+	struct curl_slist *dav_headers = NULL;
+
+	if(options & DAV_HEADER_IF) {
+		strbuf_addf(&buf, "If: (<%s>)", lock->token);
+		dav_headers = curl_slist_append(dav_headers, buf.buf);
+		strbuf_reset(&buf);
+	}
+	if(options & DAV_HEADER_LOCK) {
+		strbuf_addf(&buf, "Lock-Token: <%s>", lock->token);
+		dav_headers = curl_slist_append(dav_headers, buf.buf);
+		strbuf_reset(&buf);
+	}
+	if(options & DAV_HEADER_TIMEOUT) {
+		strbuf_addf(&buf, "Timeout: Second-%ld", lock->timeout);
+		dav_headers = curl_slist_append(dav_headers, buf.buf);
+		strbuf_reset(&buf);
+	}
+	strbuf_release(&buf);
+
+	return dav_headers;
+}
+
 static void finish_request(struct transfer_request *request);
 static void release_request(struct transfer_request *request);

@@ -588,18 +619,12 @@ static int refresh_lock(struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	char *if_header;
-	char timeout_header[25];
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers;
 	int rc = 0;

 	lock->refreshing = 1;

-	if_header = xmalloc(strlen(lock->token) + 25);
-	sprintf(if_header, "If: (<%s>)", lock->token);
-	sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
-	dav_headers = curl_slist_append(dav_headers, if_header);
-	dav_headers = curl_slist_append(dav_headers, timeout_header);
+	dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF | DAV_HEADER_TIMEOUT);

 	slot = get_active_slot();
 	slot->results = &results;
@@ -622,7 +647,6 @@ static int refresh_lock(struct remote_lock *lock)

 	lock->refreshing = 0;
 	curl_slist_free_all(dav_headers);
-	free(if_header);

 	return rc;
 }
@@ -1303,14 +1327,10 @@ static int unlock_remote(struct remote_lock *lock)
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct remote_lock *prev = remote->locks;
-	char *lock_token_header;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers;
 	int rc = 0;

-	lock_token_header = xmalloc(strlen(lock->token) + 31);
-	sprintf(lock_token_header, "Lock-Token: <%s>",
-		lock->token);
-	dav_headers = curl_slist_append(dav_headers, lock_token_header);
+	dav_headers = get_dav_token_headers(lock, DAV_HEADER_LOCK);

 	slot = get_active_slot();
 	slot->results = &results;
@@ -1331,7 +1351,6 @@ static int unlock_remote(struct remote_lock *lock)
 	}

 	curl_slist_free_all(dav_headers);
-	free(lock_token_header);

 	if (remote->locks == lock) {
 		remote->locks = lock->next;
@@ -1731,13 +1750,10 @@ static int update_remote(unsigned char *sha1,
struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	char *if_header;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers;

-	if_header = xmalloc(strlen(lock->token) + 25);
-	sprintf(if_header, "If: (<%s>)", lock->token);
-	dav_headers = curl_slist_append(dav_headers, if_header);
+	dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF);

 	strbuf_addf(&out_buffer.buf, "%s\n", sha1_to_hex(sha1));

@@ -1756,7 +1772,6 @@ static int update_remote(unsigned char *sha1,
struct remote_lock *lock)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		strbuf_release(&out_buffer.buf);
-		free(if_header);
 		if (results.curl_result != CURLE_OK) {
 			fprintf(stderr,
 				"PUT error: curl result=%d, HTTP code=%ld\n",
@@ -1766,7 +1781,6 @@ static int update_remote(unsigned char *sha1,
struct remote_lock *lock)
 		}
 	} else {
 		strbuf_release(&out_buffer.buf);
-		free(if_header);
 		fprintf(stderr, "Unable to start PUT request\n");
 		return 0;
 	}
@@ -1948,15 +1962,12 @@ static void update_remote_info_refs(struct
remote_lock *lock)
 	struct buffer buffer = { STRBUF_INIT, 0 };
 	struct active_request_slot *slot;
 	struct slot_results results;
-	char *if_header;
-	struct curl_slist *dav_headers = NULL;
+	struct curl_slist *dav_headers;

 	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
 		  add_remote_info_ref, &buffer.buf);
 	if (!aborted) {
-		if_header = xmalloc(strlen(lock->token) + 25);
-		sprintf(if_header, "If: (<%s>)", lock->token);
-		dav_headers = curl_slist_append(dav_headers, if_header);
+		dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF);

 		slot = get_active_slot();
 		slot->results = &results;
@@ -1978,7 +1989,6 @@ static void update_remote_info_refs(struct
remote_lock *lock)
 					results.curl_result, results.http_code);
 			}
 		}
-		free(if_header);
 	}
 	strbuf_release(&buffer.buf);
 }
-- 
1.6.0.4
