Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DC1A08BC
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020375; cv=none; b=hjtwn21wcXPllAY8TafzQk8ulmMYg6Tdm8KMX76czj4rZJXpo7lDFnyZ9mzqKToLDZ0zWeftSgAgtm+WNLFHlhfgP+YgWPgWOinyN1nxZ38sYIxcqSaaIy7n2AU1p51jPUcbxxUE9ugTTV/U6602NDcIpZa3jexGKARuX4JZonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020375; c=relaxed/simple;
	bh=o8NlAsZD7BkALT2zOK835T9eDLqzj+22ubrEF9P9gyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gw7RSEGLUJJjYvHCpN0O3l3nlUCwmJrcx+DZFVKykus6J7wMOb9Mf9seiE7Vun69kXcWPMtbRrKG08tfsFBMC2HSrnfsAsY3YxbVt5sXBpSckpt1XQ42qrHv6tShT1z5pZuvUL31kuAwdpBW0iyHQTTzHu98AAXsOBcce1yGoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=IYNrvrco; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="IYNrvrco"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyDiiCtlyRbrzxRTZ+qqxZqLXT3pzUj3mrr82SVnQ5I=;
	b=IYNrvrcowIzVOepdynevHjgX4pSd+w8YJcLE2UK2NqTvFAbBdSBgH7I3sr+oemhFrwQZii
	5nO/xl7QR/cxCXK5T5NvDmlGrSmrrFw7NuLstwBevgPmM3DCpYI4Y7/47jvZfiE4NQTgC+
	s/4SqswuEsyFzOwUVAxrz8s1P26cRKg=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Mar 2025 21:18:25 +0100
Subject: [PATCH 1/8] combine-diff: zero memory used for callback filepairs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-toon-blame-tree-v1-1-4173133f3786@iotcl.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

In commit 25e5e2bf85 (combine-diff: support format_callback,
2011-08-19), the combined-diff code learned how to make a multi-sourced
diff_filepair to pass to a diff callback. When we create each filepair,
we do not bother to fill in many of the fields, because they would make
no sense (e.g., there can be no rename score or broken_pair flag because
we do not go through the diffcore filters). However, we did not even
bother to zero them, leading to random values. Let's make sure
everything is blank with xcalloc, just as the regular diff code does.

We would potentially want to set the "status" flag to
something non-zero, but it is not clear to what. Possibly a
new DIFF_STATUS_COMBINED would make sense, as this is not
strictly a modification, nor does it fit any other category.

Since it is not yet clear what callers would want, this
patch simply leaves it as "0", the same empty flag that is
seen when diffcore_std is not used at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index 9527f3160d..1deb8c7374 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1315,7 +1315,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	struct diff_filepair *pair;
 	struct diff_filespec *pool;
 
-	pair = xmalloc(sizeof(*pair));
+	CALLOC_ARRAY(pair, 1);
 	CALLOC_ARRAY(pool, st_add(num_parent, 1));
 	pair->one = pool + 1;
 	pair->two = pool;

-- 
2.49.0.rc2

