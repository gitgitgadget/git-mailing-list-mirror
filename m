From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] more tests for git rev-parse --parse-opt
Date: Sun, 14 Jun 2009 01:58:42 +0200
Message-ID: <1244937523-6194-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090610141614.GA20299@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 01:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFd87-0002il-CR
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 01:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbZFMX7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2009 19:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbZFMX7M
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 19:59:12 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46766 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZFMX7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 19:59:11 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MFd7V-0001Of-Cq; Sun, 14 Jun 2009 01:59:12 +0200
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <20090610141614.GA20299@pengutronix.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121528>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 t/t1502-rev-parse-parseopt.sh |   38 +++++++++++++++++++++++++++++++++=
+++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index 997002d..be0959e 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -20,8 +20,7 @@ Extras
=20
 EOF
=20
-test_expect_success 'test --parseopt help output' '
-	git rev-parse --parseopt -- -h 2> output.err <<EOF
+cat > optionspec << EOF
 some-command [options] <args>...
=20
 some-command does foo and bar!
@@ -37,7 +36,42 @@ C?        option C with an optional argument
 Extras
 extra1    line above used to cause a segfault but no longer does
 EOF
+
+test_expect_success 'test --parseopt help output' '
+	git rev-parse --parseopt -- -h 2> output.err < optionspec
 	test_cmp expect.err output.err
 '
=20
+cat > expect <<EOF
+set -- --foo --bar 'ham' -- 'arg'
+EOF
+
+test_expect_success 'test --parseopt' '
+	git rev-parse --parseopt -- --foo --bar=3Dham arg < optionspec > outp=
ut &&
+	test_cmp expect output
+'
+
+test_expect_success 'test --parseopt with mixed options and arguments'=
 '
+	git rev-parse --parseopt -- --foo arg --bar=3Dham < optionspec > outp=
ut &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --foo -- 'arg' '--bar=3Dham'
+EOF
+
+test_expect_success 'test --parseopt with --' '
+	git rev-parse --parseopt -- --foo -- arg --bar=3Dham < optionspec > o=
utput &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --foo -- '--' 'arg' '--bar=3Dham'
+EOF
+
+test_expect_success 'test --parseopt --keep-dashdash' '
+	git rev-parse --parseopt --keep-dashdash -- --foo -- arg --bar=3Dham =
< optionspec > output &&
+	test_cmp expect output
+'
+
 test_done
--=20
1.6.3.1
