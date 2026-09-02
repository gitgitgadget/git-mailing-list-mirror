Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF847DF87
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354706; cv=none; b=uFMZU2O1zlXwDcCf0824f9pFRjxBdx8RfvGEdBwic5/wwQv/UFMxfQxQC/45mbPtZcyrstK7aTu1QxYn6gkKyNyT94ZeCypjke8DNCo5+csODu4jqStJCvlf/dvblxuqFPeMDg3vDYmSTPPxSEGPPy0q0X78C0o//WUSVIF4xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354706; c=relaxed/simple;
	bh=dqPvr1LI+/CBIrbJUdfjpSrSROhy04fqZ7XZD/Q0URw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=e90adE7TnwkjltK1uP0vkypz/NSyMwLnHcjUM32bStUiYHfv/n8wLbFXZ5kc4QBqC5ZqcZF87YQoBofO3s3PsnCFiRDGqRT5jOHibIomSCiPL1IjLrMIYmPbqvYYJyuSqMAibuZj+5UETeDgduCllR01bhqjzA8CalNLCkw5lN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=geQ1QPQM; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="geQ1QPQM"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hZjc46ccczKmHV
	for <git@vger.kernel.org>; Wed, 02 Sep 2026 15:04:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788354260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6VTIyceb6H7v0ifHhjI1vKzg261G0Q75m512khErPyM=;
	b=geQ1QPQMUG7XFXZdM3+NL1fD84HMG2Afa+gpWM4S3fvW/3Urrxo+4ll3JhzTexQrnn0z7E
	GJRSmneEgNfmFpSwtKgjli7PVWrrpX/Nq5VdWoI5II44iaEfplSVq5IbfhSkcy60OMgq/K
	RUyDrgfprYdgh2CQb4U13EtpEeAMbvylHV+fa/oDxsiSFUwsd+cUJ44blQ13YYR4c9hSYR
	JkLBVH/+gaLkFDrcVlY/aKlAiV9HzJ7FOiols2uZZiQOY8h1VTs5J31FETEPz5JOeqmO4H
	SfSKabueXPUG+0EtqWxe0GUjGnVla1IgaaanDNGU4cera+3cporNuwbJ//ihaA==
From: Yannik Tausch <dev@ytausch.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] dir: find common prefix among positive pathspecs
Message-Id: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
Date: Wed, 2 Sep 2026 15:04:09 +0200
To: git@vger.kernel.org

common_prefix_len() skips exclude pathspec items, but uses n =3D=3D 0 to
identify the initial item and items[0] as the comparison source. When
an exclude item comes first, the function returns zero even when all
positive pathspecs share a directory.

Track the first positive item explicitly. Return its match and the
common prefix length together so that common_prefix() and
fill_directory() use the correct string. Add a unit test with an
unrelated exclude before two positive pathspecs that share a directory.

Signed-off-by: Yannik Tausch <dev@ytausch.de>
---

This patch is based on =
https://lore.kernel.org/git/0CA8678D-0540-4A2E-B314-B9BEB04E2BF5@ytausch.d=
e/T/#u.

 dir.c                | 51 +++++++++++++++++++++++++++-----------------
 t/unit-tests/u-dir.c | 28 ++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index 7072715389..441c1795a1 100644
--- a/dir.c
+++ b/dir.c
@@ -212,9 +212,19 @@ static int fnmatch_icase_mem(const char *pattern, =
int patternlen,
 	return match_status;
 }
