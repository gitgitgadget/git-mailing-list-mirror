Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0422A4D6
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559308; cv=none; b=dcDE0kIJOKCpI1xirxW24sgm1lb4Yk/jIW+OiMUE78hcYhlHc/MrfB45QEG0oqBN6+7YXsPFSBQEOf2c82UIrWqsUfaKdS7mLHhXNDyiicaHLLkLwZCTyxgxsBpY5PqTIfcnOGT30lNx6+06p+C4uW/7zujTzYSLCjBnClhCWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559308; c=relaxed/simple;
	bh=9KT1fMDAaIJw8XzU9NaaI5IeTVUEwr44BjftFJLwuFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7uQyrnde4QKw2dGgqXBLPbaKSittEAqsYB0mn2hqwtpa7NGv2UiopXPAcSokkEh5DloZDvC1KMhfp0CnwfLlfa+0PBNUR/I9EB8q8gIgXcWDXw0J9OwAaTAfXuKtzi6OphUhN0kFadDQlPnTZqnZhAjHfghkJICkNMkaOIzbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 305FA335D7B;
	Fri, 25 Apr 2025 05:35:06 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] meson: fix typo in function check that prevented checking for hstrerror
Date: Fri, 25 Apr 2025 01:25:44 -0400
Message-ID: <20250425053345.17288-6-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425053345.17288-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425053345.17288-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowhere in the codebase do we otherwise check for strerror. Nowhere in
the codebase do we make use of -DNO_STRERROR. `strerror` is not a
networking function at all.

We do utilize `hstrerror` though, which is a networking function we
should have been checking here.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 66b69f2471..25bac8d89f 100644
--- a/meson.build
+++ b/meson.build
@@ -1088,7 +1088,7 @@ else
 endif
 libgit_dependencies += networking_dependencies
 
-foreach symbol : ['inet_ntop', 'inet_pton', 'strerror']
+foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
   if not compiler.has_function(symbol, dependencies: networking_dependencies)
     libgit_c_args += '-DNO_' + symbol.to_upper()
   endif
-- 
2.49.0

