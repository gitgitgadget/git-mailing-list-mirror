Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840992913
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312183; cv=none; b=qEBAa7HLVFn8qZ/OxIlDw87guNy29ilb2NQSf0phr11AbIL3cb12nm6FdyKvTtgPEHHDqyVUkXFFVfEEUud42oZMIojZIRbeLU6OhCuU1fQL0dqgltyXk24U5J69KvkQBUFhBwSAMcLy0U+AZLYIR+1ariDxXrVFk7EZ0k9jhAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312183; c=relaxed/simple;
	bh=/9gJP+E+JQoaZgFAJNZO8fswMIkX3MIP1Cv0Zg/zORY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttl0eL21+9FHmsm8aHfj6Aa/KqInZqP8C+t8Pw/RJagSydh1Lvs0VQEqkl3CkM4w+lm31PCr5N9+Nfnb2NzkfwzAqciuz4cuSfC+f8ALbFn+y9go7y9HwwnmCuEVsix42KXDmt1kYtBoeOGNVkI7ODf6Hwo8HSHwnxK4HR3Ah4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YJVkmU4L; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YJVkmU4L"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 03B875D4E3;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=/9gJP+E+JQoaZgFAJNZO8fswMIkX3MIP1Cv0Zg/zORY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=YJVkmU4LZaOYLHlvlkvSAPTsyxqtyfH24pM+wOMF1qtCEV0mnF6jRyMMDqTudavls
	 8awTMsDlBzkfECbTsHjCj75wWVbqzi69mMrtnkP7/JbMQkDvuw1vxGWy11+kNUqI3u
	 TbxmbCrBn+Aho0Zng2S/Vs9Q8dLXFf87CWcNr1kI515DIzK5u9uwEsO0qUJ2RQ53ID
	 ONe6U2+pbWOBOinNIOuuLbcnTyy6o+7Ckvpbhn9uctQyZFJZJtYEMB3ec+4BBUwvtv
	 8IpeuavN557jmlOUk82TjDt8j29vgA9k54my9PG8Q+t/JTOAC91Uk7GuM3vcqcYvEC
	 g6BjZ1ALDaWcw3MMnR7FrxXhgnJc3WXJ4tNubsDZkO096QInIzZbRc87qgvUnI/3R0
	 kjdXs/SFL3ns9VZEUq3le2evsGXzbwRYN8c4tS1ihNMuTAFhy4GwVRQl+J1FH6wzyO
	 K1NWRYUByC2UdVaSZMJNk5HuaySjx1Q1G4f0Xgk5VvECBief3dt
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 02/16] remote-curl: reset headers on new request
Date: Wed, 17 Apr 2024 00:02:26 +0000
Message-ID: <20240417000240.3611948-3-sandals@crustytoothpaste.net>
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

When we retry a post_rpc request, we currently reuse the same headers as
before.  In the future, we'd like to be able to modify them based on the
result we get back, so let's reset them on each retry so we can avoid
sending potentially duplicate headers if the values change.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1161dc7fed..e37eaa17b7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -893,7 +893,7 @@ static curl_off_t xcurl_off_t(size_t len)
 static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_received)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = http_copy_default_headers();
+	struct curl_slist *headers = NULL;
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
@@ -935,6 +935,8 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 			needs_100_continue = 1;
 	}
 
+retry:
+	headers = http_copy_default_headers();
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
 	headers = curl_slist_append(headers, needs_100_continue ?
@@ -948,7 +950,6 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	if (rpc->protocol_header)
 		headers = curl_slist_append(headers, rpc->protocol_header);
 
-retry:
 	slot = get_active_slot();
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
@@ -1044,6 +1045,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
 		credential_fill(&http_auth);
+		curl_slist_free_all(headers);
 		goto retry;
 	}
 	if (err != HTTP_OK)
