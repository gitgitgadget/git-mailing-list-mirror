Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nYBISZcC"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320EA171F
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:35:26 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68AB31C947A;
	Fri,  8 Dec 2023 17:35:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qtjMDBBeXYQf
	TcVH+vvqvy2hOR7Cj0CtM4cCLoF1VPg=; b=nYBISZcCGYmcjdV8pbgbkp2CmQl1
	e37OvmtWFU8r5/MM6XrkqXBUPx37eq8b8gP9S4aVueYWKVy1ShNu+by3GSLLFI8J
	BwJtSvBgujzRogjM5v7TfjzGZzgCUizzpyA+W8KiMFht1tHGmqDB51Xl4XE9WWqL
	WT0SWYJLySsFVu4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 602FF1C9478;
	Fri,  8 Dec 2023 17:35:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4F4F1C9477;
	Fri,  8 Dec 2023 17:35:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Britton Kerin <britton.kerin@gmail.com>
Subject: [PATCH] revision: parse integer arguments to --max-count, --skip,
 etc., more carefully
In-Reply-To: <xmqqy1e41lf5.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	09 Dec 2023 05:36:30 +0900")
References: <CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com>
	<xmqqy1e41lf5.fsf@gitster.g>
Date: Sat, 09 Dec 2023 07:35:23 +0900
Message-ID: <xmqq5y181fx0.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1437D41C-961A-11EE-82BF-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The "rev-list" and other commands in the "log" family, being the
oldest part of the system, use their own custom argument parsers,
and integer values of some options are parsed with atoi(), which
allows a non-digit after the number (e.g., "1q") to be silently
ignored.  As a natural consequence, an argument that does not begin
with a digit (e.g., "q") silently becomes zero, too.

Switch to use strtol_i() and parse_timestamp() appropriately to
catch bogus input.

