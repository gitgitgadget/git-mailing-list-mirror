From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/5] t9001: check send-email behavior with implicit sender
Date: Wed, 28 Nov 2012 15:17:13 -0500
Message-ID: <20121128201713.GA9249@sigill.intra.peff.net>
References: <20121128182534.GA21020@sigill.intra.peff.net>
 <20121128184229.GA3993@sigill.intra.peff.net>
 <7vk3t5v9q1.fsf@alter.siamese.dyndns.org>
 <20121128200626.GA4292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:17:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdo4Y-0000M8-OI
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726Ab2K1URP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:17:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34014 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042Ab2K1URP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:17:15 -0500
Received: (qmail 11656 invoked by uid 107); 28 Nov 2012 20:18:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 15:18:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 15:17:13 -0500
Content-Disposition: inline
In-Reply-To: <20121128200626.GA4292@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210772>

On Wed, Nov 28, 2012 at 03:06:26PM -0500, Jeff King wrote:

> Here's a cleaned up version that makes it more obvious the commands are
> the same (it also fixes a few minor whitespace problems on the
> indentation, which you can see from the quoting above).

I wondered how painful it would be to actually run the command and then
conditionally check the results inside the test. I ended up with this:

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c5d66cf..9c8fac1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -201,6 +201,30 @@ test_expect_success $PREREQ 'Prompting works' '
 		grep "^To: to@example.com\$" msgtxt1
 '
 
+test_expect_success $PREREQ 'handle implicit ident' '
+	clean_fake_sendmail &&
+	(
+		sane_unset GIT_AUTHOR_NAME &&
+		sane_unset GIT_AUTHOR_EMAIL &&
+		sane_unset GIT_COMMITTER_NAME &&
+		sane_unset GIT_COMMITTER_EMAIL &&
+		GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
+		{
+			git send-email \
+				--smtp-server="$(pwd)/fake.sendmail" \
+				--to=to@example.com \
+				$patches </dev/null 2>errors;
+			exit_code=$?
+		} &&
+		if test_have_prereq AUTOIDENT; then
+			test $exit_code = 0
+		else
+			test $exit_code != 0 &&
+			test_i18ngrep "tell me who you are" errors
+		fi
+	)
+'
+
 test_expect_success $PREREQ 'tocmd works' '
 	clean_fake_sendmail &&
 	cp $patches tocmd.patch &&

which does work, though it is less nice that the protections and nice
syntax of "test_must_fail" must be abandoned (unless we want to do
something horrible like 'test_must_fail sh -c "exit $exit_code"'.
I could go either way.

-Peff
