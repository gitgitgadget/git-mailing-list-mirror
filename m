Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDA299ABD
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074810; cv=none; b=VOC7FW3hZPa+iRlERCYWFy9m3FymqPLfrLQZx/Foer7dlAXZgiGFC7vUeBmpASXGoM76ckdLRo/Prk9QW+Q6/XUhvHOKTnDqQcyYUBu6GoWPIRQy3kMix8eaugavl/y0RxmRKCBexus4PJcFVlZPCVlJLIjzYbrgfmQ810gfTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074810; c=relaxed/simple;
	bh=RwYQvJZ0sHHw4QrwR5oZ5gDEAVuvC2tsaR8XrkkIxmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enyRjmjq/ioX+vM3so/uJYD/FM2MJplekL7mRLG2IX5pkQs7fuTgmqr4wMVoTeOKbQ03mGWBG8Rp1e0SYyPbn15KSx1Wmj1E0h/iJ+d3khFv2f53r8X9k+W10w7CItrXpNFl7gXfLaKaT1NnR3W91AHCk+q3xS1+14Yji2oXEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=f9NLGzk2; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="f9NLGzk2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752074806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=no5T5PdcOPLzmUDsovrSMuSHxnmnUo9cvRPYlRu78LA=;
	b=f9NLGzk2NqwRsz0q6aA7Y/ccBZ2UGOyMpDJPCi+S+NrGIKhy833A6/DqbC5+KB0xf7mijH
	S/oNDtiyoNZGm+fmWohdwJfQZi9r1Cx4czh/S39BhADaL247ikyL8Te/71z5rL1A1dbDvZ
	NTiB7KhJ+LB8UlDg/vud7nuHIYdHSaE=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 2/3] t/perf: add last-modified perf script
Date: Wed,  9 Jul 2025 17:26:27 +0200
Message-ID: <20250709152628.1644521-3-toon@iotcl.com>
In-Reply-To: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
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
index eee1863eb3..b41dfc41d7 100644
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
2.50.0.rc0.18.gfcfe60668e

