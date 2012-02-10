From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 3/3] diff --stat: use the real terminal width
Date: Fri, 10 Feb 2012 17:39:32 +0100
Message-ID: <1328891972-23695-4-git-send-email-zbyszek@in.waw.pl>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
 <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 10 17:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvtWn-0000tp-5M
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 17:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759379Ab2BJQkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 11:40:46 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52369 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757501Ab2BJQkp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 11:40:45 -0500
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RvtWe-0000kd-CL; Fri, 10 Feb 2012 17:40:44 +0100
X-Mailer: git-send-email 1.7.9.263.g8cced
In-Reply-To: <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190418>

Some projects (especially in Java), have long filename paths, with
nested directories or long individual filenames. When files are
renamed, the stat output can be almost useless. If the middle part
between { and } is long (because the file was moved to a completely
different directory), then most of the path would be truncated.

It makes sense to use the full terminal width.

If commits changing a lot of lines are displayed in a wide terminal
window (200 or more columns), and the +- graph uses the full width,
the output looks bad. Messages wrapped to about 80 columns are
interspersed with very long +- lines. It makes sense to limit the
width of the graph to a fixed value, even if more columns are
available. This fixed value is subjectively hard-coded to be 40
columns, but seems to work well for git.git and linux-2.6.git and
other repositories.

Three tests are added: the first one check that --stat output for a
long file name is the same as previously (the test should pass
independently of this patch). The last two check that --stat output
with a massive change uses only 40 columns for +- in graph output.
Those two tests are dependent on this patch.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 diff.c                  |   26 ++++++++++++++------------
 t/t4014-format-patch.sh |   40 +++++++++++++++++++++++++++++++++++++++=
+
 2 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 84780fd..8176d74 100644
--- a/diff.c
+++ b/diff.c
@@ -7,6 +7,7 @@
 #include "diffcore.h"
 #include "delta.h"
 #include "xdiff-interface.h"
+#include "help.h"
 #include "color.h"
 #include "attr.h"
 #include "run-command.h"
@@ -1376,7 +1377,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	int i, len, add, del, adds =3D 0, dels =3D 0;
 	uintmax_t max_change =3D 0, max_len =3D 0;
 	int total_files =3D data->nr;
-	int width, name_width, count;
+	int width, name_width, graph_width, count;
 	const char *reset, *add_c, *del_c;
 	const char *line_prefix =3D "";
 	int extra_shown =3D 0;
@@ -1390,8 +1391,9 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		line_prefix =3D msg->buf;
 	}
=20
-	width =3D options->stat_width ? options->stat_width : 80;
-	name_width =3D options->stat_name_width ? options->stat_name_width : =
50;
+	width =3D options->stat_width ? options->stat_width : term_columns();
+	name_width =3D options->stat_name_width ? options->stat_name_width
+		: width * 5/8; /* this gives 50 if not on tty */
 	count =3D options->stat_count ? options->stat_count : data->nr;
=20
 	/* Sanity: give at least 5 columns to the graph,
@@ -1433,14 +1435,14 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 	 * 10 is for one blank at the beginning of the line plus
 	 * " | count " between the name and the graph.
 	 *
-	 * From here on, name_width is the width of the name area,
-	 * and width is the width of the graph area.
+	 * From here name_width is the width of the name area,
+	 * and graph_width is the width of the graph area.
+	 * max_change is used to scale graph properly.
 	 */
 	name_width =3D (name_width < max_len) ? name_width : max_len;
-	if (width < (name_width + 10) + max_change)
-		width =3D width - (name_width + 10);
-	else
-		width =3D max_change;
+	graph_width =3D max_change < 40 ? max_change : 40;
+	if (width < (name_width + 10) + graph_width)
+		graph_width =3D width - (name_width + 10);
=20
 	for (i =3D 0; i < count; i++) {
 		const char *prefix =3D "";
@@ -1497,9 +1499,9 @@ static void show_stats(struct diffstat_t *data, s=
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
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7dfe716..bd3002b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -894,4 +894,44 @@ test_expect_success 'format patch ignores color.ui=
' '
 	test_cmp expect actual
 '
=20
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |	 1 +
+EOF
+name=3Daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+test_expect_success 'format patch filename width is limited' "
+	> ${name} &&
+	git add ${name} &&
+	git commit -m message &&
+	echo a > ${name} &&
+	git commit -m message ${name} &&
+	git format-patch --stat --stdout -1 |
+		grep -m 1 aaaaa > actual &&
+	test_cmp expect actual
+"
+
+cat >expect <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
+EOF
+test_expect_success 'format patch graph width is 40 columns' '
+	> abcd &&
+	git add abcd &&
+	git commit -m message &&
+	seq 1000 > abcd &&
+	git commit -m message abcd &&
+	git format-patch --stat --stdout -1 |
+		grep -m 1 abcd > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format patch ignores COLUMNS' '
+	> abcd &&
+	git add abcd &&
+	git commit -m message &&
+	seq 1000 > abcd &&
+	git commit -m message abcd &&
+	COLUMNS=3D200 git format-patch --stat --stdout -1 |
+		grep -m 1 abcd > actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.9.263.g4be11.dirty
