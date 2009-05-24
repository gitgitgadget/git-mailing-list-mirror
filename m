From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 16/18] http: use new http API in fetch_index()
Date: Sun, 24 May 2009 22:20:05 +0800
Message-ID: <20090524222005.4af6a2bd.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ec5-0006Oo-Bq
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZEXOWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbZEXOWa
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:30 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55668 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbZEXOW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:29 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so2113664pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=e70892hYcA9LD2yhRR0dA+SO5jVcnXYvtID+QKPYLoA=;
        b=Zl7U8eFn8i6X7Zj3QA3GiL4KPpkhDjogainRUlXpvcrYh6tdn05HNRsGULQRUYgMxg
         jtSwYMCIG0eUfL8plJNrNJ0YI1+vDo6So2Er9ZJZzqaL3bpoT6iK/YKQGyyOAltN7e3W
         S8fE5zO3ECqNYbU8YPcbIMh6ZJ0SkVvduUQ9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BvwSm0KxXnL9UAGE7hXmqLTP5D14tdULv2MGx8tc5fWy2l49PzTpj1+obKx+jkRlQR
         x+v1pr/3XhmK/QfE5YEDS9DYcIIh/7y5x9loOgvSTMwRw2l6e8ipzZE3GJEDoAtuwBPW
         gskLKBOQIzqmvR743IwmAgzZD6y47rXYm+xyg=
Received: by 10.114.147.1 with SMTP id u1mr12450907wad.115.1243174951775;
        Sun, 24 May 2009 07:22:31 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id l30sm12236871waf.0.2009.05.24.07.22.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:31 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119837>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   80 ++++++---------------------------------------------------------
 1 files changed, 8 insertions(+), 72 deletions(-)

diff --git a/http.c b/http.c
index ea46075..c3f7456 100644
--- a/http.c
+++ b/http.c
@@ -797,40 +797,22 @@ static int fetch_index(unsigned char *sha1, const char *base_url)
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
@@ -841,56 +823,10 @@ static int fetch_index(unsigned char *sha1, const char *base_url)
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
