Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04046A4
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445155; cv=none; b=pJu06Ep3YMagbx0AqnY+A226qY7hj540npHhxzL43p6jCBsgB0IYrPOLaBKDwOZ+oBAAu3tl3mXS2XQMBwUWnqsxLLMca4iCqJ4yxMFe9sA6AQl/2Ch7fytkWyqj+pBuZ9aZHsxFhKALAE4KX9GOa5Ijbe4jzKNI/BRyEi0yGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445155; c=relaxed/simple;
	bh=2xevrHjH0j22k/oNehdSoCNXHI5b4rfl9dDnukFJcDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmqxe+gkcdQTLFOXjvliCiWLgtCGvFYPjh9K2cP9/ny3id/yWCOSmzAEUWXKaB6CcmE6BKdeQwv8R57dUds/wBbZUHsRkKBTJaLyqV3klhl3w5jQh31vQMRD88G0eYnXHIQ/k+vt3LWkdFyUa1rJK5MOALve+MkpUoGbkCeynk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dMtLg2+2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dMtLg2+2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EC142AA00;
	Mon,  3 Jun 2024 16:05:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=2xevrHjH0j22k/oNehdSoCNXH
	I5b4rfl9dDnukFJcDc=; b=dMtLg2+2zjyYrj+B0D7urAnoKrEe4cNhgteWYHCcJ
	JOajQPj0DKvXBXp5DufC6yCjubA5nsFvn3PRMiNwh5K8Y56XVyw88fa31GdsgwYH
	c38aCFbA9ljEhRjRmwBtQ23PgizpLZ5Md7alWV1wHXvENnO/2Xv4mQLkVln8lQhC
	/0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 264A52A9FF;
	Mon,  3 Jun 2024 16:05:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C041D2A9FE;
	Mon,  3 Jun 2024 16:05:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/3] show-ref: introduce --branches and deprecate --heads
Date: Mon,  3 Jun 2024 13:05:39 -0700
Message-ID: <20240603200539.1473345-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-404-g9eaef5822c
In-Reply-To: <20240603200539.1473345-1-gitster@pobox.com>
References: <xmqq8qzl3mhg.fsf@gitster.g>
 <20240603200539.1473345-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 ABA96382-21E4-11EF-B4DA-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

We call the tips of branches "heads", but this command calls the
option to show only branches "--heads", which confuses the branches
themselves and the tips of branches.

Straighten the terminology by introducing "--branches" option that
limits the output to branches, and deprecate "--heads" option used
that way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-show-ref.txt | 18 ++++++++++--------
 builtin/show-ref.c             | 33 ++++++++++++++++++++++++++-------
 t/t1403-show-ref.sh            | 22 ++++++++++++++--------
 3 files changed, 50 insertions(+), 23 deletions(-)

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
index 1c15421e60..6b69daeb66 100644
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
@@ -279,6 +279,20 @@ static int exclude_existing_callback(const struct op=
tion *opt, const char *arg,
 	return 0;
 }
=20
+static int heads_callback(const struct option *opt, const char *arg, int=
 unset)
+{
+	int *branches_only =3D opt->value;
+
+	if (unset) {
+		warning(_("'--no-heads' is deprecated; use '--no-branches' instead"));
+		*branches_only =3D 0;
+	} else {
+		warning(_("'--heads' is deprecated; use '--branches' instead"));
+		*branches_only =3D 1;
+	}
+	return 0;
+}
+
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	struct exclude_existing_options exclude_existing_opts =3D {0};
@@ -286,8 +300,13 @@ int cmd_show_ref(int argc, const char **argv, const =
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
+		OPT_CALLBACK_F(0, "heads", &patterns_opts.branches_only,
+			       NULL,
+			       N_("deprecated synonym for --branches)"),
+			       PARSE_OPT_NOARG|PARSE_OPT_HIDDEN,
+			       &heads_callback),
 		OPT_BOOL(0, "exists", &exists, N_("check for reference existence witho=
ut resolving")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 33fb7a38ff..b72ed70435 100755
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
@@ -165,6 +165,12 @@ test_expect_success 'show-ref --heads, --tags, --hea=
d, pattern' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'show-ref --heads is deprecated' '
+	git show-ref --heads >actual 2>warning &&
+	test_grep deprecated warning &&
+	test_cmp expect.branches actual
+'
+
 test_expect_success 'show-ref --verify HEAD' '
 	echo $(git rev-parse HEAD) HEAD >expect &&
 	git show-ref --verify HEAD >actual &&
--=20
2.45.2-404-g9eaef5822c

