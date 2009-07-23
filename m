From: Jeff King <peff@peff.net>
Subject: Re: infinite loop in git-send-email with alias files
Date: Thu, 23 Jul 2009 07:09:29 -0400
Message-ID: <20090723110928.GC4247@coredump.intra.peff.net>
References: <8bd0f97a0907161810w22726ffdye5c8d64719b77b53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 13:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTwBG-0000Jk-9G
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 13:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZGWLJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 07:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZGWLJc
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 07:09:32 -0400
Received: from peff.net ([208.65.91.99]:55108 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbZGWLJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 07:09:31 -0400
Received: (qmail 10146 invoked by uid 107); 23 Jul 2009 11:11:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Jul 2009 07:11:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2009 07:09:29 -0400
Content-Disposition: inline
In-Reply-To: <8bd0f97a0907161810w22726ffdye5c8d64719b77b53@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123865>

On Thu, Jul 16, 2009 at 09:10:00PM -0400, Mike Frysinger wrote:

> i was setting up an aliasesfile for git-send-email, but in doing so, i
> inadvertently made a typo creating an infinite loop.  i didnt notice
> right away, but i did notice when `git-send-email` hung using 100% of
> a cpu.

Yep, we don't do cycle detection on alias expansion. It is easy enough
to do, though:

-- >8 --
Subject: [PATCH] send-email: detect cycles in alias expansion

With the previous code, an alias cycle like:

  $ echo 'alias a b' >aliases
  $ echo 'alias b a' >aliases
  $ git config sendemail.aliasesfile aliases
  $ git config sendemail.aliasfiletype mutt

would put send-email into an infinite loop. This patch
detects the situation and complains to the user.

Signed-off-by: Jeff King <peff@peff.net>
---
Two notes on this patch:

  1. I ended up rewriting the iterative expansion as a recursive
     function, because it makes the code simpler (doing proper detection
     in the iterative loop means you have to check where each expansion
     came from. That is, expanding "a" to "b" and "c" to "b" is OK, but
     expanding "a" to "b" to "c" is not. So you end up having to
     implement a stack, anyway. Much easier to let perl do it for us).

     But this also raises the likelihood that I screwed something up, so
     I would appreciate an extra set of eyes.

  2. It just barfs. I figure such a situation is a sign of a problem
     that the user should address. But we could also just stop expansion
     (so "a" => "b" => "a" simply expands to "a"); this is more like how
     bash aliases work, but I don't know if there is any benefit to that
     here.

     We could also print out the cycle, but I doubt it is worth the
     trouble.

 git-send-email.perl |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8ce6f1f..d508f83 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -654,13 +654,17 @@ if (!@to) {
 }
 
 sub expand_aliases {
-	my @cur = @_;
-	my @last;
-	do {
-		@last = @cur;
-		@cur = map { $aliases{$_} ? @{$aliases{$_}} : $_ } @last;
-	} while (join(',',@cur) ne join(',',@last));
-	return @cur;
+	return map { expand_one_alias($_) } @_;
+}
+
+my %EXPANDED_ALIASES;
+sub expand_one_alias {
+	my $alias = shift;
+	if ($EXPANDED_ALIASES{$alias}) {
+		die "fatal: alias '$alias' expands to itself\n";
+	}
+	local $EXPANDED_ALIASES{$alias} = 1;
+	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
 }
 
 @to = expand_aliases(@to);
-- 
1.6.4.rc1.190.g0a8d.dirty
