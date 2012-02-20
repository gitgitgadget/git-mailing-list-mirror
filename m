From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 3/8 v6] diff --stat: use the full terminal width
Date: Mon, 20 Feb 2012 22:57:09 +0100
Message-ID: <1329775034-21551-4-git-send-email-zbyszek@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 20 22:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbFH-0004NN-JT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab2BTV6C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 16:58:02 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52841 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091Ab2BTV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 16:58:00 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RzbF9-0007o6-9D; Mon, 20 Feb 2012 22:57:59 +0100
X-Mailer: git-send-email 1.7.9.1.353.g684b4
In-Reply-To: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191111>

Default to the real terminal width for diff --stat output, instead
of the hard-coded 80 columns.

Some projects (especially in Java), have long filename paths, with
nested directories or long individual filenames. When files are
renamed, the filename part in stat output can be almost useless. If
the middle part between { and } is long (because the file was moved to
a completely different directory), then most of the path would be
truncated.

It makes sense to detect and use the full terminal width and display
full filenames if possible.

The are commands like diff, show, and log, which can adapt the output
to the terminal width. There are also commands like format-patch,
whose output should be independent of the terminal width. Since it is
safer to use the 80-column default, the real terminal width is only
used if requested by the calling code by setting diffopts.stat_width=3D=
-1.
Normally this value is 0, and can be set by the user only to a
non-negative value, so -1 is safe to use internally.

This patch only changes the diff builtin to use the full terminal width=
=2E

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 builtin/diff.c         |  3 +++
 diff.c                 |  5 ++++-
 t/t4052-stat-output.sh | 11 +++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git builtin/diff.c builtin/diff.c
index 387afa7..81b6bae 100644
--- builtin/diff.c
+++ builtin/diff.c
@@ -285,6 +285,9 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
=20
+	/* Scale to real terminal size */
+	rev.diffopt.stat_width =3D -1;
+
 	/* Default to let external and textconv be used */
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
diff --git diff.c diff.c
index 01c15da..1db46a4 100644
--- diff.c
+++ diff.c
@@ -1389,7 +1389,10 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
 		line_prefix =3D msg->buf;
 	}
=20
-	width =3D options->stat_width ? options->stat_width : 80;
+	if (options->stat_width =3D=3D -1)
+		width =3D term_columns();
+	else
+		width =3D options->stat_width ? options->stat_width : 80;
 	name_width =3D options->stat_name_width ? options->stat_name_width : =
50;
 	count =3D options->stat_count ? options->stat_count : data->nr;
=20
diff --git t/t4052-stat-output.sh t/t4052-stat-output.sh
index 031107b..4bfd6a5 100755
--- t/t4052-stat-output.sh
+++ t/t4052-stat-output.sh
@@ -81,6 +81,10 @@ cat >expect80 <<'EOF'
  abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 EOF
=20
+cat >expect200 <<'EOF'
+ abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
+
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (big change)" '
@@ -90,7 +94,7 @@ do
 	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
-ignores expect80 diff HEAD^ HEAD --stat
+respects expect200 diff HEAD^ HEAD --stat
 ignores expect80 show --stat
 ignores expect80 log -1 --stat
 EOF
@@ -146,6 +150,9 @@ EOF
 cat >expect80 <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
 EOF
+cat >expect200 <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (long filename)" '
@@ -155,7 +162,7 @@ do
 	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
-ignores expect80 diff HEAD^ HEAD --stat
+respects expect200 diff HEAD^ HEAD --stat
 ignores expect80 show --stat
 ignores expect80 log -1 --stat
 EOF
--=20
1.7.9.1.353.g684b4
