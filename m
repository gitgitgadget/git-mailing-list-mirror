Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23F1F30BE
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975439; cv=none; b=hQm9YJfHOXMShQ2snlHrtDqlCBAf1oIqVvjSN+oqlXJ+xEe6BDALD0oml9geDI0KAmQq46YDmP3whZCmWdhWAcDijvYhd5/1AIIvAj0j6rCgpaIj1vbbWUZv+tUrI1DgkDKV4TWPJQhPXqOHhUJF9TX4w7ECM7O37sti1CDFR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975439; c=relaxed/simple;
	bh=xVvk7vEBiISqGxPLI05npULGqMd+Nx2d52kXQlrJ5AU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1suPe/bRfZ3/3k41OUS0/CCc1QseLqBggjHQsbRQUcwKyqdZ8v23B9+MEzBElRn2FBVWMTsQ2LrnLGCOfA7K0TeE8K2oqZopbIJTXTKjIxXSI9mAGZwG5Y0khIWgLCBP5x57Se5AinFiZ4R6H5fJFMD89hQyLWRuWZpxX8x7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4um/7nSp; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4um/7nSp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lO+wAH5Me/7I3gimJ8kxd23x+ZQekL7Kr0gSTFpFJ2g=;
	b=4um/7nSpoZurnj8Ux3qAmEPSnuBJbT2pIktiNbGFYgsKNqB4cULUazVq1URECTEP1OjV3I
	MXnAZcwASWYTMlXJoNVd0lMBNloWzb3sDsNiXdBovjvE3NpwPR5Cwu+CLyGgGK4tNLT0m1
	oPlvNvXudWwv0ap2tntKMdwGJi9D9fM=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 19 Feb 2025 15:30:21 +0100
Subject: [PATCH v2 3/7] http: turn off curl signals
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-toon-bundleuri-progress-v2-3-a84e7ffa921a@iotcl.com>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
In-Reply-To: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

Curl sets and clears the handler for SIGALRM, which makes it
incompatible with git's progress code. However, we can ask
curl not to do this.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index f4504133e8..38c7c0cd54 100644
--- a/http.c
+++ b/http.c
@@ -1245,6 +1245,8 @@ static CURL *get_curl_handle(void)
 
 	set_curl_keepalive(result);
 
+	curl_easy_setopt(result, CURLOPT_NOSIGNAL, 1);
+
 	return result;
 }
 

-- 
2.48.1.658.g4767266eb4

