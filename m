From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] chain kill signals for cleanup functions
Date: Fri, 30 Jan 2009 02:55:52 -0500
Message-ID: <20090130075552.GA27716@coredump.intra.peff.net>
References: <20090122042643.GB31427@coredump.intra.peff.net> <20090122060235.GC30133@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 08:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSoFp-0002tl-62
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 08:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZA3Hz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 02:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbZA3Hz4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 02:55:56 -0500
Received: from peff.net ([208.65.91.99]:53968 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbZA3Hzz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 02:55:55 -0500
Received: (qmail 28335 invoked by uid 107); 30 Jan 2009 07:56:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 02:56:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 02:55:52 -0500
Content-Disposition: inline
In-Reply-To: <20090122060235.GC30133@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107777>

On Thu, Jan 22, 2009 at 01:02:35AM -0500, Jeff King wrote:

> diff --git a/test-sigchain.c b/test-sigchain.c
> new file mode 100644
> index 0000000..8747dea
> --- /dev/null
> +++ b/test-sigchain.c
> [...]
> +int main(int argc, char **argv) {
> +	sigchain_push(SIGINT, one);
> +	sigchain_push(SIGINT, two);
> +	sigchain_push(SIGINT, three);
> +	raise(SIGINT);
> +	return 0;
> +}

The signal-handling test was failing on my Solaris auto-build. After
much painful debugging, it seems that when running without a controlling
terminal (such as under cron), the signal handler for terminal related
signals (including SIGINT) is initialized to SIG_IGN. Thus after popping
all of our signal handlers, we restore the SIG_IGN, the program is _not_
killed by the signal, and the test fails.

One fix would be to just "signal(SIGINT, SIG_DFL)" at the top. But I
think it makes the test cleaner to just switch to a more reliable
signal. The patch would look something like what is below. But I need to
know what exit code Windows generates for SIGTERM. Johannes?

---
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
