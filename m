Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BB84D3E
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640112; cv=none; b=QZJPxPjN9yJZKb9yYRE84K9zAS3rEji1RSGGqnNlQCiHcg0sS+SOtPnLrRnEz8coMDBCZneEj/yU1IujYYDCFd+K97oI7ylD3ctmpSs6D99Wuu6BW59MjIA4H1hxb80DDOGCTLulgqtkNAk6Rdcf98DPGN2YHPYx+afq8R3wRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640112; c=relaxed/simple;
	bh=kEs6DeEpbwAw7fGYbxlSXnlCp2EAfZ5PwfnNVEf8G0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXABwhABxyjQ49Sp1bmvo+/qM3dU3QJ5G2CH8eyZlDJ3iAy4Wc0N1znui6gbIttLIjaIiEBHXLB39ciKBif0DUb+Zs0pknzf05M4VlczN9vvZECxyHcHWfkOBcyhG4bOR3O9j15gIikP79cfa64A1KaP3gmpu2TttuoBthCLdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wW/y9BVD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wW/y9BVD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FAC337B78;
	Mon, 13 May 2024 18:41:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=kEs6DeEpbwAw7fGYbxlSXnlCp
	2EAfZ5PwfnNVEf8G0k=; b=wW/y9BVDLKHxs7KHq0VzClo3J1GYL2kx9Ta7NjB5K
	H0mMy//bD9jRz95a4l+0euAAZGhgzuUP3NTdEqdRID7c1i/lAbU8tydtilcA1S5J
	zHAmXJwJq9FpTwJE0YltGMmfZL3MO4mrnQxxZggdeCZh9qew8ZEx0faunDhHIO3L
	tM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 497A337B77;
	Mon, 13 May 2024 18:41:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ACC7237B76;
	Mon, 13 May 2024 18:41:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 5/5] apply: fix uninitialized hash function
Date: Mon, 13 May 2024 15:41:27 -0700
Message-ID: <20240513224127.2042052-6-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240513224127.2042052-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240513224127.2042052-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 FA252A8A-1179-11EF-91C8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
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
index 80261e43c7..89d89cf3f0 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -42,7 +42,7 @@ test_expect_success 'hash-object outside repository' '
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

