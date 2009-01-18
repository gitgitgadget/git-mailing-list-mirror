From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 11/12] Use the new http API in http-push.c:fetch_index()
Date: Sun, 18 Jan 2009 09:04:36 +0100
Message-ID: <1232265877-3649-12-git-send-email-mh@glandium.org>
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
 <1232265877-3649-10-git-send-email-mh@glandium.org>
 <1232265877-3649-11-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSgc-0001vc-Hh
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761555AbZARIFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761160AbZARIFM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:05:12 -0500
Received: from vuizook.err.no ([85.19.221.46]:42477 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758455AbZARIEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:50 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSeB-0002Eb-G1; Sun, 18 Jan 2009 09:04:48 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000z2-Tp; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-11-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106160>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |   76 ++++++----------------------------------------------------
 1 files changed, 8 insertions(+), 68 deletions(-)

diff --git a/http-push.c b/http-push.c
index b32def4..0812f58 100644
--- a/http-push.c
+++ b/http-push.c
@@ -898,32 +898,15 @@ static int fetch_index(unsigned char *sha1)
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char *url;
-	char tmpfile[PATH_MAX];
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-
-	FILE *indexfile;
-	struct active_request_slot *slot;
-	struct slot_results results;
+	int ret = 0;
 
 	/* Don't use the index if the pack isn't there */
 	url = xmalloc(strlen(remote->url) + 64);
 	sprintf(url, "%sobjects/pack/pack-%s.pack", remote->url, hex);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			free(url);
-			return error("Unable to verify pack %s is available",
-				     hex);
-		}
-	} else {
+	if (http_get_strbuf(url, NULL, 0)) {
 		free(url);
-		return error("Unable to start request");
+		return error("Unable to verify pack %s is available",
+			     hex);
 	}
 
 	if (has_pack_index(sha1)) {
@@ -937,55 +920,12 @@ static int fetch_index(unsigned char *sha1)
 	sprintf(url, "%sobjects/pack/pack-%s.idx", remote->url, hex);
 
 	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
-	if (!indexfile) {
-		free(url);
-		return error("Unable to open local file %s for pack index",
-			     tmpfile);
-	}
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	slot->local = indexfile;
-
-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
-	prev_posn = ftell(indexfile);
-	if (prev_posn>0) {
-		if (push_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of index for pack %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			free(url);
-			fclose(indexfile);
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
-		}
-	} else {
-		free(url);
-		fclose(indexfile);
-		return error("Unable to start request");
-	}
 
+	if (http_get_file(url, filename, 0) != HTTP_OK)
+		ret = error("Unable to get pack index %s\n", url);
+	free(filename);
 	free(url);
-	fclose(indexfile);
-
-	return move_temp_to_file(tmpfile, filename);
+	return ret;
 }
 
 static int setup_index(unsigned char *sha1)
-- 
1.6.1.141.gb32a
