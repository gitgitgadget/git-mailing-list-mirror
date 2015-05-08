From: Jeff King <peff@peff.net>
Subject: Re: t0005-signals.sh fails with ksh
Date: Fri, 8 May 2015 16:55:48 -0400
Message-ID: <20150508205548.GB13457@peff.net>
References: <31108626.20150508231514@gmail.com>
 <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: evgeny <illumsoft.org@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:55:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpJM-0003aX-2g
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbbEHUzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:55:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:55864 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752165AbbEHUzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:55:51 -0400
Received: (qmail 25176 invoked by uid 102); 8 May 2015 20:55:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 15:55:51 -0500
Received: (qmail 23520 invoked by uid 107); 8 May 2015 20:56:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 16:56:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2015 16:55:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268666>

On Fri, May 08, 2015 at 01:34:49PM -0700, Junio C Hamano wrote:

> evgeny <illumsoft.org@gmail.com> writes:
> 
> > expecting success: 
> >         OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> >         test "$OUT" -eq 141
> >
> > t0005-signals.sh[499]: eval: syntax error at line 4: `(' unmatched
> > Memory fault
> 
> Does this work if you did
> 
> 	OUT=$( ( (large_git ; echo $? 1>&3) | : ) 3>&2 ) &&
> 
> instead?

It does for me. I've tested our suite with mksh before, and it passed
(that's why the earlier check already covers ksh). But using the ksh I
get from "apt-get install ksh" on Debian (ksh93, it looks like?) fails
as described. The change above prevents the shell from crashing, and
then if we also massage the code, the test passes (i.e., the patch
below).

I'm on the fence, though, on declaring ksh93 to be unsupported. I don't
know how many other instances of this are in our test suite, and it's
one more maintenance headache to deal with. Are there really platforms
with no actual POSIX shell (on Solaris, for example, the xpg6 shell is a
much better choice)?


diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index e7f27eb..cbf778e 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -9,14 +9,23 @@ two
 one
 EOF
 
+# $1 - expected signal number
+# $2 - actual exit code
+check_signal_exit () {
+	if test "$2" = "$(($1 + 128))"; then
+		return 0; # POSIX
+	elif test "$2" = "$(($1 + 256))"; then
+		return 0; # ksh
+	elif test "$2" = 3; then
+		return 0; # Windows
+	fi
+	echo >&2 "expected death by signal $1, got exit code $2"
+	return 1
+}
+
 test_expect_success 'sigchain works' '
 	{ test-sigchain >actual; ret=$?; } &&
-	case "$ret" in
-	143) true ;; # POSIX w/ SIGTERM=15
-	271) true ;; # ksh w/ SIGTERM=15
-	  3) true ;; # Windows
-	  *) false ;;
-	esac &&
+	check_signal_exit 15 $ret &&
 	test_cmp expect actual
 '
 
@@ -40,13 +49,13 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
-	test "$OUT" -eq 141
+	OUT=$( ( (large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	check_signal_exit 13 $OUT
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
-	test "$OUT" -eq 141
+	OUT=$( ( (trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	check_signal_exit 13 $OUT
 '
 
 test_done
