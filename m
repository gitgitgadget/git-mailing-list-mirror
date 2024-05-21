Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76741494DD
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321448; cv=none; b=TcLFhs9DOWKd2sA3n9u91/PtaRDDeR2UojHP4lXVTwmC/UXtDdgoBDZMnwA9AoE77GRNNgs1k7dwpBLjJILCuLTnSwrNeV//AcHvoMgUckWM9RCt1XWOJBXFdxTFcMN7jAc82nfp+hBvwS+N6hs4NOlMj0aUHs+HTXVY8zZjCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321448; c=relaxed/simple;
	bh=/hXamjjLZaQHWfa6ICRbgFEnZW63j+p2W3spaxjKUdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGjIt1tPKu5TJOK2I2PRGtmzyTEgFznCwx8mjF/uEEztaApcADhKTDj8oMXKY42ClAGahe2EIE/NzceuOr4eqUCgU9qchaXAVh62AvDf7Gg4jJPX6b7vNWGq+AjqPdahQr51fLH1w9KACu2l/E1OnOH+tJYvBCKoHU50mz1wPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xaQKmErX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xaQKmErX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C6C62DBEF;
	Tue, 21 May 2024 15:57:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=/hXamjjLZaQHWfa6ICRbgFEnZ
	W63j+p2W3spaxjKUdU=; b=xaQKmErXtDd6/t5LJIuIOHGA64lbUopAA8NvVuQSV
	uyIU+g63ntgwYlROc4Lb09Ho5aSwU70YogDnuTnTxEMFVHsFlDYEWwDuhNzVp2ax
	Fck8ScNo9J1UpxZqtEKQbrvvCNfVa20Y7IeycbsJwN+oi2Hk5S8LToBr+VexbhU0
	rU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75F892DBEE;
	Tue, 21 May 2024 15:57:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85BCA2DBED;
	Tue, 21 May 2024 15:57:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 08/12] Revert "core.hooksPath: add some protection while cloning"
Date: Tue, 21 May 2024 12:56:54 -0700
Message-ID: <20240521195659.870714-9-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 57250506-17AC-11EF-8AB9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This defense-in-depth was intended to protect the clone operation
against future escalations where bugs in `git clone` would allow
attackers to write arbitrary files in the `.git/` directory would allow
for Remote Code Execution attacks via maliciously-placed hooks.

However, it turns out that the `core.hooksPath` protection has
unintentional side effects so severe that they do not justify the
benefit of the protections. For example, it has been reported in
https://lore.kernel.org/git/FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemis=
ts.io/
that the following invocation, which is intended to make `git clone`
safer, is itself broken by that protective measure:

	git clone --config core.hooksPath=3D/dev/null <url>

Since it turns out that the benefit does not justify the cost, let's reve=
rt
20f3588efc6 (core.hooksPath: add some protection while cloning,
2024-03-30).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c        | 13 +------------
 t/t1800-hook.sh | 15 ---------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/config.c b/config.c
index 85b37f2ee0..8c1c4071f0 100644
--- a/config.c
+++ b/config.c
@@ -1525,19 +1525,8 @@ static int git_default_core_config(const char *var=
, const char *value, void *cb)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
=20
-	if (!strcmp(var, "core.hookspath")) {
-		if (current_config_scope() =3D=3D CONFIG_SCOPE_LOCAL &&
-		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
-			die(_("active `core.hooksPath` found in the local "
-			      "repository config:\n\t%s\nFor security "
-			      "reasons, this is disallowed by default.\nIf "
-			      "this is intentional and the hook should "
-			      "actually be run, please\nrun the command "
-			      "again with "
-			      "`GIT_CLONE_PROTECTION_ACTIVE=3Dfalse`"),
-			    value);
+	if (!strcmp(var, "core.hookspath"))
 		return git_config_pathname(&git_hooks_path, var, value);
-	}
=20
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg =3D git_config_bool(var, value);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7ee12e6f48..2ef3579fa7 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -177,19 +177,4 @@ test_expect_success 'git hook run a hook with a bad =
shebang' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'clone protections' '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
-	mkdir -p my-hooks &&
-	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1
-	EOF
-
-	git hook run test-hook 2>err &&
-	grep "Hook ran" err &&
-	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=3Dtrue \
-		git hook run test-hook 2>err &&
-	grep "active .core.hooksPath" err &&
-	! grep "Hook ran" err
-'
-
 test_done
--=20
2.45.1-216-g4365c6fcf9

