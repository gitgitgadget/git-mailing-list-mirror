From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 04/12] Use the new http API in http_fetch_ref()
Date: Sun, 18 Jan 2009 09:04:29 +0100
Message-ID: <1232265877-3649-5-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
 <1232265877-3649-3-git-send-email-mh@glandium.org>
 <1232265877-3649-4-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfk-0001kf-5X
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760027AbZARIEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759899AbZARIEs
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:48 -0500
Received: from vuizook.err.no ([85.19.221.46]:42453 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758455AbZARIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:45 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe6-0002EU-8B; Sun, 18 Jan 2009 09:04:44 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yL-FD; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-4-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106154>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c |   33 ++++++++-------------------------
 1 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index 82534cf..0c9504b 100644
--- a/http.c
+++ b/http.c
@@ -604,34 +604,17 @@ int http_fetch_ref(const char *base, struct ref *ref)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
-	struct active_request_slot *slot;
-	struct slot_results results;
-	int ret;
+	int ret = -1;
 
 	url = quote_ref_url(base, ref->name);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK) {
-			strbuf_rtrim(&buffer);
-			if (buffer.len == 40)
-				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
-			else if (!prefixcmp(buffer.buf, "ref: ")) {
-				ref->symref = xstrdup(buffer.buf + 5);
-				ret = 0;
-			} else
-				ret = 1;
-		} else {
-			ret = error("Couldn't get %s for %s\n%s",
-				    url, ref->name, curl_errorstr);
+	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
+		strbuf_rtrim(&buffer);
+		if (buffer.len == 40)
+			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
+		else if (!prefixcmp(buffer.buf, "ref: ")) {
+			ref->symref = xstrdup(buffer.buf + 5);
+			ret = 0;
 		}
-	} else {
-		ret = error("Unable to start request");
 	}
 
 	strbuf_release(&buffer);
-- 
1.6.1.141.gb32a
