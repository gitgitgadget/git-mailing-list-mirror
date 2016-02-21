From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 18:19:14 -0500
Message-ID: <20160221231913.GA4094@sigill.intra.peff.net>
References: <20160219193310.GA1299@sigill.intra.peff.net>
 <cover.1456075680.git.john@keeping.me.uk>
 <81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
 <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:19:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdHd-00012g-8R
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcBUXTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:19:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:46380 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752493AbcBUXTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:19:17 -0500
Received: (qmail 24311 invoked by uid 102); 21 Feb 2016 23:19:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:19:16 -0500
Received: (qmail 13068 invoked by uid 107); 21 Feb 2016 23:19:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:19:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2016 18:19:14 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286840>

On Sun, Feb 21, 2016 at 04:01:27PM -0500, Eric Sunshine wrote:

> On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
> > GNU grep 2.23 detects the input used in this test as binary data so it
> > does not work for extracting lines from a file.  We could add the "-a"
> > option to force grep to treat the input as text, but not all
> > implementations support that.  Instead, use sed to extract the desired
> > lines since it will always treat its input as text.
> >
> > While touching these lines, modernize the test style to avoid hiding the
> > exit status of "git blame" and remove a space following a redirection
> > operator.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
> > @@ -35,8 +35,8 @@ EOF
> >  test_expect_success !MINGW \
> >         'blame respects i18n.commitencoding' '
> > -       git blame --incremental file | \
> > -               egrep "^(author|summary) " > actual &&
> > +       git blame --incremental file >output &&
> > +       sed -ne "/^\(author\|summary\) /p" output >actual &&
> 
> These tests all crash and burn with BSD sed (including Mac OS X) since
> you're not restricting yourself to BRE (basic regular expressions).
> You _could_ request extended regular expressions, which do work on
> those platforms, as well as with GNU sed:
> 
>     sed -nEe "/^(author|summary) /p" ...

At that point, I think we may as well use grep, because obscure
platforms are probably broken either way.

I'm tempted to just go the perl route. We already depend on at least a
baisc version of perl5 being installed for many of the other tests, so
it's not really introducing a new dependency.

Something like the patch below works for me. I think we could make it
shorter by using $PERLIO to get the raw behavior, but using binmode will
work even on ancient versions of perl.

John, if you agree on the direction, feel free to combine it with your
patch.

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 847d098..f7a02d8 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -33,10 +33,20 @@ author $SJIS_NAME
 summary $SJIS_MSG
 EOF
 
+filter_blame () {
+	perl -e '
+		binmode STDIN;
+		binmode STDOUT;
+		while (<>) {
+			print if /^(author|summary) /;
+		}
+	'
+}
+
 test_expect_success !MINGW \
 	'blame respects i18n.commitencoding' '
 	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
+		filter_blame >actual &&
 	test_cmp actual expected
 '
 
@@ -53,7 +63,7 @@ test_expect_success !MINGW \
 	'blame respects i18n.logoutputencoding' '
 	git config i18n.logoutputencoding eucJP &&
 	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
+		filter_blame > actual &&
 	test_cmp actual expected
 '
 
@@ -69,7 +79,7 @@ EOF
 test_expect_success !MINGW \
 	'blame respects --encoding=UTF-8' '
 	git blame --incremental --encoding=UTF-8 file | \
-		egrep "^(author|summary) " > actual &&
+		filter_blame >actual &&
 	test_cmp actual expected
 '
 
@@ -85,7 +95,7 @@ EOF
 test_expect_success !MINGW \
 	'blame respects --encoding=none' '
 	git blame --incremental --encoding=none file | \
-		egrep "^(author|summary) " > actual &&
+		filter_blame >actual &&
 	test_cmp actual expected
 '
 
