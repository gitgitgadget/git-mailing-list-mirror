Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73946B8
	for <git@vger.kernel.org>; Tue, 14 May 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649306; cv=none; b=aNU2Z3mpZfSm4EgrYSBZBOcheW3RV3uD+po76AmPksAGKacXyljC/PxVqNsXvtka5GbMEeJsSPzDvlZEV8T0HoLRSGLv7t3WKfXq8Z/FCRVsura0SWScFBmPUe/qTDn93t4MNlyNRHk4hd3+Wih5AhyLbYh+h+C7h9pFG/v8LLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649306; c=relaxed/simple;
	bh=wMyP+iGJ548649m/tCGGsMgti8TNajHwybuoyYO1BHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkPcJ+E36RYDp/cJyCWySq0D1itE4DoiFW7z6iMhR2YTqh/eQrl0BfPYs5QY5P/wvV6+XXmKtvP2T2eFc3ih8g/YqYr6bQF1mRmFwJzy6wyMFkCr9jdW1sch5OznKHdvu6vQBG5XMJzrOoOa2f21bjpc8+pVcIqB3ZYj73jVAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lOEDZPXI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lOEDZPXI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 966C5389EC;
	Mon, 13 May 2024 21:15:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=wMyP+iGJ548649m/tCGGsMgti
	8TNajHwybuoyYO1BHA=; b=lOEDZPXITfr6vml/P008FCYfX5EVkZW9tAFsRQ1Cs
	4B5npak0rMPnLY1rFEekO4U/FtVm9BlysSGJAXskYe2O5Gi/XE6TvkeIc562wbMi
	FqUjO7a8fP9yVKRxaBfeDd1gMXTie6JEHOAQ2f6gkzW5smuFN/1uZ/xKO8cFEmpU
	r0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7835D389EB;
	Mon, 13 May 2024 21:15:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54EB5389E7;
	Mon, 13 May 2024 21:14:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 5/5] apply: fix uninitialized hash function
Date: Mon, 13 May 2024 18:14:37 -0700
Message-ID: <20240514011437.3779151-6-gitster@pobox.com>
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
X-Pobox-Relay-ID:
 61FB04F8-118F-11EF-BB5F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
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
index 854bb8f343..6f32a40c6d 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -39,7 +39,7 @@ test_expect_success 'hash-object outside repository' '
 	test_cmp hash.expect hash.actual
 '
=20
-test_expect_failure 'apply a patch outside repository' '
+test_expect_success 'apply a patch outside repository' '
 	(
 		cd non-repo &&
 		cp ../nums.old nums &&
--=20
2.45.0-145-g3e4a232f6e

