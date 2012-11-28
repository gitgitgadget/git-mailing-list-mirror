From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/5] t9001: check send-email behavior with implicit sender
Date: Wed, 28 Nov 2012 15:06:26 -0500
Message-ID: <20121128200626.GA4292@sigill.intra.peff.net>
References: <20121128182534.GA21020@sigill.intra.peff.net>
 <20121128184229.GA3993@sigill.intra.peff.net>
 <7vk3t5v9q1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdnu8-0006c8-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab2K1UG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:06:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33999 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab2K1UG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:06:28 -0500
Received: (qmail 11420 invoked by uid 107); 28 Nov 2012 20:07:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 15:07:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 15:06:26 -0500
Content-Disposition: inline
In-Reply-To: <7vk3t5v9q1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210769>

On Wed, Nov 28, 2012 at 10:55:02AM -0800, Junio C Hamano wrote:

> > +test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
> > +       clean_fake_sendmail &&
> > +       (sane_unset GIT_AUTHOR_NAME &&
> > +	sane_unset GIT_AUTHOR_EMAIL &&
> > +	sane_unset GIT_COMMITTER_NAME &&
> > +	sane_unset GIT_COMMITTER_EMAIL &&
> > +	GIT_SEND_EMAIL_NOTTY=1 git send-email \
> > +		--smtp-server="$(pwd)/fake.sendmail" \
> > +		--to=to@example.com \
> > +		$patches \
> > +		</dev/null 2>errors
> > +       )
> > +'
> > +
> > +test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email' '
> > +       clean_fake_sendmail &&
> > +       (sane_unset GIT_AUTHOR_NAME &&
> > +	sane_unset GIT_AUTHOR_EMAIL &&
> > +	sane_unset GIT_COMMITTER_NAME &&
> > +	sane_unset GIT_COMMITTER_EMAIL &&
> > +	GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
> > +	test_must_fail git send-email \
> > +		--smtp-server="$(pwd)/fake.sendmail" \
> > +		$patches </dev/null 2>errors &&
> > +	test_i18ngrep "tell me who you are" errors
> > +       )
> > +'
> 
> The difference between these two tests should solely come from
> AUTOIDENT and nothing else, so it would be better to see their
> command line arguments to match; the former is with --to and the
> latter is without in this patch but I do not think you meant them to
> differ that way.

Yeah, that makes sense. The top one originally was testing that we
still prompted in the autoident case, and so had some echos piped into
send-email. I simplified it to use --to, but I agree it is even better
to show that the commands are identical.

Here's a cleaned up version that makes it more obvious the commands are
the same (it also fixes a few minor whitespace problems on the
indentation, which you can see from the quoting above).

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
index c5d66cf..97d6f4c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -201,6 +201,34 @@ test_expect_success $PREREQ 'Prompting works' '
 		grep "^To: to@example.com\$" msgtxt1
 '
 
+test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
+	clean_fake_sendmail &&
+	(sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME &&
+	sane_unset GIT_COMMITTER_EMAIL &&
+	GIT_SEND_EMAIL_NOTTY=1 git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=to@example.com \
+		$patches </dev/null 2>errors
+	)
+'
+
+test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email' '
+	clean_fake_sendmail &&
+	(sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME &&
+	sane_unset GIT_COMMITTER_EMAIL &&
+	GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
+	test_must_fail git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=to@example.com \
+		$patches </dev/null 2>errors &&
+	test_i18ngrep "tell me who you are" errors
+	)
+'
+
 test_expect_success $PREREQ 'tocmd works' '
 	clean_fake_sendmail &&
 	cp $patches tocmd.patch &&
-- 
1.8.0.207.gdf2154c
