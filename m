Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49501288517
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672515; cv=none; b=B5gC37HfOqrPoJgdt6dcl7uzE1JeTIJYw2T6h0q0Xs/ZG1lBi2QdaEb41Ph+WDH7Lnp16Nkixm1VQ0E7dfwQ30HctqRm1klX0/HRd5Hy75yQahCx2JDSNpyUQ0Vgv4ve77WCTPPVzc6basy1smcfUXxmarf6q2raRtHycU9WSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672515; c=relaxed/simple;
	bh=lB+Iy/6kQDhpt1/Fab0+Kolw9VLzvyWyR4EJHW8OM2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgbciHtxg5wy8qlQU34mjcynAKmxpZOgGTQTGJk8VCEcjaSTLzrj4A7eM9QhrvSEY+rXIXAL13fYov7N3noWHxyA2Tlkodxx+gQZ+oUSNDkCdMVvQPgK5H60B1I1iEpz19WR+l1CeDMcUsUbm3XAaUL2rt0F0Ww9NdcZbFAKdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hXpYNBiI; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hXpYNBiI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764672510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FrkNA2ezev/Fq/HnItEgMFJGMj5lqA9kCXxEBnl5ig=;
	b=hXpYNBiIWBB/m83QdDvBDbSfR2im9wG+SxeTXn2ZCfxbttpETlilRDxmaytIYg+abcaDI0
	UuU7ZdkEkzH5ga/ts8Fb/f15K2CYIKs2wLTbVvXVrzleSvEi0X/dmdluvysiNjhjczgwfR
	QTJTmvwZYbAquIwQ3BOqRIYSqOm1Xq0=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 02 Dec 2025 11:48:09 +0100
Subject: [PATCH 2/2] meson: only detect ICONV_OMITS_BOM if possible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-toon-cross-compile-v1-2-cabc8bce529f@iotcl.com>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
In-Reply-To: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In our Meson setup it automatically detects whether ICONV_OMITS_BOM
should be defined. To check this, a piece of code is compiled and ran.

When cross-compiling, it's not possible to run this piece of code. Guard
this test with a can_run_host_binaries() check to ensure it can run.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index f1b3615659..95348e69a4 100644
--- a/meson.build
+++ b/meson.build
@@ -1064,7 +1064,7 @@ if iconv.found()
     }
   '''
 
-  if compiler.run(iconv_omits_bom_source,
+  if meson.can_run_host_binaries() and compiler.run(iconv_omits_bom_source,
     dependencies: iconv,
     name: 'iconv omits BOM',
   ).returncode() != 0

-- 
2.52.0

