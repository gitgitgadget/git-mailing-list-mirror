From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 7.3/8] diff --stat: limit graph part to 40 columns
Date: Wed, 22 Feb 2012 12:51:46 +0100
Message-ID: <1329911507-10587-3-git-send-email-zbyszek@in.waw.pl>
References: <4F44D084.7030308@in.waw.pl>
 <1329911507-10587-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 22 12:52:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Ak3-0006Ga-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 12:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab2BVLwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 06:52:09 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55005 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab2BVLwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 06:52:07 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S0Aju-0007d7-Nk; Wed, 22 Feb 2012 12:52:06 +0100
X-Mailer: git-send-email 1.7.9.1.355.ge8a9f
In-Reply-To: <1329911507-10587-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191250>

The way that available columns are divided between the filename part
and the graph part is modified to use as many columns as necessary for
the filenames and up to 40 columns for the graph.

If commits changing a lot of lines are displayed in a wide terminal
window (200 or more columns), and the +- graph would use the full
width, the output would look bad. Messages wrapped to about 80 columns
would be interspersed with very long +- lines. It makes sense to limit
the width of the graph part to a fixed value, even if more columns are
available. This fixed value is subjectively hard-coded to be 40
columns, which seems to work well for git.git and linux-2.6.git and
some other repositories.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 Documentation/diff-options.txt |  2 +-
 diff.c                         |  8 ++++++--
 t/t4052-stat-output.sh         | 16 ++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git Documentation/diff-options.txt Documentation/diff-options.tx=
t
index 29647e5..e4d0e3e 100644
--- Documentation/diff-options.txt
+++ Documentation/diff-options.txt
@@ -54,7 +54,7 @@ endif::git-format-patch[]
=20
 --stat[=3D<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
-	will be used for the filename part, and the rest for
+	will be used for the filename part, and up to 40 columns for
 	the graph part. Maximum width defaults to terminal width,
 	or 80 columns if not connected to a terminal, and can be
 	overriden by `<width>`. The width of the filename part can be
diff --git diff.c diff.c
index f1c278f..8a9a387 100644
--- diff.c
+++ diff.c
@@ -1421,13 +1421,15 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 	/*
 	 * We have width =3D stat_width or term_columns() columns total.
 	 * We want a maximum of min(max_len, stat_name_width) for the name pa=
rt.
+	 * We want a maximum of min(max_change, 40) for the +- part.
 	 * We also need 1 for " " and 4 + decimal_width(max_change)
 	 * for " | NNNN " and one the empty column at the end, altogether
 	 * 6 + decimal_width(max_change).
 	 *
 	 * If there's not enough space, we will use the smaller of
 	 * stat_name_width (if set) and 5/8*width for the filename,
-	 * and the rest for constant elements + graph part.
+	 * and the rest for constant elements + graph part, but no more
+	 * than 40 for the graph part.
 	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
 	 * for the standard terminal size).
 	 *
@@ -1452,7 +1454,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	/*
 	 * First assign sizes that are wanted, ignoring available width.
 	 */
-	graph_width =3D max_change;
+	graph_width =3D max_change < 40 ? max_change : 40;
 	name_width =3D (options->stat_name_width > 0 &&
 		      options->stat_name_width < max_len) ?
 		options->stat_name_width : max_len;
@@ -1463,6 +1465,8 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	if (name_width + number_width + 6 + graph_width > width) {
 		if (graph_width > width * 3/8 - number_width - 6)
 			graph_width =3D width * 3/8 - number_width - 6;
+		if (graph_width > 40)
+			graph_width =3D  40;
 		if (name_width > width - number_width - 6 - graph_width)
 			name_width =3D width - number_width - 6 - graph_width;
 		else
diff --git t/t4052-stat-output.sh t/t4052-stat-output.sh
index 84be8bd..1b237b7 100755
--- t/t4052-stat-output.sh
+++ t/t4052-stat-output.sh
@@ -78,11 +78,7 @@ test_expect_success 'preparation for big change test=
s' '
 '
=20
 cat >expect80 <<'EOF'
- abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
-EOF
-
-cat >expect200 <<'EOF'
- abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
 EOF
=20
 while read verb expect cmd args
@@ -94,9 +90,9 @@ do
 	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
-respects expect200 diff HEAD^ HEAD --stat
-respects expect200 show --stat
-respects expect200 log -1 --stat
+respects expect80 diff HEAD^ HEAD --stat
+respects expect80 show --stat
+respects expect80 log -1 --stat
 EOF
=20
 cat >expect40 <<'EOF'
@@ -170,7 +166,7 @@ cat >expect80 <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
 EOF
 cat >expect200 <<'EOF'
- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
++++++++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
@@ -187,7 +183,7 @@ respects expect200 log -1 --stat
 EOF
=20
 cat >expect <<'EOF'
- abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
 EOF
 test_expect_success 'merge --stat respects COLUMNS (big change)' '
 	git checkout -b branch HEAD^^ &&
--=20
1.7.9.1.355.ge8a9f
