From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 15/17] http: use new http API in fetch_index()
Date: Sat, 30 May 2009 01:59:41 +0800
Message-ID: <20090530015941.8dc50007.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6PB-0000Xl-Hg
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760275AbZE2SBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760223AbZE2SBd
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:01:33 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:53739 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760254AbZE2SBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:01:31 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1678194pxi.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=PXoXbV8pWg47FGoPO/6VpmYLpK7HgQhcR1Nd2ToOUg0=;
        b=Jae1/T4oqkWQSdDDTnH57xMja2yzZvwS6Be/w1I1io0XG+JEIsJKkklBl0TVyim1i+
         hP99j6LObfZmdLGHY8gi6C3ALQmG/bkmAMzxf7Cxeao48SGWh5z1u/WJixBR6OI2gJxd
         5V2khrXrK9sGYrcessg39CYtQ/v/F9Vn5BQB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Y7kn7740k/ZWfrxCK75yxeSedRqjulON+rLUfQxnd5wD6yV9lYcyV90Wt0Q2HW/TCv
         HDGp3BnlZC55YQqvII05qg2V95BKFbkTdsH1UaCFF9DOUrRhXP0YFZVNKokNnlXUxogy
         MwuHPz6ZjOJOmVB/uNVm9DQOfOj9N69keezBM=
Received: by 10.114.106.13 with SMTP id e13mr4436094wac.87.1243620093715;
        Fri, 29 May 2009 11:01:33 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id m17sm2510699waf.33.2009.05.29.11.01.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:01:33 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120300>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   80 ++++++---------------------------------------------------------
 1 files changed, 8 insertions(+), 72 deletions(-)

diff --git a/http.c b/http.c
index ba980c8..f123094 100644
--- a/http.c
+++ b/http.c
@@ -797,40 +797,22 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
 	char *url;
-	char tmpfile[PATH_MAX];
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
 	struct strbuf buf = STRBUF_INIT;
-	struct curl_slist *range_header = NULL;
-
-	FILE *indexfile;
-	struct active_request_slot *slot;
-	struct slot_results results;

 	/* Don't use the index if the pack isn't there */
 	end_url_with_slash(&buf, base_url);
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack", hex);
 	url = strbuf_detach(&buf, 0);

-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			ret = error("Unable to verify pack %s is available",
-				    hex);
-			goto cleanup_pack;
-		}
-	} else {
-		ret = error("Unable to start request");
-		goto cleanup_pack;
+	if (http_get_strbuf(url, NULL, 0)) {
+		ret = error("Unable to verify pack %s is available",
+			    hex);
+		goto cleanup;
 	}

 	if (has_pack_index(sha1)) {
 		ret = 0;
-		goto cleanup_pack;
+		goto cleanup;
 	}

 	if (http_is_verbose)
@@ -841,56 +823,10 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	url = strbuf_detach(&buf, NULL);

 	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
-	if (!indexfile) {
-		ret = error("Unable to open local file %s for pack index",
-			    tmpfile);
-		goto cleanup_pack;
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
-	/*
-	 * If there is data present from a previous transfer attempt,
-	 * resume where it left off
-	 */
-	prev_posn = ftell(indexfile);
-	if (prev_posn>0) {
-		if (http_is_verbose)
-			fprintf(stderr,
-				"Resuming fetch of index for pack %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
+	if (http_get_file(url, filename, 0) != HTTP_OK)
+		ret = error("Unable to get pack index %s\n", url);

-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			ret = error("Unable to get pack index %s\n%s",
-				    url, curl_errorstr);
-			goto cleanup_index;
-		}
-	} else {
-		ret = error("Unable to start request");
-		goto cleanup_index;
-	}
-
-	ret = move_temp_to_file(tmpfile, filename);
-
-cleanup_index:
-	fclose(indexfile);
-cleanup_pack:
+cleanup:
 	free(hex);
 	free(url);
 	return ret;
--
1.6.3.1
