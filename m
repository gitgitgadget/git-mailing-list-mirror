From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 7.1/8] diff --stat: use a maximum of 5/8 for the filename part
Date: Wed, 22 Feb 2012 12:51:44 +0100
Message-ID: <1329911507-10587-1-git-send-email-zbyszek@in.waw.pl>
References: <4F44D084.7030308@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 22 12:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0AkC-0006OY-Rm
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 12:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab2BVLwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 06:52:13 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55007 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355Ab2BVLwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 06:52:08 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S0Ajt-0007d7-JT; Wed, 22 Feb 2012 12:52:05 +0100
X-Mailer: git-send-email 1.7.9.1.355.ge8a9f
In-Reply-To: <4F44D084.7030308@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191252>

The way that available columns are divided between the filename part
and the graph part is modified to use as many columns as necessary for
the filenames and the rest for the graph.

If there isn't enough columns to print both the filename and the
graph, at least 5/8 of available space is devoted to filenames. On a
standard 80 column terminal, or if not connected to a terminal and
using the default of 80 columns, this gives the same partition as
before.

The effect of this change is visible in the patch to t4052 that fixes a
few tests marked with test_expect_failure.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 Documentation/diff-options.txt | 14 ++++---
 diff.c                         | 90 ++++++++++++++++++++++++++--------=
------
 t/t4052-stat-output.sh         | 14 +++----
 3 files changed, 75 insertions(+), 43 deletions(-)

diff --git Documentation/diff-options.txt Documentation/diff-options.tx=
t
index 9ed78c9..29647e5 100644
--- Documentation/diff-options.txt
+++ Documentation/diff-options.txt
@@ -53,13 +53,15 @@ endif::git-format-patch[]
 	Generate a diff using the "patience diff" algorithm.
=20
 --stat[=3D<width>[,<name-width>[,<count>]]]::
-	Generate a diffstat.  You can override the default
-	output width for 80-column terminal by `--stat=3D<width>`.
-	The width of the filename part can be controlled by
-	giving another width to it separated by a comma.
+	Generate a diffstat. By default, as much space as necessary
+	will be used for the filename part, and the rest for
+	the graph part. Maximum width defaults to terminal width,
+	or 80 columns if not connected to a terminal, and can be
+	overriden by `<width>`. The width of the filename part can be
+	limited by giving another width `<name-width>` after a comma.
 	By giving a third parameter `<count>`, you can limit the
-	output to the first `<count>` lines, followed by
-	`...` if there are more.
+	output to the first `<count>` lines, followed by `...` if
+	there are more.
 +
 These parameters can also be set individually with `--stat-width=3D<wi=
dth>`,
 `--stat-name-width=3D<name-width>` and `--stat-count=3D<count>`.
diff --git diff.c diff.c
index 1db46a4..f1c278f 100644
--- diff.c
+++ diff.c
@@ -1375,7 +1375,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	int i, len, add, del, adds =3D 0, dels =3D 0;
 	uintmax_t max_change =3D 0, max_len =3D 0;
 	int total_files =3D data->nr;
-	int width, name_width, count;
+	int width, name_width, graph_width, number_width =3D 4, count;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix =3D "";
 	int extra_shown =3D 0;
@@ -1389,28 +1389,15 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 		line_prefix =3D msg->buf;
 	}
=20
-	if (options->stat_width =3D=3D -1)
-		width =3D term_columns();
-	else
-		width =3D options->stat_width ? options->stat_width : 80;
-	name_width =3D options->stat_name_width ? options->stat_name_width : =
50;
 	count =3D options->stat_count ? options->stat_count : data->nr;
=20
-	/* Sanity: give at least 5 columns to the graph,
-	 * but leave at least 10 columns for the name.
-	 */
-	if (width < 25)
-		width =3D 25;
-	if (name_width < 10)
-		name_width =3D 10;
-	else if (width < name_width + 15)
-		name_width =3D width - 15;
-
-	/* Find the longest filename and max number of changes */
 	reset =3D diff_get_color_opt(options, DIFF_RESET);
 	add_c =3D diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c =3D diff_get_color_opt(options, DIFF_FILE_OLD);
=20
+	/*
+	 * Find the longest filename and max number of changes
+	 */
 	for (i =3D 0; (i < count) && (i < data->nr); i++) {
 		struct diffstat_file *file =3D data->files[i];
 		uintmax_t change =3D file->added + file->deleted;
@@ -1431,19 +1418,62 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 	}
 	count =3D i; /* min(count, data->nr) */
=20
-	/* Compute the width of the graph part;
-	 * 10 is for one blank at the beginning of the line plus
-	 * " | count " between the name and the graph.
+	/*
+	 * We have width =3D stat_width or term_columns() columns total.
+	 * We want a maximum of min(max_len, stat_name_width) for the name pa=
rt.
+	 * We also need 1 for " " and 4 + decimal_width(max_change)
+	 * for " | NNNN " and one the empty column at the end, altogether
+	 * 6 + decimal_width(max_change).
+	 *
+	 * If there's not enough space, we will use the smaller of
+	 * stat_name_width (if set) and 5/8*width for the filename,
+	 * and the rest for constant elements + graph part.
+	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
+	 * for the standard terminal size).
 	 *
-	 * From here on, name_width is the width of the name area,
-	 * and width is the width of the graph area.
+	 * In other words: stat_width limits the maximum width, and
+	 * stat_name_width fixes the maximum width of the filename,
+	 * and is also used to divide available columns if there
+	 * aren't enough.
 	 */
