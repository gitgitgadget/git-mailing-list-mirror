From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 10/12] Use the new http API in http-walker.c:fetch_index()
Date: Sun, 18 Jan 2009 09:04:35 +0100
Message-ID: <1232265877-3649-11-git-send-email-mh@glandium.org>
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
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSgb-0001vc-SM
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761405AbZARIFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761160AbZARIFI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:05:08 -0500
Received: from vuizook.err.no ([85.19.221.46]:42475 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758641AbZARIEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:50 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSeB-0002Ea-FS; Sun, 18 Jan 2009 09:04:48 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yt-Rj; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-10-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106157>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-walker.c |   55 +++++--------------------------------------------------
 1 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index edcb779..bc1db2b 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -368,15 +368,7 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char *url;
-	char tmpfile[PATH_MAX];
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-	struct walker_data *data = walker->data;
-
-	FILE *indexfile;
-	struct active_request_slot *slot;
-	struct slot_results results;
+	int ret = 0;
 
 	if (has_pack_index(sha1))
 		return 0;
@@ -388,48 +380,11 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
 
 	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
-	if (!indexfile)
-		return error("Unable to open local file %s for pack index",
-			     tmpfile);
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
-	slot->local = indexfile;
-
-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
-	prev_posn = ftell(indexfile);
-	if (prev_posn>0) {
-		if (walker->get_verbosely)
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
-			fclose(indexfile);
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
-		}
-	} else {
-		fclose(indexfile);
-		return error("Unable to start request");
-	}
-
-	fclose(indexfile);
 
-	return move_temp_to_file(tmpfile, filename);
+	if (http_get_file(url, filename, 0) != HTTP_OK)
+		ret = error("Unable to get pack index %s\n", url);
+	free(url);
+	return ret;
 }
 
 static int setup_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
-- 
1.6.1.141.gb32a
