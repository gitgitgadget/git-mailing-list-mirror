Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A262475F7
	for <git@vger.kernel.org>; Tue, 20 May 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699296; cv=none; b=saMbSJC+EWDc2X5qTvZL0k8o6j5/PYolQtyfYJ0WE+1cPb8kXTtVohbB11/Y1panYfJ0krbZRRQxuymhDuIOM4Jjg2+TMDs5d7/ZCnZG7TmoiZTKYvsTpWSQvuoTCC7Ed/Gf8W8ykk19a277di5/nH0hTXwHbwHip2yZ2U/hRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699296; c=relaxed/simple;
	bh=RqIDdD825TaaL7QY7UR3bmy6+hd4u+1HUWh5zI85hEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JemsHVZkfUhBzcdlVthQACcmrQWrHX+X/IgnMDbkDBXBcsJg2wdUJ8TBMVi1LICn2R91fvsFIZ/zzfeRWQYa3gc4jMGqVrC080jU5uuJVxG74ez1altXcewzogfC2Ptlx0dYanzNt5NRTKnZx56aqTkJAm8SDVbDgpaj9IS0Bkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7MADrL7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7MADrL7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747699296; x=1779235296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RqIDdD825TaaL7QY7UR3bmy6+hd4u+1HUWh5zI85hEw=;
  b=l7MADrL7+favFlgmiKrwy56Ec1wGtlrzSlolIgAoObukVlzxSzIRSmLt
   j+Es5he3CNX8Yq2uZ7FYm+Pn3oLpPgvapzmIWaGwc8nZ5KIrUIqTFuUin
   VIbVo62/D5wcFxrZqDY3z3xPvPxzrrUc0Ogqph3atPOEXIyR5+SrJ313I
   lLxeOJcyFNktLg9vWSTuQftFWNOQoS9BNV68mb/GGbsL2/x1GAcqZkM3K
   90XY9SssOVHuIHWxy2kPOAvOKD3cwGN7ctPsj97HCHYEuEpyIGLbB/ux5
   +syZTb7eNJ6/vXIkXd/xbn7ZzBQQGrGtSdGsMUejeIDSkRO1UUzNBJ5fw
   g==;
X-CSE-ConnectionGUID: LGP1eP6jTlmGT9zJpujv7w==
X-CSE-MsgGUID: EO5JKOnxRrqyToNX38iVcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72125819"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72125819"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:32 -0700
X-CSE-ConnectionGUID: 0VKHERhHQoqgNDdtLNsgUA==
X-CSE-MsgGUID: bIPEmmKzS067pzessuBJAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139559136"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 1/4] prefix_path: support prefixes not ending in trailing slash
Date: Mon, 19 May 2025 17:01:22 -0700
Message-ID: <20250520000125.2162144-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
In-Reply-To: <20250520000125.2162144-1-jacob.e.keller@intel.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

The prefix_path_gently() -- and its wrapper prefix_path() -- function
normalizes the provided path and optionally adds the provided prefix to
relative paths. If the prefix does not end in a trailing slash, the
function will combine the last component of the prefix with the first
component of the relative path. This is unlikely to produce a desirable
result.

Teach prefix_path_gently() to check if the prefix ends in a slash. If it
does not, then insert a slash between the prefix and the path. Take care
to avoid inserting a slash if the prefix is empty.

Add test cases to cover the relative path behavior, which was previously
untested.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 setup.c               |  4 +++-
 t/t0060-path-utils.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index f93bd6a24a5d..bd2888500817 100644
--- a/setup.c
+++ b/setup.c
@@ -139,7 +139,9 @@ char *prefix_path_gently(const char *prefix, int len,
 			return NULL;
 		}
 	} else {
-		sanitized = xstrfmt("%.*s%s", len, len ? prefix : "", path);
+		sanitized = xstrfmt("%.*s%s%s", len, len ? prefix : "",
+				    !len || prefix[len - 1] == '/' ? "" : "/",
+				    path);
 		if (remaining_prefix)
 			*remaining_prefix = len;
 		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 8545cdfab559..9274713aea0c 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -307,6 +307,24 @@ test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink
 	test_cmp expect actual
 '
 
+test_expect_success 'prefix_path works with relative path' '
+	echo "prefix/a" >expect &&
+	test-tool path-utils prefix_path "prefix/" "a" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'prefix_path works with relative path and prefix not ending in /' '
+	echo "prefix/a" >expect &&
+	test-tool path-utils prefix_path "prefix" "a" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'prefix_path works with relative path and empty prefix' '
+	echo "a" >expect &&
+	test-tool path-utils prefix_path "" "a" >actual &&
+	test_cmp expect actual
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
2.48.1.397.gec9d649cc640

