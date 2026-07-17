Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E0336DA14
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303255; cv=none; b=Lh0WjyC25xwSnTBm87ASiEdRGHiMX6MFJEsh6cHfunBbw9Irje1htxw2RgIhqqJV52n1NzW/w2W36Jg4ZF0X3QYWZJowjC+heTOMpTAbGb1+lwlfs+gF+gw35v7x36dsXAlPSUKm92dTiy3omrSufk351xEuUcac6FfOxdmCuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303255; c=relaxed/simple;
	bh=vdbY0CCsq8YK9gfjUQ/4cGJKlZjbE7T9P3n4N+Hz8kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ht5fmRuVoi46qGef4TBMppdf1dvVMewpuilU/w0lijJb6NhQfl7fhg7CyyjkjsZwa1q4LitQsNwnKEoCrH7Qm+y+MAeiT8wPMWZDx+4G3tKHPG1HLCTF96ZWpr1Kk2Zcxqp73oahl+rnXkzfAxYegRNC7O/gOjp0svKbf8EIkpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=NMgbc6mG; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="NMgbc6mG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784303250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ray1aoeIplk8j1IkCDYzBnoFJWehP7p2lz3F9CynWWY=;
	b=NMgbc6mGX55ke56Xifym5udRJ4fydBe8TZiJpHqozsedgzN6Xd64bj0H17YOmm8SKB9lso
	IGtPICvAF7kDS7ewJEABDrg6GqEpcwH+Z4pPYx/3JyJn7SbCRZQwyhZogsKgDOsF+PMQkD
	/xFcMnocSFTEGWDzlIPLnrR/4cz2fZY=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 17 Jul 2026 17:47:02 +0200
Subject: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The last-modified builtin expands the pathspec to a set of literal paths
and builds a Bloom key for each. During the walk it looks those keys up
in the commit's filter to decide whether the commit is worth diffing.
These lookups need `bloom_filter_settings` for the key hashing.

prepare_revision_walk() runs prepare_to_use_bloom_filter() to build the
pathspec key vectors. For a pathspec that cannot be turned into a Bloom
key, such as a top-level wildcard like "*.c", that function gives up and
clears `bloom_filter_settings`.

Restore `bloom_filter_settings` after prepare_revision_walk() so the
per-path check keeps working for wildcard pathspecs.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index e8ee610404..adc7cd8c74 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -360,6 +360,14 @@ static int last_modified_run(struct last_modified *lm)
 
 	prepare_revision_walk(&lm->rev);
 
+	/*
+	 * prepare_revision_walk() clears bloom_filter_settings for pathspecs
+	 * without a Bloom key. Restore it so the per-path check keeps working.
+	 */
+	if (!lm->rev.bloom_filter_settings)
+		lm->rev.bloom_filter_settings =
+			get_bloom_filter_settings(lm->rev.repo);
+
 	max_count = lm->rev.max_count;
 
 	init_active_paths_for_commit(&lm->active_paths);

-- 
2.53.0.1323.g189a785ab5

