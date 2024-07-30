Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7DDDCD
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302277; cv=none; b=GZIZbXG1aZpyfy1mlg1C7rSqAmNCZhpQ+ryo6adYB2NoNIRtRGbmY9FWWE7O2KPfirYtiXlUcXoXC45/g6uSqJR1l11+eXaMqRQorfxJ9UWxmeruE19rhIBvK0kInKpeQ//3bhiYsRn8MUWhjo+AbQH6wNgSF6C3LB2fvufJOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302277; c=relaxed/simple;
	bh=XVGOSQ+UIm/0pOdHM4vpIKXj2vxbUX1IrFWisDUQ6Lo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVv43YEdAbg0HdkbwfK1Pz9HjVgKK0BROLAixooDkFkOiWFPvG19+kqcMtuQ4IvP40aDMxcYxZ7QmDZCOIhoAbVsN3HdLtkT0x2WKKvBvVABdcFyIR2wlyO002MeZ8Y4mamDQ4CHDp6n1/kfPn3muYHG4ZuwqK+9ycAfMKovy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CsAwzmXf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CsAwzmXf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E472A30A50;
	Mon, 29 Jul 2024 21:17:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=XVGOSQ+UIm/0pOdHM4vpIKXj2
	vxbUX1IrFWisDUQ6Lo=; b=CsAwzmXfD7t2wiUuu+45qw9I/5PLfHdVgPy2v3kWv
	yAptzE1uFO2/L2uQFx9I0+3MEYcv2XTaHI/2OQegF7Oj942OfgUiG4z+hS/E/z7e
	DpDNoRgC5K9DyWoiUwvgrYYifcpid7GR/620Hga9ydsZbi5ietR8ZhsNBdyJpcIK
	FI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DCF4D30A4F;
	Mon, 29 Jul 2024 21:17:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 67CFE30A4E;
	Mon, 29 Jul 2024 21:17:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 5/5] patch-id: tighten code to detect the patch header
Date: Mon, 29 Jul 2024 18:17:38 -0700
Message-ID: <20240730011738.4032377-6-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-71-g1aa693ace8
In-Reply-To: <20240730011738.4032377-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240730011738.4032377-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 8AF3778C-4E11-11EF-B989-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The get_one_patchid() function unconditionally takes a line that
matches the patch header (namely, a line that begins with a full
object name, possibly prefixed by "commit" or "From" plus a space)
as the beginning of a patch.  Even when it is *not* looking for one
(namely, when the previous call found the patch header and returned,
and then we are called again to skip the log message and process the
patch whose header was found by the previous invocation).

As a consequence, a line in the commit log message that begins with
one of these patterns can be mistaken to start another patch, with
current message entirely skipped (because we haven't even reached
the patch at all).

Allow the caller to tell us if it called us already and saw the
patch header (in which case we shouldn't be looking for another one,
until we see the "diff" part of the patch; instead we simply should
be skipping these lines as part of the commit log message), and skip
the header processing logic when that is the case.  In the helper
function, it also needs to flip this "are we looking for a header?"
bit, once it finished skipping the commit log message and started
processing the patches, as the patch header of the _next_ message is
the only clue in the input that the current patch is done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/patch-id.c  | 49 +++++++++++++++++++++++++++++++++------------
 t/t4204-patch-id.sh | 17 ++++++++++++++++
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index a2fdc0505d..f2e8feb6d3 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -60,10 +60,17 @@ static int scan_hunk_header(const char *p, int *p_bef=
ore, int *p_after)
=20
 /*
  * flag bits to control get_one_patchid()'s behaviour.
+ *
+ * STABLE/VERBATIM are given from the command line option as
+ * --stable/--verbatim.  FIND_HEADER conveys the internal state
+ * maintained by the caller to allow the function to avoid mistaking
+ * lines of log message before seeing the "diff" part as the beginning
+ * of the next patch.
  */
 enum {
 	GOPID_STABLE =3D (1<<0),		/* --stable */
 	GOPID_VERBATIM =3D (1<<1),	/* --verbatim */
+	GOPID_FIND_HEADER =3D (1<<2),	/* stop at the beginning of patch message=
 */
 };
