Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F546A4
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445150; cv=none; b=cienPg1/adBWaDKJ9ppyZFRtP4JtZjp+MyegEobcFORf31jL09TazNdo5/TDTVXaODCwkikqOvg/WWQkBE388dJRXEZTh+evaqoBmgtfrSg87CCzbd3XAQ/SVgU0VIttAmbwEUSDoVC8X9J4l1+pYAFrtFwCwstMwRsntSoj3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445150; c=relaxed/simple;
	bh=wjZpdyV1ZpWCt3x54nMmFYsc7s7E7L7Bu7GiMoHP1o0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT3rOzMxGGLW8lTit43quoFLZat4OX476fySXHJT31VEfTbo84uXXcKlrlIM1UaLuNvreK48skmy7Ouc8np01PdIKYXwWfU3t9LBv1IGBS0e2FUHpq1bsMOcdQCA5m743JcVecwwgnn0X4/l750xJOtACrZFgPQBVeRbKJaYoWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sMzQn/yJ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sMzQn/yJ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 874A12DE2D;
	Mon,  3 Jun 2024 16:05:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=wjZpdyV1ZpWCt3x54nMmFYsc7
	s7E7L7Bu7GiMoHP1o0=; b=sMzQn/yJPXYo7xy1om4k0tcmDJq1PlDP5atcka2CV
	YON1gMf6l7zlUZLvq+cSHRyhAv6YZ/JVqJDMloMUuI2DgLvjQ4e18aieoUj64yzE
	cjVj4+2+4+2Zqfxc5+9avuS9VhKkeaMQE3kEt6nhozDQ0nCyuXAY0CYOd0GJaKJ/
	JU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 775022DE2C;
	Mon,  3 Jun 2024 16:05:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D73CF2DE2B;
	Mon,  3 Jun 2024 16:05:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/3] ls-remote: introduce --branches and deprecate --heads
Date: Mon,  3 Jun 2024 13:05:38 -0700
Message-ID: <20240603200539.1473345-3-gitster@pobox.com>
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
 AA86670C-21E4-11EF-9169-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

We call the tips of branches "heads", but this command calls the
option to show only branches "--heads", which confuses the branches
themselves and the tips of branches.

Straighten the terminology by introducing "--branches" option that
limits the output to branches, and deprecate "--heads" option used
that way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-remote.txt | 12 +++++++-----
 builtin/ls-remote.c             | 21 ++++++++++++++++++++-
 t/t5512-ls-remote.sh            | 30 +++++++++++++++++++++++++-----
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remot=
e.txt
index 1c4f696ab5..76c86c3ce4 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -9,7 +9,7 @@ git-ls-remote - List references in a remote repository
 SYNOPSIS
 --------
 [verse]
-'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]
+'git ls-remote' [--branches] [--tags] [--refs] [--upload-pack=3D<exec>]
 	      [-q | --quiet] [--exit-code] [--get-url] [--sort=3D<key>]
 	      [--symref] [<repository> [<patterns>...]]
=20
@@ -21,14 +21,16 @@ commit IDs.
=20
 OPTIONS
 -------
--h::
---heads::
+-b::
+--branches::
 -t::
 --tags::
-	Limit to only refs/heads and refs/tags, respectively.
+	Limit to only local branches and local tags, respectively.
 	These options are _not_ mutually exclusive; when given
 	both, references stored in refs/heads and refs/tags are
-	displayed.  Note that `git ls-remote -h` used without
+	displayed.  Note that `--heads` and `-h` are deprecated
+	synonyms for `--branches` and `-b` and may be removed in
+	the future.  Also note that `git ls-remote -h` used without
 	anything else on the command line gives help, consistent
 	with other git subcommands.
=20
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 9838de69c0..95fbb8b7b5 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -38,6 +38,20 @@ static int tail_match(const char **pattern, const char=
 *path)
 	return 0;
 }
=20
+static int heads_callback(const struct option *opt, const char *arg, int=
 unset)
