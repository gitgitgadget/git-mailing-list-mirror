Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5F54F89
	for <git@vger.kernel.org>; Wed,  8 May 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172318; cv=none; b=IdzcWlT+lvLRUCJnAPrtRC5MqvzXjuSayzbkOKos2fVjf0C5INlRKAdX1pRNUWxaFANKzanWMqGtLcfSfLj81xvEKAYT9KrWuKtn3XygKX7dBakH5/21yQ1ZIHkoZhWV/v/afhr2az49YRGZUp5jDMZ+B4KEA8RbAB+xlAxwUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172318; c=relaxed/simple;
	bh=LWJi03w94FMfI8yGXIPo0lPCIui3ifpgFThJUh9tW5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAr5eO2bBWfGT8lZjUs6X8fDl1sNrl6/Ug0sVIPDdAT8EtzpXMziF0FhO/jVgpE7g1IAT/7nMhzMju/zaTU5Mc8i98YFc9QIMGY+oWj9hTR/NMHjcS8MUTSjcPIxE3HXgzphKonVXev6d86/DLAPWujRKbH3mDv5XxkYWe4Zn8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=MpsQtC62; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="MpsQtC62"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1715172315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7P9W7AEA4C8xAQeBDGGzZxOH9zzaVkQccMdG51jZydU=;
	b=MpsQtC62ghLYKUOojnJj+vqswbOZXaytqwFSsVbTSfvTbPm/FYUw9/xBTj0WXmJO+ddQxB
	N9H3Y7D4QCrSowb8kUtO9aw4EfFqUCKuaLq7V2NlX4w97gMoIwgpPs0McjC5+sPxJNqyRn
	r9NFZuoZakyxMO7yB56z9+UpsIVoWkc=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 4/4] bundle-uri: enable git-remote-https progress
Date: Wed,  8 May 2024 14:44:53 +0200
Message-ID: <20240508124453.600871-5-toon@iotcl.com>
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

When using bundle URIs large files might get downloaded during clone.
During that time, there's no feedback to the user what is happening.

Enable HTTP download progress for bundle URIs to inform the user.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bundle-uri.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index ca32050a78..462f00f668 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -293,7 +293,6 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	int found_get = 0;
 
 	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
-	cp.err = -1;
 	cp.in = -1;
 	cp.out = -1;
 
@@ -328,6 +327,9 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 		goto cleanup;
 	}
 
+	fprintf(child_in, "option progress true\n");
+	fflush(child_in);
+
 	fprintf(child_in, "get %s %s\n\n", uri, file);
 
 cleanup:
-- 
2.44.0.651.g21306a098c

