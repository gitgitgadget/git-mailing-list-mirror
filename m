From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] t9001: drop save_confirm helper
Date: Wed, 25 Mar 2015 01:32:20 -0400
Message-ID: <20150325053220.GH31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:32:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YadvX-0003a8-46
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbbCYFcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2015 01:32:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:38182 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752194AbbCYFcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:32:22 -0400
Received: (qmail 17610 invoked by uid 102); 25 Mar 2015 05:32:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:32:22 -0500
Received: (qmail 11762 invoked by uid 107); 25 Mar 2015 05:32:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:32:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:32:20 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266261>

The idea of this helper is that we want to save the current
value of a config variable and then restore it again after
the test completes. However, there's no point in actually
saving the value; it should always be restored to the string
"never" (which you can confirm by instrumenting
save_confirm to print the value it finds).

Let's just replace it with a single test_when_finished call.

Suggested-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Jeff King <peff@peff.net>
---

 t/t9001-send-email.sh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c9f54d5..7be14a4 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -817,25 +817,20 @@ test_expect_success $PREREQ '--confirm=3Dcompose'=
 '
 	test_confirm --confirm=3Dcompose --compose
 '
=20
-save_confirm () {
-	CONFIRM=3D$(git config --get sendemail.confirm) &&
-	test_when_finished "git config sendemail.confirm ${CONFIRM:-never}"
-}
-
 test_expect_success $PREREQ 'confirm by default (due to cc)' '
-	save_confirm &&
+	test_when_finished git config sendemail.confirm never &&
 	git config --unset sendemail.confirm &&
 	test_confirm
 '
=20
 test_expect_success $PREREQ 'confirm by default (due to --compose)' '
-	save_confirm &&
+	test_when_finished git config sendemail.confirm never &&
 	git config --unset sendemail.confirm &&
 	test_confirm --suppress-cc=3Dall --compose
 '
=20
 test_expect_success $PREREQ 'confirm detects EOF (inform assumes y)' '
-	save_confirm &&
+	test_when_finished git config sendemail.confirm never &&
 	git config --unset sendemail.confirm &&
 	rm -fr outdir &&
 	git format-patch -2 -o outdir &&
@@ -848,7 +843,7 @@ test_expect_success $PREREQ 'confirm detects EOF (i=
nform assumes y)' '
 '
=20
 test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)=
' '
-	save_confirm &&
+	test_when_finished git config sendemail.confirm never &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=3D1 &&
 	export GIT_SEND_EMAIL_NOTTY &&
@@ -860,7 +855,7 @@ test_expect_success $PREREQ 'confirm detects EOF (a=
uto causes failure)' '
 '
=20
 test_expect_success $PREREQ 'confirm does not loop forever' '
-	save_confirm &&
+	test_when_finished git config sendemail.confirm never &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=3D1 &&
 	export GIT_SEND_EMAIL_NOTTY &&
--=20
2.3.4.635.gd6ffcfe
