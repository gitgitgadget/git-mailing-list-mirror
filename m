Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7552550DC8
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904577; cv=none; b=Kv+7jWCXHIs7j1vO92ITHej8y71HFRafxa7XBk1AO/AmSEbapklTIM94ylCEjUrLOuHu50Ha4Ni3EfKIstlLYfNINBHPdg/cjBzIppLzsE9LWElc9MKEy2rT1Fz14WPwjm5MT1FQk+13Guj6fUi0U33TKsjlTo42cdnjDFH9mtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904577; c=relaxed/simple;
	bh=DOY2MhBlkE06vSnU9DywLcbwbEvEZKVJrQz2dpusCF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNy/+3lSihPt10opa33toTnEQ0GUq61kQdL013Sz6GfQlj1UN0wpRFNJgX+SJkGr9jTnWl+/KWzjawlH+BkocVQqVK1eBGXlTgb7zCNPcuJjgXyC5mNAVLZzdbZZOWfGWpXnNIOVrLJTPgd8IxGwAtgDAIL52IcAArNs2TVIjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ignea.aura.home.arpa (c.d.9.0.0.0.0.0.0.0.0.0.0.0.0.0.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:26c:e6c::9dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: chewi)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6639A340F28;
	Tue, 08 Sep 2026 21:56:14 +0000 (UTC)
From: James Le Cuirot <chewi@gentoo.org>
To: gitster@pobox.com
Cc: chewi@gentoo.org,
	git@vger.kernel.org
Subject: [PATCH v2] rust: respect CARGO_BUILD_TARGET when locating build output
Date: Tue,  8 Sep 2026 22:53:45 +0100
Message-ID: <20260908215344.24843-2-chewi@gentoo.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqo6e7yaw1.fsf@gitster.g>
References: <xmqqo6e7yaw1.fsf@gitster.g>
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

> Nowhere in the above description I see mention of meson, but the
> patch is only to cargo-meson that is referenced by src/meson.build
> which invites a few questions:
>
>  * Does "make" work fine without any change similar to this?
>
>  * Shouldn't the commit title say "meson" somewhere if this change
>    is only for "meson" driven build?

Good point. I hadn't realised that Make is still supported. I have now
amended the Makefile and tested both the native and cross cases.

 Makefile           | 4 ++--
 src/cargo-meson.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 1cec251..5cd5889 100644
--- a/Makefile
+++ b/Makefile
@@ -940,9 +940,9 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a

 ifdef DEBUG
-RUST_TARGET_DIR = target/debug
+RUST_TARGET_DIR = target/$(CARGO_BUILD_TARGET)/debug
 else
-RUST_TARGET_DIR = target/release
+RUST_TARGET_DIR = target/$(CARGO_BUILD_TARGET)/release
 endif

 ifeq ($(uname_S),Windows)
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
