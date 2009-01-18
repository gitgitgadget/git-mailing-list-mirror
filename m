From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 12/12] Use the new http API in http-walker.c:fetch_pack()
Date: Sun, 18 Jan 2009 09:04:37 +0100
Message-ID: <1232265877-3649-13-git-send-email-mh@glandium.org>
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
 <1232265877-3649-12-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSgd-0001vc-75
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761584AbZARIFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758455AbZARIFO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:05:14 -0500
Received: from vuizook.err.no ([85.19.221.46]:42480 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760067AbZARIEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:51 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSeB-0002Ec-KL; Sun, 18 Jan 2009 09:04:49 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000z6-W9; Sun, 18 Jan 2009 09:04:38 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-12-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106161>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-walker.c |   54 ++++--------------------------------------------------
 1 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index bc1db2b..c201463 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -656,17 +656,8 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	char *url;
 	struct packed_git *target;
 	struct packed_git **lst;
-	FILE *packfile;
 	char *filename;
-	char tmpfile[PATH_MAX];
-	int ret;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-	struct walker_data *data = walker->data;
-
-	struct active_request_slot *slot;
-	struct slot_results results;
+	int ret = 0;
 
 	if (fetch_indices(walker, repo))
 		return -1;
@@ -686,48 +677,11 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 		repo->base, sha1_to_hex(target->sha1));
 
 	filename = sha1_pack_name(target->sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	packfile = fopen(tmpfile, "a");
-	if (!packfile)
-		return error("Unable to open local file %s for pack",
-			     tmpfile);
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
-	slot->local = packfile;
-
-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
-	prev_posn = ftell(packfile);
-	if (prev_posn>0) {
-		if (walker->get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of pack %s at byte %ld\n",
-				sha1_to_hex(target->sha1), prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
 
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			fclose(packfile);
-			return error("Unable to get pack file %s\n%s", url,
-				     curl_errorstr);
-		}
-	} else {
-		fclose(packfile);
-		return error("Unable to start request");
-	}
-
-	fclose(packfile);
+	if (http_get_file(url, filename, 0) != HTTP_OK)
+		ret = error("Unable to get pack file %s\n", url);
+	free(url);
 
-	ret = move_temp_to_file(tmpfile, filename);
 	if (ret)
 		return ret;
 
-- 
1.6.1.141.gb32a
