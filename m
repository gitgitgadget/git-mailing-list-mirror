From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] diff --stat: use less columns for change counts
Date: Wed, 11 Apr 2012 16:24:09 +0200
Message-ID: <1334154249-3899-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, peff@peff.net,
	pclouds@gmail.com, j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 11 16:29:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHyYK-0002V3-GD
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 16:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330Ab2DKO3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 10:29:38 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34664 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760334Ab2DKO3g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 10:29:36 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SHyY9-0005bP-Kv; Wed, 11 Apr 2012 16:29:33 +0200
X-Mailer: git-send-email 1.7.10.344.g387ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195185>

Number of columns required for change counts is now computed based on
the maximum number of changed lines. This means that usually a few
more columns will be available for the filenames and the graph.

The graph width logic is also modified to include enough space for
"Bin XXX -> YYY bytes".

If changes to binary files are mixed with changes to text files,
change counts are padded to take at least three columns. And the other
way around, if change counts require more than three columns, then
"Bin"s are padded to align with the change count. This way, the +-
part starts in the same column as "XXX -> YYY" part for binary files.
This makes the graph easier to parse visually thanks to the empty
column. This mimics the layout of diff --stat before this change.

Tests and the tutorial are updated to reflect the new --stat output.
This means either the removal of extra padding and/or the addition of
up to three extra characters to truncated filenames. One test is added
to check the graph alignment when a binary file change and text file
change of more than 999 lines are committed together.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
Hi,

this is a patch that was first proposed as the last part of a series,
merged in af05021 "Merge branch 'zj/diff-stat-dyncol'" 2012-03-06,
but without this patch. The problem with this patch was the large
number of tests that needed to be adapted.

After merging, Junio suggested to "later consider if rerolling the
patch is worth it after the dust settles" [1]. Since 1.7.10 is
released, here is another try. I still think that this would be a
beneficial change. One sample is the diffstat below, generated without
and with this patch.

