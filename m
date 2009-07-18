From: Jeff King <peff@peff.net>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 18:29:47 -0400
Message-ID: <20090718222947.GA31147@coredump.intra.peff.net>
References: <20090718134551.GC16708@vidovic>
 <20090718135649.GA6759@sigill.intra.peff.net>
 <20090718141658.GE16708@vidovic>
 <200907182106.06776.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 19 00:30:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSIPp-0002Qo-AE
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 00:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbZGRW3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 18:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbZGRW3w
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 18:29:52 -0400
Received: from peff.net ([208.65.91.99]:51322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbZGRW3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 18:29:52 -0400
Received: (qmail 1761 invoked by uid 107); 18 Jul 2009 22:31:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 18 Jul 2009 18:31:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Jul 2009 18:29:47 -0400
Content-Disposition: inline
In-Reply-To: <200907182106.06776.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123539>

On Sat, Jul 18, 2009 at 09:06:06PM +0200, Johannes Sixt wrote:

> On Samstag, 18. Juli 2009, Nicolas Sebrecht wrote:
> > ==10807== Process terminating with default action of signal 11 (SIGSEGV)
> > ==10807==  Access not within mapped region at address 0x1
> > ==10807==    at 0x4C22349: strlen (in
> > /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so) ==10807==    by
> > 0x5616ED6: vfprintf (in /lib64/libc-2.8.so)
> > ==10807==    by 0x563C159: vsnprintf (in /lib64/libc-2.8.so)
> > ==10807==    by 0x495E90: git_vsnprintf (snprintf.c:38)
> > ==10807==    by 0x48917B: strbuf_addf (strbuf.c:203)
> 
> amd64-linux, and you build with SNPRINTF_RETURNS_BOGUS? Why do you have this 
> option set?

Ah, that's what I was missing. I can reproduce it by setting
SNPRINTF_RETURNS_BOGUS. I think the problem is in the git_vsnprintf
code, and it just by coincidence triggers in this test because of the
exact string we are trying to format.

Look at compat/snprintf.c. In git_vsnprintf, we are passed a "va_list
ap", which we then repeatedly call vsnprintf on, checking the return to
make sure we have enough space. But using a va_list repeatedly without a
va_end and va_start in the middle invokes undefined behavior. So we need
to va_copy it and use the copy.

A patch is below, which fixes the problem for me. However, va_copy is
C99, so we would generally try to avoid it. But I don't think there is a
portable way of writing this function without it. And most systems
shouldn't need to use our snprintf at all, so maybe it is portable
enough. I dunno.

---
diff --git a/compat/snprintf.c b/compat/snprintf.c
index 6c0fb05..e862db6 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -18,9 +18,12 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 {
 	char *s;
 	int ret = -1;
+	va_list cp;
 
 	if (maxsize > 0) {
-		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		va_copy(cp, ap);
+		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
+		va_end(cp);
 		if (ret == maxsize-1)
 			ret = -1;
 		/* Windows does not NUL-terminate if result fills buffer */
@@ -39,7 +42,9 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 		if (! str)
 			break;
 		s = str;
-		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		va_copy(cp, ap);
+		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
+		va_end(cp);
 		if (ret == maxsize-1)
 			ret = -1;
 	}
