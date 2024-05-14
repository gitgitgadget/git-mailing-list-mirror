Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03517F7
	for <git@vger.kernel.org>; Tue, 14 May 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649295; cv=none; b=swrjFVdMPu8NHPPwf4TWwRrAN5IXOtGSzVWCgZ9wGbniGf4pQt9A4Vk7vegquEUsXBRyXx7TFEpyBtm+lCE3UBLjKYiZ7+WgYFrWDACcA0ZsaqiVM2u/pfTSfk42twkvWeqWtisTHVmRxebVTA17jLqbYIC0qeCVSNJeUPGES0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649295; c=relaxed/simple;
	bh=T8FmNDD6Z/zEINjdGBhWrk8F1+gp6OxzY0kIgRf04WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8ZjbfFLu5+/wQt+eBmnkX62etmqpQRqk/a5SHIdS7Oz4JABudgatMEb33iSmdEUFRe3W+2CTeuFhNuS2lhyVlKaEFJOqUqG903HY6LBq3jcx8GDx6K/CWw595nGkz3S74Y0C3GvVRxp5hKl08A//gVDarKfajWfgBv9aa1AOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XTwwXP2j; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XTwwXP2j"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A8DB29DFC;
	Mon, 13 May 2024 21:14:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T8FmNDD6Z/zE
	INjdGBhWrk8F1+gp6OxzY0kIgRf04WM=; b=XTwwXP2jcjBxb1dbYKR60tHRXhGL
	5ORH5hPgq23nldNt4Knt12UfXPj0IvN5HadnimsmTFk2UnmMAQHOP3cXZURd78xw
	sRib26w3hqxl3+JwsoMA2SxlktGz5uOrVyZOMU9HSksb8uJuFS3sb5KC98xbNLdU
	sjMJe0TJybuRTfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9237429DFB;
	Mon, 13 May 2024 21:14:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AFBB29DFA;
	Mon, 13 May 2024 21:14:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/5] builtin/patch-id: fix uninitialized hash function
Date: Mon, 13 May 2024 18:14:35 -0700
Message-ID: <20240514011437.3779151-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240514011437.3779151-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240514011437.3779151-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID:
 5DA14DC2-118F-11EF-8855-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Patrick Steinhardt <ps@pks.im>

In c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07), we have adapted `initialize_repository()` to no longer set
up a default hash function. As this function is also used to set up
`the_repository`, the consequence is that `the_hash_algo` will now by
default be a `NULL` pointer unless the hash algorithm was configured
properly. This is done as a mechanism to detect cases where we may be
using the wrong hash function by accident.

This change now causes git-patch-id(1) to segfault when it's run outside
of a repository. As this command can read diffs from stdin, it does not
necessarily need a repository, but then relies on `the_hash_algo` to
compute the patch ID itself.

It is somewhat dubious that git-patch-id(1) relies on `the_hash_algo` in
the first place. Quoting its manpage:

    A "patch ID" is nothing but a sum of SHA-1 of the file diffs
    associated with a patch, with line numbers ignored. As such, it=E2=80=
=99s
    "reasonably stable", but at the same time also reasonably unique,
    i.e., two patches that have the same "patch ID" are almost
    guaranteed to be the same thing.

We explicitly document patch IDs to be using SHA-1. Furthermore, patch
IDs are supposed to be stable for most of the part. But even with the
same input, the patch IDs will now be different depending on the repo's
configured object hash.

Work around the issue by setting up SHA-1 when there was no startup
repository for now. This is arguably not the correct fix, but for now we
rather want to focus on getting the segfault fixed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/patch-id.c      | 13 +++++++++++++
 t/t1517-outside-repo.sh |  2 +-
 t/t4204-patch-id.sh     | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b970..583099cacf 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -5,6 +5,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "setup.h"
=20
 static void flush_current_id(int patchlen, struct object_id *id, struct =
object_id *result)
 {
@@ -237,6 +238,18 @@ int cmd_patch_id(int argc, const char **argv, const =
char *prefix)
 	argc =3D parse_options(argc, argv, prefix, builtin_patch_id_options,
 			     patch_id_usage, 0);
=20
+	/*
+	 * We rely on `the_hash_algo` to compute patch IDs. This is dubious as
+	 * it means that the hash algorithm now depends on the object hash of
+	 * the repository, even though git-patch-id(1) clearly defines that
+	 * patch IDs always use SHA1.
+	 *
+	 * NEEDSWORK: This hack should be removed in favor of converting
+	 * the code that computes patch IDs to always use SHA1.
+	 */
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	generate_id_list(opts ? opts > 1 : config.stable,
 			 opts ? opts =3D=3D 3 : config.verbatim);
 	return 0;
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index e0fd495ec1..ac5f3191cc 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -21,7 +21,7 @@ test_expect_success 'set up a non-repo directory and te=
st file' '
 	git diff >sample.patch
 '
=20
-test_expect_failure 'compute a patch-id outside repository' '
+test_expect_success 'compute a patch-id outside repository' '
 	git patch-id <sample.patch >patch-id.expect &&
 	(
 		cd non-repo &&
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index a7fa94ce0a..605faea0c7 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -310,4 +310,38 @@ test_expect_success 'patch-id handles diffs with one=
 line of before/after' '
 	test_config patchid.stable true &&
 	calc_patch_id diffu1stable <diffu1
 '
+
+test_expect_failure 'patch-id computes same ID with different object has=
hes' '
+	test_when_finished "rm -rf repo-sha1 repo-sha256" &&
+
+	cat >diff <<-\EOF &&
+	diff --git a/bar b/bar
+	index bdaf90f..31051f6 100644
+	--- a/bar
+	+++ b/bar
+	@@ -2 +2,2 @@
+	 b
+	+c
+	EOF
+
+	git init --object-format=3Dsha1 repo-sha1 &&
+	git -C repo-sha1 patch-id <diff >patch-id-sha1 &&
+	git init --object-format=3Dsha256 repo-sha256 &&
+	git -C repo-sha256 patch-id <diff >patch-id-sha256 &&
+	test_cmp patch-id-sha1 patch-id-sha256
+'
+
+test_expect_success 'patch-id without repository' '
+	cat >diff <<-\EOF &&
+	diff --git a/bar b/bar
+	index bdaf90f..31051f6 100644
+	--- a/bar
+	+++ b/bar
+	@@ -2 +2,2 @@
+	 b
+	+c
+	EOF
+	nongit git patch-id <diff
+'
+
 test_done
--=20
2.45.0-145-g3e4a232f6e

