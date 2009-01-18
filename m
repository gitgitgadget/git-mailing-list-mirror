From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 05/12] Use the new http API in get_refs_via_curl()
Date: Sun, 18 Jan 2009 09:04:30 +0100
Message-ID: <1232265877-3649-6-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
 <1232265877-3649-3-git-send-email-mh@glandium.org>
 <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfo-0001kf-6c
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151AbZARIFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760502AbZARIEz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:55 -0500
Received: from vuizook.err.no ([85.19.221.46]:42459 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758965AbZARIEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:47 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe6-0002EV-98; Sun, 18 Jan 2009 09:04:45 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yP-HO; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-5-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106156>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport.c |   27 ++++-----------------------
 1 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/transport.c b/transport.c
index 6919ff1..55bf274 100644
--- a/transport.c
+++ b/transport.c
@@ -432,9 +432,6 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	char *refs_url;
 	int i = 0;
 
-	struct active_request_slot *slot;
-	struct slot_results results;
-
 	struct ref *refs = NULL;
 	struct ref *ref = NULL;
 	struct ref *last_ref = NULL;
@@ -450,26 +447,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	refs_url = xmalloc(strlen(transport->url) + 11);
 	sprintf(refs_url, "%s/info/refs", transport->url);
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, refs_url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			strbuf_release(&buffer);
-			if (missing_target(&results))
-				die("%s not found: did you run git update-server-info on the server?", refs_url);
-			else
-				die("%s download error - %s", refs_url, curl_errorstr);
-		}
-	} else {
-		strbuf_release(&buffer);
-		die("Unable to start HTTP request");
-	}
+	if (http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE) != HTTP_OK)
+		goto cleanup;
 
 	data = buffer.buf;
 	start = NULL;
@@ -508,6 +487,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 		free(ref);
 	}
 
+cleanup:
+	strbuf_release(&buffer);
 	http_cleanup();
 	free(refs_url);
 	return refs;
-- 
1.6.1.141.gb32a
