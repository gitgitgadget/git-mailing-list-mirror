From: Jeff King <peff@peff.net>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sun, 11 Nov 2007 03:56:05 -0500
Message-ID: <20071111085605.GE30299@sigill.intra.peff.net>
References: <87ode3klc7.fsf@chbouib.org> <Pine.LNX.4.64.0711100052290.4362@racer.site> <20071110101420.GA21353@bulgaria> <20071110122528.GA4977@atjola.homenet> <20071110123505.GA24445@bulgaria> <20071110125126.GA7261@atjola.homenet> <20071111083224.GA30299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Swetland <swetland@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8cG-0000aF-9r
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbXKKI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbXKKI4K
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:56:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1455 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929AbXKKI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:56:09 -0500
Received: (qmail 30367 invoked by uid 111); 11 Nov 2007 08:56:07 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 03:56:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 03:56:05 -0500
Content-Disposition: inline
In-Reply-To: <20071111083224.GA30299@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64436>

On Sun, Nov 11, 2007 at 03:32:24AM -0500, Jeff King wrote:

> came out of git-format-patch with default-ish settings). So the easy,
> hackish way is probably to just add the MIME-Version and 'Content-type:
> text/plain; charset=utf-8' headers if we unquoted the author field.

Here is the quick and dirty patch. It is totally untested (as in, I
didn't even run git-send-email once), but maybe it can get somebody
started (I left some comments about how to make it less quick and
dirty).  My head is going to explode if I read any more of the ad-hoc
header parsing in git-send-email.perl.

-Peff

---
diff --git a/git-send-email.perl b/git-send-email.perl
index f9bd2e5..4a071f2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -514,11 +514,13 @@ $time = time - scalar $#files;
 
 sub unquote_rfc2047 {
 	local ($_) = @_;
-	if (s/=\?utf-8\?q\?(.*)\?=/$1/g) {
+	my $encoding;
+	if (s/=\?([^?])+\?q\?(.*)\?=/$2/g) {
+		$encoding = $1;
 		s/_/ /g;
 		s/=([0-9A-F]{2})/chr(hex($1))/eg;
 	}
-	return "$_";
+	return wantarray ? ($_, $encoding) : $_;
 }
 
 # use the simplest quoting being able to handle the recipient
@@ -667,6 +669,9 @@ foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
 
 	my $author = undef;
+	my $author_encoding;
+	my $has_content_type;
+	my $body_encoding;
 	@cc = @initial_cc;
 	@xh = ();
 	my $input_format = undef;
@@ -692,12 +697,20 @@ foreach my $t (@files) {
 						next if ($suppress_from);
 					}
 					elsif ($1 eq 'From') {
-						$author = unquote_rfc2047($2);
+						($author, $author_encoding)
+						  = unquote_rfc2047($2);
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
 					push @cc, $2;
 				}
+				elsif (/^Content-type:/i) {
+					$has_content_type = 1;
+					if (/charset="?[^ "]+/) {
+						$body_encoding = $1;
+					}
+					push @xh, $_;
+				}
 				elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
 					push @xh, $_;
 				}
@@ -756,6 +769,21 @@ foreach my $t (@files) {
 
 	if (defined $author) {
 		$message = "From: $author\n\n$message";
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
+				  "Content-Type: text/plain; charset=$author_encoding";
+			}
+		}
 	}
 
 	send_message();
