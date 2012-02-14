From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/3 v4] diff --stat: better alignment for binary files
Date: Wed, 15 Feb 2012 00:45:45 +0100
Message-ID: <1329263146-19215-2-git-send-email-zbyszek@in.waw.pl>
References: <7vsjie9q77.fsf@alter.siamese.dyndns.org>
 <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 15 00:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxS4f-0003rl-K1
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761364Ab2BNXqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 18:46:13 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52602 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757411Ab2BNXqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 18:46:10 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RxS4V-0002jK-8W; Wed, 15 Feb 2012 00:46:07 +0100
X-Mailer: git-send-email 1.7.9.6.ga1838.dirty
In-Reply-To: <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190801>

The output for binary and unmerged files was not updated in
'diff --stat': use the full terminal width'. This fixes this
omission and modifies the graph width logic to include enough
space for "Bin XXX -> YYY bytes".

If changes to binary files are mixed with changes to text files,
change counts are padded to take at least three columns. And the other
way around, if change counts require more than three columns, then
"Bin"s is padded to align with the change count. This way, the +- part
starts in the same column as "XXX -> YYY" part for binary files. This
makes the graph easier to parse visually thanks to the empty column.
This mimics the old layout of diff --stat.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 diff.c                 | 39 ++++++++++++++++++++++++++++++++-------
 t/t4012-diff-binary.sh | 17 +++++++++++++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 4dc2b5c..0732623 100644
--- a/diff.c
+++ b/diff.c
@@ -1326,8 +1326,8 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 {
 	int i, len, add, del, adds =3D 0, dels =3D 0;
 	uintmax_t max_change =3D 0, max_len =3D 0;
-	int total_files =3D data->nr;
-	int width, name_width, graph_width, number_width, count;
+	int total_files =3D data->nr, count;
+	int width, name_width, graph_width, number_width =3D 0, bin_width =3D=
 0;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix =3D "";
 	int extra_shown =3D 0;
@@ -1363,8 +1363,21 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
 		if (max_len < len)
 			max_len =3D len;
=20
-		if (file->is_binary || file->is_unmerged)
+		if (file->is_unmerged) {
+			/* "Unmerged" is 8 characters */
+			bin_width =3D bin_width < 8 ? 8 : bin_width;
 			continue;
+		}
+		if (file->is_binary) {
+			/* "Bin XXX -> YYY bytes" */
+			int w =3D 14 + decimal_width(file->added)
+				+ decimal_width(file->deleted);
+			bin_width =3D bin_width < w ? w : bin_width;
+			/* Display change counts aligned with "Bin" */
+			number_width =3D 3;
+			continue;
+		}
+
 		if (max_change < change)
 			max_change =3D change;
 	}
@@ -1389,10 +1402,19 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 	 * stat_name_width fixes the maximum width of the filename,
 	 * and is also used to divide available columns if there
 	 * aren't enough.
+	 *
+	 * Binary files are displayed with "Bin XXX -> YYY bytes"
+	 * instead of the change count and graph. This part is treated
+	 * similarly to the graph part, except that it is not
+	 * "scaled". If total width is too small to accomodate the
+	 * guaranteed minimum width of the filename part and the
+	 * separators and this message, this message will "overflow"
+	 * making the line longer than the maximum width.
 	 */
=20
 	width =3D options->stat_width ? options->stat_width : term_columns();
-	number_width =3D decimal_width(max_change);
+	number_width =3D decimal_width(max_change) > number_width ?
+		decimal_width(max_change) : number_width;
=20
 	/*
 	 * Guarantee 3/8*16=3D=3D6 for the graph part
@@ -1403,8 +1425,11 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
=20
 	/*
 	 * First assign sizes that are wanted, ignoring available width.
+	 * (strlen("Bin XXX -> YYY bytes") is bin_width + 4)
 	 */
-	graph_width =3D max_change < 40 ? max_change : 40;
+	graph_width =3D max_change + 4 > bin_width ? max_change : bin_width -=
 4;
+	if (graph_width > 40)
+		graph_width =3D 40;
 	name_width =3D (options->stat_name_width > 0 &&
 		      options->stat_name_width < max_len) ?
 		options->stat_name_width : max_len;
@@ -1458,7 +1483,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		if (data->files[i]->is_binary) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Bin ");
+			fprintf(options->file, " %*s ", number_width, "Bin");
 			fprintf(options->file, "%s%"PRIuMAX"%s",
 				del_c, deleted, reset);
 			fprintf(options->file, " -> ");
@@ -1471,7 +1496,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		else if (data->files[i]->is_unmerged) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Unmerged\n");
+			fprintf(options->file, " Unmerged\n");
 			continue;
 		}
=20
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 2d9f9a0..ea0b376 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -90,4 +90,21 @@ test_expect_success 'diff --no-index with binary cre=
ation' '
 	test_cmp expected actual
 '
=20
+cat >expect <<EOF
+ binfile  |   Bin 0 -> 1026 bytes
+ textfile | 10000 ++++++++++++++++++++++++++++++++++++++++
+EOF
+
+test_expect_success 'diff with binary files and big change count
+
+	Verify that "Bin" and the change count are properly aligned when
+	change count is big' '
+	echo X | dd of=3Dbinfile bs=3D1k seek=3D1 &&
+	git add binfile &&
+	seq 10000 > textfile &&
+	git add textfile &&
+	git diff --cached --stat binfile textfile | grep " | " > actual
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.9.6.ga1838.dirty
