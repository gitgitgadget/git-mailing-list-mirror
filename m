Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039C412290
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934781; cv=none; b=GDwAJjfzcaSUc+SUI8EB1iAyTw5gYHqfR10HMbXrApwjZ2K+JuMfBgBqjwEVYGN2fvIJDkCtEaNcLFm4/4zBjVn1siWZIveTvTB53Z7Umn8UEtWv4gFz7Wi4ft5QXazSVVU3sO/wEROyhSvem2myjfV0xc+9PzGpd72INdNNeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934781; c=relaxed/simple;
	bh=TyosA1PEysQzjTK6eLA9wuTDzN5Dic1LTGAFT4LwoA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izLYvQxnJ5NL4K3S2yUq7QYwcpNI9TEGXa/VU19DBdoYCuEiBmbVL2Ti82DpchiYJ4iW7tn5MRZLkDvBbr3TdbLN1D0TJa3uK8iEMCBQbM67amEZvZWn1XcdRMXsJwJq6PWYIHAZPwP4EoDA+4Jc2r75u4hCgSECLnZZJ2txbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from naomi (unknown [IPv6:2001:470:1f10:a2:d51e:f6fa:6358:71c8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: floppym)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 38D00341442;
	Wed, 01 Jul 2026 19:39:39 +0000 (UTC)
From: Mike Gilbert <floppym@gentoo.org>
To: git@vger.kernel.org
Cc: adrian.ratiu@collabora.com,
	Mike Gilbert <floppym@gentoo.org>
Subject: [PATCH] meson: restore hook-list.h to builtin_sources
Date: Wed,  1 Jul 2026 15:39:28 -0400
Message-ID: <20260701193928.358825-1-floppym@gentoo.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a racy build failure.

```
builtin/bugreport.c:12:10: fatal error: hook-list.h: No such file or directory
   12 | #include "hook-list.h"
      |          ^~~~~~~~~~~~~

```

hook-list.h must be generated before builtin/bugreport.c is compiled.

Bug: https://bugs.gentoo.org/978326
Fixes: 2eb541e8f2a9 (hook: move is_known_hook() to hook.c for wider use, 2026-04-10)
Signed-off-by: Mike Gilbert <floppym@gentoo.org>
---
 meson.build | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 3247697f74aa..bdc83843e8e0 100644
--- a/meson.build
+++ b/meson.build
@@ -278,7 +278,20 @@ compat_sources = [
   'compat/terminal.c',
 ]
 
+hook_list = custom_target(
+  input: 'Documentation/githooks.adoc',
+  output: 'hook-list.h',
+  command: [
+    shell,
+    meson.current_source_dir() + '/tools/generate-hooklist.sh',
+    meson.current_source_dir(),
+    '@OUTPUT@',
+  ],
+  env: script_environment,
+)
+
 libgit_sources = [
+  hook_list,
   'abspath.c',
   'add-interactive.c',
   'add-patch.c',
@@ -566,19 +579,8 @@ libgit_sources += custom_target(
   env: script_environment,
 )
 
-libgit_sources += custom_target(
-  input: 'Documentation/githooks.adoc',
-  output: 'hook-list.h',
-  command: [
-    shell,
-    meson.current_source_dir() + '/tools/generate-hooklist.sh',
-    meson.current_source_dir(),
-    '@OUTPUT@',
-  ],
-  env: script_environment,
-)
-
 builtin_sources = [
+  hook_list,
   'builtin/add.c',
   'builtin/am.c',
   'builtin/annotate.c',
-- 
2.54.0

