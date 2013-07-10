From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] wt-status: use "format" function attribute for
 status_printf
Date: Tue, 9 Jul 2013 20:23:28 -0400
Message-ID: <20130710002328.GC19423@sigill.intra.peff.net>
References: <20130710001659.GA11643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Jul 10 02:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwiC2-0001QG-8f
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 02:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab3GJAXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 20:23:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:43299 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab3GJAXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 20:23:33 -0400
Received: (qmail 26012 invoked by uid 102); 10 Jul 2013 00:24:49 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 19:24:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 20:23:28 -0400
Content-Disposition: inline
In-Reply-To: <20130710001659.GA11643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230019>

These functions could benefit from the added compile-time
safety of having the compiler check printf arguments.

Unfortunately, we also sometimes pass an empty format string,
which will cause false positives with -Wformat-zero-length.
In this case, that warning is wrong because our function is
not a no-op with an empty format: it may be printing
colorized output along with a trailing newline.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm torn on this one. It really does provide us with more compile-time
safety checks, but it's annoying that "-Wall -Werror" will no longer
work out of the box.

We could also add a status_printf_empty_line() function, but that feels
like a bit of a hack. Searching online, I also found the amusing
suggestion to do:

  status_printf_ln(s, color, "%.*s", 0,
                   "-Wformat-zero-length please choke on a bucket of socks");

but I think that is probably worse than adding a specialized function.

 wt-status.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wt-status.h b/wt-status.h
index 4121bc2..fb7152e 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -96,9 +96,9 @@ void wt_porcelain_print(struct wt_status *s);
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
 
-void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...)
-	;
-void status_printf(struct wt_status *s, const char *color, const char *fmt, ...)
-	;
+__attribute__((format (printf, 3, 4)))
+void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
 #endif /* STATUS_H */
-- 
1.8.3.rc3.24.gec82cb9
