From: Jeff King <peff@peff.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Fri, 25 May 2007 23:42:36 -0400
Message-ID: <20070526034236.GA18169@coredump.intra.peff.net>
References: <465750FE.9000406@iii.hu> <20070526004028.GA8940@sigill.intra.peff.net> <20070526011036.GA4169@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Szekeres Istvan <szekeres@iii.hu>,
	git@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
X-From: git-owner@vger.kernel.org Sat May 26 05:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrnB0-0005Mn-Jx
	for gcvg-git@gmane.org; Sat, 26 May 2007 05:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbXEZDml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 23:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXEZDml
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 23:42:41 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1695 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbXEZDmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 23:42:40 -0400
Received: (qmail 24585 invoked from network); 26 May 2007 03:42:43 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 May 2007 03:42:43 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2007 23:42:36 -0400
Content-Disposition: inline
In-Reply-To: <20070526011036.GA4169@gondor.apana.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48446>

On Sat, May 26, 2007 at 11:10:36AM +1000, Herbert Xu wrote:

> If you need to echo something that may have escapes in it, the portable
> way to do it is
> 
> printf '%s\n' "$test"

Ah, I see. I had thought the problem was coming from some dash
interpolation magic, but yes, it's just echo doing the conversion. And
POSIX is very clear that this is an implementation defined behavior.
Thanks very much for the response, Herbert.

Junio, patch is below. I have no idea how prevalent this issue is within
our scripts, but this at least fixes the reported bug.

-- >8 --
git-am: use printf instead of echo on user-supplied strings

Under some implementations of echo (such as that provided by
dash), backslash escapes are recognized without any other
options. This means that echo-ing user-supplied strings may
cause any backslash sequences in them to be converted. Using
printf resolves the ambiguity.

This bug can be seen when using git-am to apply a patch
whose subject contains the character sequence "\n"; the
characters are converted to a literal newline. Noticed by
Szekeres Istvan.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c9f66e2..543efd0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -331,7 +331,7 @@ do
 		ADD_SIGNOFF=
 	    fi
 	    {
-		echo "$SUBJECT"
+		printf '%s\n' "$SUBJECT"
 		if test -s "$dotest/msg-clean"
 		then
 			echo
@@ -394,7 +394,7 @@ do
 	fi
 
 	echo
-	echo "Applying '$SUBJECT'"
+	printf 'Applying %s\n' "$SUBJECT"
 	echo
 
 	case "$resolved" in
-- 
1.5.2.818.g9b59-dirty
