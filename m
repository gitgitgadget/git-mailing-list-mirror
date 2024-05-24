Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C3405D8
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580058; cv=none; b=biDwaRm1wkwteBMRUehEXsL/fYgDwcsVrxxnoaF24R0MACAYJlX8/rbUmUnFN18qCICnhJKE5cmnKtWYINIG05xTCNWEHqnqh3IEbtTb9CUVYxJZXRY40Uq52zDt2cPh2bFxgPiTCW6Qbmon1Ki3CcnI7v3fCFIovwhKriV/Zf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580058; c=relaxed/simple;
	bh=XQU/O6wlGwxv6RcraNPu44Hj32SNozYDzrDOT6t86ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfCgtVzY0xb3ZRyA5gx+vbRyCYRRHJWJzK5uOKwsok/TNti5E7TCt5EOMXsI5W3gmZ6n50F6X8o0i1C1u79+UkJK7RiYS2f8kblnPc7pJIGQ8Ar9XBwKftKBpk9uOz0s1Q2WTD4Cw0CHpe7J5U5AEqJvyJc7yirT5yArrCeiXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GRzOc3MA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GRzOc3MA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 14E42276E3;
	Fri, 24 May 2024 15:47:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=XQU/O6wlGwxv6RcraNPu44Hj3
	2SNozYDzrDOT6t86ds=; b=GRzOc3MA5P/bdoi9tSvEHbX3dgH5+d6/z3RjfnisI
	jghf91jN5HT6oAQaJCUC0vZu9WLDGqFgZcBbfG/n+dR/zGOAQIbXf8ydTZNXsiJW
	RBALlQoJQIW4p7Vom1SEITFBWbjHivGKARr5yFXOBZ6HnN6hwl/9IiozyPO94g7R
	UE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CE9A276E2;
	Fri, 24 May 2024 15:47:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2449E276E1;
	Fri, 24 May 2024 15:47:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 08/12] Revert "core.hooksPath: add some protection while cloning"
Date: Fri, 24 May 2024 12:47:11 -0700
Message-ID: <20240524194715.695916-9-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
In-Reply-To: <20240524194715.695916-1-gitster@pobox.com>
References: <20240524194715.695916-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 77131C2A-1A06-11EF-BC22-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
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
2.45.1-246-gb9cfe4845c

