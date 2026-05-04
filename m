Received: from mail.thalheim.io (mail.thalheim.io [135.181.61.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF237DE85
	for <git@vger.kernel.org>; Mon,  4 May 2026 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.61.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890483; cv=none; b=dmZNQR5VBmC0VNLLDZ2jDufGq74X+q2AuKJy5jAo7ZEFmv6tqR1NaNKYh9R8ygPEmcFnahy4Ai7SDHJFCN32RReoANSTPWBmAbUTkTO466dY732UHY3FNjjmMruu6ebU6rz3oGWCSA2M9ihmCrDnKKL1RNiVnckp1y8Bx5t2dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890483; c=relaxed/simple;
	bh=0w0oDWeLqLO+NRIlqwiQt9HwJFQBR8pxFNabvZ6WR+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gYp98N5bLJQS34RF7+5HOZNdnxiBlw79NNvOav6pTDHnn5mKZ5p90yNhKmLpTaiWQKZQEwkErAB4pAu2RXGFauRHfmKl94s05E5DCWGCO2kn5yRauz4fKav9SqfEI1d89hYp2S4cBL1EPvocIvANf910SS2Nok5ZULYxVLsiFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=HoOEKGzs; arc=none smtp.client-ip=135.181.61.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="HoOEKGzs"
Received: from localhost (unknown [IPv6:2001:a61:2ae0:7401:c7d2:98c5:338e:745])
	by mail.thalheim.io (Postfix) with ESMTPSA id ACD61D404EC;
	Mon, 04 May 2026 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1777889675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oweITehqjOWI2lyCcbZAIuVFxBWR2yUfiVBT1DVCSjY=;
	b=HoOEKGzs13bAwLWnqBqu7EfymliR/+983eGU++71Eq34uXqduTwJp0bN9kiuffVCtTsVGo
	LlOFQfhV8R45AEesI2Qkj/HIQuUWp6XHzZG1hNOa3Xc8TtVKjqVVMHTB2ZLLMbbnPzSjgx
	uaME+31ea/W8mXVeA/rWMSiE+UZ/hG8=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@thalheim.io smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH] t7703: ignore 'total' line when comparing ls -l output
Date: Mon,  4 May 2026 12:14:29 +0200
Message-ID: <20260504101429.340123-1-joerg@thalheim.io>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

The 'total N' header from ls -l reports the block count, which on
copy-on-write or compressing filesystems such as ZFS can change between
two back-to-back invocations even when the directory contents are
identical. The MIDX retention checks introduced in 6ce9d558ce
(midx-write: skip rewriting MIDX with --stdin-packs unless needed,
2025-12-11) compare full ls -l output and thus fail spuriously on such
filesystems. Strip the header line before comparing.

Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
---
 t/t7703-repack-geometric.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 04d5d8fc33..9b5a428620 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -299,9 +299,9 @@ test_expect_success '--geometric --write-midx retains up-to-date MIDX without bi
 		test_path_is_file .git/objects/pack/multi-pack-index &&
 		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
 
-		ls -l .git/objects/pack/ >expect &&
+		ls -l .git/objects/pack/ | sed 1d >expect &&
 		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
-		ls -l .git/objects/pack/ >actual &&
+		ls -l .git/objects/pack/ | sed 1d >actual &&
 		test_cmp expect actual
 	)
 '
@@ -316,9 +316,9 @@ test_expect_success '--geometric --write-midx retains up-to-date MIDX with bitma
 	test_path_is_file repo/.git/objects/pack/multi-pack-index &&
 	test-tool chmtime =0 repo/.git/objects/pack/multi-pack-index &&
 
-	ls -l repo/.git/objects/pack/ >expect &&
+	ls -l repo/.git/objects/pack/ | sed 1d >expect &&
 	git -C repo repack --geometric=2 --write-midx --write-bitmap-index &&
-	ls -l repo/.git/objects/pack/ >actual &&
+	ls -l repo/.git/objects/pack/ | sed 1d >actual &&
 	test_cmp expect actual
 '
 

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.53.0

