Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7B73164
	for <git@vger.kernel.org>; Wed,  8 May 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172316; cv=none; b=jK7qaBirtJ0sGocxIGkI2XMQObeN2HNdk9PvjPDhgbFV1M2LjxOhP85k6F23cbGhy8R+Aw9Bmd4VQMZUs7LneCEGYRW2zHgcoYXJN9XCeTmjOwDOQrgUv8mGGH5R0H+DloyBlrudBdOugd95G3bRUMkMfIZzbTRo2i+rTcM3tGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172316; c=relaxed/simple;
	bh=Sy6esTHw9LBvkqV8yx0KMoJJfnDWFiEG0dvA2VfCBlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0zlPANBr+LozzfZrrrGlVP60y2PDZZP+ldjywaI+65EXjFedaByJyBAyNW+h8pTZtwQzv1a6BHe8M0dnBp2CQqju/vZRpsTqefm1B5jOLhAYzuStSxG3sgY0fAKl2IAwQUd03sAnyWb7KiJfuTksYoczeDgIL2jLAIwKhmq3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VvHB40Et; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VvHB40Et"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1715172312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjlH5tYlBOzcsbkUJKs8pzOyJ10b6kTp0m3bZRQPkfg=;
	b=VvHB40EtpBajsRistXMw31t3aNKXtRA9kcLqSYNCP6e4yD6JxhWl43iroq+aU43hvrRr2d
	+4fARcRT2ejxNpxGj+DkMqZheQ6DKYUiBw0saFcG0zhQdRoZCZtmPUwhJHFQIGlOdPZWij
	GqOz6lGhpZODYHs52+KCeisPy9Gjx/4=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 3/4] remote-curl: optionally show progress for HTTP get
Date: Wed,  8 May 2024 14:44:52 +0200
Message-ID: <20240508124453.600871-4-toon@iotcl.com>
In-Reply-To: <20240508124453.600871-1-toon@iotcl.com>
References: <20240508124453.600871-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

git-remote-curl supports the `option progress` basically since it's
inception. But this option had no effect for regular HTTP(S) downloads.

Add progress indicator when downloading files through curl HTTP GET.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 remote-curl.c       |  8 +++++++-
 t/t5557-http-get.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0b6d7815fd..9fc7c3580c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1293,6 +1293,7 @@ static void parse_get(const char *arg)
 {
 	struct strbuf url = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
+	struct http_get_options http_options = {0};
 	const char *space;
 
 	space = strchr(arg, ' ');
@@ -1303,7 +1304,12 @@ static void parse_get(const char *arg)
 	strbuf_add(&url, arg, space - arg);
 	strbuf_addstr(&path, space + 1);
 
-	if (http_get_file(url.buf, path.buf, NULL))
+	http_options.initial_request = 1;
+
+	if (options.progress)
+		http_options.progress = 1;
+
+	if (http_get_file(url.buf, path.buf, &http_options))
 		die(_("failed to download file at URL '%s'"), url.buf);
 
 	strbuf_release(&url);
diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
index 76a4bbd16a..92a138caaf 100755
--- a/t/t5557-http-get.sh
+++ b/t/t5557-http-get.sh
@@ -36,4 +36,19 @@ test_expect_success 'get by URL: 200' '
 	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
 '
 
+test_expect_success 'get by URL with progress' '
+	echo hello >"$HTTPD_DOCUMENT_ROOT_PATH/hello.txt" &&
+
+	url="$HTTPD_URL/hello.txt" &&
+	cat >input <<-EOF &&
+	capabilities
+	option progress true
+	get $url file3
+
+	EOF
+
+	git remote-http $url <input 2>err &&
+        test_grep "^Downloading via HTTP: 100%" err
+'
+
 test_done
-- 
2.44.0.651.g21306a098c