Duy suggested to use the new strategy only when output would use more
than 80 columns [2]. Doing so would have the advantage that the tests
would be mostly untouched. But doing this would make the code slightly
more complicated. Also, Jonathan Nieder's patches to use --numstat
instead of --stat (2983c0e "test: use numstat instead of diffstat in
binary-diff test" 2012-03-13) removed some of the places that needed
to be adapted. So I think it's better to just modify the test output.

[1] http://article.gmane.org/gmane.comp.version-control.git/190903
[2] http://article.gmane.org/gmane.comp.version-control.git/190827

old diff-stat:
 Documentation/gitcore-tutorial.txt                 |    4 +-
 diff.c                                             |   48 ++++++++++++=
++++----
 t/t0023-crlf-am.sh                                 |    2 +-
 t/t1200-tutorial.sh                                |    4 +-
 t/t3404-rebase-interactive.sh                      |    2 +-
 t/t3903-stash.sh                                   |    2 +-
 ...

new diff-stat:
 Documentation/gitcore-tutorial.txt                 |  4 +-
 diff.c                                             | 48 ++++++++++++++=
+++-----
 t/t0023-crlf-am.sh                                 |  2 +-
 t/t1200-tutorial.sh                                |  4 +-
 t/t3404-rebase-interactive.sh                      |  2 +-
 t/t3903-stash.sh                                   |  2 +-
 t/t4012-diff-binary.sh                             | 19 +++++++++
 ...ff-tree_--cc_--patch-with-stat_--summary_master |  4 +-
 ...diff-tree_--cc_--patch-with-stat_--summary_side |  6 +--
 .../diff.diff-tree_--cc_--patch-with-stat_master   |  4 +-
 .../diff.diff-tree_--cc_--stat_--summary_master    |  4 +-
 t/t4013/diff.diff-tree_--cc_--stat_--summary_side  |  6 +--
 t/t4013/diff.diff-tree_--cc_--stat_master          |  4 +-
 ...pretty=3Doneline_--root_--patch-with-stat_initial |  6 +--
 .../diff.diff-tree_--pretty_--patch-with-stat_side |  6 +--
 ...-tree_--pretty_--root_--patch-with-stat_initial |  6 +--
 ...f-tree_--pretty_--root_--stat_--summary_initial |  6 +--
 .../diff.diff-tree_--pretty_--root_--stat_initial  |  6 +--
 ...diff.diff-tree_--root_--patch-with-stat_initial |  6 +--
 t/t4013/diff.diff-tree_-c_--stat_--summary_master  |  4 +-
 t/t4013/diff.diff-tree_-c_--stat_--summary_side    |  6 +--
 t/t4013/diff.diff-tree_-c_--stat_master            |  4 +-
 .../diff.diff_--patch-with-stat_-r_initial..side   |  6 +--
 t/t4013/diff.diff_--patch-with-stat_initial..side  |  6 +--
 t/t4013/diff.diff_--stat_initial..side             |  6 +--
 t/t4013/diff.diff_-r_--stat_initial..side          |  6 +--
 ..._--attach_--stdout_--suffix=3D.diff_initial..side |  6 +--
 ....format-patch_--attach_--stdout_initial..master | 16 ++++----
 ...format-patch_--attach_--stdout_initial..master^ | 10 ++---
 ...ff.format-patch_--attach_--stdout_initial..side |  6 +--
 ...nline_--stdout_--numbered-files_initial..master | 16 ++++----
 ...tdout_--subject-prefix=3DTESTCASE_initial..master | 16 ++++----
 ....format-patch_--inline_--stdout_initial..master | 16 ++++----
 ...format-patch_--inline_--stdout_initial..master^ | 10 ++---
 ...ormat-patch_--inline_--stdout_initial..master^^ |  6 +--
 ...ff.format-patch_--inline_--stdout_initial..side |  6 +--
 ...tch_--stdout_--cover-letter_-n_initial..master^ | 18 ++++----
 ...at-patch_--stdout_--no-numbered_initial..master | 16 ++++----
 ...ormat-patch_--stdout_--numbered_initial..master | 16 ++++----
 t/t4013/diff.format-patch_--stdout_initial..master | 16 ++++----
 .../diff.format-patch_--stdout_initial..master^    | 10 ++---
 t/t4013/diff.format-patch_--stdout_initial..side   |  6 +--
 ....log_--patch-with-stat_--summary_master_--_dir_ |  6 +--
 t/t4013/diff.log_--patch-with-stat_master          | 16 ++++----
 t/t4013/diff.log_--patch-with-stat_master_--_dir_  |  6 +--
 ..._--root_--cc_--patch-with-stat_--summary_master | 26 ++++++------
 ...f.log_--root_--patch-with-stat_--summary_master | 22 +++++-----
 t/t4013/diff.log_--root_--patch-with-stat_master   | 22 +++++-----
 ...og_--root_-c_--patch-with-stat_--summary_master | 26 ++++++------
 t/t4013/diff.show_--patch-with-stat_--summary_side |  6 +--
 t/t4013/diff.show_--patch-with-stat_side           |  6 +--
 t/t4013/diff.show_--stat_--summary_side            |  6 +--
 t/t4013/diff.show_--stat_side                      |  6 +--
 ...nged_--patch-with-stat_--summary_master_--_dir_ |  6 +--
 t/t4013/diff.whatchanged_--patch-with-stat_master  | 16 ++++----
 ...ff.whatchanged_--patch-with-stat_master_--_dir_ |  6 +--
 ..._--root_--cc_--patch-with-stat_--summary_master | 26 ++++++------
 ...anged_--root_--patch-with-stat_--summary_master | 22 +++++-----
 ...iff.whatchanged_--root_--patch-with-stat_master | 22 +++++-----
 ...ed_--root_-c_--patch-with-stat_--summary_master | 26 ++++++------
 t/t4016-diff-quote.sh                              | 14 +++----
 t/t4030-diff-textconv.sh                           |  2 +-
 t/t4045-diff-relative.sh                           |  2 +-
 t/t4049-diff-stat-count.sh                         |  4 +-
 t/t4052-stat-output.sh                             |  6 +--
 t/t4202-log.sh                                     | 30 +++++++-------
 t/t5100/patch0001                                  |  2 +-
 t/t5100/patch0002                                  |  2 +-
 t/t5100/patch0003                                  |  2 +-
 t/t5100/patch0005                                  |  4 +-
 t/t5100/patch0006                                  |  2 +-
 t/t5100/patch0010                                  |  2 +-
 t/t5100/patch0011                                  |  2 +-
 t/t5100/patch0014                                  |  2 +-
 t/t5100/patch0014--scissors                        |  2 +-
 t/t5100/sample.mbox                                | 18 ++++----
 t/t7602-merge-octopus-many.sh                      | 12 +++---
 77 files changed, 400 insertions(+), 353 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore=
-tutorial.txt
index fb0d569..5b5d5a4 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1002,8 +1002,8 @@ would be different)
 ----------------
 Updating from ae3a2da... to a80b4aa....
 Fast-forward (no commit created; -m option ignored)
- example |    1 +
- hello   |    1 +
+ example | 1 +
+ hello   | 1 +
  2 files changed, 2 insertions(+)
 ----------------
