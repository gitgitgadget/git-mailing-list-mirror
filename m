Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478FD309
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="skzTgY99"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5561333337;
	Thu, 21 Dec 2023 01:59:39 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=3klkaagxrCIoL3QSFg6YLocU+
	k5aVUUUW6zr53reI7k=; b=skzTgY997Dl611JdTB/x3gtcCqhGvYqKNe1LunASx
	lQ+JpuhFJfUqiqftdm7JJt8MKskX6XUb+kS7v9IE3w3hysXxLqPjHieKE/MEnGqg
	53uMK03QvfqQbgpoxIWNEd9VEYV5cLCWXu2pde8QPdyhRIKea2mxCDAQC/cE2v2U
	X8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4238133336;
	Thu, 21 Dec 2023 01:59:39 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D776133335;
	Thu, 21 Dec 2023 01:59:35 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	William Sprent <williams@unity3d.com>
Subject: [PATCH 3/3] sparse-checkout: tighten add_patterns_from_input()
Date: Wed, 20 Dec 2023 22:59:25 -0800
Message-ID: <20231221065925.3234048-4-gitster@pobox.com>
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
 8042422E-9FCE-11EE-BF82-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The add_patterns_from_input() function was introduced at 6fb705ab
(sparse-checkout: extract add_patterns_from_input(), 2020-02-11) and
then modified by 00408ade (builtin/sparse-checkout: add check-rules
command, 2023-03-27).  Throughout its life, it either allowed to
read patterns from the file (before 00408ade, it only allowed the
standard input, after 00408ade, an arbitrary FILE *) or from argv[],
but never both.  However, when we read from a file, the function
never checked that there is nothing in argv[] (in other words, the
command line arguments have fully been consumed), resulting in
excess arguments silently getting ignored.

This caused commands like "git sparse-checkout set [--stdin]" and
"git sparse-checkout check-rules [--rules-file <file>]" to silently
ignore the rest of the command line arguments without reporting.

The fix finally makes the --end-of-options handling for this
subcommand also work, so add test for it, too.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/sparse-checkout.c          |  4 ++++
 t/t1091-sparse-checkout-builtin.sh | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 04ae81fce8..1166e1e298 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -555,6 +555,10 @@ static void add_patterns_from_input(struct pattern_l=
ist *pl,
 				    FILE *file)
 {
 	int i;
+
+	if (file && argc)
+		die(_("excess command line parameter '%s'"), argv[0]);
+
 	if (core_sparse_checkout_cone) {
 		struct strbuf line =3D STRBUF_INIT;
=20
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
index e33a6ed1b4..107ed170ac 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -937,6 +937,10 @@ test_expect_success 'check-rules cone mode' '
 	EOF
=20
 	git -C bare ls-tree -r --name-only HEAD >all-files &&
+
+	test_must_fail git -C bare sparse-checkout check-rules --cone \
+		--rules-file ../rules excess args <all-files &&
+
 	git -C bare sparse-checkout check-rules --cone \
 		--rules-file ../rules >check-rules-file <all-files &&
=20
@@ -947,6 +951,7 @@ test_expect_success 'check-rules cone mode' '
 	git -C repo sparse-checkout check-rules >check-rules-default <all-files=
 &&
=20
 	test_grep "deep/deeper1/deepest/a" check-rules-file &&
+	test_grep ! "end-of-options" check-rules-file &&
 	test_grep ! "deep/deeper2" check-rules-file &&
=20
 	test_cmp check-rules-file ls-files &&
@@ -959,8 +964,12 @@ test_expect_success 'check-rules non-cone mode' '
 	EOF
=20
 	git -C bare ls-tree -r --name-only HEAD >all-files &&
+
+	test_must_fail git -C bare sparse-checkout check-rules --no-cone \
+		--rules-file ../rules excess args <all-files &&
+
 	git -C bare sparse-checkout check-rules --no-cone --rules-file ../rules=
\
-		>check-rules-file <all-files &&
+		--end-of-options >check-rules-file <all-files &&
=20
 	cat rules | git -C repo sparse-checkout set --no-cone --stdin &&
 	git -C repo ls-files -t >out &&
--=20
2.43.0-174-g055bb6e996

