From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 21/23] http: use new http API in fetch_index()
Date: Sat, 6 Jun 2009 16:44:00 +0800
Message-ID: <20090606164400.c923729b.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcM-0004Mp-72
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbZFFIuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZFFIup
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:50:45 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34239 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbZFFIuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:50:44 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1305746pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=FKaXEIce0FN39YhdCqEtsgepWVtY35qIGOWESfci2aA=;
        b=l1ABWTj3KWwKfMqHVxp5UmzmM5zPRREJy+bgGnYEa4kidfX/VmjPexRXh+rNcuYAlt
         2QP39eOO76A5B8734Km+/GTkKTUgUKGjU+/sInrcSIFtvgbdU7txCsweGrAeC2yH3qee
         hXUBAMoHsNYQIQCtqxqGOHnjsLNCdTN7tLo0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=cyrC2ZJ8Z83gDHv0v37xNV7jygJihFgblbyG3zF9LdW3zNPNzieut5t2V0V3EOjXQA
         ygUkURrzdwmhnEVNehig9nN5liulL86Ol6nQOk9SKBqMvh3mquXUJ4S1OkuVipsJu518
         bLNy3bvGriRFbAzUQF5daB/eulpKNqbEioGK8=
Received: by 10.142.82.6 with SMTP id f6mr1633296wfb.182.1244278247326;
        Sat, 06 Jun 2009 01:50:47 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm2717722wfg.25.2009.06.06.01.50.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:46 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120899>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   81 ++++++---------------------------------------------------------
 1 files changed, 8 insertions(+), 73 deletions(-)

diff --git a/http.c b/http.c
index 96d83d5..0701a6f 100644
--- a/http.c
+++ b/http.c
@@ -798,40 +798,22 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
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
@@ -842,57 +824,10 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	url = strbuf_detach(&buf, NULL);

 	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
-	if (!indexfile) {
-		ret = error("Unable to open local file %s for pack index",
-			    tmpfile);
-		goto cleanup_pack;
-	}
+	if (http_get_file(url, filename, 0) != HTTP_OK)
+		ret = error("Unable to get pack index %s\n", url);

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
-
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
-	slot->local = NULL;
-cleanup_pack:
+cleanup:
 	free(hex);
 	free(url);
 	return ret;
--
1.6.3.1
