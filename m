Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5810E4
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711243213; cv=none; b=QR3eDXAArZG8cVYKfKyv3mWDaCznBlTIWd66z1OdcgKVZYW4WjTQ87SKKsMb93KmbAomXU5wiBkhMIocv9JXwN8oI3/ksZW7Lo8BA1PHUP32AnJhPIedXL3qOLaXfU8JXfdVQh56W4FA3fMkbHz+WfrvHtfPOsuhGLSTjDSyFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711243213; c=relaxed/simple;
	bh=flc2Wc51u+HIaZDdabkjLz+DJAqbvsiiDqu2NGfVorQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/tN0m9gzja8/xWGp5w7yYtNYQz3IzsfjczlDt87UEFtK9O2HdkdiQ4iCx9TKgIl0/MWLGIyuweYYJsGDvJc6JAB6G1NJ811cddVTzHf9bVXeGHgBBVE0r77ouBTS3RldY3Cj1kRzlHU1j94a+VhshZnolHYbSjQy4MF1VuyeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KaWh+XSV; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KaWh+XSV"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CD9615CBB4;
	Sun, 24 Mar 2024 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242785;
	bh=flc2Wc51u+HIaZDdabkjLz+DJAqbvsiiDqu2NGfVorQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=KaWh+XSV3jF6rljHM/fRYUmLyw4Bqc7hbrhe+hrx5/9uxwKjfAeYlbOeAyNbVxp9l
	 hzlCowsBGHHRu4lvgOa+Bu+qi0Z1bYq5FKu+ngyEZj+e4jgxxrRRyzGc6vK38os8Gk
	 lMLQETb4Ugvl+avN4ElaVqu9UB5u+1+wJEjLYeOrDjnR+kMUSWHV0CJof27HVeOLVJ
	 P/97E+FydONuK0cFQMVgB0jzKQeZgxHLaCloKKjNxsteT8XgP6iF23+JClyoQgXI20
	 2oqGJMrd3n2nVit33GPhXI1E0KFE0NM0whiHAVIZNvATSHT4mGzZhhSdaFj4pJJqo5
	 C84tAsyMp6nLK5AWT+1wwkwtvNlxu0naYlGbdIPkDQLKOD4kKb89yEXDHArQk7Rb/v
	 jnQr5J04MPjqq8UCkIBA89HIqLL5pyPyniRElIzaciGTl+nbYmfg/v5k9hslVaPQNW
	 DcvG/t6BV5jRdMp6RDJbwwj4TktDwn2bbSESeM7EHSN2GPRkvgc
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 03/13] http: use new headers for each object request
Date: Sun, 24 Mar 2024 01:12:51 +0000
Message-ID: <20240324011301.1553072-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
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
 http.c | 19 +++++++++++--------
 http.h |  2 ++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index e73b136e58..1c2200da77 100644
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
@@ -1360,8 +1362,6 @@ void http_cleanup(void)
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
 
-	curl_slist_free_all(no_pragma_header);
-	no_pragma_header = NULL;
 
 	curl_slist_free_all(host_resolutions);
 	host_resolutions = NULL;
@@ -2370,6 +2370,7 @@ void release_http_pack_request(struct http_pack_request *preq)
 	}
 	preq->slot = NULL;
 	strbuf_release(&preq->tmpfile);
+	curl_slist_free_all(preq->headers);
 	free(preq->url);
 	free(preq);
 }
@@ -2454,11 +2455,11 @@ struct http_pack_request *new_direct_http_pack_request(
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
@@ -2624,13 +2625,14 @@ struct http_object_request *new_http_object_request(const char *base_url,
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
@@ -2718,5 +2720,6 @@ void release_http_object_request(struct http_object_request *freq)
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
