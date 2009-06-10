From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] more tests for git rev-parse --parse-opt
Date: Wed, 10 Jun 2009 11:42:05 +0200
Message-ID: <1244626926-19841-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <7vzlcgr088.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 11:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEKPH-0004Rg-VI
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 11:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760167AbZFJJmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbZFJJms
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 05:42:48 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34915 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760167AbZFJJmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 05:42:46 -0400
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MEKJr-0000Wx-QD; Wed, 10 Jun 2009 11:42:45 +0200
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <7vzlcgr088.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121266>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I'm not completely sure that it's portable to use input redirection and
&& together---at least it looks a bit ugly.  Probably you know better.

Best regards
Uwe

 t/t1502-rev-parse-parseopt.sh |   48 +++++++++++++++++++++++++++++++++=
++++++-
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index 997002d..081812b 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -20,8 +20,7 @@ Extras
=20
 EOF
=20
-test_expect_success 'test --parseopt help output' '
-	git rev-parse --parseopt -- -h 2> output.err <<EOF
+OPTION_SPEC=3D"\
 some-command [options] <args>...
=20
 some-command does foo and bar!
@@ -36,8 +35,53 @@ C?        option C with an optional argument
=20
 Extras
 extra1    line above used to cause a segfault but no longer does
+"
+
+test_expect_success 'test --parseopt help output' '
+	git rev-parse --parseopt -- -h 2> output.err <<EOF
+$OPTION_SPEC
 EOF
 	test_cmp expect.err output.err
 '
=20
+cat > expect <<EOF
+set -- --foo --bar 'ham' -- 'arg'
+EOF
+
+test_expect_success 'test --parseopt' '
+	git rev-parse --parseopt -- --foo --bar=3Dham arg << EOF > output &&
+$OPTION_SPEC
+EOF
+	test_cmp expect output
+'
+
+test_expect_success 'test --parseopt with mixed options and arguments'=
 '
+	git rev-parse --parseopt -- --foo arg --bar=3Dham << EOF > output &&
+$OPTION_SPEC
+EOF
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --foo -- 'arg' '--bar=3Dham'
+EOF
+
+test_expect_success 'test --parseopt with --' '
+	git rev-parse --parseopt -- --foo -- arg --bar=3Dham << EOF > output =
&&
+$OPTION_SPEC
+EOF
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- --foo -- '--' 'arg' '--bar=3Dham'
+EOF
+
+test_expect_success 'test --parseopt --keep-dashdash' '
+	git rev-parse --parseopt --keep-dashdash -- --foo -- arg --bar=3Dham =
<< EOF > output &&
+$OPTION_SPEC
+EOF
+	test_cmp expect output
+'
+
 test_done
--=20
1.6.3.1
