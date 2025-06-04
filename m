Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807E79D0
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070517; cv=none; b=lvgfpDBeOSx5msaZoX5DGhieYKA4XYoGCiZIz86eHweVKXaGGdHws+22QgG1AYsAHg5pk0KdY/MtBXHbwVHVDA7nct0PpRVRx7p8MsyMcMa2ma38BCupFFKv63EhB8zuVJk4h32fIopKAbhY2swrRnqfkvxgaDS95lYop97zC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070517; c=relaxed/simple;
	bh=VFeoUDJ/8CVB4iixr1hZLDPq9C8fBlfbjLHC7WH2zlE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n99STZFwE4olCqnbR3NXJ1vs1hUop8l4GodvmgQN0cUEGp7SZCMapikV1Ogfg/zzzXGsrV6wALJs7xl+FP/avXP/+MC2ya1FbAI7MXrNHvyfycwMumC6FEuv60gWNRMsD+e5qlLQTbIiHXYetgpcAIMFXUDEn5WGQOj2vsxiaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eP20donF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eP20donF"
Received: (qmail 14298 invoked by uid 109); 4 Jun 2025 20:55:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VFeoUDJ/8CVB4iixr1hZLDPq9C8fBlfbjLHC7WH2zlE=; b=eP20donFpI5683VF3eMom4oPst47uogIMaTzyZHN0D9/G/Jkr84xbM717hA1keVcbrLll/FN0EDqYXvjLK3fg2syfPLXFz79X20ppDndnCbsSPX51KULqFTHEuhDqM2tuMQxW2sBKIDrpcAQcEYq9g1UfDSslkAn/b40TpFoI6K2shdUi1yUxLZihWCgolMUmCxgIwJ4/JvmPP0sb9P7icfy5d0+uxy86oX/kfI7BBw5ovZSubzDKCWLKE5P4QUiPwYpgmuWnwdmzKKm0yLUIv/lhqq/tv43bw7JKDaUcCyPZopCZ406Bzx/h6hA4+szgxidpZiRo/+O1IkevmdcOQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jun 2025 20:55:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13759 invoked by uid 111); 4 Jun 2025 20:55:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jun 2025 16:55:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Jun 2025 16:55:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/3] curl: fix integer constant typechecks with
 curl_easy_setopt()
Message-ID: <20250604205513.GA1510819@coredump.intra.peff.net>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604205505.GA1510724@coredump.intra.peff.net>

The curl documentation specifies that curl_easy_setopt() takes either:

  ...a long, a function pointer, an object pointer or a curl_off_t,
  depending on what the specific option expects.

But when we pass an integer constant like "0", it will by default be a
regular non-long int. This has always been wrong, but seemed to work in
practice (I didn't dig into curl's implementation to see whether this
might actually be triggering undefined behavior, but it seems likely and
regardless we should do what the docs say).

This is especially important since curl has a type-checking macro that
causes building against curl 8.14 to produce many warnings. The specific
commit is due to their 79b4e56b3 (typecheck-gcc.h: fix the typechecks,
2025-04-22). Curiously, it does only seem to trigger when compiled with
-O2 for me.

We can fix it by just marking the constants with a long "L".

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c   |  2 +-
 http.c        | 14 +++++++-------
 remote-curl.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/http-push.c b/http-push.c
index f9e67cabd4..591e46ab26 100644
--- a/http-push.c
+++ b/http-push.c
@@ -195,7 +195,7 @@ static char *xml_entities(const char *s)
 static void curl_setup_http_get(CURL *curl, const char *url,
 		const char *custom_req)
 {
-	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_null);
diff --git a/http.c b/http.c
index 3c029cf894..cce2ea7287 100644
--- a/http.c
+++ b/http.c
@@ -1019,13 +1019,13 @@ static CURL *get_curl_handle(void)
 		die("curl_easy_init failed");
 
 	if (!curl_ssl_verify) {
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0L);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0L);
 	} else {
 		/* Verify authenticity of the peer's certificate */
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1L);
 		/* The name in the cert must match whom we tried to connect */
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
 	}
 
     if (curl_http_version) {
@@ -1117,7 +1117,7 @@ static CURL *get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
-	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
+	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20L);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
 
 #ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
@@ -1151,7 +1151,7 @@ static CURL *get_curl_handle(void)
 		user_agent ? user_agent : git_user_agent());
 
 	if (curl_ftp_no_epsv)
-		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
+		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0L);
 
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
@@ -1254,7 +1254,7 @@ static CURL *get_curl_handle(void)
 	}
 	init_curl_proxy_auth(result);
 
-	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
+	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1L);
 
 	if (curl_tcp_keepidle > -1)
 		curl_easy_setopt(result, CURLOPT_TCP_KEEPIDLE,
diff --git a/remote-curl.c b/remote-curl.c
index 590b228f67..6183772191 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -877,12 +877,12 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
 
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4L);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
-- 
2.50.0.rc1.276.g7db1193dde

