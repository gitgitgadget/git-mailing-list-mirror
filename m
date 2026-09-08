Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4819559CB7
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881122; cv=none; b=E6oF91UrZhZpI9LAmg37yAQcKBkj7orrBkSMZzZgcX4kveSvQCLyU3nqYqY4ngJJ/zG2Nzq1bCuMMXgUOs4vVMBWFViQLZXi93B7xOdE625/PWwomFJC2oE2o7aZtONeh8PZX5mGnj4NgYmo83wjP4YnbV+m6PNy3OtET4bK7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881122; c=relaxed/simple;
	bh=xOQHI9cHZ6bwAVS7Gc/nw3EkJ3tsg//qISaJ8y8HZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmQ5pJ8s+nYo/RuN35WPvOp3TyqCd7oKvmfvFarZiBZt2GD/1zrSb704fdCB+4vq3TQS7FUVsQMvzkMydHj0lvshTDdX8M3/udmHfXooY9Eckz6z0bJAqA4cpP/rj0AZrrB2/5Oqba7UASc31vKXN9dCDcGyqtur6fLmcFhAoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ignea.aura.home.arpa (c.d.9.0.0.0.0.0.0.0.0.0.0.0.0.0.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:26c:e6c::9dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: chewi)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BF1B2340BE2;
	Tue, 08 Sep 2026 15:25:09 +0000 (UTC)
From: James Le Cuirot <chewi@gentoo.org>
To: git@vger.kernel.org
Cc: James Le Cuirot <chewi@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rust: respect CARGO_BUILD_TARGET when locating build output
Date: Tue,  8 Sep 2026 16:24:26 +0100
Message-ID: <20260908152425.153131-2-chewi@gentoo.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross-compiling, Cargo always writes to a target-tuple subdirectory
determined by CARGO_BUILD_TARGET, even when it matches the native tuple.
The script looked in $BUILD_DIR/$BUILD_TYPE directly, so it failed to
find (and copy) the freshly built library.

Respect CARGO_BUILD_TARGET in the output path so the correct artifact
is located.

Signed-off-by: James Le Cuirot <chewi@gentoo.org>
---
 src/cargo-meson.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 75f3cd1..3a558aa 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -38,7 +38,7 @@ then
 	exit $RET
 fi
 
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+if ! cmp "$BUILD_DIR/${CARGO_BUILD_TARGET-}/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/${CARGO_BUILD_TARGET-}/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
 fi
-- 
2.55.0

