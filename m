Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30613A41A
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538519; cv=none; b=NOZyethwACrvngVPgkA4Is2eE9x2oAeq8B90Sa/pfkHMWl2UfFJriW+qknDWN0iP9SHvESd5y6avH6slrpFoMpepc6at9s9d3RnGUg0EhKrrfm07rQ6cWcVKTkyYDsdsDsem0p0N4xXNrEjdaKBTApzyXCwC1WNVsXi4mdU30Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538519; c=relaxed/simple;
	bh=qDUU51M8UhBlAFNOLyiQuGTb6+rF0uWLJXDZzooqWbs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbFHEMKP3SwS+WHn0tScaD+WgaA9Q6UenJbsH2KKH7xqf4b/LsfwVAMTwCx6Yih3E/+1so9sNei2VHCgduxdK5ffnc37eYSIgETnnoLnM+2KvKI3oisHTVGZ9LkIcKZQC3dRy0QQotMB16s4pg3F6v7z8ZlWzPry9FqC5XbESYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D70iU7yL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D70iU7yL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 979AF1E84D;
	Tue,  4 Jun 2024 18:01:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=qDUU51M8UhBlAFNOLyiQuGTb6
	+rF0uWLJXDZzooqWbs=; b=D70iU7yLknEpPn3v+ypkCTg31f0fxjVoNIx/Uoyyj
	AcnafpZPdCgQbc1XqteiTzx7yikH00bjHHD6B5E6kHh6csf5Q3mqmQuvKEY9SDjn
	viQyqDdsQePCStNYjlqyaVtShiY5U3e7V8hFSH8lj0t3dh++eQ589AoqPs/YuPU2
	vg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 914AD1E84C;
	Tue,  4 Jun 2024 18:01:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A826E1E848;
	Tue,  4 Jun 2024 18:01:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/3] show-ref: introduce --branches and deprecate --heads
Date: Tue,  4 Jun 2024 15:01:45 -0700
Message-ID: <20240604220145.3260714-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-409-g7b0defb391
In-Reply-To: <20240604220145.3260714-1-gitster@pobox.com>
References: <20240603200539.1473345-1-gitster@pobox.com>
 <20240604220145.3260714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0E130C60-22BE-11EF-806B-8F8B087618E4-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

We call the tips of branches "heads", but this command calls the
option to show only branches "--heads", which confuses the branches
themselves and the tips of branches.

Straighten the terminology by introducing "--branches" option that
limits the output to branches, and deprecate "--heads" option used
that way.

We do not plan to remove "--heads" or "-h" yet; we may want to do so
at Git 3.0, in which case, we may need to start advertising upcoming
removal with an extra warning when they are used.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-show-ref.txt | 18 ++++++++++--------
 builtin/show-ref.c             | 16 +++++++++-------
 t/t1403-show-ref.sh            | 24 ++++++++++++++++--------
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.=
txt
index ba75747005..616d919655 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git show-ref' [--head] [-d | --dereference]
-	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
-	     [--heads] [--] [<pattern>...]
+	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--branches] [--tags]
+	     [--] [<pattern>...]
 'git show-ref' --verify [-q | --quiet] [-d | --dereference]
 	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
 	     [--] [<ref>...]
@@ -45,12 +45,14 @@ OPTIONS
=20
 	Show the HEAD reference, even if it would normally be filtered out.
=20
---heads::
+--branches::
 --tags::
=20
-	Limit to "refs/heads" and "refs/tags", respectively.  These options
+	Limit to local branches and local tags, respectively.  These options
 	are not mutually exclusive; when given both, references stored in
-	"refs/heads" and "refs/tags" are displayed.
+	"refs/heads" and "refs/tags" are displayed.  Note that `--heads`
+	is a deprecated synonym for `--branches` and may be removed
+	in the future.
=20
 -d::
 --dereference::
@@ -139,7 +141,7 @@ When using `--hash` (and not `--dereference`), the ou=
tput is in the format:
 For example,
=20
 ------------------------------------------------------------------------=
-----
-$ git show-ref --heads --hash
+$ git show-ref --branches --hash
 2e3ba0114a1f52b47df29743d6915d056be13278
 185008ae97960c8d551adcd9e23565194651b5d1
 03adf42c988195b50e1a1935ba5fcbc39b2b029b
@@ -183,8 +185,8 @@ to check whether a particular branch exists or not (n=
otice how we don't
 actually want to show any results, and we want to use the full refname f=
or it
 in order to not trigger the problem with ambiguous partial matches).
