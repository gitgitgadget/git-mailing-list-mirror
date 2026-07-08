Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7140926A
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523057; cv=none; b=Njm0yv+ghMnr/im/7Qi9+mrLkuQcCP5VaZu3hk/czOe0fsQa8Qmge5WsVD8t6//K5WGiy3mb5a4FbjVUSH/+S9+zKtNxGt2+VHQNm0y20vW/nuhlPnvkGXWbVLd0ZnjRbvtQZ6fExYww7tF7WWQiMSfrdWCJgQXDy5ZBnscnPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523057; c=relaxed/simple;
	bh=mdXe5HJHWTdO0LIVBjOF5FqA5pw/StEeySfELbPG4S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdHqiRE7aXZ2T0UTyjgCqdULgC5/FYGXSjndyTj5AYfhNFWWMWRyt0hzYBuz/gbl3+pqpKXdlo4EYZ4taguzBz9Lg/7BhqH04kydPX4WpfHnDOpYoHamXG+hHKuMoz0Nj7EEQ61Zhl8C29Omb3VW1YU6M5IvGgynK+j0OvGbc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jVmBzbln; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jVmBzbln"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783523050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t1gk83pr4U1Bi/BtNBZXD2qW1HeH5HuqeiFaGkRWLk=;
	b=jVmBzblnQAlAl9ccfKjn0KPu4+SiSzPCeOfCSzqo/Hc8aD636l3fFSwSEFMgWaFPmh8gm3
	IRPpRqDOgPj9yKUIN+SAZ/AY40g2EiRv/xSXfGz1V354xF72NcMqgfjXZYpDasa9Vo9VCv
	bAcrC5kyiIa1oOED9gJrBHjlGnUmtDM=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 08 Jul 2026 17:03:34 +0200
Subject: [PATCH v2 1/2] bundle-uri: drain remaining response on invalid
 bundle-uri lines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-toon-bundle-uri-no-uri-v2-1-09a03d8db556@iotcl.com>
References: <20260708-toon-bundle-uri-no-uri-v2-0-09a03d8db556@iotcl.com>
In-Reply-To: <20260708-toon-bundle-uri-no-uri-v2-0-09a03d8db556@iotcl.com>
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

This error is bubbled up to `transport_get_remote_bundle_uri()`, which
is called by `cmd_clone()` in builtin/clone.c. Over here, the return
value is ignored, so clone continues.

Despite this, it still dies with this error:

    fatal: expected 'packfile'

This happens because `get_remote_bundle_uri()` exited early, leaving
some unprocessed packet data behind in the read buffer. This is
misleading to the user, because it suggests a problem with the packfile
exchange, when in reality it's caused by a misconfigured bundle-URI on
the server-side.

Fix this by continuing to read packets when an error was encountered,
but without processing the remaining lines. This drains the protocol
stream so no stale data is left behind and the caller can use it if they
like.

With this, clone now continues successfully if invalid bundle-URI data
was sent by the server. This is intentional, because since the inception
of `transport_get_remote_bundle_uri()` in 0cfde740f0 (clone: request the
'bundle-uri' command when available, 2022-12-22) the return value of
that function is ignored in `cmd_clone()` so the clone can continue
without bundles.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 connect.c                   | 15 ++++++++++++---
 t/t5558-clone-bundle-uri.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 47e39d2a73..1d74c1eda2 100644
--- a/connect.c
+++ b/connect.c
@@ -517,7 +517,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 			  struct bundle_list *bundles, int stateless_rpc)
 {
-	int line_nr = 1;
+	int line_nr = 1, err = 0;
 
 	/* Assert bundle-uri support */
 	ensure_server_supports_v2("bundle-uri");
@@ -536,10 +536,19 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 		const char *line = reader->line;
 		line_nr++;
 
+		/*
+		 * Do not parse if an error was encountered, but
+		 * continue draining the response so no stale data
+		 * is left in the reader for subsequent protocol
+		 * exchanges.
+		 */
+		if (err)
+			continue;
+
 		if (!bundle_uri_parse_line(bundles, line))
 			continue;
 
-		return error(_("error on bundle-uri response line %d: %s"),
+		err = error(_("error on bundle-uri response line %d: %s"),
 			     line_nr, line);
 	}
 
@@ -554,7 +563,7 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 	check_stateless_delimiter(stateless_rpc, reader,
 				  _("expected response end packet after ref listing"));
 
-	return 0;
+	return err;
 }
 
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 7a0943bd36..7cc8627e17 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -1302,6 +1302,35 @@ test_expect_success 'bundles with newline in target path are rejected' '
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
+		"$HTTPD_URL/smart/no-uri.git" target-no-uri 2>err &&
+	test_grep "bundle ${SQ}bundle-1${SQ} has no uri" err &&
+	test_grep ! "expected packfile" err
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
+		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri 2>err &&
+	test_grep "bundle ${SQ}bundle-1${SQ} has no uri" err &&
+	test_grep ! "expected packfile" err
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 

-- 
2.53.0.1323.g189a785ab5

