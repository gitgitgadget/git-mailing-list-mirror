From: Jeff King <peff@peff.net>
Subject: Re: One whitespace breaks sending mail (using mailrc aliases wit
 send-emal)
Date: Wed, 16 Mar 2016 22:00:15 -0400
Message-ID: <20160317020015.GC12830@sigill.intra.peff.net>
References: <CAGZ79kbRdPMkbs_-BGhCQ44hOsccG3aX16RJpE3ZHcBmDz40zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 03:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agNEe-0006YJ-9Z
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 03:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbcCQCAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 22:00:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:33034 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751745AbcCQCAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 22:00:18 -0400
Received: (qmail 6043 invoked by uid 102); 17 Mar 2016 02:00:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 22:00:18 -0400
Received: (qmail 23192 invoked by uid 107); 17 Mar 2016 02:00:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 22:00:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 22:00:15 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbRdPMkbs_-BGhCQ44hOsccG3aX16RJpE3ZHcBmDz40zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289071>

On Wed, Mar 16, 2016 at 06:28:59PM -0700, Stefan Beller wrote:

> To reproduce:
> 
> $ git config sendemail.aliasesfile ~/.mailrc
> $ git config sendemail.aliasfiletype mailrc
> $ echo "alias zzz_wrong_entry jon@do.e "
> # notice the white space at the end of the alias
> 
> $ git send-email 0001-rebase-x-do-not-die-without-i.patch --cc=zzz_wrong_entry
> Use of uninitialized value $alias in hash element at
> /usr/local/google/home/sbeller/libexec/git-core/git-send-email line
> 847.
> [...]
> The stack trace doesn't even show the wrong address, so debugging that was hard.
> Not sure I am asking for help, as I found the problem and could fix
> it, but maybe we can
> improve the error message (I have no knowledge about perl, so I may
> not be super helpful there)

I don't think so. The problem is that we return `undef` for one of the
aliases, and then later when we look at that, perl obviously is unhappy.
It's sort of the equivalent of a C program dereferencing NULL, but the
bug is assigning NULL in the first place much earlier.

You _can_ tell perl not to bother warning about accessing undef like
this, but it's usually a good idea to have such warnings on, as they are
helpful for finding real bugs.

I imagine your problem is by:

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

to suppress the extra whitespace at the end (alternatively, there may be
a way to tell quotewords() to throw out a trailing delimiter, but I
don't know the Text::ParseWords module well enough to say offhand).

-Peff
