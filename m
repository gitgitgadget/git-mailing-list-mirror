From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] parse-opt: make PARSE_OPT_STOP_AT_NON_OPTION available to git rev-parse
Date: Sun, 14 Jun 2009 01:58:43 +0200
Message-ID: <1244937523-6194-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090610141614.GA20299@pengutronix.de>
 <1244937523-6194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 01:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFd88-0002il-09
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 01:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207AbZFMX7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2009 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016AbZFMX7Q
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 19:59:16 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46772 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbZFMX7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 19:59:15 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MFd7x-0001P9-QY; Sun, 14 Jun 2009 01:59:17 +0200
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244937523-6194-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121529>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/git-rev-parse.txt |    5 +++++
 builtin-rev-parse.c             |    8 ++++++--
 t/t1502-rev-parse-parseopt.sh   |    5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 4bbdd05..82045a2 100644
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
 --sq-quote::
 	Use 'git-rev-parse' in shell quoting mode (see SQ-QUOTE
 	section below). In contrast to the `--sq` option below, this
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 112d622..5ea7518 100644
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
 	argc =3D parse_options(argc, argv, prefix, opts, usage,
-	                     keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0);
+			keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0 |
+			stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0);
=20
 	strbuf_addf(&parsed, " --");
 	sq_quote_argv(&parsed, argv, 0);
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index be0959e..e504058 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -65,6 +65,11 @@ test_expect_success 'test --parseopt with --' '
 	test_cmp expect output
 '
=20
+test_expect_success 'test --parseopt --stop-at-non-option' '
+	git rev-parse --parseopt --stop-at-non-option -- --foo arg --bar=3Dha=
m < optionspec > output &&
+	test_cmp expect output
+'
+
 cat > expect <<EOF
 set -- --foo -- '--' 'arg' '--bar=3Dham'
 EOF
--=20
1.6.3.1
