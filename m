Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0757CAA
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628083; cv=none; b=Q98w53RoJwpU1TEXr6rQDmIrv9FaXeWQ5+/nzHYFfy9wsZzIT65drCSyKzFOy7i5Jk4yy7Q9BXb5VDrh6b15j6QrMPwhAEiW/Yt+hk+WUzT1XYJ7CrNWa6jjC9iuOyj+MU1F11BXsPV4C15wgDC2rSaTQbm5oc02/K9jxZiuwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628083; c=relaxed/simple;
	bh=jWmxPVP1x66j4eH0cYbxPbQ2Xbo294/+TxzAs/pGItQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbgIWLguLfNZ9KmrSm/FH7lOsnSKmRGqnb29bkkXImSKBoGzIEYt7nh4jq9tUfuaO4lhFY1RvnqY1rZZ5jZ2J5HTNKnqRhgmWKoWL34rlVOeM29OjBfQufj/cpNWI7lqOgP73gMHeirCk1n6e+//CcZXH8QjHsHsgn8OTpKzgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TgipXJGF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TgipXJGF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 986FB36513;
	Mon, 13 May 2024 15:21:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=jWmxPVP1x66j4eH0cYbxPbQ2X
	bo294/+TxzAs/pGItQ=; b=TgipXJGF/buNRmSL6/HWDBOlNrOjprG5mLi5qjLXY
	q/9lMpmV5brdB4ma4HqyTBQW9ygrK8XNCoxFwOWNV/UPefYGxlwmQM6GGxQ6yzta
	6bz1O2ggkwnvw6GWvTu8x7Li7iCbZXyl4mNg/pzvjH0sZUj8zVjaNVXgAtgEQS2S
	u0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9088F36512;
	Mon, 13 May 2024 15:21:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C91D3650E;
	Mon, 13 May 2024 15:21:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/4] setup: add an escape hatch for "no more default hash algorithm" change
Date: Mon, 13 May 2024 12:21:09 -0700
Message-ID: <20240513192112.866021-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240513192112.866021-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240513192112.866021-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F92458DE-115D-11EF-94A3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Partially revert c8aed5e8 (repository: stop setting SHA1 as the
default object hash, 2024-05-07), to keep end-user systems still
broken when we have gap in our test coverage but yet give them an
escape hatch to set the GIT_TEST_DEFAULT_HASH_IS_SHA1=3D1 environment
variable to revert to the previous behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 repository.c  | 24 ++++++++++++++++++++++++
 t/test-lib.sh |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/repository.c b/repository.c
index 15c10015b0..6f67966e35 100644
--- a/repository.c
+++ b/repository.c
@@ -26,6 +26,30 @@ void initialize_repository(struct repository *repo)
 	repo->parsed_objects =3D parsed_object_pool_new();
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
+
+	/*
+	 * Unfortunately, we need to keep this hack around for the time being:
+	 *
+	 *   - Not setting up the hash algorithm for `the_repository` leads to
+	 *     crashes because `the_hash_algo` is a macro that expands to
+	 *     `the_repository->hash_algo`. So if Git commands try to access
+	 *     `the_hash_algo` without a Git directory we crash.
+	 *
+	 *   - Setting up the hash algorithm to be SHA1 by default breaks other
+	 *     commands when running with SHA256.
+	 *
+	 * This is another point in case why having global state is a bad idea.
+	 * Eventually, we should remove this hack and stop setting the hash
+	 * algorithm in this function altogether. Instead, it should only ever
+	 * be set via our repository setup procedures. But that requires more
+	 * work.
+	 *
+	 * As we discover the code paths that need fixing, we may remove this
+	 * code completely, but we are not there yet.
+	 */
+	if (repo =3D=3D the_repository &&
+	    git_env_bool("GIT_TEST_DEFAULT_HASH_IS_SHA1", 0))
+		repo_set_hash_algo(repo, GIT_HASH_SHA1);
 }
=20
 static void expand_base_dir(char **out, const char *in,
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 79d3e0e7d9..36d311fb4a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -542,6 +542,10 @@ export EDITOR
=20
 GIT_DEFAULT_HASH=3D"${GIT_TEST_DEFAULT_HASH:-sha1}"
 export GIT_DEFAULT_HASH
+
+GIT_TEST_DEFAULT_HASH_IS_SHA1=3D0
+export GIT_TEST_DEFAULT_HASH_IS_SHA1
+
 GIT_DEFAULT_REF_FORMAT=3D"${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
 export GIT_DEFAULT_REF_FORMAT
 GIT_TEST_MERGE_ALGORITHM=3D"${GIT_TEST_MERGE_ALGORITHM:-ort}"
--=20
2.45.0-145-g3e4a232f6e

