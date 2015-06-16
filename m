From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] trace: add pid to each output line
Date: Tue, 16 Jun 2015 15:36:39 -0400
Message-ID: <20150616193639.GB15931@peff.net>
References: <20150616193102.GA15856@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:36:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4wf8-0003An-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 21:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbbFPTgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 15:36:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:47004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751399AbbFPTgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 15:36:42 -0400
Received: (qmail 20373 invoked by uid 102); 16 Jun 2015 19:36:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 14:36:41 -0500
Received: (qmail 18264 invoked by uid 107); 16 Jun 2015 19:36:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 15:36:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 15:36:39 -0400
Content-Disposition: inline
In-Reply-To: <20150616193102.GA15856@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271790>

When there are many git commands running, it can be
confusing which process is producing which message. And if
one is trying to correlate a specific invocation with a
trace-file created using "%p", it's rather impossible.

Let's print the pid alongside each line. This does extend
the already-wide trace lines. We could make it optional, but
it's probably not worth the complexity of extra knobs.
Looking at trace output is already an exceptional thing to
be doing, and verbose output is not going to bother anyone.

Signed-off-by: Jeff King <peff@peff.net>
---
I think you can technically get by without this for most cases, as doing
GIT_TRACE=base.%p will get you the "built-in: ..." line for index-pack,
pack-objects, etc, which you can then correlate with a matching
GIT_TRACE_STDIN filename.

 trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/trace.c b/trace.c
index e1d1360..a7ec484 100644
--- a/trace.c
+++ b/trace.c
@@ -123,12 +123,13 @@ static int prepare_trace_line(const char *file, int line,
 	localtime_r(&secs, &tm);
 	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
 		    tm.tm_sec, (long) tv.tv_usec);
+	strbuf_addf(buf, "[pid=%lu] ", (unsigned long)getpid());
 
 #ifdef HAVE_VARIADIC_MACROS
 	/* print file:line */
 	strbuf_addf(buf, "%s:%d ", file, line);
-	/* align trace output (column 40 catches most files names in git) */
-	while (buf->len < 40)
+	/* align trace output (column 50 catches most files names in git) */
+	while (buf->len < 50)
 		strbuf_addch(buf, ' ');
 #endif
 
-- 
2.4.3.699.g84b4da7