=20
diff --git a/diff.c b/diff.c
index 22288b0..c316e0c 100644
--- a/diff.c
+++ b/diff.c
@@ -1443,8 +1443,8 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 {
 	int i, len, add, del, adds =3D 0, dels =3D 0;
 	uintmax_t max_change =3D 0, max_len =3D 0;
-	int total_files =3D data->nr;
-	int width, name_width, graph_width, number_width =3D 4, count;
+	int total_files =3D data->nr, count;
+	int width, name_width, graph_width, number_width =3D 0, bin_width =3D=
 0;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix =3D "";
 	int extra_shown =3D 0;
@@ -1480,8 +1480,21 @@ static void show_stats(struct diffstat_t *data, =
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
@@ -1506,12 +1519,22 @@ static void show_stats(struct diffstat_t *data,=
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
 	if (options->stat_width =3D=3D -1)
 		width =3D term_columns();
 	else
 		width =3D options->stat_width ? options->stat_width : 80;
+	number_width =3D decimal_width(max_change) > number_width ?
+		decimal_width(max_change) : number_width;
=20
 	if (options->stat_graph_width =3D=3D -1)
 		options->stat_graph_width =3D diff_stat_graph_width;
@@ -1525,10 +1548,14 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
=20
 	/*
 	 * First assign sizes that are wanted, ignoring available width.
+	 * strlen("Bin XXX -> YYY bytes") =3D=3D bin_width, and the part
+	 * starting from "XXX" should fit in graph_width.
 	 */
-	graph_width =3D (options->stat_graph_width &&
-		       options->stat_graph_width < max_change) ?
-		options->stat_graph_width : max_change;
+	graph_width =3D max_change + 4 > bin_width ? max_change : bin_width -=
 4;
+	if (options->stat_graph_width &&
+	    options->stat_graph_width < graph_width)
+		graph_width =3D options->stat_graph_width;
+
 	name_width =3D (options->stat_name_width > 0 &&
 		      options->stat_name_width < max_len) ?
 		options->stat_name_width : max_len;
@@ -1583,7 +1610,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		if (data->files[i]->is_binary) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Bin ");
+			fprintf(options->file, " %*s ", number_width, "Bin");
 			fprintf(options->file, "%s%"PRIuMAX"%s",
 				del_c, deleted, reset);
 			fprintf(options->file, " -> ");
@@ -1596,7 +1623,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		else if (data->files[i]->is_unmerged) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Unmerged\n");
+			fprintf(options->file, " Unmerged\n");
 			continue;
 		}
=20
@@ -1625,8 +1652,9 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
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
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index aaed725..f9bbb91 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -11,7 +11,7 @@ Date: Thu, 23 Aug 2007 13:00:00 +0200
 Subject: test1
=20
 ---
- foo |    1 +
+ foo | 1 +
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 foo
=20
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 9356bea..397ccb6 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -154,8 +154,8 @@ test_expect_success 'git show-branch' '
 cat > resolve.expect << EOF
 Updating VARIABLE..VARIABLE
 FASTFORWARD (no commit created; -m option ignored)
- example |    1 +
- hello   |    1 +
+ example | 1 +
+ hello   | 1 +
  2 files changed, 2 insertions(+)
 EOF
=20
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 7fd2127..4983bd7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -323,7 +323,7 @@ test_expect_success 'verbose flag is heeded, even a=
fter --continue' '
 	echo resolved > file1 &&
 	git add file1 &&
 	git rebase --continue > output &&
-	grep "^ file1 |    2 +-$" output
+	grep "^ file1 | 2 +-$" output
 '
=20
 test_expect_success 'multi-squash only fires up editor once' '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3addb80..cd04263 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -443,7 +443,7 @@ test_expect_success 'stash show format defaults to =
--stat' '
 	STASH_ID=3D$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
-	 file |    1 +
+	 file | 1 +
 	 1 file changed, 1 insertion(+)
 	EOF
 	git stash show ${STASH_ID} >actual &&
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index ed24ddd..8b4e80d 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -107,4 +107,23 @@ test_expect_success 'diff --no-index with binary c=
reation' '
 	test_cmp expected actual
 '
=20
+cat >expect <<EOF
+ binfile  |   Bin 0 -> 1026 bytes
+ textfile | 10000 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
+EOF
+
+test_expect_success 'diff --stat with binary files and big change coun=
t' '
+	echo X | dd of=3Dbinfile bs=3D1k seek=3D1 &&
+	git add binfile &&
+	i=3D0 &&
+	while test $i -lt 10000; do
+		echo $i &&
+		i=3D$(($i + 1))
+	done >textfile &&
+	git add textfile &&
+	git diff --cached --stat binfile textfile >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_ma=
ster b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
index 2f8560c..9951e36 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
@@ -1,7 +1,7 @@
 $ git diff-tree --cc --patch-with-stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_si=
de b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
index 72e03c1..cec33fa 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
@@ -1,8 +1,8 @@
 $ git diff-tree --cc --patch-with-stat --summary side
 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master b/t/t=
4013/diff.diff-tree_--cc_--patch-with-stat_master
index 8b357d9..db3c0a7 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
@@ -1,7 +1,7 @@
 $ git diff-tree --cc --patch-with-stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master b/t/t4=
013/diff.diff-tree_--cc_--stat_--summary_master
index e0568d6..d019867 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
@@ -1,6 +1,6 @@
 $ git diff-tree --cc --stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_side b/t/t401=
3/diff.diff-tree_--cc_--stat_--summary_side
index 5afc823..12b2eee 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_side
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_side
@@ -1,8 +1,8 @@
 $ git diff-tree --cc --stat --summary side
 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_master b/t/t4013/diff.d=
iff-tree_--cc_--stat_master
index f48367a..40b9179 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_master
@@ -1,6 +1,6 @@
 $ git diff-tree --cc --stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-w=
ith-stat_initial b/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--p=
atch-with-stat_initial
index 590864c..817ed06 100644
--- a/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-sta=
t_initial
+++ b/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-sta=
t_initial
@@ -1,8 +1,8 @@
 $ git diff-tree --pretty=3Doneline --root --patch-with-stat initial
 444ac553ac7612cc88969031b02b3767fb8a353a Initial
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side b/t=
/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
index e05e778..fe3f6b7 100644
--- a/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
+++ b/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_i=
nitial b/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initi=
al
index 0e2c956..06eb77e 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initial
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_in=
itial b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
index 384fa44..680eab5 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
=20
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial b/t/=
t4013/diff.diff-tree_--pretty_--root_--stat_initial
index 10384a8..9722d1b 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial
@@ -5,8 +5,8 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
=20
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial b/=
t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
index f57062e..ad69ffe 100644
--- a/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
+++ b/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
@@ -1,8 +1,8 @@
 $ git diff-tree --root --patch-with-stat initial
 444ac553ac7612cc88969031b02b3767fb8a353a
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_master b/t/t401=
3/diff.diff-tree_-c_--stat_--summary_master
index 7088683..81c3021 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_master
@@ -1,6 +1,6 @@
 $ git diff-tree -c --stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_side b/t/t4013/=
diff.diff-tree_-c_--stat_--summary_side
index ef216ab..e8dc12b 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_side
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_side
@@ -1,8 +1,8 @@
 $ git diff-tree -c --stat --summary side
 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_master b/t/t4013/diff.dif=
f-tree_-c_--stat_master
index ad19f10..89d59b1 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_master
@@ -1,6 +1,6 @@
 $ git diff-tree -c --stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff_--patch-with-stat_-r_initial..side b/t/t=
4013/diff.diff_--patch-with-stat_-r_initial..side
index ddad917..be8d1ea 100644
--- a/t/t4013/diff.diff_--patch-with-stat_-r_initial..side
+++ b/t/t4013/diff.diff_--patch-with-stat_-r_initial..side
@@ -1,7 +1,7 @@
 $ git diff --patch-with-stat -r initial..side
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff_--patch-with-stat_initial..side b/t/t401=
3/diff.diff_--patch-with-stat_initial..side
index bdbd114..5424e6d 100644
--- a/t/t4013/diff.diff_--patch-with-stat_initial..side
+++ b/t/t4013/diff.diff_--patch-with-stat_initial..side
@@ -1,7 +1,7 @@
 $ git diff --patch-with-stat initial..side
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff_--stat_initial..side b/t/t4013/diff.diff=
_--stat_initial..side
index 6d08f3d..b7741e2 100644
--- a/t/t4013/diff.diff_--stat_initial..side
+++ b/t/t4013/diff.diff_--stat_initial..side
@@ -1,6 +1,6 @@
 $ git diff --stat initial..side
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.diff_-r_--stat_initial..side b/t/t4013/diff.d=
iff_-r_--stat_initial..side
index 2ddb254..5d514f5 100644
--- a/t/t4013/diff.diff_-r_--stat_initial..side
+++ b/t/t4013/diff.diff_-r_--stat_initial..side
@@ -1,6 +1,6 @@
 $ git diff -r --stat initial..side
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.di=
ff_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=
=3D.diff_initial..side
index 3cab049..547ca06 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.diff_init=
ial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.diff_init=
ial..side
@@ -12,9 +12,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index 564a4d3..52fedc1 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 4f28460..1c3cde2 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side =
b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index b10cc2e..4717bd8 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -12,9 +12,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-fil=
es_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numb=
ered-files_initial..master
index a976a8a..02c4db7 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_init=
ial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_init=
ial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-pref=
ix=3DTESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--st=
dout_--subject-prefix=3DTESTCASE_initial..master
index b4fd664..c7677c5 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTE=
STCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTE=
STCASE_initial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 0d31036..5b3e34e 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index 18d4714..d13f8a8 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
index 29e00ab..caec553 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side =
b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index 3572f20..d3a6762 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -12,9 +12,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initi=
al..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_init=
ial..master^
index 54cdcda..244d964 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..mas=
ter^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..mas=
ter^
@@ -10,10 +10,10 @@ A U Thor (2):
   Second
   Third
=20
- dir/sub |    4 ++++
- file0   |    3 +++
- file1   |    3 +++
- file2   |    3 ---
+ dir/sub | 4 ++++
+ file0   | 3 +++
+ file1   | 3 +++
+ file2   | 3 ---
  4 files changed, 10 insertions(+), 3 deletions(-)
  create mode 100644 file1
  delete mode 100644 file2
@@ -28,9 +28,9 @@ Subject: [DIFFERENT_PREFIX 1/2] Second
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [DIFFERENT_PREFIX 2/2] Third
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..=
master b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..mast=
er
index 23194eb..bfc287a 100644
--- a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
@@ -6,9 +6,9 @@ Subject: [PATCH] Second
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH] Third
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -85,9 +85,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..mas=
ter b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
index 78f1a80..568f6f5 100644
--- a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
@@ -6,9 +6,9 @@ Subject: [PATCH 1/3] Second
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/3] Third
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -85,9 +85,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH 3/3] Side
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t40=
13/diff.format-patch_--stdout_initial..master
index a3dab7f..5f0352f 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_initial..master
@@ -6,9 +6,9 @@ Subject: [PATCH 1/3] Second
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/3] Third
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -85,9 +85,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH 3/3] Side
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4=
013/diff.format-patch_--stdout_initial..master^
index 39f4a3f..2ae454d 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_initial..master^
@@ -6,9 +6,9 @@ Subject: [PATCH 1/2] Second
=20
 This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/2] Third