+{
+	unsigned *flags =3D opt->value;
+
+	if (unset) {
+		warning(_("'--no-heads' is deprecated; use '--no-branches' instead"));
+		*flags &=3D ~REF_BRANCHES;
+	} else {
+		warning(_("'--heads' is deprecated; use '--branches' instead"));
+		*flags |=3D REF_BRANCHES;
+	}
+	return 0;
+}
+
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
 	const char *dest =3D NULL;
@@ -68,7 +82,12 @@ int cmd_ls_remote(int argc, const char **argv, const c=
har *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_BRANCHES),
+		OPT_BIT('b', "branches", &flags, N_("limit to branches"), REF_BRANCHES=
),
+		OPT_CALLBACK_F('h', "heads", &flags,
+			       NULL,
+			       N_("deprecated synonym for --branches"),
+			       PARSE_OPT_NOARG|PARSE_OPT_HIDDEN,
+			       &heads_callback),
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5dbe107ce8..b9950ca361 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -47,6 +47,7 @@ test_expect_success setup '
 	git show-ref -d	>refs &&
 	sed -e "s/ /	/" refs >>expected.all &&
=20
+	grep refs/heads/ expected.all >expected.branches &&
 	git remote add self "$(pwd)/.git" &&
 	git remote add self2 "."
 '
@@ -71,6 +72,25 @@ test_expect_success 'ls-remote self' '
 	test_cmp expected.all actual
 '
=20
+test_expect_success 'ls-remote --branches self' '
+	git ls-remote --branches self >actual &&
+	test_cmp expected.branches actual &&
+	git ls-remote -b self >actual &&
+	test_cmp expected.branches actual
+'
+
+test_expect_success 'ls-remote -h is deprecated' '
+	git ls-remote -h self >actual 2>warning &&
+	test_cmp expected.branches actual &&
+	test_grep deprecated warning
+'
+
+test_expect_success 'ls-remote --heads is deprecated' '
+	git ls-remote --heads self >actual 2>warning &&
+	test_cmp expected.branches actual &&
+	test_grep deprecated warning
+'
+
 test_expect_success 'ls-remote --sort=3D"version:refname" --tags self' '
 	generate_references \
 		refs/tags/mark \
@@ -275,7 +295,7 @@ test_expect_success 'ls-remote with filtered symref (=
refname)' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'ls-remote with filtered symref (--heads)' '
+test_expect_success 'ls-remote with filtered symref (--branches)' '
 	git symbolic-ref refs/heads/foo refs/tags/mark &&
 	cat >expect.v2 <<-EOF &&
 	ref: refs/tags/mark	refs/heads/foo
@@ -283,9 +303,9 @@ test_expect_success 'ls-remote with filtered symref (=
--heads)' '
 	$rev	refs/heads/main
 	EOF
 	grep -v "^ref: refs/tags/" <expect.v2 >expect.v0 &&
-	git -c protocol.version=3D0 ls-remote --symref --heads . >actual.v0 &&
+	git -c protocol.version=3D0 ls-remote --symref --branches . >actual.v0 =
&&
 	test_cmp expect.v0 actual.v0 &&
-	git -c protocol.version=3D2 ls-remote --symref --heads . >actual.v2 &&
+	git -c protocol.version=3D2 ls-remote --symref --branches . >actual.v2 =
&&
 	test_cmp expect.v2 actual.v2
 '
=20
@@ -335,9 +355,9 @@ test_expect_success 'ls-remote patterns work with all=
 protocol versions' '
 test_expect_success 'ls-remote prefixes work with all protocol versions'=
 '
 	git for-each-ref --format=3D"%(objectname)	%(refname)" \
 		refs/heads/ refs/tags/ >expect &&
-	git -c protocol.version=3D0 ls-remote --heads --tags . >actual.v0 &&
+	git -c protocol.version=3D0 ls-remote --branches --tags . >actual.v0 &&
 	test_cmp expect actual.v0 &&
-	git -c protocol.version=3D2 ls-remote --heads --tags . >actual.v2 &&
+	git -c protocol.version=3D2 ls-remote --branches --tags . >actual.v2 &&
 	test_cmp expect actual.v2
 '
=20
--=20
2.45.2-404-g9eaef5822c

