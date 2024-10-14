Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149EC1AB534
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911651; cv=none; b=nPtg5TrqdGWNiiaFxLDe0FQskHDANEXF6dqydDSzA+6l6oqaEOf1jR3apFI6PrW09IQBqeonE4MsBgc0+zk53VY3XFJ0IlqTX1nFM+wAG5yQY+ypT5GbI6GglBgV0EVx9jj7CZQZrCvlHwlVAAf2SOKSYqjWnQ9ZgHwvHDn76mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911651; c=relaxed/simple;
	bh=w8B7ybyDEPDyolV1vD7a/csSSNKEm720uszoA8nZVPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihXiunjaDBjh3s5jcP9eyAOGdW6V0ACNavk11d+C5oNnE0cWBSxAjTkCDqj0kAc+M8KBWeXlMJj4Pi6mr/Ba32E2ofglOJIOaqCx0rrNlYpSDSYTY9XpGAcaIOnMH8KVnA8qnXqNSiVYspPjd5gEtLgfP2B7o1fNB30HDcYDeWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bgJE0vJE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bgJE0vJE"
Received: from localhost (CSAIL-SQUARED.MIT.EDU [18.9.64.19])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49EDDq6c002030;
	Mon, 14 Oct 2024 09:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728911634; bh=EkU9cgilmYKfMJnEbv7M8GzIxEKKk9UzINz3J7PkSq0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bgJE0vJEuuJ9Zsb9Q4504E61QdOjJxY8QiyC87ojv2S9f6WCwVJiLde5otCvmviAb
	 9tqgCW2lnCUhXvfikobPq1QsS/bk5xJQiQLYegI9+cDQ2B3+JLlVyuqPsHTtSCF8rV
	 tzyYDbEsZ4WKU6zAy3Izyv+jJ0g1GFfTynEn4vIUPK9fIlrrt0hWaq/fv4SjAT3/HY
	 wNTTJM8CXNvCSTvSeSuVE/k2nBjWSxnpd4Qdjec1hfEf5bZgbKZVIuIxBuo42LQDyQ
	 SOOSnE5lpJjQh2PMrbgLtnOEwjgA04pROmJdVt3jsQdnu4ipiTpX7VD/xuAzJoZbOe
	 kQzWMSkZR/48A==
From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net, sunshine@sunshineco.com, asedeno@google.com,
        =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 1/2] Conditional use of CURLOPT_PROXYHEADER based on libcurl version
Date: Mon, 14 Oct 2024 09:13:45 -0400
Message-ID: <20241014131346.3556163-2-asedeno@mit.edu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014131346.3556163-1-asedeno@mit.edu>
References: <20241014131346.3556163-1-asedeno@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
Signed-off-by: Alejandro R. Sedeño <asedeno@google.com>
---
 git-curl-compat.h | 7 +++++++
 http.c            | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index e1d0bdd273..08ae73e0f1 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -65,6 +65,13 @@
 #define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
 #endif
 
+/**
+ * CURLOPT_PROXYHEADER was added in 7.37.0, released in May 2014.
+ */
+#if LIBCURL_VERSION_NUM >= 0x072500
+#define GIT_CURL_HAVE_CURLOPT_PROXYHEADER
+#endif
+
 /**
  * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
  * 2014. CURLE_SSL_PINNEDPUBKEYNOTMATCH was added in that same version.
diff --git a/http.c b/http.c
index d59e59f66b..30d5e4c67b 100644
--- a/http.c
+++ b/http.c
@@ -652,8 +652,12 @@ static void set_proxyauth_name_password(CURL *result)
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
 	} else if (proxy_auth.authtype && proxy_auth.credential) {
+#ifdef GIT_CURL_HAVE_CURLOPT_PROXYHEADER
 		curl_easy_setopt(result, CURLOPT_PROXYHEADER,
 				 http_append_auth_header(&proxy_auth, NULL));
+#else
+		warning(_("CURLOPT_PROXYHEADER not supported with cURL < 7.37.0"));
+#endif
 	}
 }
 
-- 
2.39.5

