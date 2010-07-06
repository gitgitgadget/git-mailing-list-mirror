From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] rev-parse: fix --parse-opt --keep-dashdash --stop-at-non-option
Date: Tue,  6 Jul 2010 16:46:05 +0200
Message-ID: <1278427565-11057-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 16:46:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9Pg-0006Qv-VJ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 16:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab0GFOqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 10:46:15 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38529 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab0GFOqO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 10:46:14 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OW9PW-00077T-Mk; Tue, 06 Jul 2010 16:46:13 +0200
X-Mailer: git-send-email 1.7.1
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=4.5 tests=BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.3.1
X-SA-Exim-Version: 4.2.1 (built Mon, 22 Mar 2010 06:51:10 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150357>

The ?: operator has a lower priority than |, so the implicit associativ=
ity
made the 6th argument of parse_options be PARSE_OPT_KEEP_DASHDASH if
keep_dashdash was true discarding PARSE_OPT_STOP_AT_NON_OPTION and
PARSE_OPT_SHELL_EVAL.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 builtin/rev-parse.c           |    4 ++--
 t/t1502-rev-parse-parseopt.sh |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b676e29..a5a1c86 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -407,8 +407,8 @@ static int cmd_parseopt(int argc, const char **argv=
, const char *prefix)
 	ALLOC_GROW(opts, onb + 1, osz);
 	memset(opts + onb, 0, sizeof(opts[onb]));
 	argc =3D parse_options(argc, argv, prefix, opts, usage,
-			keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0 |
-			stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0 |
+			(keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0) |
+			(stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0) |
 			PARSE_OPT_SHELL_EVAL);
=20
 	strbuf_addf(&parsed, " --");
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index 4346795..17c210c 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -81,4 +81,21 @@ test_expect_success 'test --parseopt --keep-dashdash=
' '
 	test_cmp expect output
 '
=20
+cat > expect <<EOF
+set -- --foo -- '--' 'arg' '--spam=3Dham'
+EOF
+
+test_expect_success 'test --parseopt --keep-dashdash --stop-at-non-opt=
ion with --' '
+	git rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --fo=
o -- arg --spam=3Dham < optionspec > output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --foo -- 'arg' '--spam=3Dham'
+EOF
+
+test_expect_success 'test --parseopt --keep-dashdash --stop-at-non-opt=
ion without --' '
+	git rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --fo=
o arg --spam=3Dham < optionspec > output &&
+	test_cmp expect output
+'
 test_done
--=20
1.7.1
