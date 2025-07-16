Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC501C5D44
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672951; cv=none; b=RiBNJTc8yQe1+k71oR252B02WORvo3By0OSQ6C/d5+ID1TMV9pYTX6d8/6vcZmrID7wRDLtrv863sKilvPSxDTJfRbL9EzYxZkrEzYMBR0MlJHu9dWaCNMBbjEHeaEVoFnvauFgdfZmOWHCS7xn0TGgrw9wEvrzcPNK94XGWkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672951; c=relaxed/simple;
	bh=qeDfQbFr33Xpoq06ferjTPKesUR5M3EIXlwsz+5ZGp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwGRgVSLWyjlVhtIDkmmHKBIsa3f4u01TtkhTDC29Q3SzuCy+BCphNIKh1CcDUVbzNIdSKH/g0h/lRR7qYFMKfCPIefEQRXGA2O5PjtpdqmX1OAYZgghYBr+yfGol5SeFIss4CiyA1RG3U6eeoMIMKseckBv8DijqRyypv95YmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YB/KWRr8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YB/KWRr8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752672947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoT5vdVTzpsuaDoleVUCtyqk/zYzIrMlMJ6VZGlsSoQ=;
	b=YB/KWRr81CpjfOK0zUQ4EOoYe95YogJFnkutsaRhGa922IZ3aMeBNxTtCp6iU3XMns3eYW
	AkdxyHBeu0MhXRwfrgHKj7fN4uielK2urQ28IL7TEqGcymiUPsg8sIPJ9oUPNw2bwCfACG
	4SbJ9ENjfeheVpSyQ8ZAFjpRGOA207g=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 2/6] t/perf: add last-modified perf script
Date: Wed, 16 Jul 2025 15:35:14 +0200
Message-ID: <20250716133518.1788126-2-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This just runs some simple last-modified commands. We already test
correctness in the regular suite, so this is just about finding
performance regressions from one version to another.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/meson.build                 |  1 +
 t/perf/p8020-last-modified.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100755 t/perf/p8020-last-modified.sh

diff --git a/t/meson.build b/t/meson.build
index fc77343331..567d524e91 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1154,6 +1154,7 @@ benchmarks = [
   'perf/p7820-grep-engines.sh',
   'perf/p7821-grep-engines-fixed.sh',
   'perf/p7822-grep-perl-character.sh',
+  'perf/p8020-last-modified.sh',
   'perf/p9210-scalar.sh',
   'perf/p9300-fast-import-export.sh',
 ]
diff --git a/t/perf/p8020-last-modified.sh b/t/perf/p8020-last-modified.sh
new file mode 100755
index 0000000000..a02ec907d4
--- /dev/null
+++ b/t/perf/p8020-last-modified.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='last-modified perf tests'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_perf 'top-level last-modified' '
+	git last-modified HEAD
+'
+
+test_perf 'top-level recursive last-modified' '
+	git last-modified -r HEAD
+'
+
+test_perf 'subdir last-modified' '
+	path=$(git ls-tree HEAD | grep ^040000 | head -n 1 | cut -f2)
+	git last-modified -r HEAD -- "$path"
+'
+
+test_done
--
2.50.1.327.g047016eb4a
