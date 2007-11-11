From: Jeff King <peff@peff.net>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sun, 11 Nov 2007 03:32:24 -0500
Message-ID: <20071111083224.GA30299@sigill.intra.peff.net>
References: <87ode3klc7.fsf@chbouib.org> <Pine.LNX.4.64.0711100052290.4362@racer.site> <20071110101420.GA21353@bulgaria> <20071110122528.GA4977@atjola.homenet> <20071110123505.GA24445@bulgaria> <20071110125126.GA7261@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Swetland <swetland@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:32:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8FH-0004U4-QT
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbXKKIc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 03:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbXKKIc2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:32:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2662 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbXKKIc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:32:27 -0500
Received: (qmail 30102 invoked by uid 111); 11 Nov 2007 08:32:26 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 03:32:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 03:32:24 -0500
Content-Disposition: inline
In-Reply-To: <20071110125126.GA7261@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64426>

On Sat, Nov 10, 2007 at 01:51:26PM +0100, Bj=F6rn Steinbrink wrote:

> On 2007.11.10 04:35:05 -0800, Brian Swetland wrote:
> > The first line of the patch is a From: field with Arve's name, in
> > an (rfc822?) encoded format):
> > From: =3D?utf-8?q?Arve=3D20Hj=3DC3=3DB8nnev=3DC3=3DA5g?=3D <arve@an=
droid.com>

It's rfc2047 (and you can grep for that in git-send-email).

> Ah! Commit author differs from mail sender, didn't think of that. Tha=
t's
> probably the same problem as with the -s option, ie. that git-send-em=
ail
> only looks at the existing text and not add anything it adds itself w=
hen
> checking the encoding. Sorry for the noise.

It's not the same problem; the '-s' problem was git-format-patch, and
this is git-send-email. In fact, git-format-patch correctly notes the
encoding in the header. It is git-send-email in this case that takes th=
e
encoded and properly marked header, deciphers it, throws away the
original encoding, and sticks it into the message body without
considering the encoding of the body.

So I think you would want to:
  1. remember the encoding pulled from the rfc2047 header
  2. When prepending the author line to the message, consider the
     body encoding.
  2a. If no encoding, then the body is US-ASCII and we can presumably
      just add
         MIME-Version: 1.0
         Content-Type: text/plain; charset=3D$enc
  2b. If there is an encoding, we need to Iconv from the name
      encoding to the body encoding.

However, as it stands now, our rfc2047 unquoting _always_ assumes that
we are in utf-8 for the name (which is probably true if the messages
came out of git-format-patch with default-ish settings). So the easy,
hackish way is probably to just add the MIME-Version and 'Content-type:
text/plain; charset=3Dutf-8' headers if we unquoted the author field.

If we want to accept arbitrary messages, below is a patch to at least
have unquote_rfc2047 return the right information (and then on
git-send-email.perl:758, where we prepend $author, the encoding would
need to be taken into account as I described above).

Given that git-send-email is already pretty dependent on
git-format-patch output (and nobody has been complaining about its
rfc2047 handling so far!) the easy, hackish way is probably the best.

-Peff

---
diff --git a/git-send-email.perl b/git-send-email.perl
index f9bd2e5..4f8297f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -514,11 +514,13 @@ $time =3D time - scalar $#files;
=20
 sub unquote_rfc2047 {
 	local ($_) =3D @_;
-	if (s/=3D\?utf-8\?q\?(.*)\?=3D/$1/g) {
+	my $encoding;
+	if (s/=3D\?([^?])+\?q\?(.*)\?=3D/$2/g) {
+		$encoding =3D $1;
 		s/_/ /g;
 		s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
 	}
-	return "$_";
+	return "$_", $encoding;
 }
=20
 # use the simplest quoting being able to handle the recipient
@@ -667,6 +669,7 @@ foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
=20
 	my $author =3D undef;
+	my $author_encoding;
 	@cc =3D @initial_cc;
 	@xh =3D ();
 	my $input_format =3D undef;
@@ -692,7 +695,8 @@ foreach my $t (@files) {
 						next if ($suppress_from);
 					}
 					elsif ($1 eq 'From') {
-						$author =3D unquote_rfc2047($2);
+						($author, $author_encoding)
+						  =3D unquote_rfc2047($2);
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
