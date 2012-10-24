From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Wed, 24 Oct 2012 23:08:26 +0200
Message-ID: <20121024210826.GA23562@shrek.podlesie.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
 <20121024171036.GA18880@shrek.podlesie.net>
 <20121024192530.GA26477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 23:08:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR8By-0003MU-PP
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 23:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049Ab2JXVIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 17:08:30 -0400
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:53595 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751447Ab2JXVI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 17:08:29 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 02978FE; Wed, 24 Oct 2012 23:08:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20121024192530.GA26477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208324>

On Wed, Oct 24, 2012 at 03:25:30PM -0400, Jeff King wrote:
> Right, but I was specifically worried about raw "=?", which is only an
> issue due to rfc2047 itself.
> 
> However, reading the patch again, we are already checking for that with
> is_rfc2047_quoted. It might miss the case where we have =? but not the
> rest of a valid encoded word, but any compliant parser should recognize
> that and leave it be.
> 
> So I think your original patch is actually correct.
> 
> [...]
> We have a possibly already-encoded header, and we would want to avoid
> double-encoding it.
> 
> In the first case, the "wants quoting" logic should be:
> 
>   is_rfc2047_quoted($subject) || /[^[:ascii:]]/
> 
> and in the latter case it would be:
> 
>   !is_rfc2047_quoted($subject) && /^[:ascii:]]/
> 

ok, I'm sending a version that just adds quote_subject() without
changing any logic, so now we still have in first case:

 /[^[:ascii:]]/

and in the latter case:
 
 !is_rfc2047_quoted($subject) && /^[:ascii:]]/


In the next patch I will just add matching for "=?" in 
subject_needs_rfc2047_quoting() and we will have:

   /=?/ || /[^[:ascii:]]/

and in the latter case:
 
   !is_rfc2047_quoted($subject) && (/=\?/ || /^[:ascii:]]/)

This will also add quoting for any rfc2047 quoted subject or any
other rfc2047-like subject, as you suggested.

Krzysiek
-- 
From a70c5385f9b4da69a8ce00a1448f87f63bbd500d Mon Sep 17 00:00:00 2001
From: Krzysztof Mazur <krzysiek@podlesie.net>
Date: Wed, 24 Oct 2012 22:46:00 +0200
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
index efeae4c..eb1b876 100755
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
+	return ($s =~ /[^[:ascii:]]/);
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
+	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
+		$subject = quote_subject($subject, $auto_8bit_encoding);
 	}
 
 	if (defined $author and $author ne $sender) {
-- 
1.8.0.4.ge8ddce6