Note that one may na=C3=AFvely expect that --max-count, --skip, etc., to
only take non-negative values, but we must allow them to also take
negative values, as an escape hatch to countermand a limit set by an
earlier option on the command line; the underlying variables are
initialized to (-1) and "--max-count=3D-1", for example, is a
legitimate way to reinitialize the limit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c                 | 41 ++++++++++++++++++++++++++++----------
 t/t6005-rev-list-count.sh  | 15 +++++++++++++-
 t/t6009-rev-list-parent.sh | 11 ++++++++++
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/revision.c b/revision.c
index 0ae1c76db3..8cda6e43d4 100644
--- a/revision.c
+++ b/revision.c
@@ -2214,6 +2214,27 @@ static void add_message_grep(struct rev_info *revs=
, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
=20
+static int parse_count(const char *arg)
+{
+	int count;
+
+	if (strtol_i(arg, 10, &count) < 0)
+		die("'%s': not an integer", arg);
+	return count;
+}
+
+static timestamp_t parse_age(const char *arg)
+{
+	timestamp_t num;
+	char *p;
+
+	errno =3D 0;
+	num =3D parse_timestamp(arg, &p, 10);
+	if (errno || *p || p =3D=3D arg)
+		die("'%s': not a number of seconds since epoch", arg);
+	return num;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const ch=
ar **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2240,29 +2261,27 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	}
=20
 	if ((argcount =3D parse_long_opt("max-count", argv, &optarg))) {
-		revs->max_count =3D atoi(optarg);
+		revs->max_count =3D parse_count(optarg);
 		revs->no_walk =3D 0;
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("skip", argv, &optarg))) {
-		revs->skip_count =3D atoi(optarg);
+		revs->skip_count =3D parse_count(optarg);
 		return argcount;
 	} else if ((*arg =3D=3D '-') && isdigit(arg[1])) {
 		/* accept -<digit>, like traditional "head" */
-		if (strtol_i(arg + 1, 10, &revs->max_count) < 0 ||
-		    revs->max_count < 0)
-			die("'%s': not a non-negative integer", arg + 1);
+		revs->max_count =3D parse_count(arg + 1);
 		revs->no_walk =3D 0;
 	} else if (!strcmp(arg, "-n")) {
 		if (argc <=3D 1)
 			return error("-n requires an argument");
-		revs->max_count =3D atoi(argv[1]);
+		revs->max_count =3D parse_count(argv[1]);
 		revs->no_walk =3D 0;
 		return 2;
 	} else if (skip_prefix(arg, "-n", &optarg)) {
-		revs->max_count =3D atoi(optarg);
+		revs->max_count =3D parse_count(optarg);
 		revs->no_walk =3D 0;
 	} else if ((argcount =3D parse_long_opt("max-age", argv, &optarg))) {
-		revs->max_age =3D atoi(optarg);
+		revs->max_age =3D parse_age(optarg);
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("since", argv, &optarg))) {
 		revs->max_age =3D approxidate(optarg);
@@ -2274,7 +2293,7 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
 		revs->max_age =3D approxidate(optarg);
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("min-age", argv, &optarg))) {
-		revs->min_age =3D atoi(optarg);
+		revs->min_age =3D parse_age(optarg);
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("before", argv, &optarg))) {
 		revs->min_age =3D approxidate(optarg);
@@ -2362,11 +2381,11 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->max_parents =3D 1;
 	} else if (skip_prefix(arg, "--min-parents=3D", &optarg)) {
-		revs->min_parents =3D atoi(optarg);
+		revs->min_parents =3D parse_count(optarg);
 	} else if (!strcmp(arg, "--no-min-parents")) {
 		revs->min_parents =3D 0;
 	} else if (skip_prefix(arg, "--max-parents=3D", &optarg)) {
-		revs->max_parents =3D atoi(optarg);
+		revs->max_parents =3D parse_count(optarg);
 	} else if (!strcmp(arg, "--no-max-parents")) {
 		revs->max_parents =3D -1;
 	} else if (!strcmp(arg, "--boundary")) {
diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 0729f800c3..62538f5a02 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -18,13 +18,23 @@ test_expect_success 'no options' '
 '
=20
 test_expect_success '--max-count' '
+	test_must_fail git rev-list --max-count=3D1q HEAD 2>error &&
+	grep "not an integer" error &&
+
 	test_stdout_line_count =3D 0 git rev-list HEAD --max-count=3D0 &&
 	test_stdout_line_count =3D 3 git rev-list HEAD --max-count=3D3 &&
 	test_stdout_line_count =3D 5 git rev-list HEAD --max-count=3D5 &&
-	test_stdout_line_count =3D 5 git rev-list HEAD --max-count=3D10
+	test_stdout_line_count =3D 5 git rev-list HEAD --max-count=3D10 &&
+	test_stdout_line_count =3D 5 git rev-list HEAD --max-count=3D-1
 '
=20
 test_expect_success '--max-count all forms' '
+	test_must_fail git rev-list -1q HEAD 2>error &&
+	grep "not an integer" error &&
+	test_must_fail git rev-list --1 HEAD &&
+	test_must_fail git rev-list -n 1q HEAD 2>error &&
+	grep "not an integer" error &&
+
 	test_stdout_line_count =3D 1 git rev-list HEAD --max-count=3D1 &&
 	test_stdout_line_count =3D 1 git rev-list HEAD -1 &&
 	test_stdout_line_count =3D 1 git rev-list HEAD -n1 &&
@@ -32,6 +42,9 @@ test_expect_success '--max-count all forms' '
 '
=20
 test_expect_success '--skip' '
+	test_must_fail git rev-list --skip 1q HEAD 2>error &&
+	grep "not an integer" error &&
+
 	test_stdout_line_count =3D 5 git rev-list HEAD --skip=3D0 &&
 	test_stdout_line_count =3D 2 git rev-list HEAD --skip=3D3 &&
 	test_stdout_line_count =3D 0 git rev-list HEAD --skip=3D5 &&
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 5a67bbc760..9c9a8459af 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -62,6 +62,17 @@ test_expect_success 'setup roots, merges and octopuses=
' '
 	git checkout main
 '
=20
+test_expect_success 'parse --max-parents & --min-parents' '
+	test_must_fail git rev-list --max-parents=3D1q HEAD 2>error &&
+	grep "not an integer" error &&
+
+	test_must_fail git rev-list --min-parents=3D1q HEAD 2>error &&
+	grep "not an integer" error &&
+
+	git rev-list --max-parents=3D1 --min-parents=3D1 HEAD &&
+	git rev-list --max-parents=3D-1 --min-parents=3D-1 HEAD
+'
+
 test_expect_success 'rev-list roots' '
=20
 	check_revlist "--max-parents=3D0" one five
--=20
2.43.0

