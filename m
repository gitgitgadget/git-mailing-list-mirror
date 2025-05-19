Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDA284B5F
	for <git@vger.kernel.org>; Mon, 19 May 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674593; cv=none; b=SYwZMdXsjA7PzccO3NW7XuinIeMe59cHonGcjF7LJ07h1oiju32nHB09RtbxyJuqt/0CUAXmLkFL0wc0au7qxV7wWSDUAPoWGan6aysMu1HGZJGul2TURRjcGlx8V1ge2CrY8E4sl+xN50C5jIWtl/QdPJKYZrORt2S9Gs8TXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674593; c=relaxed/simple;
	bh=aajX4f/9l74D5luDm/qHjYjJb5qgx5wd2P4qYQJqrY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBA/bZHsqPplmBYfChPMHysZr/q9JKnIU/bLkwj5knvWt7H/4B2YagNj6NLbAN+48uWAEC6Gr2izli0yjkAXFsxh+eNJ37Y17UBO2UX3qUtupfE5PVC+jglhZGDIvNe7iV43dTY8CLKcgaSfjzRn8gcNCzjk/eFaZG/gnGhqbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A39523430F8;
	Mon, 19 May 2025 17:09:50 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] meson: reformat default options to workaround bug in `meson configure`
Date: Mon, 19 May 2025 13:09:42 -0400
Message-ID: <20250519170945.57746-1-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 13cb20fc46 ("meson: fix compilation with Visual Studio",
2025-01-22) it has not been possible to list build options via `meson
configure`. This is due to Meson's static analysis of build options
failing to handle constant folding, and thinking we set a totally
invalid default `-std=`.

This is reported upstream but we anyways need to work with existing
versions. It turns out there is a simple solution: turn the entire
default option into a conditional branch, which means Meson sees either
nothing, or everything.

As a result, Git users can once again see pretty-printed options before
building.

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Bug: https://github.com/mesonbuild/meson/issues/14623
Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index a1476e5b32..43fc3afdf5 100644
--- a/meson.build
+++ b/meson.build
@@ -215,14 +215,12 @@ project('git', 'c',
     capture: true,
     check: true,
   ).stdout().strip() : 'unknown',
-  default_options: [
-    # Git requires C99 with GNU extensions, which of course isn't supported by
-    # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
-    # learned to define __STDC_VERSION__ with C11 and later. We thus require
-    # GNU C99 and fall back to C11. Meson only learned to handle the fallback
-    # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
-    'c_std=' + (meson.version().version_compare('>=1.3.0') ? 'gnu99,c11' : 'gnu99'),
-  ],
+  # Git requires C99 with GNU extensions, which of course isn't supported by
+  # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
+  # learned to define __STDC_VERSION__ with C11 and later. We thus require
+  # GNU C99 and fall back to C11. Meson only learned to handle the fallback
+  # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
+  default_options: meson.version().version_compare('>=1.3.0') ? ['c_std=gnu99,c11'] : ['c_std=gnu99'],
 )
 
 fs = import('fs')
-- 
2.49.0

