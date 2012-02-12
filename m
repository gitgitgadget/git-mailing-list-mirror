From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v3] diff --stat: use the full terminal width
Date: Sun, 12 Feb 2012 15:30:19 +0100
Message-ID: <1329057019-29983-1-git-send-email-zbyszek@in.waw.pl>
References: <7vmx8qr1gb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sun Feb 12 15:30:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwaS4-00072B-L1
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 15:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab2BLOar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 09:30:47 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52395 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649Ab2BLOaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 09:30:46 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RwaRx-00020G-GD; Sun, 12 Feb 2012 15:30:45 +0100
X-Mailer: git-send-email 1.7.9.3.g2429d.dirty
In-Reply-To: <7vmx8qr1gb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190572>

Use as many columns as necessary for filenames, as few columns as
necessary for change counts, and up to 40 columns for the histogram.

Some projects (especially in Java), have long filename paths, with
nested directories or long individual filenames. When files are
renamed, the stat output can be almost useless. If the middle part
between { and } is long (because the file was moved to a completely
different directory), then most of the path would be truncated.

It makes sense to detect and use the full terminal width and display
full filenames if possible.

If commits changing a lot of lines are displayed in a wide terminal
window (200 or more columns), and the +- graph would use the full
width, the output would look bad. Messages wrapped to about 80
columns would be interspersed with very long +- lines. It makes
sense to limit the width of the histogram to a fixed value, even if mor=
e
columns are available. This fixed value is subjectively hard-coded to
be 40 columns, which seems to work well for git.git and linux-2.6.git a=
nd
some other repositories.

If there isn't enough columns to print both the filename and the histog=
ram,
at least 5/8 of available space is devoted to filenames. On a standard =
80 column
terminal, or if not connected to a terminal and using the default of 80=
 columns,
this gives the same partition as before.

Number of columns required for change counts is computed based on
the maximum number of changed lines. This means that usually a few more
columns will be available for the filenames and the histogram.

Tests are added for various combinations of long filename and big chang=
e
count and ways to specify widths.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
Hi,
this is v3 (reduced to one patch) on top of:
- Save terminal width before setting up pager and export term_columns()=
,
- Rename lineno_width to decimal_width and export it.

The logic is described in a comment in show_stats() in diff.c. In case
of a column 80 terminal window, the output will not be identical,
because of using decimal_width, but it'll be very close to what was
there previously.

v3:
- use decimal_width(max_change) to calculate number of columns
  required for change counts
- rework the logic to divide columns
- document the logic in comments, update docs
- add more tests

v2:
- style fixes
- some tests for git-format-patch added
- patches 3 and 4 squashed together, since they touch the same lines
- graph width is limited to 40 columns, even if there's more space
- patch descriptions extended and cleared up

 Documentation/diff-options.txt | 14 +++---
 diff.c                         | 93 +++++++++++++++++++++++++---------=
---
 t/t4014-format-patch.sh        | 98 ++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 168 insertions(+), 37 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 9f7cba2..35dfdfb 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -53,13 +53,15 @@ endif::git-format-patch[]
 	Generate a diff using the "patience diff" algorithm.
=20
 --stat[=3D<width>[,<name-width>[,<count>]]]::
-	Generate a diffstat.  You can override the default
-	output width for 80-column terminal by `--stat=3D<width>`.
-	The width of the filename part can be controlled by
-	giving another width to it separated by a comma.
+	Generate a diffstat. By default, as much space as necessary
+	will be used for the filename part, and up to 40 columns for
+	the graph histogram. Maximum width defaults to terminal width,
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
diff --git a/diff.c b/diff.c
index 7e15426..7abcbe9 100644
--- a/diff.c
+++ b/diff.c
@@ -1327,7 +1327,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	int i, len, add, del, adds =3D 0, dels =3D 0;
 	uintmax_t max_change =3D 0, max_len =3D 0;
 	int total_files =3D data->nr;
-	int width, name_width, count;
+	int width, name_width, graph_width, number_width, count;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix =3D "";
 	int extra_shown =3D 0;
@@ -1341,25 +1341,13 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 		line_prefix =3D msg->buf;
 	}
=20
-	width =3D options->stat_width ? options->stat_width : 80;
-	name_width =3D options->stat_name_width ? options->stat_name_width : =
50;
-	count =3D options->stat_count ? options->stat_count : data->nr;
-
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
 	/* Find the longest filename and max number of changes */
 	reset =3D diff_get_color_opt(options, DIFF_RESET);
 	add_c =3D diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c =3D diff_get_color_opt(options, DIFF_FILE_OLD);
=20
+	count =3D options->stat_count ? options->stat_count : data->nr;
+
 	for (i =3D 0; (i < count) && (i < data->nr); i++) {
 		struct diffstat_file *file =3D data->files[i];
 		uintmax_t change =3D file->added + file->deleted;
@@ -1380,19 +1368,63 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 	}
 	count =3D i; /* min(count, data->nr) */