-	name_width =3D (name_width < max_len) ? name_width : max_len;
-	if (width < (name_width + 10) + max_change)
-		width =3D width - (name_width + 10);
+
+	if (options->stat_width =3D=3D -1)
+		width =3D term_columns();
 	else
-		width =3D max_change;
+		width =3D options->stat_width ? options->stat_width : 80;
=20
+	/*
+	 * Guarantee 3/8*16=3D=3D6 for the graph part
+	 * and 5/8*16=3D=3D10 for the filename part
+	 */
+	if (width < 16 + 6 + number_width)
+		width =3D 16 + 6 + number_width;
+
+	/*
+	 * First assign sizes that are wanted, ignoring available width.
+	 */
+	graph_width =3D max_change;
+	name_width =3D (options->stat_name_width > 0 &&
+		      options->stat_name_width < max_len) ?
+		options->stat_name_width : max_len;
+
+	/*
+	 * Adjust adjustable widths not to exceed maximum width
+	 */
+	if (name_width + number_width + 6 + graph_width > width) {
+		if (graph_width > width * 3/8 - number_width - 6)
+			graph_width =3D width * 3/8 - number_width - 6;
+		if (name_width > width - number_width - 6 - graph_width)
+			name_width =3D width - number_width - 6 - graph_width;
+		else
+			graph_width =3D width - number_width - 6 - name_width;
+	}
+
+	/*
+	 * From here name_width is the width of the name area,
+	 * and graph_width is the width of the graph area.
+	 * max_change is used to scale graph properly.
+	 */
 	for (i =3D 0; i < count; i++) {
 		const char *prefix =3D "";
 		char *name =3D data->files[i]->print_name;
@@ -1499,18 +1529,18 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 		adds +=3D add;
 		dels +=3D del;
=20
-		if (width <=3D max_change) {
+		if (graph_width <=3D max_change) {
 			int total =3D add + del;
=20
-			total =3D scale_linear(add + del, width, max_change);
+			total =3D scale_linear(add + del, graph_width, max_change);
 			if (total < 2 && add && del)
 				/* width >=3D 2 due to the sanity check */
 				total =3D 2;
 			if (add < del) {
-				add =3D scale_linear(add, width, max_change);
+				add =3D scale_linear(add, graph_width, max_change);
 				del =3D total - add;
 			} else {
-				del =3D scale_linear(del, width, max_change);
+				del =3D scale_linear(del, graph_width, max_change);
 				add =3D total - del;
 			}
 		}
diff --git t/t4052-stat-output.sh t/t4052-stat-output.sh
index 2b4510c..c250744 100755
--- t/t4052-stat-output.sh
+++ t/t4052-stat-output.sh
@@ -28,19 +28,19 @@ EOF
=20
 while read cmd args
 do
-	test_expect_failure "$cmd graph width defaults to 80 columns" '
+	test_expect_success "$cmd graph width defaults to 80 columns" '
 		git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp expect80 actual
 	'
=20
-	test_expect_failure "$cmd --stat=3Dwidth with long name" '
+	test_expect_success "$cmd --stat=3Dwidth with long name" '
 		git $cmd $args --stat=3D40 >output &&
 		grep " | " output >actual &&
 		test_cmp expect40 actual
 	'
=20
-	test_expect_failure "$cmd --stat-width=3Dwidth with long name" '
+	test_expect_success "$cmd --stat-width=3Dwidth with long name" '
 		git $cmd $args --stat-width=3D40 >output &&
 		grep " | " output >actual &&
 		test_cmp expect40 actual
@@ -87,7 +87,7 @@ EOF
=20
 while read verb expect cmd args
 do
-	test_expect_success "$cmd $verb COLUMNS (big change)" '
+	test_expect_success "$cmd $verb too many COLUMNS (big change)" '
 		COLUMNS=3D200 git $cmd $args >output
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
@@ -130,7 +130,7 @@ test_expect_success 'preparation for long filename =
tests' '
 '
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
 EOF
=20
 while read cmd args
@@ -151,7 +151,7 @@ cat >expect80 <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
 EOF
 cat >expect200 <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
@@ -178,7 +178,7 @@ test_expect_success 'merge --stat respects COLUMNS =
(big change)' '
 '
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++++++++++++++++++++++
+ aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
+++++++++++++++++++++++++++++
 EOF
 test_expect_success 'merge --stat respects COLUMNS (long filename)' '
 	COLUMNS=3D100 git merge --stat --no-ff master >output &&
--=20
1.7.9.1.355.ge8a9f