=20
 static int get_one_patchid(struct object_id *next_oid, struct object_id =
*result,
@@ -71,6 +78,7 @@ static int get_one_patchid(struct object_id *next_oid, =
struct object_id *result,
 {
 	int stable =3D flags & GOPID_STABLE;
 	int verbatim =3D flags & GOPID_VERBATIM;
+	int find_header =3D flags & GOPID_FIND_HEADER;
 	int patchlen =3D 0, found_next =3D 0;
 	int before =3D -1, after =3D -1;
 	int diff_is_binary =3D 0;
@@ -86,26 +94,39 @@ static int get_one_patchid(struct object_id *next_oid=
, struct object_id *result,
 		int len;
=20
 		/*
-		 * If we see a line that begins with "<object name>",
-		 * "commit <object name>" or "From <object name>", it is
-		 * the beginning of a patch.  Return to the caller, as
-		 * we are done with the one we have been processing.
+		 * The caller hasn't seen us find a patch header and
+		 * return to it, or we have started processing patch
+		 * and may encounter the beginning of the next patch.
 		 */
-		if (skip_prefix(line, "commit ", &p))
-			;
-		else if (skip_prefix(line, "From ", &p))
-			;
-		if (!get_oid_hex(p, next_oid)) {
-			if (verbatim)
-				the_hash_algo->update_fn(&ctx, line, strlen(line));
-			found_next =3D 1;
-			break;
+		if (find_header) {
+			/*
+			 * If we see a line that begins with "<object name>",
+			 * "commit <object name>" or "From <object name>", it is
+			 * the beginning of a patch.  Return to the caller, as
+			 * we are done with the one we have been processing.
+			 */
+			if (skip_prefix(line, "commit ", &p))
+				;
+			else if (skip_prefix(line, "From ", &p))
+				;
+			if (!get_oid_hex(p, next_oid)) {
+				if (verbatim)
+					the_hash_algo->update_fn(&ctx, line, strlen(line));
+				found_next =3D 1;
+				break;
+			}
 		}
=20
 		/* Ignore commit comments */
 		if (!patchlen && !starts_with(line, "diff "))
 			continue;
=20
+		/*
+		 * We are past the commit log message.  Prepare to
+		 * stop at the beginning of the next patch header.
+		 */
+		find_header =3D 1;
+
 		/* Parsing diff header?  */
 		if (before =3D=3D -1) {
 			if (starts_with(line, "GIT binary patch") ||
@@ -201,11 +222,13 @@ static void generate_id_list(unsigned flags)
 	struct strbuf line_buf =3D STRBUF_INIT;
=20
 	oidclr(&oid);
+	flags |=3D GOPID_FIND_HEADER;
 	while (!feof(stdin)) {
 		patchlen =3D get_one_patchid(&n, &result, &line_buf, flags);
 		if (patchlen)
 			flush_current_id(&oid, &result);
 		oidcpy(&oid, &n);
+		flags &=3D ~GOPID_FIND_HEADER;
 	}
 	strbuf_release(&line_buf);
 }
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 1627fdda1b..b1d98d4110 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -137,6 +137,23 @@ test_expect_success 'patch-id computes the same for =
various formats' '
 	test_cmp actual expect
 '
=20
+hash=3D$(git rev-parse same:)
+for cruft in "$hash" "commit $hash is bad" "From $hash status"
+do
+	test_expect_success "patch-id with <$cruft> in log message" '
+		git format-patch -1 --stdout same >patch-0 &&
+		git patch-id <patch-0 >expect &&
+
+		{
+			sed -e "/^$/q" patch-0 &&
+			printf "random message\n%s\n\n" "$cruft" &&
+			sed -e "1,/^$/d" patch-0
+		} >patch-cruft &&
+		git patch-id <patch-cruft >actual &&
+		test_cmp actual expect
+	'
+done
+
 test_expect_success 'whitespace is irrelevant in footer' '
 	get_patch_id main &&
 	git checkout same &&
--=20
2.46.0-69-gd0749fd195

