Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89CD51A
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640099; cv=none; b=Sl8m6V4B4nz9UvXnkjeApuqqNwvxZF0C1/tunyS4+Y0JxEYt3a+htVBHXSdrr7otvdWud3NVYEeKGG8uXleoPyUturiHaI21hYYsFa4u2A5I1kydy6PMmuaw37NX4aUTfqF8DQNZbbur6MSZQroSUW2eSr5SLu6q4t/raxTwbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640099; c=relaxed/simple;
	bh=1ePELs4mWVSgyv+IxxouIyXTCavCKgtRD2yG+ZZg4PY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZGdB7hQ1T13RRWEImXKuaOymR/hb3Tx+Zf8gj/K1s8wmwW3jgVuaBQLAbutbu83sPGsZhom7XTe9ShCvN4XDp14DDiurIf1mZ13+zFaLUyI7dm1q1mGExOsaJfPcbADfy+uFaxSrd3zVFGsPOLC7nAnOTOWCwtwlVFfJjVQ0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DndD3IxU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DndD3IxU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9055637B75;
	Mon, 13 May 2024 18:41:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=1ePELs4mWVSgyv+IxxouIyXTC
	avCKgtRD2yG+ZZg4PY=; b=DndD3IxUSaQbpmaIqlVurZoM+pqMAJPYW1nTIMksQ
	YkTJ43Nf9G+FXGIxbkVxrSyiokSeBp1KyDB7IgZpRc5Y1WBj8q0bfp6hcEuTutBm
	0vY7WopAInlrqRBYUPE51RqtSTOGPsWM9JYMnKbSt8Kbje6GV7g/bdZds2AYEtsX
	dA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 88E2937B74;
	Mon, 13 May 2024 18:41:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72E0937B73;
	Mon, 13 May 2024 18:41:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 1/5] setup: add an escape hatch for "no more default hash algorithm" change
Date: Mon, 13 May 2024 15:41:23 -0700
Message-ID: <20240513224127.2042052-2-gitster@pobox.com>
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
 F2D9BCBE-1179-11EF-BF0F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Partially revert c8aed5e8 (repository: stop setting SHA1 as the
default object hash, 2024-05-07), to keep end-user systems still
broken when we have gap in our test coverage but yet give them an
escape hatch to set the GIT_TEST_DEFAULT_HASH_ALGORITHM environment
variable to "sha1" in order to revert to the previous behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 repository.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/repository.c b/repository.c
index 15c10015b0..2001c760dc 100644
--- a/repository.c
+++ b/repository.c
@@ -19,6 +19,20 @@
 static struct repository the_repo;
 struct repository *the_repository =3D &the_repo;
=20
+static void set_default_hash_algo(struct repository *repo)
+{
+	const char *hash_name;
+	int algo;
+
+	hash_name =3D getenv("GIT_DEFAULT_HASH_ALGORITHM");
+	if (!hash_name)
+		return;
+	algo =3D hash_algo_by_name(hash_name);
+	if (algo =3D=3D GIT_HASH_UNKNOWN)
+		return;
+	repo_set_hash_algo(repo, algo);
+}
+
 void initialize_repository(struct repository *repo)
 {
 	repo->objects =3D raw_object_store_new();
@@ -26,6 +40,24 @@ void initialize_repository(struct repository *repo)
 	repo->parsed_objects =3D parsed_object_pool_new();
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
+
+	/*
+	 * When a command runs inside a repository, it learns what
+	 * hash algorithm is in use from the repository, but some
+	 * commands are designed to work outside a repository, yet
+	 * they want to access the_hash_algo, if only for the length
+	 * of the hashed value to see if their input looks like a
+	 * plausible hash value.
+	 *
+	 * We are in the process of identifying the codepaths and
+	 * giving them an appropriate default individually; any
+	 * unconverted codepath that tries to access the_hash_algo
+	 * will thus fail.  The end-users however have an escape hatch
+	 * to set GIT_DEFAULT_HASH_ALGORITHM environment variable to
+	 * "sha1" get back the old behaviour of defaulting to SHA-1.
+	 */
+	if (repo =3D=3D the_repository)
+		set_default_hash_algo(repo);
 }
=20
 static void expand_base_dir(char **out, const char *in,
--=20
2.45.0-145-g3e4a232f6e

