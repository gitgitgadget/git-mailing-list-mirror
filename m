From: Jeff King <peff@peff.net>
Subject: [PATCH 21/25] t9001: use test_when_finished
Date: Fri, 20 Mar 2015 06:13:22 -0400
Message-ID: <20150320101321.GU12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvp-0005zp-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbCTKN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:35725 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbCTKNY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:24 -0400
Received: (qmail 5939 invoked by uid 102); 20 Mar 2015 10:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:24 -0500
Received: (qmail 21693 invoked by uid 107); 20 Mar 2015 10:13:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:22 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265897>

The confirmation tests in t9001 all save the value of
sendemail.confirm, do something to it, then restore it at
the end, in a way that breaks the &&-chain (they are not
wrong, because they save the $? value, but it fools
--chain-lint).

Instead, they can all use test_when_finished, and we can
even make the code simpler by factoring out the shared
lines.

Note that we can _almost_ use test_config here, except that:

  1. We do not restore the config with test_unconfig, but by
     setting it back to some prior value.

  2. We are not always setting a config variable. Sometimes
     the change to be undone is unsetting it entirely.

We could teach test_config to handle these cases, but it's
not worth the complexity for a single call-site.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9001-send-email.sh | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 37caa18..c9f54d5 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -817,26 +817,25 @@ test_expect_success $PREREQ '--confirm=compose' '
 	test_confirm --confirm=compose --compose
 '
 
-test_expect_success $PREREQ 'confirm by default (due to cc)' '
+save_confirm () {
 	CONFIRM=$(git config --get sendemail.confirm) &&
+	test_when_finished "git config sendemail.confirm ${CONFIRM:-never}"
+}
+
+test_expect_success $PREREQ 'confirm by default (due to cc)' '
+	save_confirm &&
 	git config --unset sendemail.confirm &&
 	test_confirm
-	ret="$?"
-	git config sendemail.confirm ${CONFIRM:-never}
-	test $ret = "0"
 '
 
 test_expect_success $PREREQ 'confirm by default (due to --compose)' '
-	CONFIRM=$(git config --get sendemail.confirm) &&
+	save_confirm &&
 	git config --unset sendemail.confirm &&
 	test_confirm --suppress-cc=all --compose
-	ret="$?"
-	git config sendemail.confirm ${CONFIRM:-never}
-	test $ret = "0"
 '
 
 test_expect_success $PREREQ 'confirm detects EOF (inform assumes y)' '
-	CONFIRM=$(git config --get sendemail.confirm) &&
+	save_confirm &&
 	git config --unset sendemail.confirm &&
 	rm -fr outdir &&
 	git format-patch -2 -o outdir &&
@@ -846,13 +845,10 @@ test_expect_success $PREREQ 'confirm detects EOF (inform assumes y)' '
 			--to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			outdir/*.patch </dev/null
-	ret="$?"
-	git config sendemail.confirm ${CONFIRM:-never}
-	test $ret = "0"
 '
 
 test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)' '
-	CONFIRM=$(git config --get sendemail.confirm) &&
+	save_confirm &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=1 &&
 	export GIT_SEND_EMAIL_NOTTY &&
@@ -861,13 +857,10 @@ test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)' '
 			--to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			$patches </dev/null
-	ret="$?"
-	git config sendemail.confirm ${CONFIRM:-never}
-	test $ret = "0"
 '
 
 test_expect_success $PREREQ 'confirm does not loop forever' '
-	CONFIRM=$(git config --get sendemail.confirm) &&
+	save_confirm &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=1 &&
 	export GIT_SEND_EMAIL_NOTTY &&
@@ -876,9 +869,6 @@ test_expect_success $PREREQ 'confirm does not loop forever' '
 			--to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			$patches
-	ret="$?"
-	git config sendemail.confirm ${CONFIRM:-never}
-	test $ret = "0"
 '
 
 test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
-- 
2.3.3.520.g3cfbb5d
