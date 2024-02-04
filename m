Received: from 2.mo583.mail-out.ovh.net (2.mo583.mail-out.ovh.net [178.33.109.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C7124B2B
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.109.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707073848; cv=none; b=aog2Lxcay5Si+h7bruOhVBYv+NU0JNO7NQxnF64s0l9Gq00q7T7Lry5Hyvbih49PpUc8Kv4IcpWgZFkRqQkq797XJ3Wh+7aOZfDkyI8b6nTTDm75Jnr9ERLhXV+B/jmDeVDNSKZepbizd0gnCeYDHZXRtW9LdlGzYj6nJR2BxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707073848; c=relaxed/simple;
	bh=uFAtNeA7KtVLs6s07qvXBcKTSZoQoWNGoODfORwedXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL7i21hAqgdeMVTZEoVpDu3z/UYuNrmvYXc9+2MA5qMDvFOKniErajNvHYkrFMpSXvUKqka9l6lDoWlQKr8M66VRQcjisrDdmm/WZbhUFjpoag4dwR5j6Sn2AFEqagoXhsSA3a1KFbnt1OjeHLxuOQ0xfrJNn9uTq1OvNefe4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org; spf=pass smtp.mailfrom=devyard.org; arc=none smtp.client-ip=178.33.109.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devyard.org
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.140.177])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id D918927EC5
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 18:54:32 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-z4d9m (unknown [10.108.54.55])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9B65B1FE89;
	Sun,  4 Feb 2024 18:54:32 +0000 (UTC)
Received: from devyard.org ([37.59.142.107])
	by ghost-submission-6684bf9d7b-z4d9m with ESMTPSA
	id qFQ5JGjdv2XGEgAAbck5jQ
	(envelope-from <ypsah@devyard.org>); Sun, 04 Feb 2024 18:54:32 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S00125edca4a-f3bb-4b47-9875-ad8106406f7b,
                    2F615BA836ACE59B185ACC479DFD3D80C8A04DFC) smtp.auth=ashpy@devyard.org
X-OVh-ClientIp:213.10.167.74
From: Quentin Bouget <ypsah@devyard.org>
To: git@vger.kernel.org
Cc: Quentin Bouget <ypsah@devyard.org>
Subject: [PATCH 1/2] http: only reject basic auth credentials once they have been tried
Date: Sun,  4 Feb 2024 19:54:26 +0100
Message-ID: <20240204185427.39664-2-ypsah@devyard.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204185427.39664-1-ypsah@devyard.org>
References: <20240204185427.39664-1-ypsah@devyard.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15954001683923056053
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepsfhuvghnthhinhcuuehouhhgvghtuceohihpshgrhhesuggvvhihrghrugdrohhrgheqnecuggftrfgrthhtvghrnhepheetjeeiteehffevfedtvdeigfeludekteejgfejgfdutddvhfduudelgfehuedvnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpkhgvrhgsvghrohhsrdhmugenucfkphepuddvjedrtddrtddruddpvddufedruddtrdduieejrdejgedpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoeihphhsrghhseguvghvhigrrhgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth

When CURLAUTH_GSSNEGOTIATE is enabled, it is currently assumed that
the provided username/password relate to a GSSAPI auth attempt.
In practice, forges such as gitlab can be deployed with HTTP basic auth
and GSSAPI auth both listening on the same port, meaning just because
the server supports GSSAPI and failed an authentication attempt using
the provided credentials, it does not mean the credentials are not valid
HTTP basic auth credentials.

This is documented as a long running bug here [1] and breaks token-based
authentication when the token is provided in the remote's URL itself.

This commit makes it so credentials are only dropped once they have been
tried both as GSSAPI credentials and HTTP basic auth credentials.

[1] https://gitlab.com/gitlab-org/gitlab/-/blob/b0e0d25646d1992fefda863febdcba8d4c7a1bbf/doc/integration/kerberos.md#L250

Signed-off-by: Quentin Bouget <ypsah@devyard.org>
---
 http.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index e73b136e58..ccea19ac47 100644
--- a/http.c
+++ b/http.c
@@ -1758,10 +1758,7 @@ static int handle_curl_result(struct slot_results *results)
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
-		if (http_auth.username && http_auth.password) {
-			credential_reject(&http_auth);
-			return HTTP_NOAUTH;
-		} else {
+		if ((http_auth_methods & CURLAUTH_GSSNEGOTIATE) == CURLAUTH_GSSNEGOTIATE) {
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
 			if (results->auth_avail) {
 				http_auth_methods &= results->auth_avail;
@@ -1769,6 +1766,9 @@ static int handle_curl_result(struct slot_results *results)
 			}
 			return HTTP_REAUTH;
 		}
+		if (http_auth.username && http_auth.password)
+			credential_reject(&http_auth);
+		return HTTP_NOAUTH;
 	} else {
 		if (results->http_connectcode == 407)
 			credential_reject(&proxy_auth);
-- 
2.43.0

