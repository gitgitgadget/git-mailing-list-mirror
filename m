Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFD301491
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773655; cv=none; b=lRNWHhfH4hAIjHjnGKfbd8GgxapObWb2yc23MaGOau+VlZJtpWAkeUxlNEe0gAs3jvtgCqS7RGIQrmMjXDQyGRfNEu50pn6gVGLrBBvIGHOKneuv9Qn9cypiAsniCopdsXWLDbkaxScFKP0/Er2GUds6fwpDyCmItKElEWWLr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773655; c=relaxed/simple;
	bh=ey2Rljm6iViAqG3+Gwi04t1GNHIeN9NuqoKJS7JJYCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMrmogMiZjG26pimI7nZ2KOmCNEHQ6HLby+iSyzz1NHg0rEd21G2a7pC7yEka7PYWXqz+WLZ6X4Udgwnv53795qRzKpqMe7leXYgESHkYaEuYn82yCVpyQa1F/36Kqcptjxm/FHXaRX3H03blEZzPBczskLwuGNNZq51U+Ih1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=q7X7vFs3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="q7X7vFs3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764773643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jNUrHHljlIccnG9uwPzjlCgxzeOVe5HGMDNu61ches=;
	b=q7X7vFs3MunikC6MJ/yJ5gLVGVbWhbTZgPZPcLR+5+8yEzxxC4w1vZ4rrf5EqA9/4fGX+Y
	r29KWY5lQod8OLLTp9yp7WUgdSxWrFu6H4kHmtjvgle4Bd4OXjGm0ivSac7CK41qaLUrmW
	nQwx3O+FJiznAUCltIOUyWBH5aq3hT8=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	ps@pks.im
Subject: [PATCH 3/2] meson: use is_cross_build() where possible
Date: Wed,  3 Dec 2025 15:53:31 +0100
Message-ID: <20251203145331.621529-1-toon@iotcl.com>
In-Reply-To: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In previous commit the first use of meson.can_run_host_binaries() was
introduced. This is a guard around compiler.run() to ensure it's
actually possible to execute the provided.

In other places we've been having the same issue, but here `not
meson.is_cross_build()` is used as guard. This does the trick, but it
also prevents the code from running even when an exe_wrapper is
configured.

Switch to using meson.can_run_host_binaries() here as well.

There is another place left that still uses `not
meson.is_cross_build()`, but here it's a guard around fs.exists(). That
function will always run on the build machine, so checking for
cross-compilation is still in place here.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 95348e69a4..00ad8a5c60 100644
--- a/meson.build
+++ b/meson.build
@@ -1492,7 +1492,7 @@ if not has_bsd_sysctl
   endif
 endif

-if not meson.is_cross_build() and compiler.run('''
+if meson.can_run_host_binaries() and compiler.run('''
   #include <stdio.h>

   int main(int argc, const char **argv)
--
2.52.0
