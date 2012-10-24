From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Wed, 24 Oct 2012 19:10:36 +0200
Message-ID: <20121024171036.GA18880@shrek.podlesie.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 19:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR4Tk-00065k-LN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 19:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589Ab2JXRKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 13:10:40 -0400
Received: from [93.179.225.50] ([93.179.225.50]:38265 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756417Ab2JXRKj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 13:10:39 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 8BB91450; Wed, 24 Oct 2012 19:10:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20121024084636.GA23500@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208310>

On Wed, Oct 24, 2012 at 04:46:36AM -0400, Jeff King wrote:
> On Wed, Oct 24, 2012 at 10:03:35AM +0200, Krzysztof Mazur wrote:
> 
> > The git-send-email always use RFC2047 subject quoting for files
> > with "broken" encoding - non-ASCII files without Content-Transfer-Encoding,
> > even for ASCII subjects. Now for ASCII subjects the RFC2047 quoting will be
> > skipped.
> > [...]
> > -	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
> > +	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
> > +			($subject =~ /[^[:ascii:]]/)) {
> 
> Is that test sufficient? We would also need to encode if it has rfc2047
> specials, no?

For Subject this should be sufficient. According to RFC822 after
"Subject:" we have "text" token,

--- from RFC822 ---
                 /  "Subject"           ":"  *text
--- from RFC822 ---

and text is defined as:

--- from RFC822 ---
     text        =  <any CHAR, including bare    ; => atoms, specials,
                     CR & bare LF, but NOT       ;  comments and
                     including CRLF>             ;  quoted-strings are
                                                 ;  NOT recognized.
--- from RFC822 ---

so only CRLF is not allowed in Subject.


So the problem only exists for broken RFC2047-like texts, but I think
it's ok to just pass such subjects, in most cases the Subject comes
from already formatted patch file. I think that we just want to fix Subjects
without specified encoding here.


In most cases, when git-send-email is used for patches generated
by "git format-patch" we just don't want to corrupt Subject. The
"git format-patch" generates "broken" patches when commit message
uses only ASCII characters and patch contains some non-ASCII characters.
In this case original git-send-email, without this patch, adds RFC2047
quotation for pure ASCII Subject.

> 
> It looks like we use the same regex elsewhere. Maybe this would be a
> good chance to abstract out a needs_rfc2047_quoting while we are in the
> area?

It's a good idea, however rules are different for Subject and addresses
(sanitize_address).

I think we can go even further, we can just add quote_subject(),
which performs this test and calls quote_rfc2047() if necessary.
I'm sending bellow patch that does that.

Krzysiek
-- 
From a1e6eef831275485ec1555d94ff0d9aac852dd12 Mon Sep 17 00:00:00 2001
From: Krzysztof Mazur <krzysiek@podlesie.net>
Date: Wed, 24 Oct 2012 19:08:57 +0200
Subject: [PATCH] git-send-email: introduce quote_subject()

The quote_rfc2047() always adds RFC2047 quoting and to avoid quoting ASCII
subjects, before calling quote_rfc2047() subject must be tested for non-ASCII
characters. To avoid this new quote_subject() function is introduced.
The quote_subject() performs this test and calls quote_rfc2047() only if
necessary.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index efeae4c..e9aec8d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -657,9 +657,7 @@ EOT
 			$initial_subject = $1;
 			my $subject = $initial_subject;
 			$_ = "Subject: " .
-				($subject =~ /[^[:ascii:]]/ ?
-				 quote_rfc2047($subject, $compose_encoding) :
-				 $subject) .
+				quote_subject($subject, $compose_encoding) .
 				"\n";
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
 			$initial_reply_to = $1;
@@ -907,6 +905,22 @@ sub is_rfc2047_quoted {
 	$s =~ m/^(?:"[[:ascii:]]*"|=\?$token\?$token\?$encoded_text\?=)$/o;
 }
 
+sub subject_needs_rfc2047_quoting {
+	my $s = shift;
+
+	return !is_rfc2047_quoted($s) && ($s =~ /[^[:ascii:]]/);
+}
+
+sub quote_subject {
+ 	local $subject = shift;
+ 	my $encoding = shift || 'UTF-8';
+
+ 	if (subject_needs_rfc2047_quoting($subject)) {
+		return quote_rfc2047($subject, $encoding);
+ 	}
+ 	return $subject;
+}
+
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address {
 	my ($recipient) = @_;
@@ -1327,9 +1341,8 @@ foreach my $t (@files) {
 		$body_encoding = $auto_8bit_encoding;
 	}
 
-	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
-			($subject =~ /[^[:ascii:]]/)) {
-		$subject = quote_rfc2047($subject, $auto_8bit_encoding);
+	if ($broken_encoding{$t}) {
+		$subject = quote_subject($subject, $auto_8bit_encoding);
 	}
 
 	if (defined $author and $author ne $sender) {
-- 
1.8.0.3.gf4c35fc
