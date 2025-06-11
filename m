Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DBC374C4
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603150; cv=none; b=Xd5vYhKLLQ1HvAghNbmDjuy0tAAoIpObg6OxqUQ80ACiZOhO1awyxPvnlBl+mjcplXgcrFiLexYTcEtFU+7Fqr4UeyWMTsAi+sBLvbRBhnbXLqGugV3Szam9c+czMl8F15i3Dq9jyZHrQmtLUoF6jBJc+EflzK3n33b9ziTyjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603150; c=relaxed/simple;
	bh=Ch1zAsC+1kv2kMpPrXklNv3obEIeQYrYkxv71gPh7a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGN/2OaS5CHGIQMDbalwfKHWJ2fABcYtFeTg3qv0bsfC9sQxDE0oGaXkPiFkmFc/gNdvGDvzK1R6Jvii7XiRD0KvTZlQS9lfgZZAN7L/Q8tOSqHxJAnDigSaUE69muCp23E1CF1a8B1WrZofzyON6EBdE3Ea5ujE98rZp59iQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RC/Xvr8o; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RC/Xvr8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749603149; x=1781139149;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ch1zAsC+1kv2kMpPrXklNv3obEIeQYrYkxv71gPh7a8=;
  b=RC/Xvr8osR4jHY09Vgfqmt96IRamsV/qK3Q7sdo5pRvbLUCCr7dyRcjj
   vj5SpWk28viuQ6dABxA1BwXf+TwE2KViDxbhlRa+odC9PsJiRJtSETVSd
   wPtzRI9JVUiiSEL9E9Dw3Env7RLKfUj8DIsMaEWyNgV+QDxCzVjL5snQ6
   kk7bGzDrEOXhkMB8TyRdy4waI0ONoikoGuHQKzP47aBV8ymuJJPO8AXBQ
   pnhKPNBmJ18hJn7q0Jq+WaNd7jrzSQnvSSHBJtgPtWJjJE+/ZXjEA3Abr
   6lB2bUYiydfnutgKkDtMfrjr1p8aXMPZ/f/YUPfHorcPk9hP+07z8xtqR
   g==;
X-CSE-ConnectionGUID: +oJ2XfnzSBK7tELKDXiaNg==
X-CSE-MsgGUID: sFxNZisMQWquMcCchWjceA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62012587"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62012587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:26 -0700
X-CSE-ConnectionGUID: o1ZT7FO9RhWQW9Lwf1V9jw==
X-CSE-MsgGUID: Ivp7LAhcRy2TacZggJ3EeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="170199741"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Jun 2025 17:52:17 -0700
Subject: [PATCH 3/6] remote: check branch->merge before access in
 branch_release
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-jk-submodule-helper-use-url-v1-3-6d14c1504e91@gmail.com>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

The branch_release function doesn't check the merge field before
accessing it, based on an assumption that merge will be set if
branch->merge_nr is non-zero.

This is not always the case. It turns out that branch->merge is not
initialized until set_merge() is called, but branch->merge_nr can be
non-zero from handle_config() calling add_merge().

set_merge() is not called until branch_get(). This function does set
merge_nr to zero if merge is not initialized. However, branch_release is
called on every branch when tearing down a repository.

An upcoming change to submodule--helper will initialize the remote state
by calling read_config(). In some cases, this results in branches in the
remote_state which have a non-zero merge_nr but no merge array. This
results in a crash when tearing the repository down.

To fix this, lets simply check if merge is valid before attempting to
release its contents.

This makes it safe to initialize the remote_state for a submodule
repository without crashing on teardown.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 7092b12209d93e20ce1ed3b7d9e4cbac058c57ff..1035f0cd32d034cce05bd2a3d829ec90795ff4e2 100644
--- a/remote.c
+++ b/remote.c
@@ -253,9 +253,11 @@ static void branch_release(struct branch *branch)
 	free((char *)branch->refname);
 	free(branch->remote_name);
 	free(branch->pushremote_name);
-	for (int i = 0; i < branch->merge_nr; i++)
-		refspec_item_clear(branch->merge[i]);
-	free(branch->merge);
+	if (branch->merge) {
+		for (int i = 0; i < branch->merge_nr; i++)
+			refspec_item_clear(branch->merge[i]);
+		free(branch->merge);
+	}
 }
 
 static struct rewrite *make_rewrite(struct rewrites *r,

-- 
2.48.1.397.gec9d649cc640