=20
-	/* Compute the width of the graph part;
-	 * 10 is for one blank at the beginning of the line plus
-	 * " | count " between the name and the graph.
+	/* We have width =3D stat_width or term_columns() columns total.
+	 * We want a maximum of min(max_len, stat_name_width) for the name pa=
rt.
+	 * We want a maximum of min(max_change, 40) for the +- part.
+	 * We also need 1 for " " and 4 + decimal_width(max_change)
+	 * for " | NNNN " and one for " " at the end, altogether
+	 * 6 + decimal_width(max_change).
+	 *
+	 * If there's not enough space, we will use stat_name_width
+	 * or 5/8*width for filename, and the rest for constant
+	 * elements + histogram, but no more than 40 for the histogram.
+	 * (5/8 gives 50 for filename and 30 for constant parts and
+	 * histogram for the standard terminal size).
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
-	else
-		width =3D max_change;
+	width =3D options->stat_width ? options->stat_width : term_columns();
+	number_width =3D decimal_width(max_change);
+	/* first sizes that are wanted */
+	graph_width =3D max_change < 40 ? max_change : 40;
+	name_width =3D (options->stat_name_width > 0 &&
+		      options->stat_name_width < max_len) ?
+		options->stat_name_width : max_len;
+
+	/* sanity: guarantee a minimum and maximum width */
+	if (width < 25)
+		width =3D 25;
+
+	if (name_width + number_width + 6 + graph_width > width) {
+		if (graph_width > width * 3/8 - number_width - 6)
+			graph_width =3D width * 3/8 - number_width - 6;
+		if (graph_width > 40)
+			graph_width =3D  40;
+		if (name_width > width - number_width - 6 - graph_width)
+			name_width =3D width - number_width - 6 - graph_width;
+		else
+			graph_width =3D width - number_width - 6 - name_width;
+	}
=20
+	/* More sanity: give at least 5 columns to the graph,
+	 * but leave at least 10 columns for the name.
+	 *
+	 * This should already be satisfied, unless max_change is
+	 * really huge. If the window is extemely narrow, this might
+	 * overflow available columns.
+	 */
+	if (name_width < 10 && max_len >=3D 10)
+		name_width =3D 10;
+	if (graph_width < 5 && max_change >=3D 5)
+		graph_width =3D 5;
+
+	/* From here name_width is the width of the name area,
+	 * and graph_width is the width of the graph area.
+	 * max_change is used to scale graph properly.
+	 */
 	for (i =3D 0; i < count; i++) {
 		const char *prefix =3D "";
 		char *name =3D data->files[i]->print_name;
@@ -1448,14 +1480,15 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 		adds +=3D add;
 		dels +=3D del;
=20
-		if (width <=3D max_change) {
-			add =3D scale_linear(add, width, max_change);
-			del =3D scale_linear(del, width, max_change);
+		if (graph_width <=3D max_change) {
+			add =3D scale_linear(add, graph_width, max_change);
+			del =3D scale_linear(del, graph_width, max_change);
 		}
 		fprintf(options->file, "%s", line_prefix);
 		show_name(options->file, prefix, name, len);
-		fprintf(options->file, "%5"PRIuMAX"%s", added + deleted,
-				added + deleted ? " " : "");
+		fprintf(options->file, " %*"PRIuMAX"%s",
+			number_width, added + deleted,
+			added + deleted ? " " : "");
 		show_graph(options->file, '+', add, add_c, reset);
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 6797512..91be989 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -519,7 +519,7 @@ test_expect_success 'shortlog of cover-letter wraps=
 overly-long onelines' '
=20
 cat > expect << EOF
 ---
- file |   16 ++++++++++++++++
+ file | 16 ++++++++++++++++
  1 files changed, 16 insertions(+), 0 deletions(-)
=20
 diff --git a/file b/file
@@ -894,4 +894,100 @@ test_expect_success 'format patch ignores color.u=
i' '
 	test_cmp expect actual
 '
=20
+name=3Daaaaaaaaaa
+name=3D$name$name$name$name$name$name$name$name$name$name$name$name
+test_expect_success 'preparation' "
+	> ${name} &&
+	git add ${name} &&
+	git commit -m message &&
+	echo a > ${name} &&
+	git commit -m message ${name}
+"
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaa | 1 +
+EOF
+test_expect_success 'format patch graph width is 80 columns' '
+	git format-patch --stat --stdout -1 |
+		grep -m 1 aaaaa > actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+test_expect_success 'format patch --stat=3Dwidth with long name' '
+	git format-patch --stat=3D40 --stdout -1 |
+		grep -m 1 aaaa > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat-width=3Dwidth works long name=
' '
+	git format-patch --stat-width=3D40 --stdout -1 |
+		grep -m 1 aaaa > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat=3D...,name-width with long na=
me' '
+	git format-patch --stat=3D60,32 --stdout -1 |
+		grep -m 1 aaaa > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat-name-width with long name' '
+	git format-patch --stat-name-width=3D32 --stdout -1 |
+		grep -m 1 aaaa > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'preparation' '
+	> abcd &&
+	git add abcd &&
+	git commit -m message &&
+	seq 1000 > abcd &&
+	git commit -m message abcd
+'
+
+cat >expect <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
+EOF
+test_expect_success 'format patch graph width is 40 columns' '
+	git format-patch --stat --stdout -1 |
+		grep -m 1 abcd > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch ignores COLUMNS' '
+	COLUMNS=3D200 git format-patch --stat --stdout -1 |
+		grep -m 1 abcd > actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++
+EOF
+test_expect_success 'format patch --stat=3Dwidth with big change' '
+	git format-patch --stat=3D40 --stdout -1 |
+		grep -m 1 abcd > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch --stat-width=3Dwidth with big change=
' '
+	git format-patch --stat-width=3D40 --stdout -1 |
+		grep -m 1 abcd > actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+EOF
+test_expect_success 'format patch --stat=3Dwidth with big change and l=
ong name' '
+	cp abcd aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	git add aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	git commit -m message &&
+	git format-patch --stat-width=3D60 --stdout -1 |
+		grep -m 1 aaaa > actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.9.3.g2429d.dirty
