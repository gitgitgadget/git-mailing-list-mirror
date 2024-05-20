Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4450A63
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246891; cv=none; b=Q3JlMEDw+pCuvFrFHKaczVhg61kkXAloe1njFHCtC2K5kF3ktcwvEs3PD9E1GQ25iSfVx+feuziFMf4UXMioTUihSiJY2TrHYvzx/F3bilL+swfxRkH6BmM7mLqkWSer3n2ZbMEmlDinPptXSGsqM/G7V8+svUTZLUKN8RL9EZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246891; c=relaxed/simple;
	bh=6KkTum+UDwiKepSretVEQR5iUfDqngXnvfGBys3FVDQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMujN3qu1Uie6PwUx1wjzrrUsXRcD5QTP6MKaHHuG6aRwSlHRgL3rdVN853XIa2n3eQGLu13y2b0/hDuXGW9Rs6wCOKYNl+CltXehpGOerAO6Hzby7/P1Nnmp4oDhH2ipZltpcS2FsX/f/EUz2GmhGi6JF31cJYYZR280+Qfoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v8K2juB+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v8K2juB+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B26729B8C;
	Mon, 20 May 2024 19:14:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=6KkTum+UDwiKepSretVEQR5iU
	fDqngXnvfGBys3FVDQ=; b=v8K2juB+Df4EVzN2jqfAb1dR58ZtaM2DEcSmpLbVO
	82w+0GZNGKYmM6so9+ysGFgPoIRsqLN83LejGtwGOMbtiyn9EjwQTPpEVcX+Qde7
	cyxlK2N0yNNjgjL750EkEVSed3u/97Ty/kSlBEUGeTn+jkTKo/zKtuz01yKE5Omm
	B0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00BC429B8B;
	Mon, 20 May 2024 19:14:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BB3329B8A;
	Mon, 20 May 2024 19:14:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v5 5/5] apply: fix uninitialized hash function
Date: Mon, 20 May 2024 16:14:34 -0700
Message-ID: <20240520231434.1816979-6-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240520231434.1816979-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240520231434.1816979-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 C0CC8604-16FE-11EF-989C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"git apply" can work outside a repository as a better "GNU patch",
but when it does so, it still assumed that it can access
the_hash_algo, which is no longer true in the new world order.

Make sure we explicitly fall back to SHA-1 algorithm for backward
compatibility.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c         | 4 ++++
 t/t1517-outside-repo.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 861a01910c..e9175f820f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "repository.h"
+#include "hash.h"
 #include "apply.h"
=20
 static const char * const apply_usage[] =3D {
@@ -18,6 +19,9 @@ int cmd_apply(int argc, const char **argv, const char *=
prefix)
 	if (init_apply_state(&state, the_repository, prefix))
 		exit(128);
=20
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	argc =3D apply_parse_options(argc, argv,
 				   &state, &force_apply, &options,
 				   apply_usage);
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 2d8982d61a..557808ffa7 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -37,7 +37,7 @@ test_expect_success 'hash-object outside repository (us=
es SHA-1)' '
 	test_cmp hash.expect hash.actual
 '
=20
-test_expect_failure 'apply a patch outside repository' '
+test_expect_success 'apply a patch outside repository' '
 	(
 		cd non-repo &&
 		cp ../nums.old nums &&
--=20
2.45.1-216-g4365c6fcf9