=20
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..side b/t/t4013=
/diff.format-patch_--stdout_initial..side
index 8810920..a7d52fb 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--stdout_initial..side
@@ -5,9 +5,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
=20
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir=
_ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index 4085bbd..a18f147 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -12,7 +12,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -31,7 +31,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -53,7 +53,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.l=
og_--patch-with-stat_master
index 4586279..ae425c4 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -12,9 +12,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -54,8 +54,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -86,9 +86,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t401=
3/diff.log_--patch-with-stat_master_--_dir_
index 6e172cf..d5207ca 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -12,7 +12,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -31,7 +31,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -53,7 +53,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_m=
aster b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index 48b0d4b..0fc1e8c 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
@@ -6,8 +6,8 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
     Merge branch 'side'
=20
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master=
 b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index f9dc512..dffc09d 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -12,9 +12,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -55,8 +55,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -88,9 +88,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -130,9 +130,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013=
/diff.log_--root_--patch-with-stat_master
index 0807ece..55aa980 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -12,9 +12,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -54,8 +54,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -86,9 +86,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -127,9 +127,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_mas=
ter b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index 84f5ef6..019d85f 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
@@ -6,8 +6,8 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
     Merge branch 'side'
=20
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --combined dir/sub
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.show_--patch-with-stat_--summary_side b/t/t40=
13/diff.show_--patch-with-stat_--summary_side
index e60384d..95a474e 100644
--- a/t/t4013/diff.show_--patch-with-stat_--summary_side
+++ b/t/t4013/diff.show_--patch-with-stat_--summary_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.show_--patch-with-stat_side b/t/t4013/diff.sh=
ow_--patch-with-stat_side
index a3a3255..974e99b 100644
--- a/t/t4013/diff.show_--patch-with-stat_side
+++ b/t/t4013/diff.show_--patch-with-stat_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.show_--stat_--summary_side b/t/t4013/diff.sho=
w_--stat_--summary_side
index d16f464..a71492f 100644
--- a/t/t4013/diff.show_--stat_--summary_side
+++ b/t/t4013/diff.show_--stat_--summary_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
=20
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.show_--stat_side b/t/t4013/diff.show_--stat_s=
ide
index 6300c05..9be7124 100644
--- a/t/t4013/diff.show_--stat_side
+++ b/t/t4013/diff.show_--stat_side
@@ -5,8 +5,8 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
=20
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_maste=
r_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master=
_--_dir_
index 16ae543..c8b6af2 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_di=
r_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_di=
r_
@@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -24,7 +24,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -46,7 +46,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master b/t/t401=
3/diff.whatchanged_--patch-with-stat_master
index f3e45ec..1ac431b 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_master
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -47,8 +47,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -79,9 +79,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_ =
b/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
index c77f0bc..b30c285 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
@@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -24,7 +24,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -46,7 +46,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--s=
ummary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_=
--summary_master
index 8d03efe..30aae78 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_=
master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_=
master
@@ -6,8 +6,8 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
     Merge branch 'side'
