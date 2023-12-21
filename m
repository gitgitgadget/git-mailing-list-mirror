Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D011734
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m31chFpb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DA93E346C4;
	Thu, 21 Dec 2023 01:59:33 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=aXx/CEb8V3GWZJgttIS/8RNZ4
	z6BoLepkL58LL81O2Q=; b=m31chFpb4Cp0S8VAPrGHSD5zKgztE/ZcwmGShPhKv
	WGwnk19kch0kxrdlwnBzjCY11sEMeSVjtRgsQKxAamB6IX3+sUCMh4vjFTb0ZDp6
	QnM7MeMMietcFi0nYA9WgnPsWG4hKuutGrrO0HBOgMufp7Rbz2/p5uVrizf5wCXA
	aA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D2B09346C3;
	Thu, 21 Dec 2023 01:59:33 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C798346C2;
	Thu, 21 Dec 2023 01:59:30 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Josh Steadmon <steadmon@google.com>
Subject: [PATCH 1/3] sparse-checkout: take care of "--end-of-options" in set/add/check-rules
Date: Wed, 20 Dec 2023 22:59:23 -0800
Message-ID: <20231221065925.3234048-2-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-174-g055bb6e996
In-Reply-To: <20231221065925.3234048-1-gitster@pobox.com>
References: <20231221065925.3234048-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 7D0EA2DC-9FCE-11EE-A879-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

93851746 (parse-options: decouple "--end-of-options" and "--",
2023-12-06) updated the world order to make callers of parse-options
that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
do with "--end-of-options" they may see after parse_options() returns.

This unfortunately broke "sparse-checkout set/add", and from this
invocation,

  "git sparse-checkout [add|set] --[no-]cone --end-of-options pattern..."

we now see "--end-of-options" listed in .git/info/sparse-checkout as if
it is one of the path patterns.

A breakage that results from the same cause exists in the check-rules
subcommand, but check-rules has a few other problems that need to be
corrected before it can fully work with --end-of-options safely,
which will be addressed later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/sparse-checkout.c          | 3 +++
 parse-options.c                    | 8 ++++++++
 parse-options.h                    | 2 ++
 t/t1090-sparse-checkout-scope.sh   | 8 ++++++++
 t/t1091-sparse-checkout-builtin.sh | 2 +-
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5c8ffb1f75..8f55127202 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -779,6 +779,7 @@ static int sparse_checkout_add(int argc, const char *=
*argv, const char *prefix)
 			     builtin_sparse_checkout_add_options,
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+	parse_opt_skip_end_of_options(&argc, &argv);
=20
 	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
=20
@@ -826,6 +827,7 @@ static int sparse_checkout_set(int argc, const char *=
*argv, const char *prefix)
 			     builtin_sparse_checkout_set_options,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+	parse_opt_skip_end_of_options(&argc, &argv);
=20
 	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
 		return 1;
@@ -998,6 +1000,7 @@ static int sparse_checkout_check_rules(int argc, con=
st char **argv, const char *
 			     builtin_sparse_checkout_check_rules_options,
 			     builtin_sparse_checkout_check_rules_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+	parse_opt_skip_end_of_options(&argc, &argv);
=20
 	if (check_rules_opts.rules_file && check_rules_opts.cone_mode < 0)
 		check_rules_opts.cone_mode =3D 1;
diff --git a/parse-options.c b/parse-options.c
index d50962062e..fe265bbf68 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1321,3 +1321,11 @@ void die_for_incompatible_opt4(int opt1, const cha=
r *opt1_name,
 		break;
 	}
 }
+
+void parse_opt_skip_end_of_options(int *argc, const char ***argv)
+{
+	if (*argc && !strcmp(**argv, "--end-of-options")) {
+		(*argc)--;
+		(*argv)++;
+	}
+}
diff --git a/parse-options.h b/parse-options.h
index bd62e20268..0d3354d4a8 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -498,6 +498,8 @@ int parse_opt_passthru_argv(const struct option *, co=
nst char *, int);
 /* value is enum branch_track* */
 int parse_opt_tracking_mode(const struct option *, const char *, int);
=20
+void parse_opt_skip_end_of_options(int *argc, const char ***argv);
+
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) { \
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-s=
cope.sh
index 3a14218b24..5b96716235 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -57,6 +57,14 @@ test_expect_success 'return to full checkout of main' =
'
 test_expect_success 'skip-worktree on files outside sparse patterns' '
 	git sparse-checkout disable &&
 	git sparse-checkout set --no-cone "a*" &&
+	cat .git/info/sparse-checkout >wo-eoo &&
+
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone --end-of-options "a*" &&
+	cat .git/info/sparse-checkout >w-eoo &&
+
+	test_cmp wo-eoo w-eoo &&
+
 	git checkout-index --all --ignore-skip-worktree-bits &&
=20
 	git ls-files -t >output &&
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
index f67611da28..e33a6ed1b4 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -334,7 +334,7 @@ test_expect_success 'cone mode: set with nested folde=
rs' '
=20
 test_expect_success 'cone mode: add independent path' '
 	git -C repo sparse-checkout set deep/deeper1 &&
-	git -C repo sparse-checkout add folder1 &&
+	git -C repo sparse-checkout add --end-of-options folder1 &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
--=20
2.43.0-174-g055bb6e996

