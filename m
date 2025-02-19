Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D91EFFBA
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975447; cv=none; b=Kl8SHVmihINzWBfuSTEfen50MupcZa/BG20xKZoqJIpf9FWIKRbtcjA3Ogr1MSebluDBH+vOlQBTL82czXkI9W7q95648S3qrkj3IVeuiUMP2DeJFWzVPBHXaFU0L8MF0c6U9YYWWcEZju8/KEb6szNYDN56TCIjXv0Wbr9oN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975447; c=relaxed/simple;
	bh=bV2JtYgd58+snXTd6oOUZ6/R2V/BxZ3GK4cbI2KfH/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwdc2UgJkq+C+WU9ZGpTFnuoLhvACuQsYZcJAwc9X3UWU63bUtaB81gW2CFZ4iB+6fJhjTfEEBE8/tZhWKB1rAhCvFA4jBOODVrre0gZ1jh2k/nuM7mu9uDdjqy9u8u/ESzREFE5A4s9VO2HzoK3fZsgpM0jLbMLFBcdXQaFkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ra+Qd57O; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ra+Qd57O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9je5gL906t30/+gI4ocC72T8uh20JLe7rRStNv7GDaQ=;
	b=ra+Qd57OeT5MUbuVoPgpvdJ/4W/a82vJuUE1rI8Qgoy4WjetofPNZ8aA1iDSmQZZiYQ8SU
	vYGXXyj+cPN8wAsA/LvsrjQPVFtkhAQMfxqBeVJBxWZh8yRWaKp3OxV1U6gR3FrUhn4sja
	Fm/qQA82lqcrwWt9kqn81XuYYDB6NFY=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 19 Feb 2025 15:30:24 +0100
Subject: [PATCH v2 6/7] bundle-uri: enable git-remote-https progress
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-toon-bundleuri-progress-v2-6-a84e7ffa921a@iotcl.com>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
In-Reply-To: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When using bundle URIs large files might get downloaded during clone.
During that time, there's no feedback to the user what is happening.

Enable HTTP download progress for bundle URIs to inform the user.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 744257c49c..0ef96cd00f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -298,7 +298,6 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	int found_get = 0;
 
 	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
-	cp.err = -1;
 	cp.in = -1;
 	cp.out = -1;
 
@@ -333,6 +332,7 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 		goto cleanup;
 	}
 
+	fprintf(child_in, "option progress true\n");
 	fprintf(child_in, "get %s %s\n\n", uri, file);
 
 cleanup:

-- 
2.48.1.658.g4767266eb4

