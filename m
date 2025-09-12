Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFBD320A04
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695633; cv=none; b=S3gok+VLTV3QTRVw5foXDO4de3Ovw88MOkDuygvZIcE8evw3xZJPNa4r/3n7JTqfgSvIpNd49aH3Pfj0jz2KMUrmAx/C5r++mdT6EQBdxSyJowLJ/TYdr0z1NCWbYU8kJZ8pxc8tHoXJ5qh7Gt19rmZvEmWl9asxUEtC53rt8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695633; c=relaxed/simple;
	bh=Fi7Yj9sR6qOMGCax5tAKNXecUL+bINT6nnfrv017Qkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nc+Hj56EbV913lpHR6NGRaboCJHFV1+bxJ2YkrecxWJnvAJpsSt55jtEFPFBjApOhjVNHp5wzzFjcLTI25BirnS2vj8hbSpufSVhNeLaTfmYjWUQP9Dpc7BccJq4EbJBH035BJEQF2Kh2cmHg3shpEuwghg918iMK7J8uNngWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5lLNZpB6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5lLNZpB6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1757695628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REhllK/sMbsmZENfuTOuNREaiZS3DV5I9auHEQ7jQ4c=;
	b=5lLNZpB6xL4QwEbSsmwDVJLkR+376HdLVJwPqCRmb3wR7bSKxbDNQVp4pP8/bWfONtEQaZ
	uSCSXZ0kXoxw6BcP7nakpEeBzGzCuPIzIX6WeDWNluT65sr447wk6+QVIbkvZWkF+lLQPP
	MyJcLOpx6tPD/SQSrQKRYIPWD9dA/TQ=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 12 Sep 2025 18:46:33 +0200
Subject: [PATCH 2/2] bundle-uri: do not abort on invalid packet line
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-b4-toon-bundle-uri-no-uri-v1-2-f4525a406df8@iotcl.com>
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
In-Reply-To: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

On clone, when the client sends the `bundle-uri` command, the server
might respond with invalid data. For example if it sends information
about a bundle where the 'uri' is empty, it produces the following
error:

    Cloning into 'foo'...
    error: bundle-uri: line has empty key or value
    error: error on bundle-uri response line 4: bundle.bundle-1.uri=
    error: could not retrieve server-advertised bundle-uri list

This error doesn't cause git-clone(1) to abort, because the return value
from `transport_get_remote_bundle_uri()` is ignored in
`builtin/clone.c`. This should allow the clone to continue *without* the
use of bundle URIs.

Although when cloning over HTTP, the following error occurs after the
above error messages:

    fatal: expected 'packfile'

This is happens because there remains unprocessed data from the
bundle-URI negotiation.

Fix the error by continuing to read packet data when an invalid
bundle-uri line is received.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 connect.c                   |  4 ++--
 t/t5558-clone-bundle-uri.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 8352b71faf..d2e2bd8cce 100644
--- a/connect.c
+++ b/connect.c
@@ -536,8 +536,8 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 		if (!bundle_uri_parse_line(bundles, line))
 			continue;
 
-		return error(_("error on bundle-uri response line %d: %s"),
-			     line_nr, line);
+		warning(_("ignore invalid bundle-uri response line %d: %s"),
+			    line_nr, line);
 	}
 
 	if (reader->status != PACKET_READ_FLUSH)
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3cf498b950..73aebd0b81 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -1326,6 +1326,31 @@ test_expect_success 'bundles with newline in target path are rejected' '
 	test_path_is_missing escape
 '
 
+test_expect_success 'bundles advertised with missing URI' '
+	git clone --no-local --mirror clone-from \
+		"$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.bundle-1.creationToken 1 &&
+
+	git -c transfer.bundleURI=true clone \
+		"$HTTPD_URL/smart/no-uri.git" target-no-uri
+'
+
+test_expect_success 'bundles advertised with empty URI' '
+	git clone --no-local --mirror clone-from \
+		"$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.uri "" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.creationToken 1 &&
+
+	git -c transfer.bundleURI=true clone \
+		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 

-- 
2.51.0

