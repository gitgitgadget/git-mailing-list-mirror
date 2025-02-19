Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AF1F3BBC
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975446; cv=none; b=C28esoI32VxkpWVWcgx81dUfKS+LULqGUDM9DRYKnD/O4kn9nJBF2q8CPcniH5YbSyyql6qW6wcnPqdJxdwd9eRWCQy31VAekY2rv4DEpIdZtVZ9reIE7NPZxstP8mLlDAtBN2WXrwmsDRMFMggOxoROWSdtQzDXvxK1TidUP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975446; c=relaxed/simple;
	bh=IZVu+H15wECpIcgG9JuF2Dyl4ag64WDbS0W9QcxqYsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKQxlXgSb1BSb0K4Ke1iVzgxYxE+9n3hBIvxqx1neBouxjC5HBe8ssTer4ppscVSrymy5NEYKoigXzKvoaUo7uIPUUjph1B/LDF9rVdBTTDivoPLVQXSeb0M+BCeqQeeSFdFwdD5AR6U46arim8AERScMa9TbIeFpLkx4swmkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YfW9Ef1m; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YfW9Ef1m"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fVqSQFfDknsvCxZ8e3E23RsjAZI1DHBzRa3fve39Jc=;
	b=YfW9Ef1mzPgU9dngjZYZXf0KieZAWvnJTaqz8YBy5mZHnVxX4YW6QoDCb+o2cLmqDm0dwz
	CCE+NrEYCVkgztVG/WuBZsZiUCfIokQnU2WkumVq7z5dC/J1Q3UR0/AtiH56L+5d925uhk
	xykh8WFxEBFpIz092l5c5KyHTMa7aBA=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 19 Feb 2025 15:30:23 +0100
Subject: [PATCH v2 5/7] remote-curl: optionally show progress for HTTP get
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-toon-bundleuri-progress-v2-5-a84e7ffa921a@iotcl.com>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
In-Reply-To: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
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
index 1273507a96..f710d6b3cb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1317,6 +1317,7 @@ static void parse_get(const char *arg)
 {
 	struct strbuf url = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
+	struct http_get_options http_options = {0};
 	const char *space;
 
 	space = strchr(arg, ' ');
@@ -1327,7 +1328,12 @@ static void parse_get(const char *arg)
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
index 67fcc23f11..41f3d16ef9 100755
--- a/t/t5557-http-get.sh
+++ b/t/t5557-http-get.sh
@@ -35,4 +35,19 @@ test_expect_success 'get by URL: 200' '
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
+	test_grep "^Downloading via HTTP: 100%" err
+'
+
 test_done

-- 
2.48.1.658.g4767266eb4

