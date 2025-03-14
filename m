Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC72E3389
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975576; cv=none; b=fuChJp0e/267fA9l+SV9+AIuzeih4sTGLZZ5cXTHqg9nLDiEscddFWgl1+rzR0PqzPMQJYWeIUlqkRFYdlCs+O3r9fGFf/oW9lIQoOgsJ7iY6bUGWj5PvvJHp5TplL9+CPoES0PcDsj1DCR4mhbvfLHmqbSomKxDUOELoL9fyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975576; c=relaxed/simple;
	bh=pSeK9/qHm4ZqHpqJwVdpgL24s3of2JF9nYlVM58lor4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlrR6xnY6vUvcuXNI3fN8bCeSrOUpnvV+sqU/uJeFb3QWyPjYGEK8oXGykObcd1SS0enjTWiLOGzm6Gze9JX+BPVlVEQXGmfT0jWWtYnSP4a7VZEofDRrZ5tSmyarKfuildAcIRw/nmc8PGyX8SaaKpkLI+S7cuGbp3zNuASGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.. (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E1138343083;
	Fri, 14 Mar 2025 18:06:13 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Sam James <sam@gentoo.org>
Subject: [PATCH v2] meson: use test_environment conditionally.
Date: Fri, 14 Mar 2025 18:05:57 +0000
Message-ID: <3d127f293818f935efdb9ca7bb556e6a8f233ef7.1741975557.git.sam@gentoo.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_environment is only defined with -Dtests, so use it conditionally
and define a stub environment() instead, to avoid erroring out:

```
$ meson setup -Dtests=false -Dcontrib=subtree build
[...]

contrib/subtree/meson.build:15:27: ERROR: Unknown variable "test_environment".
```

Do the same for 'netrc' in contrib/ as it uses the same pattern.
---
v2: Use syntax that actually works in netrc.

 contrib/credential/netrc/meson.build | 8 ++++++--
 contrib/subtree/meson.build          | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index a990dbb86d..337c82c992 100644
--- a/contrib/credential/netrc/meson.build
+++ b/contrib/credential/netrc/meson.build
@@ -7,8 +7,12 @@ credential_netrc = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-credential_netrc_testenv = test_environment
-credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
+if get_option('tests')
+  credential_netrc_testenv = test_environment
+  credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
+else
+  credential_netrc_testenv = environment()
+endif
 
 test('t-git-credential-netrc',
   shell,
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 9c72b23625..d18f188216 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -12,8 +12,12 @@ git_subtree = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-subtree_test_environment = test_environment
-subtree_test_environment.prepend('PATH', meson.current_build_dir())
+if get_option('tests')
+  subtree_test_environment = test_environment
+  subtree_test_environment.prepend('PATH', meson.current_build_dir())
+else
+  subtree_test_environment = environment()
+endif
 
 test('t7900-subtree', shell,
   args: [ 't7900-subtree.sh' ],
-- 
2.48.1

