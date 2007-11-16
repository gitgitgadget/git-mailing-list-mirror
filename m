From: Jeff King <peff@peff.net>
Subject: Re: [BUG] encoding problem with format-patch + send-email
Date: Fri, 16 Nov 2007 05:49:09 -0500
Message-ID: <20071116104907.GA13087@sigill.intra.peff.net>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 11:50:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isylp-0001A6-Tl
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 11:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbXKPKtP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 05:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXKPKtP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 05:49:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4808 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbXKPKtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 05:49:14 -0500
Received: (qmail 16521 invoked by uid 111); 16 Nov 2007 10:49:12 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 16 Nov 2007 05:49:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2007 05:49:09 -0500
Content-Disposition: inline
In-Reply-To: <20071115105726.GA18555@bre-cln-ukleine.digi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65214>

On Thu, Nov 15, 2007 at 11:57:26AM +0100, Uwe Kleine-K=F6nig wrote:

> send-email adds "From: A. U. Thor <author@tld>" to the body if sender
> and From: in the patch to send differ.
>=20
> Both is just fine, but if the author has some non-ascii characters in
> her name but the body is ascii-only the resulting mail is broken.

I posted an untested fix to this and discussed the issue in

  http://article.gmane.org/gmane.comp.version-control.git/64426
  http://article.gmane.org/gmane.comp.version-control.git/64436

but nobody seems to have been interested after that (I don't even use
git-send-email myself).

Below is an updated patch (there was a typo in one of the regexes in th=
e
original) that meets my limited testing for the all-utf8 case (I don't
know how people actually use alternate encodings with git, if at all, s=
o
I don't know that I can put together a good test case). My test case wa=
s
something like:

  git-clone git test && cd test
  echo junk >>Makefile
  git-commit -m junk --author 'Uwe Kleine-K=F6nig <peff@peff.net>' -a
  git-format-patch HEAD^
  git-send-email 0001-junk.patch

> What about adding the Content-Type and Content-Transfer-Encoding head=
ers
> in any case?

You could probably add them unconditionally, but it would be nice to
have them match the encoding, so you'd still want to pick them out of
the rfc2047 encoding in the from header.

-Peff

-- >8 --
git-send-email: add charset header if we add encoded 'From'

We sometimes pick out the original rfc822 'From' header and
include it in the body of the message. If the original
author's name needs encoding, then we should specify that in
the content-type header.

If we already had a content-type header in the mail, then we
may need to re-encode. The logic is there to detect
this case, but it doesn't actually do the re-encoding.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f9bd2e5..fd0a4ad 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -514,11 +514,13 @@ $time =3D time - scalar $#files;
=20
 sub unquote_rfc2047 {
 	local ($_) =3D @_;
-	if (s/=3D\?utf-8\?q\?(.*)\?=3D/$1/g) {
+	my $encoding;
+	if (s/=3D\?([^?]+)\?q\?(.*)\?=3D/$2/g) {
+		$encoding =3D $1;
 		s/_/ /g;
 		s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
 	}
-	return "$_";
+	return wantarray ? ($_, $encoding) : $_;
 }
=20
 # use the simplest quoting being able to handle the recipient
@@ -667,6 +669,9 @@ foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
=20
 	my $author =3D undef;
+	my $author_encoding;
+	my $has_content_type;
+	my $body_encoding;
 	@cc =3D @initial_cc;
 	@xh =3D ();
 	my $input_format =3D undef;
@@ -692,12 +697,20 @@ foreach my $t (@files) {
 						next if ($suppress_from);
 					}
 					elsif ($1 eq 'From') {
-						$author =3D unquote_rfc2047($2);
+						($author, $author_encoding)
+						  =3D unquote_rfc2047($2);
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
 					push @cc, $2;
 				}
+				elsif (/^Content-type:/i) {
+					$has_content_type =3D 1;
+					if (/charset=3D"?[^ "]+/) {
+						$body_encoding =3D $1;
+					}
+					push @xh, $_;
+				}
 				elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
 					push @xh, $_;
 				}
@@ -756,6 +769,21 @@ foreach my $t (@files) {
=20
 	if (defined $author) {
 		$message =3D "From: $author\n\n$message";
+		if (defined $author_encoding) {
+			if ($has_content_type) {
+				if ($body_encoding eq $author_encoding) {
+					# ok, we already have the right encoding
+				}
+				else {
+					# uh oh, we should re-encode
+				}
+			}
+			else {
+				push @xh,
+				  'MIME-Version: 1.0',
+				  "Content-Type: text/plain; charset=3D$author_encoding";
+			}
+		}
 	}
=20
 	send_message();
--=20
1.5.3.1.47.g88b7d-dirty
