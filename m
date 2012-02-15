From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/3 v5] diff --stat: use the full terminal width
Date: Wed, 15 Feb 2012 12:03:27 +0100
Message-ID: <1329303808-16989-2-git-send-email-zbyszek@in.waw.pl>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
 <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 15 12:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxcek-0006bD-T2
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 12:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759067Ab2BOLEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 06:04:10 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52618 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758974Ab2BOLEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 06:04:07 -0500
Received: from [193.0.104.42] (helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RxceY-0000Yn-4Z; Wed, 15 Feb 2012 12:04:04 +0100
X-Mailer: git-send-email 1.7.9.5.g91d5
In-Reply-To: <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190825>

Use as many columns as necessary for the filenames and up to 40
columns for the graph.

Some projects (especially in Java), have long filename paths, with
nested directories or long individual filenames. When files are
renamed, the filename part in stat output can be almost useless. If
the middle part between { and } is long (because the file was moved to
a completely different directory), then most of the path would be
truncated.

It makes sense to detect and use the full terminal width and display
full filenames if possible.

If commits changing a lot of lines are displayed in a wide terminal
window (200 or more columns), and the +- graph would use the full
width, the output would look bad. Messages wrapped to about 80 columns
would be interspersed with very long +- lines. It makes sense to limit
the width of the graph part to a fixed value, even if more columns are
available. This fixed value is subjectively hard-coded to be 40
columns, which seems to work well for git.git and linux-2.6.git and
some other repositories.

If there isn't enough columns to print both the filename and the
graph, at least 5/8 of available space is devoted to filenames. On a
standard 80 column terminal, or if not connected to a terminal and
using the default of 80 columns, this gives the same partition as
before.

The --stat output in tests is not affected.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
This is the main patch. Presented with the two options (either
hardcode number_width=3D4 or remove fprintf(options->file, "
%*"PRIuMAX"%s", number_width, ...)), I've taken the middle way:
number_width=3D4 is hardcoded, but the fprintf is reverted to the previ=
ous
version. I think that this way the code is most readable, independently
if later changes.

Junio suggested to:
 - contain a change to the test suite somewhere, probably t/test-lib.sh=
,
   to set COLUMNS=3D80 and export it, to make sure that the existing te=
st
   won't be broken when the number of columns learned from ioctl(1) is
   different from 80; and

 - add a new test that explicitly sets wider COLUMNS and makes sure you
   get a wider diffstat graph.

I haven't done this, because $COLUMNS and the actual terminal width is =
always
ignored in tests. There's even a test to verify that COLUMNS=3D200 does=
n't
mess up git format-patch output.

A test to check that diff --stat responds to terminal size would be
nice, but I don't know how to force git-diff to use the real terminal
size in tests.

v5:
- tests are moved to an earlier patch
- using decimal_width(change count) is moved to a later patch
- "histogram" is really not used

v4:
- comments are updated and the word "histogram" is banished
- "mopping up" is removed (but the minimum width are guaranteed)

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


 Documentation/diff-options.txt | 14 ++++---
 diff.c                         | 88 +++++++++++++++++++++++++++-------=
-----
 2 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 9f7cba2..36e4ee3 100644
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
diff --git a/diff.c b/diff.c
index 7e15426..be6d40b 100644
--- a/diff.c
+++ b/diff.c
@@ -1327,7 +1327,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	int i, len, add, del, adds =3D 0, dels =3D 0;
 	uintmax_t max_change =3D 0, max_len =3D 0;
 	int total_files =3D data->nr;
-	int width, name_width, count;
+	int width, name_width, graph_width, number_width =3D 4, count;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix =3D "";
 	int extra_shown =3D 0;
@@ -1341,25 +1341,15 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 		line_prefix =3D msg->buf;
 	}
=20
-	width =3D options->stat_width ? options->stat_width : 80;
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
@@ -1380,19 +1370,63 @@ static void show_stats(struct diffstat_t *data,=
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
+	 * We want a maximum of min(max_change, 40) for the +- part.
+	 * We also need 1 for " " and 4 + decimal_width(max_change)
+	 * for " | NNNN " and one the empty column at the end, altogether
+	 * 6 + decimal_width(max_change).
+	 *
+	 * If there's not enough space, we will use the smaller of
+	 * stat_name_width (if set) and 5/8*width for the filename,
+	 * and the rest for constant elements + graph part, but no more
+	 * than 40 for the graph part.
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
-	else
-		width =3D max_change;
=20
+	width =3D options->stat_width ? options->stat_width : term_columns();
+
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
+	graph_width =3D max_change < 40 ? max_change : 40;
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
+		if (graph_width > 40)
+			graph_width =3D  40;
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
@@ -1448,9 +1482,9 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
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
--=20
1.7.9.5.g91d5
