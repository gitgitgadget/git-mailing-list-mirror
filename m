Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB9371885
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303251; cv=none; b=nXwPdClAs32HVWebONmb/3OUigPBmz/sk4BqG86CfzKRbRu5qcxMehkXB7noCc/4tJJrA9Qp4CisGUH3/Sg8zn646MlM4MoqPRHXsCMeE767jjm1yIWiV8PbrLT279D5nh9h0WYq4Ys5O1J1Modsf+LQEbq7wFAuuaKW29NMbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303251; c=relaxed/simple;
	bh=DTu2MVgbI2wnGp/b4X+gdkqtC6xS4OHGo9gNfxIEC+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HY3DEn9K6YggmrepP6mS9Y/ZyWFBg9cL5wS5flomLdsUXVJp/LxSXzxnflWR5T9uy+IYRcm2bhvxW3OmcgH8fx18xzS+V61CSuCJmAjANVyZzwDvyFz4rW8OzjsrpsQ96kbPOAQtNBiGhyeXRsRyNdVDMSFfKTrkzrRSjK7juQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1TDUhrpP; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1TDUhrpP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784303247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov0cmUt/8Vu7iqA++xVMTskzbhqoxeEOjCxnrQPJW84=;
	b=1TDUhrpPYUkwZi2CB6Cf7b6UX2LSORlhGfDfK1ol3Fplxaqf5uXTw51oBH7yfpAx0ZFtJh
	Xu90Qtl8HekVq9Nd7iffi2+o9/VoW2raoMIYBBXA6k3IqVttOK3bilwyOXSxJxhDAIVpF5
	iYggHI5V+RuDyVEdXoAcysqps5ZcHB0=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 17 Jul 2026 17:47:01 +0200
Subject: [PATCH 3/4] last-modified: check pathspec against Bloom filter
 first
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-toon-speed-up-last-modified-v1-3-410418f18614@iotcl.com>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When git-last-modified(1) starts, it builds a list of all the paths
matching the pathspec it needs to find the last modifying commit for.
For example, every file and subdirectory listed by:

    $ git last-modified -t --max-depth=0 -- src/

As it resolves a commit for each path during the revision walk, it drops
that path from the list.

To avoid diffing trees for every commit, Bloom filters are used when
available. For each remaining path, the commit's Bloom filter is checked
to see whether the commit changed that path. The Bloom filter says
either "no" or "maybe", and only in the latter case is the diff
calculated.

git-log(1) does this differently. It does not expand the pathspec but
checks the Bloom filter against the pathspec itself. This way, commits
not touching any path matching the pathspec can be discarded as a whole.

Apply this same check to git-last-modified(1). In a previous commit the
function revs_maybe_changed_in_bloom(), used by git-log(1), was made
public. Use this as a pre-filter in git-last-modified(1). After this
pre-filter, paths are still checked one-by-one to only find those which
don't have a "last commit" yet.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 5478182f2e..e8ee610404 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -272,6 +272,9 @@ static bool maybe_changed_path(struct last_modified *lm,
 	if (!filter)
 		return true;
 
+	if (revs_maybe_changed_in_bloom(&lm->rev, filter) == 0)
+		return false;
+
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
 		if (active && !bitmap_get(active, ent->diff_idx))
 			continue;

-- 
2.53.0.1323.g189a785ab5

