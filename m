Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386243AB5
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709503577; cv=none; b=HPQBy+6KAspvjEET5FRzCokXQi1T/h/jqJTit0/cgsxKpJg/+jQni/47LR9VeHsUsaUGt7KeB1GBz0bFKA/azj4g47zrouN3uYw3zoQq53204LU8mcIUmPXYAn94CQNL4UpSrcC+AT6oDuce8vBAMslJHAfMqpnRnZ1uFqCQ6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709503577; c=relaxed/simple;
	bh=/mqoNEoBicViRw6Quxeoab0b/2O87R6CfpJarGKFVLQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqf96LsXQXxQpQNP/awIW0VlBOwUl3eRZvFim5/VSKGgH2cdsP3YelB9CIKu/bccbIqJkSEyV3swDe83pFPbHBfyqQsnNM2tcwDMwmy1+2cHPdrch8NXoAjP9swDgp55KOF9HLRZIfNnKe3eqdaVlryQZ5LDE+9jlPHVMt4/lBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KEfGbWz0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KEfGbWz0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B91B3027C;
	Sun,  3 Mar 2024 17:06:09 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=/mqoNEoBicViRw6Quxeoab0b/
	2O87R6CfpJarGKFVLQ=; b=KEfGbWz0r16elEbMk2ejksOWrza1C62m8AYVzWErh
	VNgcQirtm0qGfQKIx4ZdUf3cQjrTocctH7BahGDvxeE/LqbL8e+Yb1tkbSyWL0cP
	/fnpbgAP+X/qorSF9yFB3jdEZFQRroy48TJhGI8naMVzGy03qppegaC9l5Uy9fnc
	v8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 748F33027B;
	Sun,  3 Mar 2024 17:06:09 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10E3A3027A;
	Sun,  3 Mar 2024 17:06:06 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/1] clean: further clean-up of implementation around "--force"
Date: Sun,  3 Mar 2024 14:06:00 -0800
Message-ID: <20240303220600.2491792-2-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-84-gb387623c12
In-Reply-To: <20240303220600.2491792-1-gitster@pobox.com>
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
 <20240303220600.2491792-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 3B7DF686-D9AA-11EE-94F4-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

We clarified how clean.requireForce interacts with the --dry-run
option in the previous commit, both in the implementation and in the
documentation.  Even when "git clean" (without other options) is
required to be used with "--force" (i.e. either clean.requireForce
is unset, or explicitly set to true) to protect end-users from
casual invocation of the command by mistake, "--dry-run" does not
require "--force" to be used, because it is already its own
protection mechanism by being a no-op to the working tree files.

The previous commit, however, missed another clean-up opportunity
around the same area.  Just like in the "--dry-run" mode, the
command in the "--interactive" mode does not require "--force",
either.  This is because by going interactive and giving the end
user one more step to confirm, the mode itself is serving as its own
protection mechanism.

Let's take things one step further, unify the code that defines
interaction between `--force` and these two other options.  Just
like we added explanation for the reason why "--dry-run" does not
honor `clean.requireForce`, add the same explanation for
"--interactive".  Finally, add some tests to show the interaction
between "--force" and "--interactive" (we already have tests that
show interaction between "--force" and "--dry-run").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/clean.txt | 2 +-
 Documentation/git-clean.txt    | 4 +++-
 builtin/clean.c                | 9 ++-------
 t/t7300-clean.sh               | 6 ++++++
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/clean.txt b/Documentation/config/clean.=
txt
index b19ca210f3..c0188ead4e 100644
--- a/Documentation/config/clean.txt
+++ b/Documentation/config/clean.txt
@@ -1,3 +1,3 @@
 clean.requireForce::
 	A boolean to make git-clean refuse to delete files unless -f
-	or -i is given. Defaults to true.
+	is given. Defaults to true.
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 662eebb852..082d033438 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -37,7 +37,7 @@ OPTIONS
 --force::
 	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to delete files or directories
-	unless given -f or -i.  Git will refuse to modify untracked
+	unless given -f.  Git will refuse to modify untracked
 	nested git repositories (directories with a .git subdirectory)
 	unless a second -f is given.
=20
@@ -45,6 +45,8 @@ OPTIONS
 --interactive::
 	Show what would be done and clean files interactively. See
 	``Interactive mode'' for details.
+	Configuration variable clean.requireForce is ignored, as
+	this mode gives its own safety protection by going interactive.
=20
 -n::
 --dry-run::
diff --git a/builtin/clean.c b/builtin/clean.c
index 41502dcb0d..29efe84153 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -950,13 +950,8 @@ int cmd_clean(int argc, const char **argv, const cha=
r *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, builtin_clean_usage=
,
 			     0);
=20
-	/* Dry run won't remove anything, so requiring force makes no sense */
-	if (dry_run)
-		require_force =3D 0;
-
-	if (require_force !=3D 0 && !force && !interactive)
-		die(_("clean.requireForce is true and neither -f nor -i given:"
-				  " refusing to clean"));
+	if (require_force !=3D 0 && !force && !interactive && !dry_run)
+		die(_("clean.requireForce is true and -f not given: refusing to clean"=
));
=20
 	if (force > 1)
 		rm_flags =3D 0;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 611b3dd3ae..1f7201eb60 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -407,6 +407,12 @@ test_expect_success 'clean.requireForce and -f' '
=20
 '
=20
+test_expect_success 'clean.requireForce and --interactive' '
+	git clean --interactive </dev/null >output 2>error &&
+	test_grep ! "requireForce is true and" error &&
+	test_grep "\*\*\* Commands \*\*\*" output
+'
+
 test_expect_success 'core.excludesfile' '
=20
 	echo excludes >excludes &&
--=20
2.44.0-84-gb387623c12

