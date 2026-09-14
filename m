Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A73B19D6
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370851; cv=none; b=EkFiOmKVXnqmL+Yg5HiTsSFsD1bdPc6LlGQqFfidULr1wMucqTUk7MqgTesDCRzLTfPTY+VcBrkrIVYuCVL4XsxH9Y02jLb75So3JlCZs2eZ95YzgIXXLMM+8VeKuC8i7GyX+WQOY9x4zE5Tr8N1bRBscceQcAetR6zxGs1okjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370851; c=relaxed/simple;
	bh=KG4btxfATa1KDjQ1c1Db7tlU8u0n6I6SRC4ewnHge54=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RTUPFtv8boxJ4ay0Pf6UzyWD/iNrJo086hyYzgIfTG8E3vpscNE61uKTNjJYXJ+8cYmXWgqdpXMd7eC+5+n0YxOb2RQEWXoAm40sOlysJRpQyUJpweTB05luQGAqok5dgMyz3W99DmrSxcEeT/dLMT6WW4ddHS5HLjicdbAyc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=usEf4k0g; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="usEf4k0g"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hjxYd3Bz8zKm7S;
	Mon, 14 Sep 2026 09:27:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1789370837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QS7yk02RDuIrdgbg80+3CrgbKoF1bCh21jcAcninA74=;
	b=usEf4k0gAhLZhI4hHPss5yRFf+KABIH//MK46WBOJIBnHURbrk1MD6Y70Q6oo9WBmlS3nN
	qPSGMyf7/v/VCYDt8x4qH7ualbL1/LTgVwfSr9c/m8URxHg2LnIkSc34/zeEzj4LOGCb0U
	IXcSLvLLUkA9LBxOz0Xc6w7gMeEVf6nke+TJWmZHdm3FaQNpU5wymhCw3oGPtDW/I8NNnM
	nJ0dZVoFtYCE+46658BAw5JlH34qmyWG8yrPRazOGxRuaQ05d32o/Xhc7q7FV+/zG32Cdo
	IOClF3ixotpNpHCI6PWdQT0DvfSqExTcEBKTi/Qn79gGs3Qe3Yy8/RvsWzh1LQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v4 2/2] dir: preserve pathspec prefix optimization with
 leading excludes
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <7CB757FB-1F2D-4EE6-8C31-8C2CD6D42397@ytausch.de>
Date: Mon, 14 Sep 2026 09:27:05 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 newren@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B90E7FCE-0A5F-4629-A2BE-37F2CAC5F3B1@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
 <7CB757FB-1F2D-4EE6-8C31-8C2CD6D42397@ytausch.de>
To: git@vger.kernel.org

Directory walks use the common directory prefix of non-exclude
pathspec items to avoid scanning unrelated portions of the working
tree or index. Exclude items only remove paths from that candidate
set, so they do not need to widen the traversal.

When an exclude item is the first pathspec item, common_prefix_len()
fails to establish a comparison base and returns a zero-length prefix.
The result is correct, but Git unnecessarily traverses from a broader
starting point even when all non-exclude items share a directory.

Use the first non-exclude item as the comparison base and return its
string together with the prefix length, allowing callers to start from
the recovered directory prefix. Exclude matching continues to use full
paths, so this restores the optimization without changing which paths
are selected. Add a unit test covering an exclude item before two
non-exclude items with a common directory.

Signed-off-by: Yannik Tausch <dev@ytausch.de>
---
 dir.c                | 37 +++++++++++++++++++++----------------
 t/unit-tests/u-dir.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index 5f42c992d3..abc4a78f31 100644
--- a/dir.c
+++ b/dir.c
@@ -212,9 +212,10 @@ static int fnmatch_icase_mem(const char *pattern, =
int patternlen,
 	return match_status;
 }
=20
-static size_t common_prefix_len(const struct pathspec *pathspec)
+static size_t common_prefix_len(const struct pathspec *pathspec,
+				const char **matched_prefix)
 {
-	int n;
+	int n, first =3D -1;
 	size_t max =3D 0;
=20
 	/*
@@ -237,43 +238,47 @@ static size_t common_prefix_len(const struct =
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
+	*matched_prefix =3D first < 0 ? NULL : =
pathspec->items[first].match;
 	return max;
 }
=20
 /*
- * Returns a copy of the longest leading path common among all
- * pathspecs.
+ * Returns a copy of the longest leading path common among all pathspec
+ * items that are not excluded.
  */
 char *common_prefix(const struct pathspec *pathspec)
 {
-	unsigned long len =3D common_prefix_len(pathspec);
+	const char *matched_prefix;
+	size_t len =3D common_prefix_len(pathspec, &matched_prefix);
=20
-	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
+	return len ? xmemdupz(matched_prefix, len) : NULL;
 }
=20
 int fill_directory(struct dir_struct *dir,
 		   struct index_state *istate,
 		   const struct pathspec *pathspec)
 {
-	const char *prefix;
+	const char *matched_prefix;
 	size_t prefix_len;
=20
 	unsigned exclusive_flags =3D DIR_SHOW_IGNORED | =
DIR_SHOW_IGNORED_TOO;
@@ -284,11 +289,11 @@ int fill_directory(struct dir_struct *dir,
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	prefix_len =3D common_prefix_len(pathspec);
-	prefix =3D prefix_len ? pathspec->items[0].match : "";
+	prefix_len =3D common_prefix_len(pathspec, &matched_prefix);
=20
 	/* Read the directory and prune it */
-	read_directory(dir, istate, prefix, prefix_len, pathspec);
+	read_directory(dir, istate, prefix_len ? matched_prefix : "",
+		       prefix_len, pathspec);
=20
 	return prefix_len;
 }
@@ -394,7 +399,7 @@ static int match_pathspec_item(struct index_state =
*istate,
=20
 	/*
 	 * The normal call pattern is:
-	 * 1. prefix =3D common_prefix_len(ps);
+	 * 1. prefix =3D common_prefix_len(ps, &matched_prefix);
 	 * 2. prune something, or fill_directory
 	 * 3. match_pathspec()
 	 *
@@ -414,8 +419,8 @@ static int match_pathspec_item(struct index_state =
*istate,
 	 * Normally the caller (common_prefix_len() in fact) does
 	 * _exact_ matching on name[-prefix+1..-1] and we do not need
 	 * to check that part. Be defensive and check it anyway, in
-	 * case common_prefix_len is changed, or a new caller is
-	 * introduced that does not use common_prefix_len.
+	 * case common_prefix_len() is changed, or a new caller is
+	 * introduced that does not use common_prefix_len().
 	 *
 	 * If the penalty turns out too high when prefix is really
 	 * long, maybe change it to
diff --git a/t/unit-tests/u-dir.c b/t/unit-tests/u-dir.c
index 2d0adaa39e..a3442c3d3c 100644
--- a/t/unit-tests/u-dir.c
+++ b/t/unit-tests/u-dir.c
@@ -45,3 +45,31 @@ void test_dir__within_depth(void)
=20
=20
 }
+
+void test_dir__common_prefix_skips_excluded_pathspec_items(void)
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
--=20
2.55.0

