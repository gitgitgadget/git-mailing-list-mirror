From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] smart-http: Don't use Expect: 100-Continue
Date: Tue, 15 Feb 2011 08:57:24 -0800
Message-ID: <1297789044-17978-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 17:57:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpODU-0008Sb-Q4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 17:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab1BOQ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 11:57:28 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64371 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab1BOQ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 11:57:27 -0500
Received: by pva4 with SMTP id 4so52364pva.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 08:57:26 -0800 (PST)
Received: by 10.142.226.15 with SMTP id y15mr2045439wfg.85.1297789046415;
        Tue, 15 Feb 2011 08:57:26 -0800 (PST)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id z1sm441290wfd.9.2011.02.15.08.57.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 08:57:25 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc3.268.g2af8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166857>

Some HTTP/1.1 servers or proxies don't correctly implement the
100-Continue feature of HTTP/1.1.  Its a difficult feature to
implement right, and isn't commonly used by browsers, so many
developers may not even be aware that their server (or proxy)
doesn't honor it.

Within the smart HTTP protocol for Git we only use this newer
"Expect: 100-Continue" feature to probe for missing authentication
before uploading a large payload like a pack file during push.
If authentication is necessary, we expect the server to send the
401 Not Authorized response before the bulk data transfer starts,
thus saving the client bandwidth during the retry.

A different method to probe for working authentication is to send an
empty command list (that is just "0000") to $URL/git-receive-pack.
or $URL/git-upload-pack.  All versions of both receive-pack and
upload-pack since the introduction of smart HTTP in Git 1.6.6
cleanly accept just a flush-pkt under --stateless-rpc mode, and
exit with success.

If HTTP level authentication is successful, the backend will return
an empty response, but with HTTP status code 200.  This enables
the client to continue with the transfer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote-curl.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 04d4813..3d82dc2 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -356,14 +356,59 @@ static size_t rpc_in(const void *ptr, size_t eltsize,
 	return size;
 }
 
+static int run_slot(struct active_request_slot *slot)
+{
+	int err = 0;
+	struct slot_results results;
+
+	slot->results = &results;
+	slot->curl_result = curl_easy_perform(slot->curl);
+	finish_active_slot(slot);
+
+	if (results.curl_result != CURLE_OK) {
+		err |= error("RPC failed; result=%d, HTTP code = %ld",
+			results.curl_result, results.http_code);
+	}
+
+	return err;
+}
+
+static int probe_rpc(struct rpc_state *rpc)
+{
+	struct active_request_slot *slot;
+	struct curl_slist *headers = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	int err;
+
+	slot = get_active_slot();
+
+	headers = curl_slist_append(headers, rpc->hdr_content_type);
+	headers = curl_slist_append(headers, rpc->hdr_accept);
+
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, buf);
+
+	err = run_slot(slot);
+
+	curl_slist_free_all(headers);
+	strbuf_release(&buf);
+	return err;
+}
+
 static int post_rpc(struct rpc_state *rpc)
 {
 	struct active_request_slot *slot;
-	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
-	int err = 0, large_request = 0;
+	int err, large_request = 0;
 
 	/* Try to load the entire request, if we can fit it into the
 	 * allocated buffer space we can use HTTP/1.0 and avoid the
@@ -386,8 +431,13 @@ static int post_rpc(struct rpc_state *rpc)
 		rpc->len += n;
 	}
 
+	if (large_request) {
+		err = probe_rpc(rpc);
+		if (err)
+			return err;
+	}
+
 	slot = get_active_slot();
-	slot->results = &results;
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
@@ -401,7 +451,7 @@ static int post_rpc(struct rpc_state *rpc)
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
 		 */
-		headers = curl_slist_append(headers, "Expect: 100-continue");
+		headers = curl_slist_append(headers, "Expect:");
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
@@ -475,13 +525,7 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
-	slot->curl_result = curl_easy_perform(slot->curl);
-	finish_active_slot(slot);
-
-	if (results.curl_result != CURLE_OK) {
-		err |= error("RPC failed; result=%d, HTTP code = %ld",
-			results.curl_result, results.http_code);
-	}
+	err = run_slot(slot);
 
 	curl_slist_free_all(headers);
 	free(gzip_body);
-- 
1.7.4.rc3.268.g2af8b
