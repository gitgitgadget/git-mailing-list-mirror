Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6D187554
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764151; cv=none; b=Z5RsUXw7wvyjUuM55Ip7BVSpMorma3VnUMDroLJAXiSmVcYGcnugEfcft4jckt4ELhzLBTGJZGIlHaOpnGzfFpJW4dQTlHAo/lkqq7jEU5ETWMvwf7d9MdY/MO5QO5rfhl3dWsYG2tNlGKMHrKjZD8r6qTLxO9DjlaKnvgFDF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764151; c=relaxed/simple;
	bh=8fXTx39+Id2WmAukuX0HFvoimhpw62LDGlvbd6MckeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=suldDs9w2wotKB/bmkeLsK87pmtDLPbB/CM2b2EnHgGZd9aPp4lD6zD4OvyroaiYGiC4HeAZcJc+AywsvkVHKOCr25z5j/RwMNasNqt6sqsfXlF8PhdR0EjHKq0BSVhCs4qyD3fn3jTkyoqUzRPzWY/bRI4V/PZx3oXMeI/d1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pJy/8P2I; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pJy/8P2I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1736764139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RdHR2Ac0iKo6WeZ2kmSyW/ccG6Q9UyU6AIwQA4KPGBs=;
	b=pJy/8P2Ijmm6oUAqlTB0WX/u7zgImtA0yZl8wDhna166Lb9Bqy763rWdrG30CeTe0Q71B0
	FwZJTOe/eq92/RdxnW+MmV84toK4pDgESN5nc5PeJjhqcsiQR4TlH4f8E7ygS+dpYqf/4D
	0lQRRx9Xc4qOBo37MVt8AEux6UwpL2M=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 13 Jan 2025 11:28:04 +0100
Subject: [PATCH] meson: ensure correct version-def.h is used
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
X-B4-Tracking: v=1; b=H4sIALPqhGcC/x2MQQqAMAwEvyI5G2iNXvyKeKg2ag620ooIxb8bv
 e3AzhTInIQz9FWBxJdkiUHB1hXMmwsro3hlaEzTGWsJzxgDLnLjzlnXxelTkHzriRbvJiZQ+Ui
 spz88jM/zAgHXh1loAAAA
X-Change-ID: 20250113-toon-fix-meson-version-3d4d33fdabe3
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

To build the libgit-version library, Meson first generates
`version-def.h` in the build directory. Then it compiles `version.c`
into a library. During compilation, Meson tells to include both the
build directory and the project root directory.

However, when the user previously has compiled Git using Make, they will
have a `version-def.h` file in project root directory as well. Because
`version-def.h` is included in `version.c` using the #include directive
with double quotes, some compilers will look for the header file in the
same directory as the source file. This will cause compilation of
`version.c` ran by Meson to include `version-def.h` previously made by
Make, which might be out of date.

Copy `version.c` to the build directory before compiling it to ensure
`version-def.h` from the build directory is used.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0064eb64f546a6349a8694ce251bd352febda6fe..8ecb22c80e4fc3f194e97c14dbf83f541d72b25b 100644
--- a/meson.build
+++ b/meson.build
@@ -1486,11 +1486,15 @@ version_def_h = custom_target(
   env: version_gen_environment,
 )
 
+# Because most compilers prefer header files in the same directory as the source
+# file, copy version.c to the build directory.
+version_c = fs.copyfile(meson.current_source_dir() / 'version.c', 'version.c')
+
 # Build a separate library for "version.c" so that we do not have to rebuild
 # everything when the current Git commit changes.
 libgit_version_library = static_library('git-version',
   sources: [
-    'version.c',
+    version_c,
     version_def_h,
   ],
   c_args: libgit_c_args,

---

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
change-id: 20250113-toon-fix-meson-version-3d4d33fdabe3

Thanks
--
Toon

