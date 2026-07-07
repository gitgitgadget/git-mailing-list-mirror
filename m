Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC22EEE61
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400897; cv=none; b=sC2ot7KkltdQSbXji+FOVplTvHQ9pcte2h+GI1uH7gOxJQy2yYoWw2/qvmogL5v13LjPMZ6NybtQGNR2EjCQDzKndjg1kZQ0KEP1lJOHkUIXWlUs1mY37B7gifRF3T19Q81QCcnDpjYLmIw9Hdhf/ARA1joOXHsVdpXYueNzfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400897; c=relaxed/simple;
	bh=dESNdydcSfYbQAUjrTjFnCUd4atI8/HYuBHny/ZpfkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKtilDmXI7uOSRa8rnlPS24CsL3bTfG0OGxyDkqgOUOBv/Svy17oDq1RpXE3EzVCxnsTuKBkgFqPBKqxSrq6vvCc09QPKlGVk3C9vEwscPpsJix/Vv+AALw9Zo4fLNnqqxawDmMJf+/ZeCrkNoVzrciaWm579/5E4X4YSgz36TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DnZeQcgu; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DnZeQcgu"
Received: (qmail 17548 invoked by uid 106); 7 Jul 2026 05:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dESNdydcSfYbQAUjrTjFnCUd4atI8/HYuBHny/ZpfkU=; b=DnZeQcgu+D/3R1oaEHR/9f2eMbN3ChhUPsiXONY2+hJ2gC5E2WR3GTpv1gdpS/qNQJjij1agRZlRxDeukN9B44y/7AdHfzTE54KTqkhY44QIXKn3pTpJSy05A8m8PviyXWoCIIeq/C2poUAsBO9ZhqZwYQpJSUad/T3UmUCbbLg9kPjJFsFwg2EqqfxpA1Jlcf1Hkr3H5c+cJARqmOeyHSqr9pFvcEOylNThTH+hgcJj2aIreiRjwdB/CcmbP+d8QOUWwIwMLMQVxr48Or5Ug1qmivBh06XsPKTOGm/UmZMFmoxh6riFu8JBy+x9hGO8MTIeKFZFD9GAOnLRKCEc8Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 05:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22519 invoked by uid 111); 7 Jul 2026 05:08:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 01:08:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 01:08:14 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 6/7] http: use idempotent git_hash_discard()
Message-ID: <20260707050814.GF1288294@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707045556.GA1288172@coredump.intra.peff.net>

Now that it is OK to call git_hash_discard() even after finalizing the
hash, we no longer need the ctx_valid bool added by a2d8ea5a76 (http:
discard hash in dumb-http http_object_request, 2026-07-02).

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 5 +----
 http.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 0341de5031..caccf2108e 100644
--- a/http.c
+++ b/http.c
@@ -2880,7 +2880,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	git_inflate_init(&freq->stream);
 
 	git_hash_init(&freq->c, the_hash_algo);
-	freq->hash_ctx_valid = 1;
 
 	freq->url = get_remote_object_url(base_url, hex, 0);
 
@@ -2989,7 +2988,6 @@ int finish_http_object_request(struct http_object_request *freq)
 	}
 
 	git_hash_final_oid(&freq->real_oid, &freq->c);
-	freq->hash_ctx_valid = 0;
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
@@ -3030,8 +3028,7 @@ void release_http_object_request(struct http_object_request **freq_p)
 	curl_slist_free_all(freq->headers);
 	strbuf_release(&freq->tmpfile);
 	git_inflate_end(&freq->stream);
-	if (freq->hash_ctx_valid)
-		git_hash_discard(&freq->c);
+	git_hash_discard(&freq->c);
 
 	free(freq);
 	*freq_p = NULL;
diff --git a/http.h b/http.h
index 6b0639150f..729c51904d 100644
--- a/http.h
+++ b/http.h
@@ -255,7 +255,6 @@ struct http_object_request {
 	struct object_id oid;
 	struct object_id real_oid;
 	struct git_hash_ctx c;
-	int hash_ctx_valid;
 	git_zstream stream;
 	int zret;
 	int rename;
-- 
2.55.0.459.g1b256877c9

