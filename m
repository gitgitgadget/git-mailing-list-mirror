Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49D225775
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482785; cv=none; b=TM/vu++rYyWEAtULoiLa1eRctSakn783hT5MhP7r8VB142YgK9MRaSLPYUyZWmzAhbHXy2b02Ts6Ul2u5xFQnLKnMOCfibZnDb/RPk+ldkjaBvn5OwIyf3HeQiXW4R22kxyOCKSsbyxoYaGgo2aUi51tPcoRb3oWMnIJE+muuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482785; c=relaxed/simple;
	bh=dESNdydcSfYbQAUjrTjFnCUd4atI8/HYuBHny/ZpfkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1/Ro7jfKefyZN/QS1Zgugm0jUQ7Yb6t/9NsoIqYy6qfdaeHTPEo8gluO3Kysg/Q5+OAeZ+Jp7vLiJM2/plvblQyQfOUY+uL24AYzJOIGljaot4JXST5nis2qydsfbXCuE/H57YQx/Px+Nu1dOCmsT7SWOaOjQEDiLC4Limo9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HOm0r5FS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HOm0r5FS"
Received: (qmail 25463 invoked by uid 106); 8 Jul 2026 03:53:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dESNdydcSfYbQAUjrTjFnCUd4atI8/HYuBHny/ZpfkU=; b=HOm0r5FSrJDx++F6T9Bsh+h527S8mwAgzgYTXOj5/ARBXzMNsTIYl0muKgWJSGMxQN3HzKboanxCmtfmvb1dzKr2y5DfdPFTF62BnvQqdN/UAApUi9QxkIFqnQHHKwXf8erWhHLTtucgKCi0pyvXbHu8LJmG5W4Uy4hXPGDiFtCWKPwdkX6bDVV0Dfy9iTQ7lJgxuHp2i34T9HnWuOF9Yur4Ofb6MdH2tss6R3QhjgxiPP6H/KkqBr76iy+Fi8MPmGPRrkUTUTSOajXaHBOHFcdIZxrk7z7EgnyXTBz6nBmcgyKzm0QNmEitOLiQltFPxMUcsWd78haKsJRDSmRwlA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:53:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 41017 invoked by uid 111); 8 Jul 2026 03:53:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:53:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:53:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] http: use idempotent git_hash_discard()
Message-ID: <20260708035302.GF41620@coredump.intra.peff.net>
References: <20260708035235.GA41491@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708035235.GA41491@coredump.intra.peff.net>

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

