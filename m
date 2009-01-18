From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 08/12] Use the new http API in update_remote_info_refs()
Date: Sun, 18 Jan 2009 09:04:33 +0100
Message-ID: <1232265877-3649-9-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
 <1232265877-3649-3-git-send-email-mh@glandium.org>
 <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org>
 <1232265877-3649-6-git-send-email-mh@glandium.org>
 <1232265877-3649-7-git-send-email-mh@glandium.org>
 <1232265877-3649-8-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSgb-0001vc-5U
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761290AbZARIFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760502AbZARIFE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:05:04 -0500
Received: from vuizook.err.no ([85.19.221.46]:42466 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759799AbZARIEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe9-0002EY-CS; Sun, 18 Jan 2009 09:04:46 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yk-NM; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-8-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106158>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/http-push.c b/http-push.c
index e0b4f5a..7627860 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1960,29 +1960,20 @@ static void update_remote_info_refs(struct remote_lock *lock)
 static int remote_exists(const char *path)
 {
 	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
-	struct active_request_slot *slot;
-	struct slot_results results;
-	int ret = -1;
+	int ret;
 
 	sprintf(url, "%s%s", remote->url, path);
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.http_code == 404)
-			ret = 0;
-		else if (results.curl_result == CURLE_OK)
-			ret = 1;
-		else
-			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
-	} else {
-		fprintf(stderr, "Unable to start HEAD request\n");
+	switch (http_get_strbuf(url, NULL, 0)) {
+	case HTTP_OK:
+		ret = 1;
+		break;
+	case HTTP_MISSING_TARGET:
+		ret = 0;
+		break;
+	default:
+		ret = -1;
 	}
-
 	free(url);
 	return ret;
 }
-- 
1.6.1.141.gb32a
