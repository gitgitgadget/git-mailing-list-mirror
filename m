From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 3/3 v5] diff --stat: use less columns for change counts
Date: Wed, 15 Feb 2012 12:03:28 +0100
Message-ID: <1329303808-16989-3-git-send-email-zbyszek@in.waw.pl>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
 <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 15 12:04:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxcfB-0006xA-5T
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 12:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759115Ab2BOLEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 06:04:35 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52622 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758972Ab2BOLEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 06:04:34 -0500
Received: from [193.0.104.42] (helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1Rxcew-0000Yn-Bj; Wed, 15 Feb 2012 12:04:32 +0100
X-Mailer: git-send-email 1.7.9.5.g91d5
In-Reply-To: <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190826>

Number of columns required for change counts is computed based on the
maximum number of changed lines. This means that usually a few more
columns will be available for the filenames and the graph.

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
One test for the graph alignment with a binary file change and text
file change of more than 999 lines is added.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
This is the small patch which causes big changes in output.
In previous version this was part of patch 1 (use the full terminal
width) and whole of patches 2 (better aligment for binary files) and 3
(update diff --stat output).

 Documentation/gitcore-tutorial.txt                 |  4 +-
 diff.c                                             | 44 ++++++++++++++=
---
 t/t0023-crlf-am.sh                                 |  2 +-
 t/t1200-tutorial.sh                                |  4 +-
 t/t3404-rebase-interactive.sh                      |  2 +-
 t/t3903-stash.sh                                   |  4 +-
 t/t4012-diff-binary.sh                             | 19 ++++++++
 ...ff-tree_--cc_--patch-with-stat_--summary_master |  4 +-
 ...diff-tree_--cc_--patch-with-stat_--summary_side |  6 +-
 .../diff.diff-tree_--cc_--patch-with-stat_master   |  4 +-
 .../diff.diff-tree_--cc_--stat_--summary_master    |  4 +-
 t/t4013/diff.diff-tree_--cc_--stat_--summary_side  |  6 +-
 t/t4013/diff.diff-tree_--cc_--stat_master          |  4 +-
 ...pretty=3Doneline_--root_--patch-with-stat_initial |  6 +-
 .../diff.diff-tree_--pretty_--patch-with-stat_side |  6 +-
 ...-tree_--pretty_--root_--patch-with-stat_initial |  6 +-
 ...f-tree_--pretty_--root_--stat_--summary_initial |  6 +-
 .../diff.diff-tree_--pretty_--root_--stat_initial  |  6 +-
 ...diff.diff-tree_--root_--patch-with-stat_initial |  6 +-
 t/t4013/diff.diff-tree_-c_--stat_--summary_master  |  4 +-
 t/t4013/diff.diff-tree_-c_--stat_--summary_side    |  6 +-
 t/t4013/diff.diff-tree_-c_--stat_master            |  4 +-
 .../diff.diff_--patch-with-stat_-r_initial..side   |  6 +-
 t/t4013/diff.diff_--patch-with-stat_initial..side  |  6 +-
 t/t4013/diff.diff_--stat_initial..side             |  6 +-
 t/t4013/diff.diff_-r_--stat_initial..side          |  6 +-
 ..._--attach_--stdout_--suffix=3D.diff_initial..side |  6 +-
 ....format-patch_--attach_--stdout_initial..master | 16 +++---
 ...format-patch_--attach_--stdout_initial..master^ | 10 ++--
 ...ff.format-patch_--attach_--stdout_initial..side |  6 +-
 ...nline_--stdout_--numbered-files_initial..master | 16 +++---
 ...tdout_--subject-prefix=3DTESTCASE_initial..master | 16 +++---
 ....format-patch_--inline_--stdout_initial..master | 16 +++---
 ...format-patch_--inline_--stdout_initial..master^ | 10 ++--
 ...ormat-patch_--inline_--stdout_initial..master^^ |  6 +-
 ...ff.format-patch_--inline_--stdout_initial..side |  6 +-
 ...tch_--stdout_--cover-letter_-n_initial..master^ | 18 ++++----
 ...at-patch_--stdout_--no-numbered_initial..master | 16 +++---
 ...ormat-patch_--stdout_--numbered_initial..master | 16 +++---
 t/t4013/diff.format-patch_--stdout_initial..master | 16 +++---
 .../diff.format-patch_--stdout_initial..master^    | 10 ++--
 t/t4013/diff.format-patch_--stdout_initial..side   |  6 +-
 ....log_--patch-with-stat_--summary_master_--_dir_ |  6 +-
 t/t4013/diff.log_--patch-with-stat_master          | 16 +++---
 t/t4013/diff.log_--patch-with-stat_master_--_dir_  |  6 +-
 ..._--root_--cc_--patch-with-stat_--summary_master | 26 +++++-----
 ...f.log_--root_--patch-with-stat_--summary_master | 22 ++++----
 t/t4013/diff.log_--root_--patch-with-stat_master   | 22 ++++----
 ...og_--root_-c_--patch-with-stat_--summary_master | 26 +++++-----
 t/t4013/diff.show_--patch-with-stat_--summary_side |  6 +-
 t/t4013/diff.show_--patch-with-stat_side           |  6 +-
 t/t4013/diff.show_--stat_--summary_side            |  6 +-
 t/t4013/diff.show_--stat_side                      |  6 +-
 ...nged_--patch-with-stat_--summary_master_--_dir_ |  6 +-
 t/t4013/diff.whatchanged_--patch-with-stat_master  | 16 +++---
 ...ff.whatchanged_--patch-with-stat_master_--_dir_ |  6 +-
 ..._--root_--cc_--patch-with-stat_--summary_master | 26 +++++-----
 ...anged_--root_--patch-with-stat_--summary_master | 22 ++++----
 ...iff.whatchanged_--root_--patch-with-stat_master | 22 ++++----
 ...ed_--root_-c_--patch-with-stat_--summary_master | 26 +++++-----
 t/t4014-format-patch.sh                            | 10 ++--
 t/t4016-diff-quote.sh                              | 14 +++---
 t/t4030-diff-textconv.sh                           |  2 +-
 t/t4043-diff-rename-binary.sh                      |  4 +-
 t/t4045-diff-relative.sh                           |  2 +-
 t/t4047-diff-dirstat.sh                            | 54 +++++++++++---=
--------
 t/t4049-diff-stat-count.sh                         |  4 +-
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
 t/t7602-merge-octopus-many.sh                      | 12 ++--
 78 files changed, 415 insertions(+), 368 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore=
-tutorial.txt
index c27d086..b781bbf 100644
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
  2 files changed, 2 insertions(+), 0 deletions(-)
 ----------------
=20
diff --git a/diff.c b/diff.c
index be6d40b..dd72d35 100644
--- a/diff.c
+++ b/diff.c
@@ -1326,8 +1326,8 @@ static void show_stats(struct diffstat_t *data, s=
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
@@ -1389,9 +1402,19 @@ static void show_stats(struct diffstat_t *data, =
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
+	number_width =3D decimal_width(max_change) > number_width ?
+		decimal_width(max_change) : number_width;
=20
 	/*
 	 * Guarantee 3/8*16=3D=3D6 for the graph part
@@ -1402,8 +1425,12 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
=20
 	/*
 	 * First assign sizes that are wanted, ignoring available width.
+	 * strlen("Bin XXX -> YYY bytes") =3D=3D bin_width, and the part
+	 * starting from "XXX" should fit in graph_width.
 	 */
-	graph_width =3D max_change < 40 ? max_change : 40;
+	graph_width =3D max_change + 4 > bin_width ? max_change : bin_width -=
 4;
+	if (graph_width > 40)
+		graph_width =3D 40;
 	name_width =3D (options->stat_name_width > 0 &&
 		      options->stat_name_width < max_len) ?
 		options->stat_name_width : max_len;
@@ -1457,7 +1484,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		if (data->files[i]->is_binary) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Bin ");
+			fprintf(options->file, " %*s ", number_width, "Bin");
 			fprintf(options->file, "%s%"PRIuMAX"%s",
 				del_c, deleted, reset);
 			fprintf(options->file, " -> ");
@@ -1470,7 +1497,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		else if (data->files[i]->is_unmerged) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Unmerged\n");
+			fprintf(options->file, " Unmerged\n");
 			continue;
 		}
=20
@@ -1488,8 +1515,9 @@ static void show_stats(struct diffstat_t *data, s=
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
index 5e29e13..77ff21c 100755
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
  2 files changed, 2 insertions(+), 0 deletions(-)
 EOF
=20
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index b981572..c8fe1a9 100755
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
index dbe2ac1..fbf064e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -443,7 +443,7 @@ test_expect_success 'stash show - stashes on stack,=
 stash-like argument' '
 	STASH_ID=3D$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
-	 file |    1 +
+	 file | 1 +
 	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
 	git stash show ${STASH_ID} >actual &&
@@ -481,7 +481,7 @@ test_expect_success 'stash show - no stashes on sta=
ck, stash-like argument' '
 	STASH_ID=3D$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
-	 file |    1 +
+	 file | 1 +
 	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
 	git stash show ${STASH_ID} >actual &&
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 2d9f9a0..9dd48bb 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -90,4 +90,23 @@ test_expect_success 'diff --no-index with binary cre=
ation' '
 	test_cmp expected actual
 '
=20
+cat >expect <<EOF
+ binfile  |   Bin 0 -> 1026 bytes
+ textfile | 10000 ++++++++++++++++++++++++++++++++++++++++
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
index 3a9f78a..b87f758 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
@@ -1,7 +1,7 @@
 $ git diff-tree --cc --patch-with-stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
=20
 diff --cc dir/sub
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_si=
de b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
index a61ad8c..47665f9 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master b/t/t=
4013/diff.diff-tree_--cc_--patch-with-stat_master
index 49f23b9..efe6dcc 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
@@ -1,7 +1,7 @@
 $ git diff-tree --cc --patch-with-stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
=20
 diff --cc dir/sub
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master b/t/t4=
013/diff.diff-tree_--cc_--stat_--summary_master
index cc6eb3b..1b465f0 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
@@ -1,6 +1,6 @@
 $ git diff-tree --cc --stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_side b/t/t401=
3/diff.diff-tree_--cc_--stat_--summary_side
index 50362be..44fcf4e 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_master b/t/t4013/diff.d=
iff-tree_--cc_--stat_master
index fae7f33..6dffb7f 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_master
@@ -1,6 +1,6 @@
 $ git diff-tree --cc --stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-w=
ith-stat_initial b/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--p=
atch-with-stat_initial
index d5c333a..a7d91c9 100644
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
  3 files changed, 8 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side b/t=
/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
index 4d30e7e..2061f37 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_i=
nitial b/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initi=
al
index 7dfa6af..71d912e 100644
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
  3 files changed, 8 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_in=
itial b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
index 43bfce2..b80dbcc 100644
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
  3 files changed, 8 insertions(+), 0 deletions(-)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial b/t/=
t4013/diff.diff-tree_--pretty_--root_--stat_initial
index 9154aa4..88cb5c9 100644
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
  3 files changed, 8 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial b/=
t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
index 1562b62..748ba93 100644
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
  3 files changed, 8 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_master b/t/t401=
3/diff.diff-tree_-c_--stat_--summary_master
index ac9f641..700c386 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_master
@@ -1,6 +1,6 @@
 $ git diff-tree -c --stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_side b/t/t4013/=
diff.diff-tree_-c_--stat_--summary_side
index 2afcca1..520aa4f 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_master b/t/t4013/diff.dif=
f-tree_-c_--stat_master
index c2fe6a9..cdc7c40 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_master
@@ -1,6 +1,6 @@
 $ git diff-tree -c --stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
- dir/sub |    2 ++
- file0   |    3 +++
+ dir/sub | 2 ++
+ file0   | 3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.diff_--patch-with-stat_-r_initial..side b/t/t=
4013/diff.diff_--patch-with-stat_-r_initial..side
index 9ed317a..abf43a9 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff_--patch-with-stat_initial..side b/t/t401=
3/diff.diff_--patch-with-stat_initial..side
index 8b50629..f88262e 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff_--stat_initial..side b/t/t4013/diff.diff=
_--stat_initial..side
index 0517b5d..17a07be 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.diff_-r_--stat_initial..side b/t/t4013/diff.d=
iff_-r_--stat_initial..side
index 245220d..54507eb 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.di=
ff_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=
=3D.diff_initial..side
index 52116d3..6996877 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index ce49bd6..d56a1a3 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 5f1b238..b76e61f 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side =
b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 4a2364a..769cf32 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-fil=
es_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numb=
ered-files_initial..master
index 43b81eb..0ee7338 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-pref=
ix=3DTESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--st=
dout_--subject-prefix=3DTESTCASE_initial..master
index ca3f60b..fbf3bd4 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 08f2301..d68e3ee 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index 07f1230..668e38f 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
index 67633d4..6b84b1b 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initi=
al..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_init=
ial..master^
index 3b4e113..d8cba57 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..=
master b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..mast=
er
index f7752eb..a2a4726 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..mas=
ter b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
index 8e67dbf..602f4b0 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t40=
13/diff.format-patch_--stdout_initial..master
index 7b89978..bcf739e 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4=
013/diff.format-patch_--stdout_initial..master^
index b7f9725..7d5ba0f 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..side b/t/t4013=
/diff.format-patch_--stdout_initial..side
index e765088..9ed0ea2 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir=
_ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index bd7f5c0..e2954d3 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -12,7 +12,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -31,7 +31,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -53,7 +53,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.l=
og_--patch-with-stat_master
index 14595a6..e417873 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
index 5a4e727..cebec52 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -12,7 +12,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -31,7 +31,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -53,7 +53,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_m=
aster b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index df0aaa9..540633f 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master=
 b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index c11b5f2c..fb289d8 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013=
/diff.log_--root_--patch-with-stat_master
index 5f0c98f..84f535d 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_mas=
ter b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index e62c368..3e89ace 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.show_--patch-with-stat_--summary_side b/t/t40=
13/diff.show_--patch-with-stat_--summary_side
index 377f2b7..38c1841 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.show_--patch-with-stat_side b/t/t4013/diff.sh=
ow_--patch-with-stat_side
index fb14c53..38f6be2 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.show_--stat_--summary_side b/t/t4013/diff.sho=
w_--stat_--summary_side
index 5bd5977..e6f30a4 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.show_--stat_side b/t/t4013/diff.show_--stat_s=
ide
index 3b22327..58ee49a 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
 $
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_maste=
r_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master=
_--_dir_
index 6a467cc..ee340b8 100644
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
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -24,7 +24,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -46,7 +46,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master b/t/t401=
3/diff.whatchanged_--patch-with-stat_master
index 1e1bbe1..4adeab7 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
index 13789f1..63a3043 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
@@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -24,7 +24,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -46,7 +46,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub |    2 ++
+ dir/sub | 2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--s=
ummary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_=
--summary_master
index e96ff1f..60f3788 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summar=
y_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_=
master
index 0291153..9b7f63f 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master b=
/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
index 9b0349c..cba8f3c 100644
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--sum=
mary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--su=
mmary_master
index c0aff68..8e24293 100644
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 9 insertions(+), 0 deletions(-)
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
  2 files changed, 5 insertions(+), 0 deletions(-)
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
  3 files changed, 8 insertions(+), 0 deletions(-)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f6ebb51..bb430ac 100755
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
@@ -906,7 +906,7 @@ test_expect_success 'preparation' "
 "
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
 |    1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaa | 1 +
 EOF
 test_expect_success 'format patch graph width defaults to 80 columns' =
'
 	git format-patch --stat --stdout -1 >output &&
@@ -915,7 +915,7 @@ test_expect_success 'format patch graph width defau=
lts to 80 columns' '
 '
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 EOF
 test_expect_success 'format patch --stat=3Dwidth with long name' '
 	git format-patch --stat=3D40 --stdout -1 >output &&
@@ -930,13 +930,13 @@ test_expect_success 'format patch --stat-width=3D=
width works with long name' '
 '
=20
 test_expect_success 'format patch --stat=3D...,name-width with long na=
me' '
-	git format-patch --stat=3D60,29 --stdout -1 >output &&
+	git format-patch --stat=3D60,32 --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'format patch --stat-name-width with long name' '
-	git format-patch --stat-name-width=3D29 --stdout -1 >output &&
+	git format-patch --stat-name-width=3D32 --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index ab0c2f0..e451f2a 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -59,13 +59,13 @@ test_expect_success TABS_IN_FILENAMES 'git diff --s=
ummary -M HEAD' '
=20
 test_expect_success TABS_IN_FILENAMES 'setup expected files' '
 cat >expect <<\EOF
- pathname.1 =3D> "Rpathname\twith HT.0"            |    0
- pathname.3 =3D> "Rpathname\nwith LF.0"            |    0
- "pathname\twith HT.3" =3D> "Rpathname\nwith LF.1" |    0
- pathname.2 =3D> Rpathname with SP.0               |    0
- "pathname\twith HT.2" =3D> Rpathname with SP.1    |    0
- pathname.0 =3D> Rpathname.0                       |    0
- "pathname\twith HT.0" =3D> Rpathname.1            |    0
+ pathname.1 =3D> "Rpathname\twith HT.0"            | 0
+ pathname.3 =3D> "Rpathname\nwith LF.0"            | 0
+ "pathname\twith HT.3" =3D> "Rpathname\nwith LF.1" | 0
+ pathname.2 =3D> Rpathname with SP.0               | 0
+ "pathname\twith HT.2" =3D> Rpathname with SP.1    | 0
+ pathname.0 =3D> Rpathname.0                       | 0
+ "pathname\twith HT.0" =3D> Rpathname.1            | 0
  7 files changed, 0 insertions(+), 0 deletions(-)
 EOF
 '
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 88c5619..6a6344c 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -85,7 +85,7 @@ test_expect_success 'status -v produces text' '
 '
=20
 cat >expect.stat <<'EOF'
- file |  Bin 2 -> 4 bytes
+ file | Bin 2 -> 4 bytes
  1 files changed, 0 insertions(+), 0 deletions(-)
 EOF
 test_expect_success 'diffstat does not run textconv' '
diff --git a/t/t4043-diff-rename-binary.sh b/t/t4043-diff-rename-binary=
=2Esh
index 0601281..ad0b2da 100755
--- a/t/t4043-diff-rename-binary.sh
+++ b/t/t4043-diff-rename-binary.sh
@@ -23,8 +23,8 @@ test_expect_success 'move the files into a "sub" dire=
ctory' '
 '
=20
 cat > expected <<\EOF
- bar =3D> sub/bar |  Bin 5 -> 5 bytes
- foo =3D> sub/foo |    0
+ bar =3D> sub/bar | Bin 5 -> 5 bytes
+ foo =3D> sub/foo |   0
  2 files changed, 0 insertions(+), 0 deletions(-)
=20
 diff --git a/bar b/sub/bar
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 8a3c63b..336df82 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -32,7 +32,7 @@ test_expect_success "-p $*" "
 check_stat() {
 expect=3D$1; shift
 cat >expected <<EOF
- $expect |    1 +
+ $expect | 1 +
  1 files changed, 1 insertions(+), 0 deletions(-)
 EOF
 test_expect_success "--stat $*" "
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 29e80a5..75eaf16 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -252,41 +252,41 @@ EOF
 '
=20
 cat <<EOF >expect_diff_stat
- changed/text             |    2 +-
- dst/copy/changed/text    |   10 ++++++++++
- dst/copy/rearranged/text |   10 ++++++++++
- dst/copy/unchanged/text  |   10 ++++++++++
- dst/move/changed/text    |   10 ++++++++++
- dst/move/rearranged/text |   10 ++++++++++
- dst/move/unchanged/text  |   10 ++++++++++
- rearranged/text          |    2 +-
- src/move/changed/text    |   10 ----------
- src/move/rearranged/text |   10 ----------
- src/move/unchanged/text  |   10 ----------
+ changed/text             |  2 +-
+ dst/copy/changed/text    | 10 ++++++++++
+ dst/copy/rearranged/text | 10 ++++++++++
+ dst/copy/unchanged/text  | 10 ++++++++++
+ dst/move/changed/text    | 10 ++++++++++
+ dst/move/rearranged/text | 10 ++++++++++
+ dst/move/unchanged/text  | 10 ++++++++++
+ rearranged/text          |  2 +-
+ src/move/changed/text    | 10 ----------
+ src/move/rearranged/text | 10 ----------
+ src/move/unchanged/text  | 10 ----------
  11 files changed, 62 insertions(+), 32 deletions(-)
 EOF
=20
 cat <<EOF >expect_diff_stat_M
- changed/text                      |    2 +-
- dst/copy/changed/text             |   10 ++++++++++
- dst/copy/rearranged/text          |   10 ++++++++++
- dst/copy/unchanged/text           |   10 ++++++++++
- {src =3D> dst}/move/changed/text    |    2 +-
- {src =3D> dst}/move/rearranged/text |    2 +-
- {src =3D> dst}/move/unchanged/text  |    0
- rearranged/text                   |    2 +-
+ changed/text                      |  2 +-
+ dst/copy/changed/text             | 10 ++++++++++
+ dst/copy/rearranged/text          | 10 ++++++++++
+ dst/copy/unchanged/text           | 10 ++++++++++
+ {src =3D> dst}/move/changed/text    |  2 +-
+ {src =3D> dst}/move/rearranged/text |  2 +-
+ {src =3D> dst}/move/unchanged/text  |  0
+ rearranged/text                   |  2 +-
  8 files changed, 34 insertions(+), 4 deletions(-)
 EOF
=20
 cat <<EOF >expect_diff_stat_CC
- changed/text                      |    2 +-
- {src =3D> dst}/copy/changed/text    |    2 +-
- {src =3D> dst}/copy/rearranged/text |    2 +-
- {src =3D> dst}/copy/unchanged/text  |    0
- {src =3D> dst}/move/changed/text    |    2 +-
- {src =3D> dst}/move/rearranged/text |    2 +-
- {src =3D> dst}/move/unchanged/text  |    0
- rearranged/text                   |    2 +-
+ changed/text                      | 2 +-
+ {src =3D> dst}/copy/changed/text    | 2 +-
+ {src =3D> dst}/copy/rearranged/text | 2 +-
+ {src =3D> dst}/copy/unchanged/text  | 0
+ {src =3D> dst}/move/changed/text    | 2 +-
+ {src =3D> dst}/move/rearranged/text | 2 +-
+ {src =3D> dst}/move/unchanged/text  | 0
+ rearranged/text                   | 2 +-
  8 files changed, 6 insertions(+), 6 deletions(-)
 EOF
=20
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 641e70d..5edac4e 100755
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
 	 2 files changed, 2 insertions(+), 0 deletions(-)
 	EOF
 	git diff --stat --stat-count=3D2 >actual &&
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
index 61f36ba..5a86e24 100755
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
  3 files changed, 3 insertions(+), 0 deletions(-)
  create mode 100644 c2.c
  create mode 100644 c3.c
@@ -73,7 +73,7 @@ cat >expected <<\EOF
 Already up-to-date with c4
 Trying simple merge with c5
 Merge made by the 'octopus' strategy.
- c5.c |    1 +
+ c5.c | 1 +
  1 files changed, 1 insertions(+), 0 deletions(-)
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
  2 files changed, 2 insertions(+), 0 deletions(-)
  create mode 100644 c1.c
  create mode 100644 c2.c
--=20
1.7.9.5.g91d5
