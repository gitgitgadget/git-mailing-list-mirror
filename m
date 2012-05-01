From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 3/4] diff --stat: report chmoded binary files like text files
Date: Tue,  1 May 2012 19:10:14 +0200
Message-ID: <1335892215-21331-4-git-send-email-zbyszek@in.waw.pl>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mj@ucw.cz,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 01 19:11:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGbd-0003Tc-TI
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab2EARLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:11:13 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35796 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2EARLN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:11:13 -0400
Received: from ip-37-209-134-178.free.aero2.net.pl ([37.209.134.178] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPGbX-0003uH-9s; Tue, 01 May 2012 19:11:12 +0200
X-Mailer: git-send-email 1.7.10.539.g288dd
In-Reply-To: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196701>

Binary files chmoded without content change were reported as if they
were rewritten. At the same time, text files in the same situation
were reported as "unchanged". Let's treat binary files like text files
here, and simply say that they are unchanged.

=46or text files, we knew that they were unchanged if the numbers of
lines added and deleted were both 0. For binary files this metric does
not make sense and is not calculated, so a new way of conveying this
information is needed. A new flag is_unchanged is added in struct
diffstat_t that is set if the contents of both files are identical.
=46or consistency, this new flag is used both for text files and binary
files.

Output of --shortstat is modified in the same way.

Reported-by: Martin Mare=C5=A1 <mj@ucw.cz>
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 diff.c               |   28 +++++++++++++++++-----------
 t/t4006-diff-mode.sh |    8 +-------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index 7da16c9..6eb2946 100644
--- a/diff.c
+++ b/diff.c
@@ -1299,6 +1299,7 @@ struct diffstat_t {
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
+		unsigned is_unchanged:1;
 		uintmax_t added, deleted;
 	} **files;
 };
@@ -1471,7 +1472,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		struct diffstat_file *file =3D data->files[i];
 		uintmax_t change =3D file->added + file->deleted;
 		if (!data->files[i]->is_renamed &&
-			 (change =3D=3D 0)) {
+		    data->files[i]->is_unchanged) {
 			count++; /* not shown =3D=3D room for one more */
 			continue;
 		}
@@ -1565,7 +1566,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		int name_len;
=20
 		if (!data->files[i]->is_renamed &&
-			 (added + deleted =3D=3D 0)) {
+		    data->files[i]->is_unchanged) {
 			total_files--;
 			continue;
 		}
@@ -1587,8 +1588,12 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
 		if (data->files[i]->is_binary) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
-			fprintf(options->file, "  Bin ");
-			fprintf(options->file, "%s%"PRIuMAX"%s",
+			fprintf(options->file, "  Bin");
+			if (data->files[i]->is_unchanged) {
+				fprintf(options->file, "\n");
+				continue;
+			}
+			fprintf(options->file, " %s%"PRIuMAX"%s",
 				del_c, deleted, reset);
 			fprintf(options->file, " -> ");
 			fprintf(options->file, "%s%"PRIuMAX"%s",
@@ -1661,16 +1666,15 @@ static void show_shortstats(struct diffstat_t *=
data, struct diff_options *option
 		return;
=20
 	for (i =3D 0; i < data->nr; i++) {
-		if (!data->files[i]->is_binary &&
-		    !data->files[i]->is_unmerged) {
-			int added =3D data->files[i]->added;
-			int deleted=3D data->files[i]->deleted;
+		if (!data->files[i]->is_unmerged) {
 			if (!data->files[i]->is_renamed &&
-			    (added + deleted =3D=3D 0)) {
+			    data->files[i]->is_unchanged) {
 				total_files--;
+			} else if (data->files[i]->is_binary) {
+				; /* do nothing */
 			} else {
-				adds +=3D added;
-				dels +=3D deleted;
+				adds +=3D data->files[i]->added;
+				dels +=3D data->files[i]->deleted;
 			}
 		}
 	}
@@ -2379,6 +2383,8 @@ static void builtin_diffstat(const char *name_a, =
const char *name_b,
 		return;
 	}
=20
+	data->is_unchanged =3D hashcmp(one->sha1, two->sha1) =3D=3D 0;
+
 	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
 		data->is_binary =3D 1;
 		data->added =3D diff_filespec_size(two);
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index a81c095..e85a1d6 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -46,18 +46,12 @@ test_expect_success '--shortstat output after text =
chmod' '
=20
 test_expect_success '--stat output after binary chmod' '
 	test_chmod +x binbin &&
-	cat >expect <<-EOF &&
-	 binbin |  Bin 1024 -> 1024 bytes
-	 1 file changed, 0 insertions(+), 0 deletions(-)
-	EOF
+	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success '--shortstat output after binary chmod' '
-	cat >expect <<-EOF &&
-	 1 file changed, 0 insertions(+), 0 deletions(-)
-	EOF
 	git diff HEAD --shortstat >actual &&
 	test_cmp expect actual
 '
--=20
1.7.10.539.g288dd
