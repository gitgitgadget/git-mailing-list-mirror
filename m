From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: ignore trailing whitespace in mailrc alias
 file
Date: Thu, 17 Mar 2016 19:58:22 -0400
Message-ID: <20160317235822.GA10612@sigill.intra.peff.net>
References: <1458252496-4118-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:58:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aghoU-0008BT-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbcCQX61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 19:58:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:33792 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750937AbcCQX60 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 19:58:26 -0400
Received: (qmail 445 invoked by uid 102); 17 Mar 2016 23:58:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 19:58:25 -0400
Received: (qmail 6887 invoked by uid 107); 17 Mar 2016 23:58:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 19:58:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:58:22 -0400
Content-Disposition: inline
In-Reply-To: <1458252496-4118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289173>

On Thu, Mar 17, 2016 at 03:08:16PM -0700, Stefan Beller wrote:

> I just wrote the commit message as I would do, but offer you to claim
> authorship for that perl stuff. So in case you'd want to reword that,
> I'd ask you to that.  Also asking for your signoff. (But apart from
> that I consider this patch final.)

Yeah, I am happy to take the credit/blame when somebody inevitably shows
a case where this does the wrong thing (I say inevitable because I
assume that is the fate of all regexes -- to one day be proven to miss a
corner case).

But surely you know that my commit messages are more verbose than that.
:)

Here's what I would have written:

-- >8 --
Subject: [PATCH] send-email: ignore trailing whitespace in mailrc alias file

The regex for parsing mailrc considers everything after the
second whitespace to be the email address, up to the end of
the line. We have to include whitespace there, because you
may have multiple space-separated addresses, each with their
own internal quoting.

But if there is trailing whitespace, we include that, too.
This confuses quotewords() when we try to split the
individual addresses, and we end up storing "undef" in our
alias list. Later parts of the code then access that,
generating perl warnings.

Let's tweak our regex to throw away any trailing whitespace
on each line.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d356901..c45b22a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -533,7 +533,7 @@ my %parse_alias = (
 			$aliases{$alias} = \@addr
 		}}},
 	mailrc => sub { my $fh = shift; while (<$fh>) {
-		if (/^alias\s+(\S+)\s+(.*)$/) {
+		if (/^alias\s+(\S+)\s+(.*?)\s*$/) {
 			# spaces delimit multiple addresses
 			$aliases{$1} = [ quotewords('\s+', 0, $2) ];
 		}}},
-- 
2.8.0.rc3.378.gf2f7872
