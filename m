From: Jeff King <peff@peff.net>
Subject: [PATCH 6/5] t9001: check send-email behavior with implicit sender
Date: Wed, 28 Nov 2012 13:42:29 -0500
Message-ID: <20121128184229.GA3993@sigill.intra.peff.net>
References: <20121128182534.GA21020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdmas-0002X5-UY
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab2K1Smb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:42:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33920 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab2K1Smb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:42:31 -0500
Received: (qmail 10107 invoked by uid 107); 28 Nov 2012 18:43:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 13:43:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 13:42:29 -0500
Content-Disposition: inline
In-Reply-To: <20121128182534.GA21020@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210757>

On Wed, Nov 28, 2012 at 01:25:35PM -0500, Jeff King wrote:

> Here are the cleanups and refactorings split out from my
> jk/send-email-sender-prompt series. They can go right on master and are
> independent of Felipe's fc/send-email-no-sender-prompt topic.
> [...]
> Dropped were:
> [...]
>   - send-email prompting change; obsoleted by Felipe's patch

Here is one more patch pulling out the extra tests from my final commit.
It needs to go on top of the merge of Felipe's series and the one I just
sent. The former because of the new prompting behavior, and the latter
because of the AUTOIDENT prerequisites.

If it's simpler, my whole series can just go on top of Felipe's patch
(or vice versa).

-- >8 --
Subject: [PATCH] t9001: check send-email behavior with implicit sender

We allow send-email to use an implicitly-defined identity
for the sender (because there is still a confirmation step),
but we abort when we cannot generate such an identity. Let's
make sure that we test this.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9001-send-email.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c5d66cf..27edfa8 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -201,6 +201,34 @@ test_expect_success $PREREQ 'Prompting works' '
 		grep "^To: to@example.com\$" msgtxt1
 '
 
+test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
+       clean_fake_sendmail &&
+       (sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME &&
+	sane_unset GIT_COMMITTER_EMAIL &&
+	GIT_SEND_EMAIL_NOTTY=1 git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=to@example.com \
+		$patches \
+		</dev/null 2>errors
+       )
+'
+
+test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email' '
+       clean_fake_sendmail &&
+       (sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME &&
+	sane_unset GIT_COMMITTER_EMAIL &&
+	GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
+	test_must_fail git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches </dev/null 2>errors &&
+	test_i18ngrep "tell me who you are" errors
+       )
+'
+
 test_expect_success $PREREQ 'tocmd works' '
 	clean_fake_sendmail &&
 	cp $patches tocmd.patch &&
-- 
1.8.0.207.gdf2154c