=20
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summar=
y_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_=
master
index 1874d06..db90e51 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_maste=
r
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_maste=
r
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -48,8 +48,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -81,9 +81,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -123,9 +123,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master b=
/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
index 5211ff2..9a6cc92 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -47,8 +47,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -79,9 +79,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--sum=
mary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--su=
mmary_master
index ad30245..d1d32bd 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_ma=
ster
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_ma=
ster
@@ -6,8 +6,8 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
     Merge branch 'side'
=20
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --combined dir/sub
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file3   |    4 ++++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
- file1   |    3 +++
+ dir/sub | 2 ++
+ file1   | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 ---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub |    2 ++
- file0   |    3 +++
- file2   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 3ec7118..97b8177 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -73,13 +73,13 @@ test_expect_success TABS_IN_FILENAMES 'git diff --n=
umstat -M HEAD' '
=20
 test_expect_success TABS_IN_FILENAMES 'git diff --stat -M HEAD' '
 	cat >expect <<-\EOF &&
-	 pathname.1 =3D> "Rpathname\twith HT.0"            |    0
-	 pathname.3 =3D> "Rpathname\nwith LF.0"            |    0
-	 "pathname\twith HT.3" =3D> "Rpathname\nwith LF.1" |    0
-	 pathname.2 =3D> Rpathname with SP.0               |    0
-	 "pathname\twith HT.2" =3D> Rpathname with SP.1    |    0
-	 pathname.0 =3D> Rpathname.0                       |    0
-	 "pathname\twith HT.0" =3D> Rpathname.1            |    0
+	 pathname.1 =3D> "Rpathname\twith HT.0"            | 0
+	 pathname.3 =3D> "Rpathname\nwith LF.0"            | 0
+	 "pathname\twith HT.3" =3D> "Rpathname\nwith LF.1" | 0
+	 pathname.2 =3D> Rpathname with SP.0               | 0
+	 "pathname\twith HT.2" =3D> Rpathname with SP.1    | 0
+	 pathname.0 =3D> Rpathname.0                       | 0
+	 "pathname\twith HT.0" =3D> Rpathname.1            | 0
 	 7 files changed, 0 insertions(+), 0 deletions(-)
 	EOF
 	git diff --stat -M HEAD >actual &&
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 06b05df..d4ab4f2 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -85,7 +85,7 @@ test_expect_success 'status -v produces text' '
 '
