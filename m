Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FE1F03E6
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933172; cv=none; b=qUxPRvxrhoQxwbuV+aS84zzRf2kv3WKQprg/Ga62GEwCjREH2/jAa0hQgQtqmjKdIqSClaBloZDUyjnBpQD2iOJ2It5ahqvsdK4M+1/YiQSNlKocNTKpHwFNMXEDdw2//fZ7cdr2c2YW0ELaKWW92LpFPGPhSyMsR8NrYnhq3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933172; c=relaxed/simple;
	bh=K+0Fcv1hqDC3oCBT3d3TKufLfqJoWL2N1HUGhVoLYzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjI+13pEmZikhUL/yE31dD9Q3TCVjjRvQWG8D1sxHuiaqlR3D4ygQzq2+yaPYXLnnPenKnRz6g7+8mNJrY4CxtG+JsFhOrISf3mnitXtpJbGX96hzU9r0DUlXIsgjyPyjQPRG9AjBVJf3XetZUU+pwV1+HxQ/BoJNMDNmBAAXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5FC8334307D;
	Tue, 25 Mar 2025 20:06:09 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Sam James <sam@gentoo.org>
Subject: [PATCH] meson: disable coccinelle configuration when building from a tarball
Date: Tue, 25 Mar 2025 16:05:40 -0400
Message-ID: <20250325200542.197687-1-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wiring up coccinelle in the build, depends on running git commands to
get the list of files to operate on. Reasonable, for a feature mainly
used by people developing on git. If building git itself from a tarball
distribution of git's own source code, one likely does not need to run
coccinelle.

But running those git commands failed, and caused the build to error
out, if `spatch` was installed -- because the build assumed that its
presence indicated a desire to use it on this source tree. Instead, we
can expand the conditional to check for both `spatch` and the `.git`
file or directory.

Meson's `opt.require()` method allows us to add a prerequisite for the
feature option. If the prerequisite fails, then the option either:
- converts autodetection to disabled
- emits an informative error

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 contrib/coccinelle/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 5d76a7fee6..ea054c924f 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -1,4 +1,9 @@
-spatch = find_program('spatch', required: get_option('coccinelle'))
+coccinelle_opt = get_option('coccinelle').require(
+  fs.exists(meson.project_source_root() / '.git'),
+  error_message: 'coccinelle can only be run from a git checkout',
+)
+
+spatch = find_program('spatch', required: coccinelle_opt)
 if not spatch.found()
   subdir_done()
 endif

base-commit: c1d6628c9433c09ff62f916f2b933ee12995e9d8
-- 
2.48.1