=20
-To show only tags, or only proper branch heads, use `--tags` and/or `--h=
eads`
-respectively (using both means that it shows tags and heads, but not oth=
er
+To show only tags, or only proper branch heads, use `--tags` and/or `--b=
ranches`
+respectively (using both means that it shows tags and branches, but not =
other
 random references under the refs/ subdirectory).
=20
 To do automatic tag object dereferencing, use the `-d` or `--dereference=
`
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1c15421e60..f634bc3e44 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -11,8 +11,8 @@
=20
 static const char * const show_ref_usage[] =3D {
 	N_("git show-ref [--head] [-d | --dereference]\n"
-	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]\n"
-	   "             [--heads] [--] [<pattern>...]"),
+	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--branches] =
[--tags]\n"
+	   "             [--] [<pattern>...]"),
 	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
 	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
 	   "             [--] [<ref>...]"),
@@ -188,7 +188,7 @@ static int cmd_show_ref__verify(const struct show_one=
_options *show_one_opts,
=20
 struct patterns_options {
 	int show_head;
-	int heads_only;
+	int branches_only;
 	int tags_only;
 };
=20
@@ -206,8 +206,8 @@ static int cmd_show_ref__patterns(const struct patter=
ns_options *opts,
=20
 	if (opts->show_head)
 		head_ref(show_ref, &show_ref_data);
-	if (opts->heads_only || opts->tags_only) {
-		if (opts->heads_only)
+	if (opts->branches_only || opts->tags_only) {
+		if (opts->branches_only)
 			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
 		if (opts->tags_only)
 			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
@@ -286,8 +286,10 @@ int cmd_show_ref(int argc, const char **argv, const =
char *prefix)
 	struct show_one_options show_one_opts =3D {0};
 	int verify =3D 0, exists =3D 0;
 	const struct option show_ref_options[] =3D {
-		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can =
be combined with heads)")),
-		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (c=
an be combined with tags)")),
+		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can =
be combined with branches)")),
+		OPT_BOOL(0, "branches", &patterns_opts.branches_only, N_("only show br=
anches (can be combined with tags)")),
+		OPT_HIDDEN_BOOL(0, "heads", &patterns_opts.branches_only,
+				N_("deprecated synonym for --branches")),
 		OPT_BOOL(0, "exists", &exists, N_("check for reference existence witho=
ut resolving")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 33fb7a38ff..403f6b8f7d 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -121,13 +121,13 @@ test_expect_success 'show-ref -d' '
=20
 '
=20
-test_expect_success 'show-ref --heads, --tags, --head, pattern' '
+test_expect_success 'show-ref --branches, --tags, --head, pattern' '
 	for branch in B main side
 	do
 		echo $(git rev-parse refs/heads/$branch) refs/heads/$branch || return =
1
-	done >expect.heads &&
-	git show-ref --heads >actual &&
-	test_cmp expect.heads actual &&
+	done >expect.branches &&
+	git show-ref --branches >actual &&
+	test_cmp expect.branches actual &&
=20
 	for tag in A B C
 	do
@@ -136,15 +136,15 @@ test_expect_success 'show-ref --heads, --tags, --he=
ad, pattern' '
 	git show-ref --tags >actual &&
 	test_cmp expect.tags actual &&
=20
-	cat expect.heads expect.tags >expect &&
-	git show-ref --heads --tags >actual &&
+	cat expect.branches expect.tags >expect &&
+	git show-ref --branches --tags >actual &&
 	test_cmp expect actual &&
=20
 	{
 		echo $(git rev-parse HEAD) HEAD &&
-		cat expect.heads expect.tags
+		cat expect.branches expect.tags
 	} >expect &&
-	git show-ref --heads --tags --head >actual &&
+	git show-ref --branches --tags --head >actual &&
 	test_cmp expect actual &&
=20
 	{
@@ -165,6 +165,14 @@ test_expect_success 'show-ref --heads, --tags, --hea=
d, pattern' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'show-ref --heads is deprecated and hidden' '
+	test_expect_code 129 git show-ref -h >short-help &&
+	test_grep ! -e --heads short-help &&
+	git show-ref --heads >actual 2>warning &&
+	test_grep ! deprecated warning &&
+	test_cmp expect.branches actual
+'
+
 test_expect_success 'show-ref --verify HEAD' '
 	echo $(git rev-parse HEAD) HEAD >expect &&
 	git show-ref --verify HEAD >actual &&
--=20
2.45.2-409-g7b0defb391

