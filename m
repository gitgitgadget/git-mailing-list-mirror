From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 06/12] Use the new http API in http-walker.c:fetch_indices()
Date: Sun, 18 Jan 2009 09:04:31 +0100
Message-ID: <1232265877-3649-7-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
 <1232265877-3649-3-git-send-email-mh@glandium.org>
 <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org>
 <1232265877-3649-6-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfm-0001kf-Q6
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760874AbZARIE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760224AbZARIEx
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:53 -0500
Received: from vuizook.err.no ([85.19.221.46]:42462 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759123AbZARIEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe9-0002EX-B0; Sun, 18 Jan 2009 09:04:46 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yX-JW; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-6-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106152>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-walker.c |   31 ++++++++-----------------------
 1 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 0139d1e..edcb779 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -648,9 +648,6 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	int i = 0;
 	int ret = 0;
 
-	struct active_request_slot *slot;
-	struct slot_results results;
-
 	if (repo->got_indices)
 		return 0;
 
@@ -660,27 +657,15 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	url = xmalloc(strlen(repo->base) + 21);
 	sprintf(url, "%s/objects/info/packs", repo->base);
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			if (missing_target(&results)) {
-				repo->got_indices = 1;
-				goto cleanup;
-			} else {
-				repo->got_indices = 0;
-				ret = error("%s", curl_errorstr);
-				goto cleanup;
-			}
-		}
-	} else {
+	switch (http_get_strbuf(url, &buffer, HTTP_NO_CACHE)) {
+	case HTTP_OK:
+		break;
+	case HTTP_MISSING_TARGET:
+		repo->got_indices = 1;
+		goto cleanup;
+	default:
 		repo->got_indices = 0;
-		ret = error("Unable to start request");
+		ret = -1;
 		goto cleanup;
 	}
 
-- 
1.6.1.141.gb32a
