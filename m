Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C921C16B
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357128; cv=none; b=uestb+EAZevcHxPvLMK4TPMpBBa2eJ+xMDV9QR23RXx6QWY1OodEN05qBzhWh+iW6gGl2JCkjl1N2adPlzjzP772TgxUQGig/jkK+uYh8mNVkT7JYR5Zcr8wj/ZSVXapBhLDo1ZzQ8sIghDStIgOqYeVyi/BiZIix+XMt29iG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357128; c=relaxed/simple;
	bh=+huLwaWYG8zjK/r/YGTani1UAZNVjRCuJAp6yqoayqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/poz5TyqmVngRPP60Ics4Y+fA71v4bRMS864KMf78n+bNOcECTt1H2Df9UgKMJfwhZm95s+rfjuKV4xhlQUdePD/QEmvIcIOU3ITzaxA2RWcQ5hNXogWdzPs1qtW0bryR88stLb+1MBNVsQOGCcLCPLIpKIdLCJDdnORxC1yiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fb3nRxbA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fb3nRxbA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1741357124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJhEcUgp6w2sG9RhaENEDzyIS5MqG42MmWbQsPsXMcs=;
	b=fb3nRxbAQA5hXa5Po5KmbCIMasJNmm3et0fEuxn91DDG30/AN2Sw0MfrxwWD2lplPZNiwU
	e8+cIakc5pRAhI095RDADPV6/31Am77ea9nNQHuuvH25Mt8zbt3FXX5CIwWEonX2Trc7/s
	mCx0fRU2fj6y8BiXdp514RDFsa48Q/k=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 07 Mar 2025 15:18:08 +0100
Subject: [PATCH 2/2] help: print zlib-ng version number
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-toon-zlib-git-version-v1-2-5e8069752bb9@iotcl.com>
References: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
In-Reply-To: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When building against zlib-ng, the header file `zlib.h` is not included,
but `zlib-ng.h` is included instead. It's `zlib.h` that defines
`ZLIB_VERSION` and that macro is used to print out zlib version in
`git-version(1)` with `--build-options`. But when it's not defined, no
version is printed.

`zlib-ng.h` defines another macro: `ZLIBNG_VERSION`. Use that macro to
print the zlib-ng version in `git version --build-options` when it's
set. Otherwise fallback to `ZLIB_VERSION`.

Signed-off-by: Toon Claes <toon@iotcl.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
---
 help.c               | 4 +++-
 t/t0091-bugreport.sh | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 707cd59b79..c54bd9918a 100644
--- a/help.c
+++ b/help.c
@@ -798,7 +798,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 #if defined OPENSSL_VERSION_TEXT
 		strbuf_addf(buf, "OpenSSL: %s\n", OPENSSL_VERSION_TEXT);
 #endif
-#if defined ZLIB_VERSION
+#if defined ZLIBNG_VERSION
+		strbuf_addf(buf, "zlib-ng: %s\n", ZLIBNG_VERSION);
+#elif defined ZLIB_VERSION
 		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
 #endif
 	}
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index e11d819b62..e38ca7a901 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -47,7 +47,8 @@ test_expect_success 'sanity check "System Info" section' '
 	# This is bound to differ from environment to environment,
 	# so we just do some rather high-level checks.
 	grep "uname: ." system &&
-	grep "compiler info: ." system
+	grep "compiler info: ." system &&
+	grep "zlib." system
 '
 
 test_expect_success 'dies if file with same name as report already exists' '

-- 
2.49.0.rc1.410.g72b47a15e9

