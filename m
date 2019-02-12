Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1951F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBLBXm (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34342 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbfBLBXi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:38 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C63E60E59;
        Tue, 12 Feb 2019 01:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934617;
        bh=IIAQhUwViuOnvBSSz5YI0UAy07LU+dsMBhJXScJ5C68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=b8LR1rO+8ziV9EeyyRzKsDeHftJeCHzT9x0QWcyQMqHQItssDy2rdBKg20QXIVezO
         4qpfZCNfDTslU+ce8ddeL05nBInVAFxPiIB6V7h8Aiz4wHTwRj4RprAtLGHoQpPi8t
         IKPYHyCImD2kKINzobx9cyOzsPRRWA+U2CSaNQy9QdVLXJB1EvP5SEMTYIDHwP0FYX
         bw40QloXAbE1mqjMD1x4htcanPiQQYVklCMYVax2uHjvHKakdsph5T+vV8FlfHLRry
         h64wQjnu1kqKxSWrx4WGR2oPrPSQqqwAADPOGYyfPkrKuwM8/zM9OCoswE14z1fddL
         8pI+b8RG8U0lJgf8yLHotLfUu+BO5CkmAtBsiQWpy/bqHiPzyVTXS30hV4h+JKfXrw
         c1xk6TS+USlkW1PDmcCN7EmgXSMvbQ/HXW6tIFvLVf1W2jxFKMr+weDVlE3hnbhJAH
         QPKVCUvJtLDCpWVbMmTqlLXTmeJ70BM3Q9UoZu3Q4qBZt7mN1t2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 21/31] http: compute hash of downloaded objects using the_hash_algo
Date:   Tue, 12 Feb 2019 01:22:46 +0000
Message-Id: <20190212012256.1005924-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c | 10 +++++-----
 http.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 993ddc956a..458d07fabb 100644
--- a/http.c
+++ b/http.c
@@ -2337,8 +2337,8 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		freq->stream.next_out = expn;
 		freq->stream.avail_out = sizeof(expn);
 		freq->zret = git_inflate(&freq->stream, Z_SYNC_FLUSH);
-		git_SHA1_Update(&freq->c, expn,
-				sizeof(expn) - freq->stream.avail_out);
+		the_hash_algo->update_fn(&freq->c, expn,
+					 sizeof(expn) - freq->stream.avail_out);
 	} while (freq->stream.avail_in && freq->zret == Z_OK);
 	return size;
 }
@@ -2396,7 +2396,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 
 	git_inflate_init(&freq->stream);
 
-	git_SHA1_Init(&freq->c);
+	the_hash_algo->init_fn(&freq->c);
 
 	freq->url = get_remote_object_url(base_url, hex, 0);
 
@@ -2431,7 +2431,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	if (prev_read == -1) {
 		memset(&freq->stream, 0, sizeof(freq->stream));
 		git_inflate_init(&freq->stream);
-		git_SHA1_Init(&freq->c);
+		the_hash_algo->init_fn(&freq->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(freq->localfile, 0, SEEK_SET);
@@ -2502,7 +2502,7 @@ int finish_http_object_request(struct http_object_request *freq)
 	}
 
 	git_inflate_end(&freq->stream);
-	git_SHA1_Final(freq->real_oid.hash, &freq->c);
+	the_hash_algo->final_fn(freq->real_oid.hash, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
diff --git a/http.h b/http.h
index 4eb4e808e5..10d3cfdb80 100644
--- a/http.h
+++ b/http.h
@@ -225,7 +225,7 @@ struct http_object_request {
 	long http_code;
 	struct object_id oid;
 	struct object_id real_oid;
-	git_SHA_CTX c;
+	git_hash_ctx c;
 	git_zstream stream;
 	int zret;
 	int rename;
