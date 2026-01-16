Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990743AA6
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568956; cv=none; b=LuKqtWshu797GisfFpToo15b+Ocq1ZR6UuZkKKKAAp0U/BRHpTDy8xlhlnnsaa7WLjyIpamUlS0YVsxSbWrpN3qG5jCaejZs3455JamTAaOU7OQ1AN0ICW/N6Rf8koISr2kw4xHqqZjU6poRsFUOFVJHbFZ2RgXIEti8jhRdHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568956; c=relaxed/simple;
	bh=eXTIpgU5sFp9KiKON3UKOzNpuQ3fcekFuEmy4e1sPmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezgEGR5eBwjUqy5kOoUtXZNFDxWpd7saYSSp4/72pP8g/9+IS90GYySHWoMyuE5WkvXQcgK4UhqSuWj5FUQqQyemqQ97bbrv2hcw8SfUMXgkr7zyS6E/tPhacKFxacAHAacHiiiL+7MbwptS7j9EF3FYBm13KKvUgKsfKPOiqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=m07/PzTA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="m07/PzTA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768568953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fsEixiPbCMB6icwDG3ivaUrKO/gYxTA7wdNMv8IKX0=;
	b=m07/PzTA6i4aFR0USKF6aygUG9WowpO6pPjOUUQ9BxNPgPRFdNaPJPjbjLeswJJcyvsBPh
	kX1rgU2yIJqm1NLg1ZA21FTaXycTiO2dVtDRPJmOJpN6Fd1K3tO/CSweRYxDuxywqWAatz
	PXH6cGssIMg2gLlnMlV7qGQd2XvYVIY=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:08:39 +0100
Subject: [PATCH v3 3/4] last-modified: remove double error message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-tree-v3-3-e6ade4dc35ab@iotcl.com>
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
X-Migadu-Flow: FLOW_OUT

When the user passes two revisions, they get the following output:

    $ git last-modified HEAD HEAD~
    error: last-modified can only operate on one revision at a time
    error: unable to setup last-modified

The error message about "unable to setup" is not very informative,
remove it.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 06e3f79aec..0df85be318 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -495,7 +495,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
 
 	if (populate_paths_from_revs(lm) < 0)
-		return error(_("unable to setup last-modified"));
+		return -1;
 
 	CALLOC_ARRAY(lm->all_paths, hashmap_get_size(&lm->paths));
 	lm->all_paths_nr = 0;

-- 
2.52.0