=20
 cat >expect.stat <<'EOF'
- file |  Bin 2 -> 4 bytes
+ file | Bin 2 -> 4 bytes
  1 file changed, 0 insertions(+), 0 deletions(-)
 EOF
 test_expect_success 'diffstat does not run textconv' '
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 18fadcf..3950f50 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -44,7 +44,7 @@ test_expect_success "--numstat $*" "
 check_stat() {
 expect=3D$1; shift
 cat >expected <<EOF
- $expect |    1 +
+ $expect | 1 +
  1 file changed, 1 insertion(+)
 EOF
 test_expect_success "--stat $*" "
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 591ffbc..b41eb61 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -14,8 +14,8 @@ test_expect_success setup '
 	echo a >a &&
 	echo b >b &&
 	cat >expect <<-\EOF
-	 a |    1 +
-	 b |    1 +
+	 a | 1 +
+	 b | 1 +
 	 2 files changed, 2 insertions(+)
 	EOF
 	git diff --stat --stat-count=3D2 >actual &&
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 328aa8f..4bdc7d4 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -22,7 +22,7 @@ test_expect_success 'preparation' '
 while read cmd args
 do
 	cat >expect <<-'EOF'
-	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
a |    1 +
+	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaa | 1 +
 	EOF
 	test_expect_success "$cmd: small change with long name gives more spa=
ce to the name" '
 		git $cmd $args >output &&
@@ -31,7 +31,7 @@ do
 	'
=20
 	cat >expect <<-'EOF'
-	 ...aaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
+	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 	EOF
 	test_expect_success "$cmd --stat=3Dwidth: a long name is given more r=
oom when the bar is short" '
 		git $cmd $args --stat=3D40 >output &&
@@ -46,7 +46,7 @@ do
 	'
=20
 	cat >expect <<-'EOF'
-	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
+	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 	EOF
 	test_expect_success "$cmd --stat=3D...,name-width with long name" '
 		git $cmd $args --stat=3D60,30 >output &&
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 32cf0bd..71be59d 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -528,7 +528,7 @@ cat >expect <<\EOF
 | |
 | |     reach
 | | ---
-| |  reach.t |    1 +
+| |  reach.t | 1 +
 | |  1 file changed, 1 insertion(+)
 | |
 | | diff --git a/reach.t b/reach.t
@@ -551,7 +551,7 @@ cat >expect <<\EOF
 | | |
 | | |       octopus-b
 | | |   ---
-| | |    octopus-b.t |    1 +
+| | |    octopus-b.t | 1 +
 | | |    1 file changed, 1 insertion(+)
 | | |
 | | |   diff --git a/octopus-b.t b/octopus-b.t
@@ -567,7 +567,7 @@ cat >expect <<\EOF
 | |
 | |       octopus-a
 | |   ---
-| |    octopus-a.t |    1 +
+| |    octopus-a.t | 1 +
 | |    1 file changed, 1 insertion(+)
 | |
 | |   diff --git a/octopus-a.t b/octopus-a.t
@@ -583,7 +583,7 @@ cat >expect <<\EOF
 |
 |       seventh
 |   ---
-|    seventh.t |    1 +
+|    seventh.t | 1 +
 |    1 file changed, 1 insertion(+)
 |
 |   diff --git a/seventh.t b/seventh.t
@@ -617,7 +617,7 @@ cat >expect <<\EOF
 | | | |
 | | | |     tangle-a
 | | | | ---
-| | | |  tangle-a |    1 +
+| | | |  tangle-a | 1 +
 | | | |  1 file changed, 1 insertion(+)
 | | | |
 | | | | diff --git a/tangle-a b/tangle-a
@@ -639,7 +639,7 @@ cat >expect <<\EOF
 | |/| |
 | | | |       side-2
 | | | |   ---
-| | | |    2 |    1 +
+| | | |    2 | 1 +
 | | | |    1 file changed, 1 insertion(+)
 | | | |
 | | | |   diff --git a/2 b/2
@@ -655,7 +655,7 @@ cat >expect <<\EOF
 | | | |
 | | | |     side-1
 | | | | ---
-| | | |  1 |    1 +
+| | | |  1 | 1 +
 | | | |  1 file changed, 1 insertion(+)
 | | | |
 | | | | diff --git a/1 b/1
@@ -671,7 +671,7 @@ cat >expect <<\EOF
 | | | |
 | | | |     Second
 | | | | ---
-| | | |  one |    1 +
+| | | |  one | 1 +
 | | | |  1 file changed, 1 insertion(+)
 | | | |
 | | | | diff --git a/one b/one
@@ -687,7 +687,7 @@ cat >expect <<\EOF
 |/| |
 | | |       sixth
 | | |   ---
-| | |    a/two |    1 -
+| | |    a/two | 1 -
 | | |    1 file changed, 1 deletion(-)
 | | |
 | | |   diff --git a/a/two b/a/two
@@ -703,7 +703,7 @@ cat >expect <<\EOF
 | | |
 | | |     fifth
 | | | ---
-| | |  a/two |    1 +
+| | |  a/two | 1 +
 | | |  1 file changed, 1 insertion(+)
 | | |
 | | | diff --git a/a/two b/a/two
@@ -719,7 +719,7 @@ cat >expect <<\EOF
 | |
 | |       fourth
 | |   ---
-| |    ein |    1 +
+| |    ein | 1 +
 | |    1 file changed, 1 insertion(+)
 | |
 | |   diff --git a/ein b/ein
@@ -735,8 +735,8 @@ cat >expect <<\EOF
 |
 |       third
 |   ---
-|    ichi |    1 +
-|    one  |    1 -
+|    ichi | 1 +
+|    one  | 1 -
 |    2 files changed, 1 insertion(+), 1 deletion(-)
 |
 |   diff --git a/ichi b/ichi
@@ -759,7 +759,7 @@ cat >expect <<\EOF
 |
 |     second
 | ---
-|  one |    2 +-
+|  one | 2 +-
 |  1 file changed, 1 insertion(+), 1 deletion(-)
 |
 | diff --git a/one b/one
@@ -775,7 +775,7 @@ cat >expect <<\EOF
=20
       initial
   ---
-   one |    1 +
+   one | 1 +
    1 file changed, 1 insertion(+)
=20
   diff --git a/one b/one
diff --git a/t/t5100/patch0001 b/t/t5100/patch0001
index 8ce1551..02c9774 100644
--- a/t/t5100/patch0001
+++ b/t/t5100/patch0001
@@ -1,5 +1,5 @@
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
diff --git a/t/t5100/patch0002 b/t/t5100/patch0002
index 8ce1551..02c9774 100644
--- a/t/t5100/patch0002
+++ b/t/t5100/patch0002
@@ -1,5 +1,5 @@
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
diff --git a/t/t5100/patch0003 b/t/t5100/patch0003
index 8ce1551..02c9774 100644
--- a/t/t5100/patch0003
+++ b/t/t5100/patch0003
@@ -1,5 +1,5 @@
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
diff --git a/t/t5100/patch0005 b/t/t5100/patch0005
index 7d24b24..ab7a383 100644
--- a/t/t5100/patch0005
+++ b/t/t5100/patch0005
@@ -1,7 +1,7 @@
 ---
=20
- Documentation/git-cvsimport-script.txt |    9 ++++++++-
- git-cvsimport-script                   |    4 ++--
+ Documentation/git-cvsimport-script.txt | 9 ++++++++-
+ git-cvsimport-script                   | 4 ++--
  2 files changed, 10 insertions(+), 3 deletions(-)
=20
 50452f9c0c2df1f04d83a26266ba704b13861632
diff --git a/t/t5100/patch0006 b/t/t5100/patch0006
index 8ce1551..02c9774 100644
--- a/t/t5100/patch0006
+++ b/t/t5100/patch0006
@@ -1,5 +1,5 @@
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
diff --git a/t/t5100/patch0010 b/t/t5100/patch0010
index f055481..436821c 100644
--- a/t/t5100/patch0010
+++ b/t/t5100/patch0010
@@ -1,5 +1,5 @@
 ---
- builtin-mailinfo.c |    2 +-
+ builtin-mailinfo.c | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
diff --git a/t/t5100/patch0011 b/t/t5100/patch0011
index 8841d3c..0988713 100644
--- a/t/t5100/patch0011
+++ b/t/t5100/patch0011
@@ -1,5 +1,5 @@
 ---
- builtin-mailinfo.c  |    4 ++--
+ builtin-mailinfo.c  | 4 ++--
=20
 diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
 index 3e5fe51..aabfe5c 100644
diff --git a/t/t5100/patch0014 b/t/t5100/patch0014
index 124efd2..3f3825f 100644
--- a/t/t5100/patch0014
+++ b/t/t5100/patch0014
@@ -1,5 +1,5 @@
 ---
- builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++++-
+ builtin-mailinfo.c | 37 ++++++++++++++++++++++++++++++++++++-
  1 files changed, 36 insertions(+), 1 deletions(-)
=20
 diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
diff --git a/t/t5100/patch0014--scissors b/t/t5100/patch0014--scissors
index 124efd2..3f3825f 100644
--- a/t/t5100/patch0014--scissors
+++ b/t/t5100/patch0014--scissors
@@ -1,5 +1,5 @@
 ---
- builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++++-
+ builtin-mailinfo.c | 37 ++++++++++++++++++++++++++++++++++++-
  1 files changed, 36 insertions(+), 1 deletions(-)
=20
 diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index de10312..34a09a0 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -12,7 +12,7 @@ Subject: [PATCH] a commit.
 Here is a patch from A U Thor.
=20
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
@@ -52,7 +52,7 @@ two truly blank and another full of spaces in between=
=2E
 Hope this helps.
=20
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
@@ -83,7 +83,7 @@ Message-Id: <nitpicker.12121212@example.net>
 Hopefully this would fix the problem stated there.
=20
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
@@ -249,8 +249,8 @@ actual flags.
 Signed-off-by: David K=3DE5gedal <davidk@lysator.liu.se>
 ---
=20
- Documentation/git-cvsimport-script.txt |    9 ++++++++-
- git-cvsimport-script                   |    4 ++--
+ Documentation/git-cvsimport-script.txt | 9 ++++++++-
+ git-cvsimport-script                   | 4 ++--
  2 files changed, 10 insertions(+), 3 deletions(-)
=20
 50452f9c0c2df1f04d83a26266ba704b13861632
@@ -379,7 +379,7 @@ Subject: [PATCH] a commit.
 Here is a patch from A U Thor.
=20
 ---
- foo |    2 +-
+ foo | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/foo b/foo
@@ -449,7 +449,7 @@ memcmp("Subject: ", header[i], 7) will never match.
 Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
 Signed-off-by: Junio C Hamano <gitster@pobox.com>
 ---
- builtin-mailinfo.c |    2 +-
+ builtin-mailinfo.c | 2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
=20
 diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
@@ -482,7 +482,7 @@ Content-Transfer-Encoding: quoted-printable
 Here comes a commit log message, and
 its second line is here.
 ---
- builtin-mailinfo.c  |    4 ++--
+ builtin-mailinfo.c  | 4 ++--
=20
 diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
 index 3e5fe51..aabfe5c 100644
@@ -587,7 +587,7 @@ everything before it in the message body.
=20
 Signed-off-by: Junio C Hamano <gitster@pobox.com>
 ---
- builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++++-
+ builtin-mailinfo.c | 37 ++++++++++++++++++++++++++++++++++++-
  1 files changed, 36 insertions(+), 1 deletions(-)
=20
 diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many=
=2Esh
index bce0bd3..bef1108 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -54,9 +54,9 @@ Trying simple merge with c2
 Trying simple merge with c3
 Trying simple merge with c4
 Merge made by the 'octopus' strategy.
- c2.c |    1 +
- c3.c |    1 +
- c4.c |    1 +
+ c2.c | 1 +
+ c3.c | 1 +
+ c4.c | 1 +
  3 files changed, 3 insertions(+)
  create mode 100644 c2.c
  create mode 100644 c3.c
@@ -73,7 +73,7 @@ cat >expected <<\EOF
 Already up-to-date with c4
 Trying simple merge with c5
 Merge made by the 'octopus' strategy.
- c5.c |    1 +
+ c5.c | 1 +
  1 file changed, 1 insertion(+)
  create mode 100644 c5.c
 EOF
@@ -87,8 +87,8 @@ cat >expected <<\EOF
 Fast-forwarding to: c1
 Trying simple merge with c2
 Merge made by the 'octopus' strategy.
- c1.c |    1 +
- c2.c |    1 +
+ c1.c | 1 +
+ c2.c | 1 +
  2 files changed, 2 insertions(+)
  create mode 100644 c1.c
  create mode 100644 c2.c
--=20
1.7.10.344.g387ed
