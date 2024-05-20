Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C84AEF0
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246881; cv=none; b=VWu4y03Ie7FxVv3Mfa4rzhkk6XTCVACn4KKOczE1yjFi7qE+02ODdpVA119JeNnTtrDeBGwHHXnSm/Y20y0H1vt1egtZCaaZIjOn9/jp9t7csPDzrYmohzBRPoI3q2/S2njp9f6tH4yGi5gYCvDsdZT+fqOCh3emrWiugoUROmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246881; c=relaxed/simple;
	bh=hPBn5e5a6onIiqcVYsmepkK6zjr1MhXbrsAgJYiorT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6Fw+TjJYXzU1Z51cZHrEHKTBKajKh7DqoNi7VSky77bf/C9OaYEOPW7oy0B8B95Gi2klWYvSnHutYAYTahSn5IRuiJDn+VxiB+ZwGXT0TnzgASrpvk2bapiOoIjD6I14wXpC6XgcisH4FU/NPGS+Uq4dX8Wyvr/5H9Ma+Q2YIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jJ2NP+eR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jJ2NP+eR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E610E29B89;
	Mon, 20 May 2024 19:14:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=hPBn5e5a6onIiqcVYsmepkK6z
	jr1MhXbrsAgJYiorT8=; b=jJ2NP+eRNto5BHkAOFGfzxzls2M0zOX51KfF82ewT
	ybyjBfyq15q+mgOLhAiKmCibyRsYlERdduuUfaQ44b5qWrqdTO1OWXHl24+zjlau
	pMedBGB8JwEhCj+KoX+z7A2t1b19rzpX+gciD1wg1F9G/ksgh4YDq2lgE9bhGtva
	DA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE35829B88;
	Mon, 20 May 2024 19:14:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54E7F29B87;
	Mon, 20 May 2024 19:14:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v5 1/5] setup: add an escape hatch for "no more default hash algorithm" change
Date: Mon, 20 May 2024 16:14:30 -0700
Message-ID: <20240520231434.1816979-2-gitster@pobox.com>
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
 BAD24CF2-16FE-11EF-931E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Partially revert c8aed5e8 (repository: stop setting SHA1 as the
default object hash, 2024-05-07), to keep end-user systems still
broken when we have gap in our test coverage but yet give them an
escape hatch to set the GIT_TEST_DEFAULT_HASH_ALGO environment
variable to "sha1" in order to revert to the previous behaviour.

Due to the way the end-user facing GIT_DEFAULT_HASH environment
variable is used in our test suite, we unfortunately cannot reuse it
for this purpose.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 repository.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/repository.c b/repository.c
index 15c10015b0..c62e329878 100644
--- a/repository.c
+++ b/repository.c
@@ -19,6 +19,28 @@
 static struct repository the_repo;
 struct repository *the_repository =3D &the_repo;
=20
+/*
+ * An escape hatch: if we hit a bug in the production code that fails
+ * to set an appropriate hash algorithm (most likely to happen when
+ * running outside a repository), we can tell the user who reported
+ * the crash to set the environment variable to "sha1" (all lowercase)
+ * to revert to the historical behaviour of defaulting to SHA-1.
+ */
+static void set_default_hash_algo(struct repository *repo)
+{
+	const char *hash_name;
+	int algo;
+
+	hash_name =3D getenv("GIT_TEST_DEFAULT_HASH_ALGO");
+	if (!hash_name)
+		return;
+	algo =3D hash_algo_by_name(hash_name);
+	if (algo =3D=3D GIT_HASH_UNKNOWN)
+		return;
+
+	repo_set_hash_algo(repo, algo);
+}
+
 void initialize_repository(struct repository *repo)
 {
 	repo->objects =3D raw_object_store_new();
@@ -26,6 +48,28 @@ void initialize_repository(struct repository *repo)
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
+	 * We are in the process of identifying such code paths and
+	 * giving them an appropriate default individually; any
+	 * unconverted code paths that try to access the_hash_algo
+	 * will thus fail.  The end-users however have an escape hatch
+	 * to set GIT_TEST_DEFAULT_HASH_ALGO environment variable to
+	 * "sha1" to get back the old behaviour of defaulting to SHA-1.
+	 *
+	 * This escape hatch is deliberately kept unadvertised, so
+	 * that they see crashes and we can get a report before
+	 * telling them about it.
+	 */
+	if (repo =3D=3D the_repository)
+		set_default_hash_algo(repo);
 }
=20
 static void expand_base_dir(char **out, const char *in,
--=20
2.45.1-216-g4365c6fcf9

