Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A55A936
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904551; cv=none; b=PD/l4Zldz8N8TFYC9sR/kK0FqAx7XgIrbJHjhAyVLDESMwChNNLx8le+V+w1c2hFsNZZMAj9AookxPQRc0eqARAi8Ae9rmF/m1/L/RauJAHEMVXKuPURp4YZH1yRpUz2Mh7hUlpqjE5OVCaXwxcMTIQD6+9+5U8vLTGSsM0MbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904551; c=relaxed/simple;
	bh=Z0/z3nEOnZDPCfmCrylMguarsm8kmHMuJaFbKIkV4W8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWMJx7ltge6OY4PblmdRWqbVJHDAhi0UR7sBPaJ4qgMbBRWjPSf4nNTLWCAswfnEyww3J9dKRvfRisbBpLSmQYvfdVtJQpp8ZF4dlT29QhRcKP8k49STLgKFTYwSEMaNccoiVhcuVkD2voXupwhqoLCUYRAUY1mUUsKr7LW3mAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FPKepvCd; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPKepvCd"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BF102315AB;
	Mon,  5 Aug 2024 20:35:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Z0/z3nEOnZDPCfmCrylMguars
	m8kmHMuJaFbKIkV4W8=; b=FPKepvCdOUqbJJztmtzK8nFq7RoaNta2zA/IA11k5
	nxCyCuYhki0K7O+oTW4SwcCoHDKk2Xvi8XxTe3SM3BGfJxMwwgor7+8Zo7dyqlj4
	+EJ8cjVIhQ4kK69PvuaPi2OYMXOxKH/Y/PQWGdVRASApRu1huZtFqC9mzTnm8Y+T
	ok=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B7AFE315AA;
	Mon,  5 Aug 2024 20:35:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CD61315A8;
	Mon,  5 Aug 2024 20:35:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 2/4] cat-file: avoid "too many arguments"
Date: Mon,  5 Aug 2024 17:35:37 -0700
Message-ID: <20240806003539.3292562-3-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-235-g968ce1ce0e
In-Reply-To: <20240806003539.3292562-1-gitster@pobox.com>
References: <20240806003539.3292562-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 D1A5653A-538B-11EF-A5A1-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Running "git cat-file -e a b c d e f g" would fail and say "too many
arguments".  By reading that message, you cannot tell if the command
could have worked if you limited the list of objects to 5 items
instead of 7, or the command is prepared to take only a single item.

Let's report that "b" is an unexpected argument instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c  | 3 ++-
 t/t1006-cat-file.sh | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 18fe58d6b8..ba85825c55 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1074,7 +1074,8 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
 		else if (argc =3D=3D 1)
 			obj_name =3D argv[0];
 		else
-			usage_msg_opt(_("too many arguments"), usage, options);
+			usage_msg_optf(_("unknown argument: '%s'"),
+				       usage, options, argv[1]);
 	} else if (!argc) {
 		usage_with_options(usage, options);
 	} else if (argc !=3D 2) {
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa..8ad440bbcc 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -66,16 +66,18 @@ do
 	done
 done
=20
-test_too_many_arguments () {
+test_unknown_arg () {
+	unk=3D$1
+	shift
 	test_expect_code 129 "$@" 2>err &&
-	grep -E "^fatal: too many arguments$" err
+	grep -E "^fatal: unknown argument: '$unk'" err
 }
=20
 for opt in $short_modes $cw_modes
 do
 	args=3D"one two three"
 	test_expect_success "usage: too many arguments: $opt $args" '
-		test_too_many_arguments git cat-file $opt $args
+		test_unknown_arg two git cat-file $opt $args
 	'
=20
 	for opt2 in --buffer --follow-symlinks
--=20
2.46.0-235-g968ce1ce0e