=20
-static size_t common_prefix_len(const struct pathspec *pathspec)
+struct pathspec_prefix {
+	const char *match;
+	size_t len;
+};
+
+/*
+ * Find the common prefix of positive pathspec items. The returned =
match
+ * points into the first positive item and is not NUL-terminated at =
len.
+ */
+static struct pathspec_prefix find_common_prefix(const struct pathspec =
*pathspec)
 {
-	int n;
+	struct pathspec_prefix prefix =3D { 0 };
+	int n, first =3D -1;
 	size_t max =3D 0;
=20
 	/*
@@ -237,44 +247,47 @@ static size_t common_prefix_len(const struct =
pathspec *pathspec)
 		size_t i =3D 0, len =3D 0, item_len;
 		if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
 			continue;
+		if (first < 0)
+			first =3D n;
 		if (pathspec->items[n].magic & PATHSPEC_ICASE)
 			item_len =3D pathspec->items[n].prefix;
 		else
 			item_len =3D pathspec->items[n].nowildcard_len;
-		while (i < item_len && (n =3D=3D 0 || i < max)) {
+		while (i < item_len && (n =3D=3D first || i < max)) {
 			char c =3D pathspec->items[n].match[i];
-			if (c !=3D pathspec->items[0].match[i])
+			if (c !=3D pathspec->items[first].match[i])
 				break;
 			if (c =3D=3D '/')
 				len =3D i + 1;
 			i++;
 		}
-		if (n =3D=3D 0 || len < max) {
+		if (n =3D=3D first || len < max) {
 			max =3D len;
 			if (!max)
 				break;
 		}
 	}
-	return max;
+	prefix.match =3D first < 0 ? NULL : =
pathspec->items[first].match;
+	prefix.len =3D max;
+	return prefix;
 }
=20
 /*
- * Returns a copy of the longest leading path common among all
+ * Returns a copy of the longest leading path common among all positive
  * pathspecs.
  */
 char *common_prefix(const struct pathspec *pathspec)
 {
-	unsigned long len =3D common_prefix_len(pathspec);
+	struct pathspec_prefix prefix =3D find_common_prefix(pathspec);
=20
-	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
+	return prefix.len ? xmemdupz(prefix.match, prefix.len) : NULL;
 }
=20
 int fill_directory(struct dir_struct *dir,
 		   struct index_state *istate,
 		   const struct pathspec *pathspec)
 {
-	const char *prefix;
-	size_t prefix_len;
+	struct pathspec_prefix prefix;
=20
 	unsigned exclusive_flags =3D DIR_SHOW_IGNORED | =
DIR_SHOW_IGNORED_TOO;
 	if ((dir->flags & exclusive_flags) =3D=3D exclusive_flags)
@@ -284,13 +297,13 @@ int fill_directory(struct dir_struct *dir,
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	prefix_len =3D common_prefix_len(pathspec);
-	prefix =3D prefix_len ? pathspec->items[0].match : "";
+	prefix =3D find_common_prefix(pathspec);
=20
 	/* Read the directory and prune it */
-	read_directory(dir, istate, prefix, prefix_len, pathspec);
+	read_directory(dir, istate, prefix.len ? prefix.match : "",
+		       prefix.len, pathspec);
=20
-	return prefix_len;
+	return prefix.len;
 }
=20
 int within_depth(const char *name, int namelen,
@@ -394,7 +407,7 @@ static int match_pathspec_item(struct index_state =
*istate,
=20
 	/*
 	 * The normal call pattern is:
-	 * 1. prefix =3D common_prefix_len(ps);
+	 * 1. prefix =3D find_common_prefix(ps).len;
 	 * 2. prune something, or fill_directory
 	 * 3. match_pathspec()
 	 *
@@ -411,11 +424,11 @@ static int match_pathspec_item(struct index_state =
*istate,
 	 * prefix part when :(icase) is involved. We do exact
 	 * comparison ourselves.
 	 *
-	 * Normally the caller (common_prefix_len() in fact) does
+	 * Normally the caller (find_common_prefix() in fact) does
 	 * _exact_ matching on name[-prefix+1..-1] and we do not need
 	 * to check that part. Be defensive and check it anyway, in
-	 * case common_prefix_len is changed, or a new caller is
-	 * introduced that does not use common_prefix_len.
+	 * case find_common_prefix() is changed, or a new caller is
+	 * introduced that does not use find_common_prefix().
 	 *
 	 * If the penalty turns out too high when prefix is really
 	 * long, maybe change it to
diff --git a/t/unit-tests/u-dir.c b/t/unit-tests/u-dir.c
index 2d0adaa39e..8b558e0391 100644
--- a/t/unit-tests/u-dir.c
+++ b/t/unit-tests/u-dir.c
@@ -45,3 +45,31 @@ void test_dir__within_depth(void)
=20
=20
 }
+
+void test_dir__common_prefix_skips_excluded_pathspecs(void)
+{
+	struct pathspec_item items[] =3D {
+		{
+			.match =3D "unrelated/path",
+			.magic =3D PATHSPEC_EXCLUDE,
+			.nowildcard_len =3D 14,
+		},
+		{
+			.match =3D "foo/bar",
+			.nowildcard_len =3D 7,
+		},
+		{
+			.match =3D "foo/baz",
+			.nowildcard_len =3D 7,
+		},
+	};
+	struct pathspec pathspec =3D {
+		.nr =3D ARRAY_SIZE(items),
+		.magic =3D PATHSPEC_EXCLUDE,
+		.items =3D items,
+	};
+	char *prefix =3D common_prefix(&pathspec);
+
+	cl_assert_equal_s(prefix, "foo/");
+	free(prefix);
+}

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
prerequisite-patch-id: 256750f07ff447732869d1aadde2f1050e7bb169
--=20
2.55.0=
