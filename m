From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/2] Fix some more memory leaks in http-push.c
Date: Fri, 14 Dec 2007 22:18:00 +0100
Message-ID: <1197667081-9909-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 22:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3HvS-00026z-MY
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 22:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbXLNVSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 16:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbXLNVSG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 16:18:06 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:36838 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbXLNVSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 16:18:05 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2817.orange.fr (SMTP Server) with ESMTP id 6DFB17000098
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 22:18:02 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-17-136.w82-124.abo.wanadoo.fr [82.124.59.136])
	by mwinf2817.orange.fr (SMTP Server) with ESMTP id 4D4FC7000096;
	Fri, 14 Dec 2007 22:18:02 +0100 (CET)
X-ME-UUID: 20071214211802316.4D4FC7000096@mwinf2817.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J3Huz-0002a8-HF; Fri, 14 Dec 2007 22:18:01 +0100
X-Mailer: git-send-email 1.5.4.rc0.8.gbf4af-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68347>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index fffbe9c..fc60bfd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -925,11 +925,14 @@ static int fetch_index(unsigned char *sha1)
 				     hex);
 		}
 	} else {
+		free(url);
 		return error("Unable to start request");
 	}
 
-	if (has_pack_index(sha1))
+	if (has_pack_index(sha1)) {
+		free(url);
 		return 0;
+	}
 
 	if (push_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
@@ -939,9 +942,11 @@ static int fetch_index(unsigned char *sha1)
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
 	indexfile = fopen(tmpfile, "a");
-	if (!indexfile)
+	if (!indexfile) {
+		free(url);
 		return error("Unable to open local file %s for pack index",
 			     tmpfile);
+	}
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -1135,10 +1140,12 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
+		free(url);
 		if (results.curl_result != CURLE_OK)
 			return error("Couldn't get %s for %s\n%s",
 				     url, ref, curl_errorstr);
 	} else {
+		free(url);
 		return error("Unable to start request");
 	}
 
@@ -2107,6 +2114,7 @@ static int remote_exists(const char *path)
 
         if (start_active_slot(slot)) {
 		run_active_slot(slot);
+		free(url);
 		if (results.http_code == 404)
 			return 0;
 		else if (results.curl_result == CURLE_OK)
@@ -2114,6 +2122,7 @@ static int remote_exists(const char *path)
 		else
 			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
 	} else {
+		free(url);
 		fprintf(stderr, "Unable to start HEAD request\n");
 	}
 
-- 
1.5.4.rc0.8.gbf4af-dirty
