Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF82FBE0D
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372436; cv=none; b=IGGQm8Z2fuCcyWuD2C/vd5T80KTAdlMUCAnVFAbiSrKvA2+x0APfStWjRKofFEm5qB5xFus6RJdXGlUmzlnRL7I4lh6CEy74VyG0cAB531+FfW0N/myGeKJrRlU5r8OMq8o5xolPuEP9FXyIZ3sYUuHfj8tQ+8UsHu+Kyj2W6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372436; c=relaxed/simple;
	bh=Vydkkd4CQ1c4yP4AyVHoFFL6mqdhgBT625rt1PaIs2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnHJWsAZW0ZvJAzJf5Rv6ubatoO0ySmuMlF0aTzrn6qyYkDkocsLXOm592XEW3TJHUpv1a0rmmJybhYpv1bBhqqgZuTe9yfew5g1Iz/CZWR1urUD0bBYjRY7TD/mGtyMGGYzM7i/7wpGx4HL2dthEIgIgC0vdauTKdWoLbcDlU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=lIlPH/Cg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="lIlPH/Cg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765372432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI07jitmnOLAcL0fOkxRJRGyS4FqdMsWTmoKyM5rQcg=;
	b=lIlPH/Cg3nBPpVZvgPVG1n6eaEU4X+GMjWNyVEUXwAkbbrTaE6JH5+2uiqOzycSfOATLsP
	VAHjRhIBx3J9A6xq12+i+1e/osLuIalYzmt+Yjc2We8mVw6QZlcMLJJn7gCkqZDCx/F6n8
	AB+/qSAXUMPFIRS90jiv2lJq9YRA0Ls=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 10 Dec 2025 14:13:02 +0100
Subject: [PATCH 2/2] contrib/coccinelle: pass include paths to spatch(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-toon-cocci-memzero-v1-2-ae916a79065b@iotcl.com>
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
In-Reply-To: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In the previous commit a new coccinelle rule is added. But neiter
`make coccicheck` nor `meson compile coccicheck` did detect a case in
builtin/last-modified.c.

This case involves the field `scratch` in `struct last_modified`. This
field is of type `struct bitmap` and that struct has a member
`eword_t *words`. Both are defined in `ewah/ewok.h`. Now, while
builtin/last-modified.c does include that header (with the subdir in the
#include directive), it seems coccinelle does not process it. So it's
unaware of the type of `words` in the bitmap, and it doesn't recognize
the rule from previous commit that uses:

    type T;
    T *ptr;

Fix coccicheck by passing all possible include paths inside the Git
project so spatch(1) can find the headers and can determine the types.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Makefile                       | 2 +-
 contrib/coccinelle/meson.build | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6fc322ff88..46d07b2d52 100644
--- a/Makefile
+++ b/Makefile
@@ -981,7 +981,7 @@ SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
-SPATCH_INCLUDE_FLAGS = --all-includes
+SPATCH_INCLUDE_FLAGS = --all-includes $(addprefix -I ,compat ewah refs sha256 trace2 win32 xdiff)
 SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
 
diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index dc3f73c2e7..ae7f5b5460 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -50,6 +50,11 @@ foreach header : headers_to_check
   coccinelle_headers += meson.project_source_root() / header
 endforeach
 
+coccinelle_includes = []
+foreach path : ['compat', 'ewah', 'refs', 'sha256', 'trace2', 'win32', 'xdiff']
+  coccinelle_includes += ['-I', meson.project_source_root() / path]
+endforeach
+
 patches = [ ]
 foreach source : coccinelle_sources
   patches += custom_target(
@@ -58,6 +63,7 @@ foreach source : coccinelle_sources
       '--all-includes',
       '--sp-file', concatenated_rules,
       '--patch', meson.project_source_root(),
+      coccinelle_includes,
       '@INPUT@',
     ],
     input: meson.project_source_root() / source,

-- 
2.52.0

