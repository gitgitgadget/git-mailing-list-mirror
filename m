Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF36378824
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127258; cv=none; b=g3qo7XUB3CrCv7BjaqN6vXPRF3jqUMt3n1/0JfmZshRWxtuEcshYQ9BW0qXJDRB/v6IkRgA+6SLNOlbyr/xnxR0aHmxeDuN3NZR5hocazIyI6JHnEy0Lpj4FTmcJBZg6juseTdc8oeiLJJkRZmnK0UygEUeZlLovpnomrSUj/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127258; c=relaxed/simple;
	bh=teDBlY49KNlED/x31+1/B6Wyb7MQKqVQT/vZLHHNIpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2CLQoTzcpLcxzm9ryzgX1G4SE7BfJEdYacKko6QkNavUGv6WbpEJLjJXOwHEwqN745+dnn1gK+BkI4KupLqSFZXdzVFrFDeT1X9/DBuRa80tS+mcQPCtUQAGvNY41N0bLtRmn0xmy0P+Kc2XAXNX8WsmHM/2x4V/DVBB4TNaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=IWx3QWo6; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="IWx3QWo6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786127255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVbA6u7e2LIvzsHg3hlL90yR7oi+p7dEjHZ5rDGX1x8=;
	b=IWx3QWo6XM21UcauKXG2ePFrzbDakPqYScdGtbSrJpXBPjpd3vdSTczg0LQ9foiL/8tzJR
	w1gb3g3bdYWWAfb1M4w3gxUdXzPi8UeV0u3cX1vtUXWLPoTpAtcovje/5ue8vtjEHCH7iC
	Bbux/0gnJDFP2l3bSOlZdZ7FI09LTzk=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 07 Aug 2026 20:26:52 +0200
Subject: [PATCH v2 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-toon-speed-up-last-modified-v2-6-7d87bbdeaf9b@iotcl.com>
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
In-Reply-To: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
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
index 5678731a04..35d9dccd9b 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -369,6 +369,14 @@ static int last_modified_run(struct last_modified *lm)
 
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
2.55.0.679.g6767b8d81c

