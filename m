From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Wed, 26 Mar 2008 02:20:29 -0400
Message-ID: <20080326062029.GA26286@coredump.intra.peff.net>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net> <20080325230321.GB17744@coredump.intra.peff.net> <200803260759.48922.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeP0c-0000cZ-NR
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYCZGUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2008 02:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYCZGUd
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:20:33 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4941 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYCZGUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:20:32 -0400
Received: (qmail 4161 invoked by uid 111); 26 Mar 2008 06:20:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 02:20:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 02:20:29 -0400
Content-Disposition: inline
In-Reply-To: <200803260759.48922.tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78261>

On Wed, Mar 26, 2008 at 07:59:48AM +0200, Teemu Likonen wrote:

> These patches seem to work except that the quoting of Subject field=20
> works only if user types a non-Ascii text to the "What subject should=
=20
> the initial email start with?" prompt. If she changes the subject in=20
> editor it won't be rfc2047-quoted.

Ah, yes, I hadn't considered that. We should definitely do the quoting
after all of the user's input. Replace 2/2 from my series with the patc=
h
below, which handles this case correctly (and as a bonus, the user sees
the unencoded subject in the editor, which is much more readable).

> Thank you anyway, I think we're going to right direction. I think 'gi=
t=20
> send-mail --compose' is nice way to produce introductory message to=20
> patch series. If --compose doesn't support MIME encoding reasonable=20
> way, user may have to write and send intro message with real MUA and=20
> find out the Message-Id for correct In-Reply-To field for the actual=20
> patch series.

git-format-patch recently got a --cover-letter option which does the
same thing. I actually use a real MUA (mutt) instead of send-email, and
this way you can avoid the message-id cutting and pasting that is
required. It automatically does the right thing with encodings because =
I
end up sending the message using my MUA.

> E-mail agents KMail and Mutt have setting for preferred encodings for=
=20
> outgoing mail. It's a list of encodings,=20
> like "us-ascii,iso-8859-1,utf-8". The first one that fits (including=20
> From, To, Cc, Subject, the body, ...?) is used, so there is some kind=
=20
> of detection of content after the message has been composed.

Yes, the git-send-email code is a real mess for this sort of thing. I
think it started very small and specific, and has gotten hack upon hack
piled on it. It would be much nicer rewritten from scratch around one o=
f
the many abstracted perl mail objects (though that does introduce a new
dependency).

> If portable content encoding detection is difficult or considered=20
> unnecessary, then I think a documented configurable option is fine=20
> (UTF-8 by default).

I think that is sensible. Want to try adding it on top of my patches?

Below is the revised subject-munging patch.

-- >8 --
send-email: rfc2047-quote subject lines with non-ascii characters

We always use 'utf-8' as the encoding, since we currently
have no way of getting the information from the user.

This also refactors the quoting of recipient names, since
both processes can share the rfc2047 quoting code.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   |   20 ++++++++++++++++++--
 t/t9001-send-email.sh |   15 +++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7c4f06c..3694f81 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -536,6 +536,15 @@ EOT
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
+			}
+		}
 		print C2 $_;
 	}
 	close(C);
@@ -626,6 +635,14 @@ sub unquote_rfc2047 {
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
@@ -643,8 +660,7 @@ sub sanitize_address
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
1.5.5.rc1.123.ge5f4e6
