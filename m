From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 03/11] http-walker: verify remote packs
Date: Sat, 16 May 2009 11:51:32 +0800
Message-ID: <20090516115132.c371d40b.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5B0S-0005js-4O
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbZEPDz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756108AbZEPDzZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:25 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:61221 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbZEPDzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:20 -0400
Received: by mail-pz0-f115.google.com with SMTP id 13so1344167pzk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ICCJwxo+lurS+dDyZsODilquMWxMZIFdLkXMnsj0rMM=;
        b=DJf4CexdDeQVl3GCNTTHimuQSMSzKIaEH+QITBEoYnkU8FknInylnv0ViFN+knMOKf
         1bouyHhupg4U00cZES/wdUhYUBs2IW9EqAf7DrCe8JAUsbN1oZAiIRsNa85xy+9TNovO
         azQBDgZbYK3ImxaPBOYDJESFryMkosPDBHMFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=Z5yzhTlkRDJbFGs6PX5Apvk/1xqJ2SJaGvRJQKRnr62Io7pSgCCA82sWRusH0pHgAx
         kWLqOsyXN1V8ODOOSy1miMEEF9fBC7X8JbQpR+9O9UHrpCUPXG5qivgv9/yfcV3Iy63o
         w9nysZ56IMvAIPBYFNlwxAaBQFVusuwA0T4Dc=
Received: by 10.114.202.15 with SMTP id z15mr6173376waf.67.1242446121786;
        Fri, 15 May 2009 20:55:21 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id v25sm2138987wah.32.2009.05.15.20.55.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:21 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119325>

In c17fb6e ("Verify remote packs, speed up pending request queue"),
changes were made to index fetching in http-push.c, particularly the
methods fetch_index and setup_index. Since http-walker.c has similar
code for index fetching, these improvements should apply to
http-walker.c's fetch_index and setup_index.

Invocations of free() of string memory are reproduced as well.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-walker.c |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 4cc760b..cf46adb 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -384,24 +384,48 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	struct active_request_slot *slot;
 	struct slot_results results;
 
-	if (has_pack_index(sha1))
+	/* Don't use the index if the pack isn't there */
+	url = xmalloc(strlen(repo->base) + 64);
+	sprintf(url, "%s/objects/pack/pack-%s.pack", repo->base, hex);
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			free(url);
+			return error("Unable to verify pack %s is available",
+				     hex);
+		}
+	} else {
+		free(url);
+		return error("Unable to start request");
+	}
+
+	if (has_pack_index(sha1)) {
+		free(url);
 		return 0;
+	}
 
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
 
-	url = xmalloc(strlen(repo->base) + 64);
 	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
 
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
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -426,15 +450,18 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
+			free(url);
 			fclose(indexfile);
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
+		free(url);
 		fclose(indexfile);
 		return error("Unable to start request");
 	}
 
+	free(url);
 	fclose(indexfile);
 
 	return move_temp_to_file(tmpfile, filename);
-- 
1.6.3.rc0
