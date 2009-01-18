From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 09/12] Use the new http API in fetch_symref()
Date: Sun, 18 Jan 2009 09:04:34 +0100
Message-ID: <1232265877-3649-10-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
 <1232265877-3649-3-git-send-email-mh@glandium.org>
 <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org>
 <1232265877-3649-6-git-send-email-mh@glandium.org>
 <1232265877-3649-7-git-send-email-mh@glandium.org>
 <1232265877-3649-8-git-send-email-mh@glandium.org>
 <1232265877-3649-9-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSga-0001vc-G0
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759918AbZARIFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759387AbZARIFA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:05:00 -0500
Received: from vuizook.err.no ([85.19.221.46]:42468 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759820AbZARIEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSeB-0002EZ-Bp; Sun, 18 Jan 2009 09:04:47 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yn-Pe; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-9-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106159>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7627860..b32def4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1982,27 +1982,12 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
-	struct active_request_slot *slot;
-	struct slot_results results;
 
 	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", remote->url, path);
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			die("Couldn't get %s for remote symref\n%s",
-			    url, curl_errorstr);
-		}
-	} else {
-		die("Unable to start remote symref request");
-	}
+	if (http_get_strbuf(url, &buffer, 0) != HTTP_OK)
+		die("Couldn't get %s for remote symref\n", url);
 	free(url);
 
 	free(*symref);
-- 
1.6.1.141.gb32a
