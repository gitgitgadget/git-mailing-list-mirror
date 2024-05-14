Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB5EC5
	for <git@vger.kernel.org>; Tue, 14 May 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649293; cv=none; b=FVhSfKOMI/Tt95pItXshLvb9ThP1EZh4Gidsc/FrJU62yoKzoKAYHCISAkprfbt3yK1v1+avArcih4uc6S7yxDz6kfHYc8Q2VWkJRtjZQd+Kw9s7Wko2VKfg66DTzT2wyZzESt1HrV1AE3eCtk0rfhx8STydVtM0VYeBkujaTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649293; c=relaxed/simple;
	bh=AqaurW/LXawFDSXmXK7KM1kVdAWnDy3VG/UXnz0jUIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHlL2bMgLkYHamH9tDQwfEunu/QRRjWqvM69/f9YS4Qi3qDSEcJXu7d85de4x5Vaqx1FrzNkEcFfgiUFhKz6BjmTV3a8+6aHdMoCHfHPupk4I7PRWg0shuZYJ+1KFe33HbWCriLZ2YS2SP3obmIPGcVvp8vZBP2K8kYwGmGE66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U9lnmDJs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U9lnmDJs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ED7A389E1;
	Mon, 13 May 2024 21:14:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=AqaurW/LXawFDSXmXK7KM1kVd
	AWnDy3VG/UXnz0jUIU=; b=U9lnmDJsCfJ+AafZMxZzO4UPaKCdqrAdAZdU9bOfY
	J1Oa8KeTn/e361jBrWZBRTt/R37R+lbBRX4UFdO7J9IImYxFODNhN/6dZQtioN5y
	Hqoqfm9XCxaPjenCUhrRZfrbht9YZwJN7Pom1qPIdsHMhMMxzM88Il8+SzMs3+Hm
	uc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D584389E0;
	Mon, 13 May 2024 21:14:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 44B5E389D9;
	Mon, 13 May 2024 21:14:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 1/5] setup: add an escape hatch for "no more default hash algorithm" change
Date: Mon, 13 May 2024 18:14:33 -0700
Message-ID: <20240514011437.3779151-2-gitster@pobox.com>
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
 5998C7DC-118F-11EF-A18F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Partially revert c8aed5e8 (repository: stop setting SHA1 as the
default object hash, 2024-05-07), to keep end-user systems still
broken when we have gap in our test coverage but yet give them an
escape hatch to set the GIT_DEFAULT_HASH environment variable to
"sha1" in order to revert to the previous behaviour.  This variable
has been in use for using SHA-256 hash by default, and it should be
a better fit than inventing a new and test-only knob.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.h |  1 +
 repository.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 setup.c       |  2 --
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/environment.h b/environment.h
index 05fd94d7be..deaa29408f 100644
--- a/environment.h
+++ b/environment.h
@@ -56,6 +56,7 @@ const char *getenv_safe(struct strvec *argv, const char=
 *name);
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
=20
 /*
  * Environment variable used in handshaking the wire protocol.
diff --git a/repository.c b/repository.c
index 15c10015b0..f912ee9a7c 100644
--- a/repository.c
+++ b/repository.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "environment.h"
 #include "repository.h"
 #include "object-store-ll.h"
 #include "config.h"
@@ -19,6 +20,27 @@
 static struct repository the_repo;
 struct repository *the_repository =3D &the_repo;
=20
+static void set_default_hash_algo(struct repository *repo)
+{
+	const char *hash_name;
+	int algo;
+
+	hash_name =3D getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
+	if (!hash_name)
+		return;
+	algo =3D hash_algo_by_name(hash_name);
+
+	/*
+	 * NEEDSWORK: after all, falling back to SHA-1 by assigning
+	 * GIT_HASH_SHA1 to algo here, instead of returning, may give
+	 * us better behaviour.
+	 */
+	if (algo =3D=3D GIT_HASH_UNKNOWN)
+		return;
+
+	repo_set_hash_algo(repo, algo);
+}
+
 void initialize_repository(struct repository *repo)
 {
 	repo->objects =3D raw_object_store_new();
@@ -26,6 +48,24 @@ void initialize_repository(struct repository *repo)
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
+	 * to set GIT_DEFAULT_HASH environment variable to "sha1" get
+	 * back the old behaviour of defaulting to SHA-1.
+	 */
+	if (repo =3D=3D the_repository)
+		set_default_hash_algo(repo);
 }
=20
 static void expand_base_dir(char **out, const char *in,
diff --git a/setup.c b/setup.c
index 7c996659bd..d084703465 100644
--- a/setup.c
+++ b/setup.c
@@ -1840,8 +1840,6 @@ int daemonize(void)
 #define TEST_FILEMODE 1
 #endif
=20
-#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
-
 static void copy_templates_1(struct strbuf *path, struct strbuf *templat=
e_path,
 			     DIR *dir)
 {
--=20
2.45.0-145-g3e4a232f6e

