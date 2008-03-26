From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Wed, 26 Mar 2008 04:39:25 -0400
Message-ID: <20080326083925.GA31475@coredump.intra.peff.net>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net> <200803260759.48922.tlikonen@iki.fi> <20080326062029.GA26286@coredump.intra.peff.net> <20080326083033.GA13933@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Mar 26 09:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeRB6-0007VR-2y
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 09:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbYCZIj3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2008 04:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbYCZIj3
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 04:39:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4287 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbYCZIj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 04:39:28 -0400
Received: (qmail 13400 invoked by uid 111); 26 Mar 2008 08:39:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 04:39:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 04:39:25 -0400
Content-Disposition: inline
In-Reply-To: <20080326083033.GA13933@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78275>

On Wed, Mar 26, 2008 at 10:30:33AM +0200, Teemu Likonen wrote:

> I had missed the --cover-letter option completely. It may be useful t=
oo.
> I'm still trying to find the best way to send pathces. If I send intr=
o
> message with real MUA I either need to wait for the message to show u=
p
> on a mailing list or check my sent-mail folder to find the Message-Id=
=2E
> Once I know the Message-Id I can send the actual patch series with 'g=
it
> send-email' as replies to the intro message. Well, this is OK.

That is how I used to do it; now I use --cover-letter (which you
probably missed because it is brand new in the upcoming 1.5.5).

> > I think that is sensible. Want to try adding it on top of my patche=
s?
> I'd like to, but I can only do sh/bash stuff and possibly some
> copy-and-paste programming with other scripting languages. You'd end =
up
> fixing my code anyway, sorry.

OK, I will add it to the end of my long todo. Out of curiosity, do you
actually want something besides utf-8, or is this just to make us feel
feature complete?

> As you noticed, I accidentally sent you a couple of test emails becau=
se
> send-email CCed mails to patches' author (I think). Now I have set
> "suppresscc =3D all" and "suppressfrom =3D true" which should prevent=
 such
> accidents. Shouldn't these be defaults? In my opinion it's generally =
the
> best practice to always explicitly define what parties emails are sen=
t
> to.

I think this is probably a good change. But it is a behavior change,
which means it is definitely out during the -rc freeze. And it may or
may not need a warning period for users.

> There is unmatching bracket in your patch:

Argh, yes. I _thought_ I ran it successfully through the test script,
but obviously I failed to 'make' and just tested the previous version.
It works fine with the bracket removed.

=46or reference, the fixed-up patch is below.

-- >8 --
send-email: rfc2047-quote subject lines with non-ascii characters

We always use 'utf-8' as the encoding, since we currently
have no way of getting the information from the user.

This also refactors the quoting of recipient names, since
both processes can share the rfc2047 quoting code.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   |   19 +++++++++++++++++--
 t/t9001-send-email.sh |   15 +++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7c4f06c..d0f9d4a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -536,6 +536,14 @@ EOT
 		if (!$in_body && /^MIME-Version:/i) {
 			$need_8bit_cte =3D 0;
 		}
+		if (!$in_body && /^Subject: ?(.*)/i) {
+			my $subject =3D $1;
+			$_ =3D "Subject: " .
+				($subject =3D~ /[^[:ascii:]]/ ?
+				 quote_rfc2047($subject) :
+				 $subject) .
+				"\n";
+		}
 		print C2 $_;
 	}
 	close(C);
@@ -626,6 +634,14 @@ sub unquote_rfc2047 {
 	return wantarray ? ($_, $encoding) : $_;
 }
=20
+sub quote_rfc2047 {
+	local $_ =3D shift;
+	my $encoding =3D shift || 'utf-8';
+	s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord($1))/eg;
+	s/(.*)/=3D\?$encoding\?q\?$1\?=3D/;
+	return $_;
+}
+
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address
 {
@@ -643,8 +659,7 @@ sub sanitize_address
=20
 	# rfc2047 is needed if a non-ascii char is included
 	if ($recipient_name =3D~ /[^[:ascii:]]/) {
-		$recipient_name =3D~ s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord($=
1))/eg;
-		$recipient_name =3D~ s/(.*)/=3D\?utf-8\?q\?$1\?=3D/;
+		$recipient_name =3D quote_rfc2047($recipient_name);
 	}
=20
 	# double quotes are needed if specials or CTLs are included
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e222c49..a4bcd28 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -210,4 +210,19 @@ test_expect_success '--compose respects user mime =
type' '
 	! grep "^Content-Type: text/plain; charset=3Dutf-8" msgtxt1
 '
=20
+test_expect_success '--compose adds MIME for utf8 subject' '
+	clean_fake_sendmail &&
+	echo y | \
+	  GIT_EDITOR=3D$(pwd)/fake-editor \
+	  GIT_SEND_EMAIL_NOTTY=3D1 \
+	  git send-email \
+	  --compose --subject utf8-s=C3=BCbj=C3=ABct \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^fake edit" msgtxt1 &&
+	grep "^Subject: =3D?utf-8?q?utf8-s=3DC3=3DBCbj=3DC3=3DABct?=3D" msgtx=
t1
+'
+
 test_done
--=20
1.5.5.rc1.133.g360d
