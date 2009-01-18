From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 07/12] Use the new http API in http-push.c:fetch_indices()
Date: Sun, 18 Jan 2009 09:04:32 +0100
Message-ID: <1232265877-3649-8-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
 <1232265877-3649-3-git-send-email-mh@glandium.org>
 <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org>
 <1232265877-3649-6-git-send-email-mh@glandium.org>
 <1232265877-3649-7-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfo-0001kf-TX
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758965AbZARIFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761028AbZARIE7
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:59 -0500
Received: from vuizook.err.no ([85.19.221.46]:42464 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759251AbZARIEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe9-0002EW-BD; Sun, 18 Jan 2009 09:04:46 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000ye-L9; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-7-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106155>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |   32 +++++++-------------------------
 1 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/http-push.c b/http-push.c
index e69179b..e0b4f5a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1008,9 +1008,7 @@ static int fetch_indices(void)
 	struct strbuf buffer = STRBUF_INIT;
 	char *data;
 	int i = 0;
-
-	struct active_request_slot *slot;
-	struct slot_results results;
+	int ret = 0;
 
 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");
@@ -1018,28 +1016,10 @@ static int fetch_indices(void)
 	url = xmalloc(strlen(remote->url) + 20);
 	sprintf(url, "%sobjects/info/packs", remote->url);
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			strbuf_release(&buffer);
-			free(url);
-			if (results.http_code == 404)
-				return 0;
-			else
-				return error("%s", curl_errorstr);
-		}
-	} else {
-		strbuf_release(&buffer);
-		free(url);
-		return error("Unable to start request");
+	if (http_get_strbuf(url, &buffer, 0) != HTTP_OK) {
+		ret = -1;
+		goto cleanup;
 	}
-	free(url);
 
 	data = buffer.buf;
 	while (i < buffer.len) {
@@ -1061,8 +1041,10 @@ static int fetch_indices(void)
 		i++;
 	}
 
+cleanup:
 	strbuf_release(&buffer);
-	return 0;
+	free(url);
+	return ret;
 }
 
 static void one_remote_object(const char *hex)
-- 
1.6.1.141.gb32a
