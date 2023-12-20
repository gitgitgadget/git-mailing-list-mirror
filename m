Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA33495DA
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RLmBv9Cp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C66D030AAB;
	Wed, 20 Dec 2023 18:19:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	918vSl2EFt2mNtchyKweLJ5tnoWuqNNAQIPtSqmuBw=; b=RLmBv9CpBqQYCi6Ez
	N5VBnJC0ZFiXbc4qjwVybcAmvpY3SKQrFdNxUnZCoNAq85NA6W7F69ka4L/P3JSr
	US55Hr00R+3BI/5dxpjxqaEPQDeRnFFuK2xbE9LsWXEAbEyaW9CTuSx3EoAlRb2E
	MUaijsVeFw1LkdUQWcoSxm+Mmg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B68FD30AAA;
	Wed, 20 Dec 2023 18:19:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BDD630AA2;
	Wed, 20 Dec 2023 18:19:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
Date: Wed, 20 Dec 2023 15:19:23 -0800
Message-ID: <xmqqbkakqx6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 37137AE0-9F8E-11EE-A447-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

93851746 (parse-options: decouple "--end-of-options" and "--",
2023-12-06) updated the world order to make callers of parse-options
that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
do with "--end-of-options" they may see after parse_options() returns.

This unfortunately broke "sparse-checkout set/add", and from this
invocation,

  "git sparse-checkout [add|set] --[no-]cone --end-of-options pattern..."

we now see "--end-of-options" listed in .git/info/sparse-checkout as if
it is one of the path patterns.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/sparse-checkout.c          | 9 +++++++++
 t/t1090-sparse-checkout-scope.sh   | 8 ++++++++
 t/t1091-sparse-checkout-builtin.sh | 2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
index 80227f3df1..226a458b10 100644
--- c/builtin/sparse-checkout.c
+++ w/builtin/sparse-checkout.c
@@ -776,6 +776,10 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
+	if (argc && !strcmp(*argv, "--end-of-options")) {
+		argc--;
+		argv++;
+	}
 	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
 
 	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
@@ -823,6 +827,11 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
+	if (argc && !strcmp(*argv, "--end-of-options")) {
+		argc--;
+		argv++;
+	}
+
 	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
 		return 1;
 
diff --git c/t/t1090-sparse-checkout-scope.sh w/t/t1090-sparse-checkout-scope.sh
index 3a14218b24..5b96716235 100755
--- c/t/t1090-sparse-checkout-scope.sh
+++ w/t/t1090-sparse-checkout-scope.sh
@@ -57,6 +57,14 @@ test_expect_success 'return to full checkout of main' '
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
 
 	git ls-files -t >output &&
diff --git c/t/t1091-sparse-checkout-builtin.sh w/t/t1091-sparse-checkout-builtin.sh
index f67611da28..e33a6ed1b4 100755
--- c/t/t1091-sparse-checkout-builtin.sh
+++ w/t/t1091-sparse-checkout-builtin.sh
@@ -334,7 +334,7 @@ test_expect_success 'cone mode: set with nested folders' '
 
 test_expect_success 'cone mode: add independent path' '
 	git -C repo sparse-checkout set deep/deeper1 &&
-	git -C repo sparse-checkout add folder1 &&
+	git -C repo sparse-checkout add --end-of-options folder1 &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
