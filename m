Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14913C76BE
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035830; cv=none; b=K63bv3noj+ID5F99m+374vH9FmsFFGIsl4Cm1oiJfl22otiawDKNXp9Ro4tx6M9j8es4Jf6c2/Gn6R1+bGDPTq6XHvf6vCPnFxvM31iGxJcY6S+RLkc0cwUtw3Vvr9nZd1WDFRue6Z0yPI4No+8DZz39kTDgFJKPDse2l8Owa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035830; c=relaxed/simple;
	bh=mL7Pu9y3FzOMA00Swgf0hBCsxSOFLjt/kk0gx5rgkLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLsYGFTo+FC76/g5K3+DbQER2/TmqGzjyz3eSKC3vmuHKA4NAxqnEjLAJ40s8523vv7sTEs1POEf4SJWANiXuWNaSkZs25RW7F/WIBRC+ytmIV8iIBrVuyfksprMrUvgPEOtHnD3bqqxGwTlghv/iTQjDH/MYamipg/2wdNxHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ignea.aura.home.arpa (c.d.9.0.0.0.0.0.0.0.0.0.0.0.0.0.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:26c:e6c::9dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: chewi)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2CC77341B2B;
	Thu, 10 Sep 2026 10:23:46 +0000 (UTC)
From: James Le Cuirot <chewi@gentoo.org>
To: gitster@pobox.com
Cc: chewi@gentoo.org,
	git@vger.kernel.org
Subject: [PATCH v3] rust: respect CARGO_BUILD_TARGET when locating build output
Date: Thu, 10 Sep 2026 11:20:14 +0100
Message-ID: <20260910102013.1235066-2-chewi@gentoo.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqq4ifyqjdi.fsf@gitster.g>
References: <xmqq4ifyqjdi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross-compiling, Cargo always writes to a target-tuple subdirectory
determined by CARGO_BUILD_TARGET, even when it matches the native tuple.
The build looked in $BUILD_DIR/$BUILD_TYPE directly, so it failed to
locate the freshly built library.

Respect CARGO_BUILD_TARGET in the output path so the correct artifact
is located.

Signed-off-by: James Le Cuirot <chewi@gentoo.org>
---

> This seems to be based on a bit stale codebase.  Specifically you
> would want to build on top of post-924dfced6b (Makefile: support
> universal macOS builds via RUST_TARGETS, 2026-07-08) version of
> Makefile.

Apologies, I had used the maint branch. Now rebased on master.

> When CARGO_BUILD_TARGET is not defined, this leaves double slashes
> in the resulting pathname, which may not be incorrect per-se, but
> still is not what you meant to say, which is probably a lot closer
> to
>
>     ${CARGO_BUILD_TARGET+$CARGO_BUILD_TARGET/}

I believed this would not cause an issue, so I intentionally went with
simplicity over correctness. It's not a big difference though, so this
revision goes with correctness.

 Makefile           | 2 +-
 src/cargo-meson.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d4b7759..f0ca2e4 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
 else
 RUST_LIB_NAME = libgitcore.a
 endif
-RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
+RUST_LIB = target/$(if $(CARGO_BUILD_TARGET),$(CARGO_BUILD_TARGET)/)$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif

 GITLIBS = common-main.o $(LIB_FILE)
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 75f3cd1..83c7e7b 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -38,7 +38,7 @@ then
 	exit $RET
 fi

-if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+if ! cmp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
 fi
--
2.55.0
