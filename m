Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570914B96B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538516; cv=none; b=ZyzJkqd6dsDW4d8B2fvFxfPqrtmWLkoiTbkqY0gHstaR0G8hFlVEbDwQ3Hq4/it3yaBem5qiREaC43Id4K0ZtwD2yfxOPKMCAAl+qnDNq5lmxjyl09ra/U+cb7mbf/y4+L9cgcen22TVBmMRqrkHFNWfjjZcHb1ae+JbAAsuHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538516; c=relaxed/simple;
	bh=wk7IEmxvM9+6i/zhR+UZJWKKrYyCybfDNHHlSgS0eyM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo8F8LYAY6LZHzWlhrw4npAbrDIAFEkb2Z4iR3HXAJ/kca6wDBDsvKgQ4NI+LsWsK89BwS2STEvTNH9VJS9m8Kr6Os6iaS3VMgPA1BF6Zdvs3VIlmEYqlP3SBJ4rggxQcs70YK9tSFnSu3nIGtvwUxgJM8FEgU3f7fcsv70PIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RJ59OUyV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RJ59OUyV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 89F9837754;
	Tue,  4 Jun 2024 18:01:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=wk7IEmxvM9+6i/zhR+UZJWKKr
	YyCybfDNHHlSgS0eyM=; b=RJ59OUyVsQxxBhrme4qFUz/CQmee1A7b+hVWiORZj
	rWHzV0BU6ObUDLkspvsoDR1BJPNHibadfPCTnWMRSVMNG2m5I3F2mQlxjADJmF3h
	4Du1zM7BSmI4xL9T4GOpfoSIio1u4iWhRgGm0zGI6H9ZvdlGgUDedUccVivpqdKD
	0I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7063537753;
	Tue,  4 Jun 2024 18:01:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C299A37750;
	Tue,  4 Jun 2024 18:01:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/3] ls-remote: introduce --branches and deprecate --heads
Date: Tue,  4 Jun 2024 15:01:44 -0700
Message-ID: <20240604220145.3260714-3-gitster@pobox.com>
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
 0CF30D8A-22BE-11EF-B80C-6488940A682E-77302942!pb-smtp2.pobox.com
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
 Documentation/git-ls-remote.txt | 12 +++++++-----
 builtin/ls-remote.c             |  7 +++++--
 t/t5512-ls-remote.sh            | 32 +++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 12 deletions(-)

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
index 65fb22a8a2..69841ed49f 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -9,7 +9,7 @@
 #include "wildmatch.h"
=20
 static const char * const ls_remote_usage[] =3D {
-	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]\=
n"
+	N_("git ls-remote [--branches] [--tags] [--refs] [--upload-pack=3D<exec=
>]\n"
 	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=3D<k=
ey>]\n"
 	   "              [--symref] [<repository> [<patterns>...]]"),
 	NULL
@@ -68,7 +68,10 @@ int cmd_ls_remote(int argc, const char **argv, const c=
har *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_BRANCHES),
+		OPT_BIT('b', "branches", &flags, N_("limit to branches"), REF_BRANCHES=
),
+		OPT_BIT_F('h', "heads", &flags,
+			  N_("deprecated synonym for --branches"), REF_BRANCHES,
+			  PARSE_OPT_HIDDEN),
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5dbe107ce8..42e77eb5a9 100755
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
@@ -71,6 +72,27 @@ test_expect_success 'ls-remote self' '
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
+test_expect_success 'ls-remote -h is deprecated w/o warning' '
+	git ls-remote -h self >actual 2>warning &&
+	test_cmp expected.branches actual &&
+	test_grep ! deprecated warning
+'
+
+test_expect_success 'ls-remote --heads is deprecated and hidden w/o warn=
ing' '
+	test_expect_code 129 git ls-remote -h >short-help &&
+	test_grep ! -e --head short-help &&
+	git ls-remote --heads self >actual 2>warning &&
+	test_cmp expected.branches actual &&
+	test_grep ! deprecated warning
+'
+
 test_expect_success 'ls-remote --sort=3D"version:refname" --tags self' '
 	generate_references \
 		refs/tags/mark \
@@ -275,7 +297,7 @@ test_expect_success 'ls-remote with filtered symref (=
refname)' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'ls-remote with filtered symref (--heads)' '
+test_expect_success 'ls-remote with filtered symref (--branches)' '
 	git symbolic-ref refs/heads/foo refs/tags/mark &&
 	cat >expect.v2 <<-EOF &&
 	ref: refs/tags/mark	refs/heads/foo
@@ -283,9 +305,9 @@ test_expect_success 'ls-remote with filtered symref (=
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
@@ -335,9 +357,9 @@ test_expect_success 'ls-remote patterns work with all=
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
2.45.2-409-g7b0defb391

