From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/test-lib.sh: fix TRASH_DIRECTORY handling
Date: Sun, 14 Apr 2013 15:38:21 -0400
Message-ID: <20130414193821.GC4599@sigill.intra.peff.net>
References: <11cf45ad9779240b588da4b25c8ae5b6cc61b427.1365957201.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:38:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSkx-00029o-Cy
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3DNTi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:38:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45549 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299Ab3DNTi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:38:26 -0400
Received: (qmail 16317 invoked by uid 107); 14 Apr 2013 19:40:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 15:40:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 15:38:21 -0400
Content-Disposition: inline
In-Reply-To: <11cf45ad9779240b588da4b25c8ae5b6cc61b427.1365957201.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221157>

On Sun, Apr 14, 2013 at 05:34:56PM +0100, John Keeping wrote:

> After the location of $TRASH_DIRECTORY is adjusted by
> $TEST_OUTPUT_DIRECTORY, we go on to use the $test variable to make the
> trash directory and cd into it.  This means that when
> $TEST_OUTPUT_DIRECTORY is not "." and an absolute --root has not been
> specified, we do not remove the trash directory once the tests are
> complete (remove_trash is set to $TRASH_DIRECTORY).
> 
> Fix this by always referring to the trash directory as $TRASH_DIRECTORY.

Thanks, this seems to date back all the way to my f423ef5 (tests: allow
user to specify trash directory location, 2009-08-09), although I think
at that time it was not even possible to run the tests from any other
directory. So I am happy to blame Thomas's later patches for violating
my assumptions. :)

Definitely:

  Acked-by: Jeff King <peff@peff.net>

It probably makes sense to do the patch below on top, so that the error
doesn't happen again (I'd just as soon have it squashed into your patch,
since then then the motivation is even more obvious).

-- >8 --
Subject: [PATCH] t/test-lib.sh: drop "$test" variable

The $test variable is used as an interim buffer for
constructing $TRASH_DIRECTORY, and is almost compatible with
it (the exception being that $test has not been converted to
an absolute path). Let's get rid of it entirely so that
later code does not accidentally use it, thinking the two
are interchangeable.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a16bc73..b3f2488 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -600,11 +600,11 @@ fi
 fi
 
 # Test repository
-test="trash directory.$(basename "$0" .sh)"
-test -n "$root" && test="$root/$test"
-case "$test" in
-/*) TRASH_DIRECTORY="$test" ;;
- *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$test" ;;
+TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
+test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
+case "$TRASH_DIRECTORY" in
+/*) ;; # absolute path is good
+ *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$TRASH_DIRECTORY" || {
-- 
1.8.2.rc0.33.gd915649
