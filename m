Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D130BF68
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783233; cv=none; b=XtzE45Z+NVHMdpNmsptSIBfe8nj3u6yUXfqsNR86DUhWbFkPVqruE9B2DthiY9W9Lm4ahZ2Icp93m914Brb3OVM39dTcUDh7sEUceVTSxU5SxJRpR2z78M1m3HqHVTE1fnbfthKLQfkWXiE8f3EMvukuJwbcbZTvEozP7Qe9VO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783233; c=relaxed/simple;
	bh=Drj87lI+hoo4ihbsoNsdFiwTsQ6lXcn4tkaXKUM3MJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5CXbc2aCFU2acf555NyV5/K+52rNu8IbV+BFriecmycev1ht1wjz3H1rCDDSZjmgYuPsp0l7IuMiUdCe7C/67xYdAwMzu5MDD92D0GvWhEQtvf4UcuEd0WjFkusiCvm5WpPaIgjIRymIiI3k29lLIChAUpT4QchC51EbfCQSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hjd5L4Um; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hjd5L4Um"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769783226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07k04mZU+M+Luh0uaJHvkP4Q+LR+smP4fKTXg0bpUOc=;
	b=hjd5L4Um9Qr9EHDQO4CMQJa+eDrlkCtbt8+wl5707F2Cs0GP+bRxFMMoiqN9pq/kaO0Ina
	IREQ15noW3kkmvZN/s568xbmJErCp1wVUv9AnUVL0aaqZbPckO2DlbLXzRLsm7A0fBpGLk
	04aN8U1iSU1OZDj5u9WfmfwEltFfIL4=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 30 Jan 2026 15:26:37 +0100
Subject: [PATCH v6 3/4] last-modified: remove double error message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-toon-last-modified-tree-v6-3-db827e5df985@iotcl.com>
References: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
In-Reply-To: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
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
index 31dea975a0..e02ec8428b 100644
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
2.53.0.rc1.267.g6e3a78c723

