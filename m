Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE423A9A0
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870166; cv=none; b=H3h+Ofhimoe+fw6hN/q+7VuXsYv7uTLhBV/eD4X+GIGPRNJDvdPLMcT99YBU4ePFDOP9eYPg9gmcDKvRDNTOW9dENwdVdTMgwMM7nyxjvf/oZRuaHVIAarQ4cmLZ/rt4wkpyoAWtev11CC6D/1KlIe0FuYiCedvasrOSvwjlnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870166; c=relaxed/simple;
	bh=ri4OAQ3BjJB5N+RvDF9TVjFGrLV3rWxmwhsMRgnHNCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O83HFgNcY0EDg8P4XEUWkRMtYyhcRowoiyxcYVfpKNDsjcvGYaFD5SeE578OJropU99wDnG4XCJpxPJqicSTUifqPtNwTwWWp0EUyXuAtI5PTrEU6IhARXGqUPNq+fW6imdfnwhQOyt03Wd9Xl3r1QrI/1TxPjpc5s5/y9oMgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esSYxRRW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esSYxRRW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870165; x=1779406165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ri4OAQ3BjJB5N+RvDF9TVjFGrLV3rWxmwhsMRgnHNCs=;
  b=esSYxRRWBVlIOJJUxBguzvd/frolT4Ozu/US782vVilqCQsZ7j40IYY6
   MlUE84K88cwsf/fL0YprZWg1L1CaD1ghWS1stE3y33/UwCAO08zPihVhu
   yQBbYB5NoeCOnea4TecTtkdTgWpYqfzVtjB2SFNgE/WKVdAMlSkpJxGLG
   5CAavn3FJzUcrtRaV88BJ7LwD4AXPVaS75nR38UFA+8D7r0/hRSgASIlu
   fq8h3quM1lpX8czT3ydH5Su479JPH2RbkmWg6trmuh3+3im3kAvm3GIz+
   gM+NVchz7Az5dCa74bzGzaBHFmFVb5/Pk/T/Ge24X60Sa7zVO40qRL79Q
   A==;
X-CSE-ConnectionGUID: 3RB7uzGvS6a8BzcpGViqyg==
X-CSE-MsgGUID: /onP3aQpTW+ZQOCrX1TBvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75271678"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="75271678"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:22 -0700
X-CSE-ConnectionGUID: higxkGieScifhlF7YOTf0Q==
X-CSE-MsgGUID: N+3GG5uxSA2mAQwNwXEGnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140072360"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 1/3] pathspec: add match_leading_pathspec variant
Date: Wed, 21 May 2025 16:29:15 -0700
Message-ID: <20250521232917.2333291-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
In-Reply-To: <20250521232917.2333291-1-jacob.e.keller@intel.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

The do_match_pathspec() function has the DO_MATCH_LEADING_PATHSPEC
option to allow pathspecs to match when matching "src" against a
pathspec like "src/path/...". This support is not exposed by
match_pathspec, and the internal flags to do_match_pathspec are not
exposed outside of dir.c

The upcoming support for pathspecs in git diff --no-index need the
LEADING matching behavior when iterating down through a directory with
readdir.

We could try to expose the match_pathspec_with_flags to the public API.
However, DO_MATCH_EXCLUDES really shouldn't be public, and its a bit
weird to only have a few of the flags become public.

Instead, add match_leading_pathspec() as a function which sets both
DO_MATCH_DIRECTORY and DO_MATCH_LEADING_PATHSPEC when is_dir is true.

This will be used in a following change to support pathspec matching in
git diff --no-index.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 pathspec.h |  6 ++++++
 dir.c      | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/pathspec.h b/pathspec.h
index de537cff3cb6..cda3eb5b91f7 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -184,6 +184,12 @@ int match_pathspec(struct index_state *istate,
 		   const char *name, int namelen,
 		   int prefix, char *seen, int is_dir);
 
+/* Set both DO_MATCH_DIRECTORY and DO_MATCH_LEADING_PATHSPEC if is_dir true */
+int match_leading_pathspec(struct index_state *istate,
+			   const struct pathspec *ps,
+			   const char *name, int namelen,
+			   int prefix, char *seen, int is_dir);
+
 /*
  * Determine whether a pathspec will match only entire index entries (non-sparse
  * files and/or entire sparse directories). If the pathspec has the potential to
diff --git a/dir.c b/dir.c
index a374972b6243..86eb77b82a79 100644
--- a/dir.c
+++ b/dir.c
@@ -577,6 +577,16 @@ int match_pathspec(struct index_state *istate,
 					 prefix, seen, flags);
 }
 
+int match_leading_pathspec(struct index_state *istate,
+			   const struct pathspec *ps,
+			   const char *name, int namelen,
+			   int prefix, char *seen, int is_dir)
+{
+	unsigned flags = is_dir ? DO_MATCH_DIRECTORY | DO_MATCH_LEADING_PATHSPEC : 0;
+	return match_pathspec_with_flags(istate, ps, name, namelen,
+					 prefix, seen, flags);
+}
+
 /**
  * Check if a submodule is a superset of the pathspec
  */
-- 
2.48.1.397.gec9d649cc640

