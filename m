Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50532E3389
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975400; cv=none; b=AEAdCzs5fsPrJvzxH8M0+oq2z3F7JEiPPXbQp+YoLfHqgd45ACz0KL26zOr4fbGvTchdxaEy01eEQHpq51bgaLIRKOA1vuszWFALgsllZxvY3P7WyNn+o7FC7ygMACMr9mjSjGO+acUSM/3ySwsh0SgN4C/Ll4EewRjVxPmiD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975400; c=relaxed/simple;
	bh=5ZQ8dbxs3vhB1fWHaCzRXqAiHcWorKhhSaJUKIyMPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AO4uG6ET3jMroXFhxPMCoFgiUnbClpuyy6rr/VuSVsQ4mbDHWvmn8c/elr7zQC1fpDX9W6UXnvGRJ/XEE+SrwxcNDlH03kciX4NeO8vb1Xkr2JPk0XSEJoF/WVnEcKcu81I4tAp0gvuNQ4m0mkly3gDcE32UpUAwjGICbLzRjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.. (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 265BD3430AC;
	Fri, 14 Mar 2025 18:03:16 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Sam James <sam@gentoo.org>
Subject: [PATCH] meson: use test_environment conditionally.
Date: Fri, 14 Mar 2025 18:02:47 +0000
Message-ID: <310a34bace801d288e369c6a01a8d04ffc4c3c06.1741975367.git.sam@gentoo.org>
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
Not sure if we can do better here somehow or not (with a disabler?)

 contrib/credential/netrc/meson.build | 8 ++++++--
 contrib/subtree/meson.build          | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index a990dbb86d..6d815d01c4 100644
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
+fi
 
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

