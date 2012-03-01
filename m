From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7a 8/9] diff --stat: enable limiting of the graph part
Date: Thu,  1 Mar 2012 13:26:45 +0100
Message-ID: <1330604806-30288-8-git-send-email-zbyszek@in.waw.pl>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
 <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 01 13:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S35AA-0006v2-1l
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030833Ab2CAMbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:31:00 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55395 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030800Ab2CAMa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 07:30:59 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S359u-00026K-D4; Thu, 01 Mar 2012 13:30:58 +0100
X-Mailer: git-send-email 1.7.9.2.399.gdf4d.dirty
In-Reply-To: <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191926>

A new option --stat-graph-width=3D<width> can be used to limit the widt=
h
of the graph part even is more space is available. Up to <width>
columns will be used for the graph.

If commits changing a lot of lines are displayed in a wide terminal
window (200 or more columns), and the +- graph uses the full width,
the output can be hard to comfortably scan with a horizontal movement
of human eyes. Messages wrapped to about 80 columns would be
interspersed with very long +- lines. It makes sense to limit the
width of the graph part to a fixed value (e.g. 70 columns), even if
more columns are available.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |    2 ++
 diff.c                         |   23 +++++++++++++++++++++--
 diff.h                         |    1 +
 t/t4052-stat-output.sh         |    6 ++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 6b9408f..d34efd5 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -59,6 +59,8 @@ endif::git-format-patch[]
 	or 80 columns if not connected to a terminal, and can be
 	overriden by `<width>`. The width of the filename part can be
 	limited by giving another width `<name-width>` after a comma.
+	The width of the graph part can be limited by using
+	`--stat-graph-width=3D<width>`.
 	By giving a third parameter `<count>`, you can limit the
 	output to the first `<count>` lines, followed by `...` if
 	there are more.
diff --git a/diff.c b/diff.c
index 1656310..8f2abc8 100644
--- a/diff.c
+++ b/diff.c
@@ -1375,13 +1375,15 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 	/*
 	 * We have width =3D stat_width or term_columns() columns total.
 	 * We want a maximum of min(max_len, stat_name_width) for the name pa=
rt.
+	 * We want a maximum of min(max_change, stat_graph_width) for the +- =
part.
 	 * We also need 1 for " " and 4 + decimal_width(max_change)
 	 * for " | NNNN " and one the empty column at the end, altogether
 	 * 6 + decimal_width(max_change).
 	 *
 	 * If there's not enough space, we will use the smaller of
 	 * stat_name_width (if set) and 5/8*width for the filename,
-	 * and the rest for constant elements + graph part.
+	 * and the rest for constant elements + graph part, but no more
+	 * than stat_graph_width for the graph part.
 	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
 	 * for the standard terminal size).
 	 *
@@ -1406,7 +1408,9 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	/*
 	 * First assign sizes that are wanted, ignoring available width.
 	 */
-	graph_width =3D max_change;
+	graph_width =3D (options->stat_graph_width &&
+		       options->stat_graph_width < max_change) ?
+		options->stat_graph_width : max_change;
 	name_width =3D (options->stat_name_width > 0 &&
 		      options->stat_name_width < max_len) ?
 		options->stat_name_width : max_len;
@@ -1417,6 +1421,9 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	if (name_width + number_width + 6 + graph_width > width) {
 		if (graph_width > width * 3/8 - number_width - 6)
 			graph_width =3D width * 3/8 - number_width - 6;
+		if (options->stat_graph_width &&
+		    graph_width > options->stat_graph_width)
+			graph_width =3D options->stat_graph_width;
 		if (name_width > width - number_width - 6 - graph_width)
 			name_width =3D width - number_width - 6 - graph_width;
 		else
@@ -3289,6 +3296,7 @@ static int stat_opt(struct diff_options *options,=
 const char **av)
 	char *end;
 	int width =3D options->stat_width;
 	int name_width =3D options->stat_name_width;
+	int graph_width =3D options->stat_graph_width;
 	int count =3D options->stat_count;
 	int argcount =3D 1;
=20
@@ -3317,6 +3325,16 @@ static int stat_opt(struct diff_options *options=
, const char **av)
 				name_width =3D strtoul(av[1], &end, 10);
 				argcount =3D 2;
 			}
+		} else if (!prefixcmp(arg, "-graph-width")) {
+			arg +=3D strlen("-graph-width");
+			if (*arg =3D=3D '=3D')
+				graph_width =3D strtoul(arg + 1, &end, 10);
+			else if (!*arg && !av[1])
+				die("Option '--stat-graph-width' requires a value");
+			else if (!*arg) {
+				graph_width =3D strtoul(av[1], &end, 10);
+				argcount =3D 2;
+			}
 		} else if (!prefixcmp(arg, "-count")) {
 			arg +=3D strlen("-count");
 			if (*arg =3D=3D '=3D')
@@ -3342,6 +3360,7 @@ static int stat_opt(struct diff_options *options,=
 const char **av)
 		return 0;
 	options->output_format |=3D DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width =3D name_width;
+	options->stat_graph_width =3D graph_width;
 	options->stat_width =3D width;
 	options->stat_count =3D count;
 	return argcount;
diff --git a/diff.h b/diff.h
index ae71f4c..2021a1d 100644
--- a/diff.h
+++ b/diff.h
@@ -129,6 +129,7 @@ struct diff_options {
=20
 	int stat_width;
 	int stat_name_width;
+	int stat_graph_width;
 	int stat_count;
 	const char *word_regex;
 	enum diff_words_type word_diff;
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 9a8f62d..3d823af 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -136,6 +136,12 @@ do
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success "$cmd --stat-graph--width with big change" '
+		git $cmd $args --stat-graph-width=3D26 >output
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
 done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
--=20
1.7.9.2.399.gdf4d.dirty
