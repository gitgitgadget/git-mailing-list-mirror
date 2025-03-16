Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBEA7483
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742105185; cv=none; b=RXH5uN5Yz4TMuXLA45tPd8YEwYpjD1bD9x5WX8E2Ug9Q5yZouas/jhgdAdD551ADIMbRtS2kD/mmLwL7QtWDjhGy69yZo8eUntHEvTQUkDNba9Tjt+pZplOtwzGu+74UXQ3WsPBPWGhLWw0rz19Q3CV8fjCCYC9roBqtINr4j58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742105185; c=relaxed/simple;
	bh=zKwGd58wrww7FvSMrwDIjpLNHF/qtkYVfi0qHWX2uq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5jXsDTBgUE4ULgrfwybyEDE2rAE+tCzzy7QUvZGwF2Ub3b1O1hF0GtR/tDD3BPgtjRIAVnMQNvrxG8Oi7QAZenxCi0DWxtd83DGfo4bg3sCwJSGjqvdxdxYeEobB+UCVRcIDZY/YtQRLbYSL4J6/vuf/TjoAxR0CZTlueCs3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8C9D4342FF0;
	Sun, 16 Mar 2025 06:06:21 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Sam James <sam@gentoo.org>
Subject: [PATCH] meson: fix perl detection when docs are enabled, but perl bindings aren't
Date: Sun, 16 Mar 2025 02:06:05 -0400
Message-ID: <20250316060605.166364-1-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `perl` variable in meson.build is assigned to a program lookup,
which may have the value "not-found object" if configuring with
`-Dperl=disabled`.

There is already a list of other cases where we do need a perl command,
even when not building perl bindings. Building documentation should be
one of those cases, but was missing from the list. Add it.

Fixes:

```
$ meson setup builddir/ -Ddocs=man -Dperl=disabled -Dtests=false
[...]
Documentation/meson.build:308:22: ERROR: Tried to use not-found external program in "command"
```

Bug: https://bugs.gentoo.org/949247
Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9d..c6241c7a12 100644
--- a/meson.build
+++ b/meson.build
@@ -772,7 +772,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
+if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
   perl_required = true
 endif
 
-- 
2.48.1

