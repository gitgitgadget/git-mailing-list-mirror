Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840722904
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312183; cv=none; b=b0HIEXGqMq+rroOXE3l4DAZTDaj9KryEeGt5eAIPSjhZGOrt9GX5YtlsjOISHwP78medKfFPkOB3gWKKdepZTS0n/0M5TyjE9GqYDYvwlF2Qh6sgaCqR12H1HjEXvZHt/Ju4KhAunMQFTj/S3kBMF2VeNW/hvdNkH3M4IMfT4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312183; c=relaxed/simple;
	bh=r2cEH9gJw6DRewoR5EcFUlQwCcobEMlk5fkACL07Djs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FntNZHy23KbMFeBvQn/J5WsGiwCzKmLyhM1BhXLZ1n315NGTumyJA3hmdXLGQZPwScOK5Lhwv+TBoSkR8DLRibYYlzWuUMj6muPr1GAXldvSK4gxY6Uj/3VZJhmSjBKEWewjE5KMQ9OswWskGkQakz6ysczHdzbxSenTCsygr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UiikIxwv; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UiikIxwv"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 10C1A5D4E4;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=r2cEH9gJw6DRewoR5EcFUlQwCcobEMlk5fkACL07Djs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=UiikIxwvQ4Svf4iFkD+7CvQLxSQ2CDPB8nppNr4ypuUZRYBd6vWW6eOc/XtBGqHQQ
	 k6l6+3KgxwSYlgAlHCWg9DbBsdXHYooZ6YM7oJbnU6P/bfCHW7IR3NEScNSUOrarkE
	 fNhHHGFenGsvMDhFp7HBURTzLTZcvoxRyUqZiA60cml5J4Q/jAemqD/NYk722MQKhZ
	 94Ep8em9olDcGEuyqhM+XgaYjxpneMlIFdxCTIIt4gLJZJY/EVsgPRYZcPM/sBHH3c
	 CtEG3vCe7kb2Hn6bXvaKEXVWl0G9eIDehsNpDJIlOX9qTFJwoBjX0bJdpCieP+tmHj
	 SQroaHHdUxvXWq3DND8/SNcXGXMNfT8V663dTx+/5FDHPv2/W+EBj4A2VhASrunufR
	 RfthogZf5Nzc4NA/06ZGKr2JIJNUOqAMdA+hK3hV5Xpg+S3m3K/3S8UDS8XGVFosFx
	 Cb3kbCKDrS4hBY6X+QefH8t7cZ9NkXXpB32vncFRIbZXDd8FqKU
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 03/16] http: use new headers for each object request
Date: Wed, 17 Apr 2024 00:02:27 +0000
Message-ID: <20240417000240.3611948-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240417000240.3611948-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240417000240.3611948-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we create one set of headers for all object requests and reuse
it.  However, we'll need to adjust the headers for authentication
purposes in the future, so let's create a new set for each request so
that we can adjust them if the authentication changes.

Note that the cost of allocation here is tiny compared to the fact that
we're making a network call, not to mention probably a full TLS
connection, so this shouldn't have a significant impact on performance.
Moreover, nobody who cares about performance is using the dumb HTTP
protocol anyway, since it often makes huge numbers of requests compared
to the smart protocol.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c | 20 +++++++++++---------
 http.h |  2 ++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index e73b136e58..22639b0974 100644
--- a/http.c
+++ b/http.c
@@ -128,7 +128,6 @@ static unsigned long empty_auth_useless =
 	| CURLAUTH_DIGEST;
 
 static struct curl_slist *pragma_header;
-static struct curl_slist *no_pragma_header;
 static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
 
 static struct curl_slist *host_resolutions;
@@ -299,6 +298,11 @@ size_t fwrite_null(char *ptr UNUSED, size_t eltsize UNUSED, size_t nmemb,
 	return nmemb;
 }
 
+static struct curl_slist *object_request_headers(void)
+{
+	return curl_slist_append(http_copy_default_headers(), "Pragma:");
+}
+
 static void closedown_active_slot(struct active_request_slot *slot)
 {
 	active_requests--;
@@ -1275,8 +1279,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma: no-cache");
-	no_pragma_header = curl_slist_append(http_copy_default_headers(),
-		"Pragma:");
 
 	{
 		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
@@ -1360,9 +1362,6 @@ void http_cleanup(void)
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
 
-	curl_slist_free_all(no_pragma_header);
-	no_pragma_header = NULL;
-
 	curl_slist_free_all(host_resolutions);
 	host_resolutions = NULL;
 
@@ -2370,6 +2369,7 @@ void release_http_pack_request(struct http_pack_request *preq)
 	}
 	preq->slot = NULL;
 	strbuf_release(&preq->tmpfile);
+	curl_slist_free_all(preq->headers);
 	free(preq->url);
 	free(preq);
 }
@@ -2454,11 +2454,11 @@ struct http_pack_request *new_direct_http_pack_request(
 	}
 
 	preq->slot = get_active_slot();
+	preq->headers = object_request_headers();
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEDATA, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
-	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
-		no_pragma_header);
+	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER, preq->headers);
 
 	/*
 	 * If there is data present from a previous transfer attempt,
@@ -2624,13 +2624,14 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	}
 
 	freq->slot = get_active_slot();
+	freq->headers = object_request_headers();
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, freq->headers);
 
 	/*
 	 * If we have successfully processed data from a previous fetch
@@ -2718,5 +2719,6 @@ void release_http_object_request(struct http_object_request *freq)
 		release_active_slot(freq->slot);
 		freq->slot = NULL;
 	}
+	curl_slist_free_all(freq->headers);
 	strbuf_release(&freq->tmpfile);
 }
diff --git a/http.h b/http.h
index 3af19a8bf5..c5f8cc4620 100644
--- a/http.h
+++ b/http.h
@@ -196,6 +196,7 @@ struct http_pack_request {
 	FILE *packfile;
 	struct strbuf tmpfile;
 	struct active_request_slot *slot;
+	struct curl_slist *headers;
 };
 
 struct http_pack_request *new_http_pack_request(
@@ -229,6 +230,7 @@ struct http_object_request {
 	int zret;
 	int rename;
 	struct active_request_slot *slot;
+	struct curl_slist *headers;
 };
 
 struct http_object_request *new_http_object_request(
