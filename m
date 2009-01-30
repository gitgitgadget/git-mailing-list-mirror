From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] chain kill signals for cleanup functions
Date: Fri, 30 Jan 2009 03:21:01 -0500
Message-ID: <20090130082101.GA28809@coredump.intra.peff.net>
References: <20090122042643.GB31427@coredump.intra.peff.net> <20090122060235.GC30133@coredump.intra.peff.net> <20090130075552.GA27716@coredump.intra.peff.net> <4982B68C.2070207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 09:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSoeT-0000eq-Gb
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 09:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbZA3IVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 03:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbZA3IVF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 03:21:05 -0500
Received: from peff.net ([208.65.91.99]:55530 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbZA3IVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 03:21:04 -0500
Received: (qmail 28476 invoked by uid 107); 30 Jan 2009 08:21:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 03:21:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 03:21:01 -0500
Content-Disposition: inline
In-Reply-To: <4982B68C.2070207@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107779>

On Fri, Jan 30, 2009 at 09:13:00AM +0100, Johannes Sixt wrote:

> Jeff King schrieb:
> > One fix would be to just "signal(SIGINT, SIG_DFL)" at the top. But I
> > think it makes the test cleaner to just switch to a more reliable
> > signal. The patch would look something like what is below. But I need to
> > know what exit code Windows generates for SIGTERM. Johannes?
> 
> The same as with SIGINT: 3.

Hmm. Clever.

Junio, can you apply this on top of the jk/signal-cleanup topic?

-- >8 --
Subject: [PATCH] t0005: use SIGTERM for sigchain test

The signal tests consists of checking that each of our
handlers is executed, and that the test program was killed
by the final signal. We arbitrarily used SIGINT as the kill
signal.

However, some platforms (notably Solaris) will default
SIGINT to SIG_IGN if there is no controlling terminal. In
that case, we don't end up killing the program with the
final signal and the test fails.

This is a problem since the test script should not depend
on outside factors; let's use SIGTERM instead, which should
behave consistently.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0005-signals.sh |    2 +-
 test-sigchain.c    |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 9707af7..09f855a 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -12,7 +12,7 @@ EOF
 test_expect_success 'sigchain works' '
 	test-sigchain >actual
 	case "$?" in
-	130) true ;; # POSIX w/ SIGINT=2
+	143) true ;; # POSIX w/ SIGTERM=15
 	  3) true ;; # Windows
 	  *) false ;;
 	esac &&
diff --git a/test-sigchain.c b/test-sigchain.c
index 8747dea..42db234 100644
--- a/test-sigchain.c
+++ b/test-sigchain.c
@@ -14,9 +14,9 @@ X(three)
 #undef X
 
 int main(int argc, char **argv) {
-	sigchain_push(SIGINT, one);
-	sigchain_push(SIGINT, two);
-	sigchain_push(SIGINT, three);
-	raise(SIGINT);
+	sigchain_push(SIGTERM, one);
+	sigchain_push(SIGTERM, two);
+	sigchain_push(SIGTERM, three);
+	raise(SIGTERM);
 	return 0;
 }
-- 
1.6.1.2.420.ga6a64.dirty
