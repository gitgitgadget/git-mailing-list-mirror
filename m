Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180582E54D7
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309397; cv=none; b=ixUdTDpH5Cop6Ot4A7Yepfat3yk6w6R8/73CJIPwzvk4ULl6EGICvJ54gWpgnS5OMdMsQwzwRpfTKxX0+EMcd/+2y6Wki8ECKyq5cM7gjhk411NCOye/+izJWZlKJx1WvNFupWQpQzn1YGx+qdvng/hV60eklmFeVYGV1XUH5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309397; c=relaxed/simple;
	bh=d7JL0LkSVIQbiFJUeKNahaq7TdvsRE+u+bwwAnUYgq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XiLoRhcBKv9e2Sk2fQKkKbdcWG8OmQ/fpQeGzB0lag232dDF1c34+nL7vddWHSUp4kLDzLVhv3tFXzg/VvTE5UHHAHdhMSmJZzvi9MIR2p/rWALxqZR8PcvAYDDPZoci70jQpfjRz9e115rpynF4dQDJziyyvq2Qg8rL+9Xo+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2k9myzRb; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2k9myzRb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1751309392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3//WUQLp50+ljuM7fwMYfEzypLTKvsE0yWK7OjXQxR4=;
	b=2k9myzRbVu0k0cwAFbU+p9d9gUUmpKToYNikZ6kTcY3+KpQtnjQ83UoJnN93eIMYJx05Dq
	vt9pq4vwIK+XyIPqRXGj3Mf68ptiVDB4AAsWBHqKMVfFrss4bUiwAKzLiNXVuMrZ8y2vMu
	XY7/7AymKOoGds90YbODHxs21ccInbM=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 30 Jun 2025 20:49:24 +0200
Subject: [PATCH RFC v3 2/3] t/perf: add last-modified perf script
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-toon-new-blame-tree-v3-2-3516025dc3bc@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
In-Reply-To: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>
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

diff --git a/t/meson.build b/t/meson.build
index 44eb2a693f..09f83d89ca 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1155,6 +1155,7 @@ benchmarks = [
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

