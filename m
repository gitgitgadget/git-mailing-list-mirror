From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] parse-opt: make PARSE_OPT_STOP_AT_NON_OPTION available to git rev-parse
Date: Tue, 28 Apr 2009 22:29:23 +0200
Message-ID: <1240950564-15124-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 22:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LytwT-0000eP-PZ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 22:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZD1U3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZD1U3b
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 16:29:31 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43718 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZD1U3a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 16:29:30 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lytvi-0000Ag-FG; Tue, 28 Apr 2009 22:29:29 +0200
X-Mailer: git-send-email 1.6.2.4
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117806>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/git-rev-parse.txt |    5 +++++
 builtin-rev-parse.c             |    8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index fba30b1..8d3ba14 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -30,6 +30,11 @@ OPTIONS
 	Only meaningful in `--parseopt` mode. Tells the option parser to echo
 	out the first `--` met instead of skipping it.
=20
+--stop-at-non-option::
+	Only meaningful in `--parseopt` mode.  Lets the option parser stop at
+	the first non-option argument.  This can be used to parse sub-command=
s
+	that take options themself.
+
 --revs-only::
 	Do not output flags and parameters not meant for
 	'git-rev-list' command.
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 22c6d6a..864f13d 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -301,7 +301,7 @@ static const char *skipspaces(const char *s)
=20
 static int cmd_parseopt(int argc, const char **argv, const char *prefi=
x)
 {
-	static int keep_dashdash =3D 0;
+	static int keep_dashdash =3D 0, stop_at_non_option =3D 0;
 	static char const * const parseopt_usage[] =3D {
 		"git rev-parse --parseopt [options] -- [<args>...]",
 		NULL
@@ -309,6 +309,9 @@ static int cmd_parseopt(int argc, const char **argv=
, const char *prefix)
 	static struct option parseopt_opts[] =3D {
 		OPT_BOOLEAN(0, "keep-dashdash", &keep_dashdash,
 					"keep the `--` passed as an arg"),
+		OPT_BOOLEAN(0, "stop-at-non-option", &stop_at_non_option,
+					"stop parsing after the "
+					"first non-option argument"),
 		OPT_END(),
 	};
=20
@@ -394,7 +397,8 @@ static int cmd_parseopt(int argc, const char **argv=
, const char *prefix)
 	ALLOC_GROW(opts, onb + 1, osz);
 	memset(opts + onb, 0, sizeof(opts[onb]));
 	argc =3D parse_options(argc, argv, opts, usage,
-	                     keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0);
+			keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0 |
+			stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0);
=20
 	strbuf_addf(&parsed, " --");
 	sq_quote_argv(&parsed, argv, 0);
--=20
1.6.2.4
