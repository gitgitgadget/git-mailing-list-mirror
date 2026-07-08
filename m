Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB06409291
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523062; cv=none; b=YxRrMtQIUkO6UZGM1uDKCJkZ7ymzr/3CTKX/Lq9zpE/HxZNAK7iCeldgZFG/Rq++dA2YV3kkrDMGBwHQKqNFCt69RTaBoS2/a1ZHSTfHA98mIqyB9u7cJZWuPD07veFNpwOBv/i18L5eV6mWewgYoOQ6Y4pPX1mHNTwDisy3L8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523062; c=relaxed/simple;
	bh=i59xSPm9LzrIik+XkdxDBLGGUbJowOEew1spMI8KY9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9DgbFC9FDTjnsf3ZcuAjb4qrvjHhO6GGwSTALA+s/4dP38hxF6/UkjnzqXP3xRMAHOsDXGdSJbKKTY7GjX9S++0eugNeT3ipgzg9+S02jw81d+koT37y1ZRwI9rU4AxD7JrYiqW9CBFMUqBDVUqp7PdMGKWZXNb4AebooTeM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=a2FCVDy3; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="a2FCVDy3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783523054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5luTTvyt0y+8MreCAr7Y4W3AfJ3X2C8mkodcKqEpuE=;
	b=a2FCVDy3BH9jW4lMOEfsLhQ9C1G7f0hmhWnD3v6rY70bWTKyPQ5gQpzkW++jHx2wvESJq5
	tWXwaakAHmy7SK8mijrNCsCakACRcoTHhpcqbWo9uvw+uW2DzB72tsLQ4lnkWvykKH/DbK
	Zuu1ts9HMKrMiBHr2gXO2uGjUY+2fF4=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 08 Jul 2026 17:03:35 +0200
Subject: [PATCH v2 2/2] bundle-uri: stop sending invalid bundle
 configuration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-toon-bundle-uri-no-uri-v2-2-09a03d8db556@iotcl.com>
References: <20260708-toon-bundle-uri-no-uri-v2-0-09a03d8db556@iotcl.com>
In-Reply-To: <20260708-toon-bundle-uri-no-uri-v2-0-09a03d8db556@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

From: Justin Tobler <jltobler@gmail.com>

When bundle-URI info is requested by the client, the server responds
with all "bundle.*" config lines as key=value packet lines. On the
client-side, the received bundle config packet lines are always expected
to contain both a key and a value otherwise the client errors out during
parsing. The server performs no validation of the read bundle
configuration though which results in any misconfiguration on the
server-side, such as bundle configuration with an empty value, being
blindly sent to the client.

To avoid having the server transmit invalid configuration to clients,
only send bundle configuration that has non-empty values.

This change makes bundle-URI information sent by the server
syntactically correct, but semantically it still can be invalid. For
example the server may end up sending `bundle.bundle-1.creationToken`,
but be lacking a `bundle.bundle-1.uri` for that bundle. The `uri` is
mandatory, thus the client cannot process this bundle and will error
with the message:

    error: bundle 'bundle-1' has no uri

Fixing this would require a more complex solution, because bundles need
to be validated as a whole and not line-by-line. This is considered
outside the scope of this change.

Co-authored-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bundle-uri.c                 |  8 ++++++--
 t/lib-bundle-uri-protocol.sh | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 3b2e347288..f956d3db7b 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -946,8 +946,12 @@ static int config_to_packet_line(const char *key, const char *value,
 {
 	struct packet_reader *writer = data;
 
-	if (starts_with(key, "bundle."))
-		packet_write_fmt(writer->fd, "%s=%s", key, value);
+	if (starts_with(key, "bundle.")) {
+		if (value && *value)
+			packet_write_fmt(writer->fd, "%s=%s", key, value);
+		else
+			warning(_("config '%s' has no value"), key);
+	}
 
 	return 0;
 }
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index de09b6b02e..e0e19715cd 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -214,3 +214,26 @@ test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
 		>actual &&
 	test_cmp_config_output expect actual
 '
+
+test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2 with empty value" '
+	test_config -C "$BUNDLE_URI_PARENT" \
+		bundle.bundle1.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED-1.bdl" &&
+	test_config -C "$BUNDLE_URI_PARENT" \
+		bundle.bundle2.uri "" &&
+
+	# The empty bundle.bundle2.uri value is invalid configuration and the
+	# server must not advertise it to the client.
+	cat >expect <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "bundle1"]
+		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-1.bdl
+	EOF
+
+	test-tool bundle-uri \
+		ls-remote \
+		"$BUNDLE_URI_REPO_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'

-- 
2.53.0.1323.g189a785ab5

