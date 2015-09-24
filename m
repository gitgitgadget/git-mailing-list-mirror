From: Jeff King <peff@peff.net>
Subject: [PATCH 05/68] add xsnprintf helper function
Date: Thu, 24 Sep 2015 17:05:37 -0400
Message-ID: <20150924210537.GB30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:05:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDi4-0000EN-RV
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbbIXVFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:05:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:35904 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753958AbbIXVFj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:05:39 -0400
Received: (qmail 11800 invoked by uid 102); 24 Sep 2015 21:05:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:05:39 -0500
Received: (qmail 28871 invoked by uid 107); 24 Sep 2015 21:05:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:05:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:05:37 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278564>

There are a number of places in the code where we call
sprintf(), with the assumption that the output will fit into
the buffer. In many cases this is true (e.g., formatting a
number into a large buffer), but it is hard to tell
immediately from looking at the code. It would be nice if we
had some run-time check to make sure that our assumption is
correct (and to communicate to readers of the code that we
are not blindly calling sprintf, but have actually thought
about this case).

This patch introduces xsnprintf, which behaves just like
snprintf, except that it dies whenever the output is
truncated. This acts as a sort of assert() for these cases,
which can help find places where the assumption is violated
(as opposed to truncating and proceeding, which may just
silently give a wrong answer).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h |  3 +++
 wrapper.c         | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index f649e81..348b9dc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -744,6 +744,9 @@ static inline size_t xsize_t(off_t len)
 	return (size_t)len;
 }
 
+__attribute__((format (printf, 3, 4)))
+extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
+
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
 
diff --git a/wrapper.c b/wrapper.c
index 0e22d43..6fcaa4d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -621,6 +621,22 @@ char *xgetcwd(void)
 	return strbuf_detach(&sb, NULL);
 }
 
+int xsnprintf(char *dst, size_t max, const char *fmt, ...)
+{
+	va_list ap;
+	int len;
+
+	va_start(ap, fmt);
+	len = vsnprintf(dst, max, fmt, ap);
+	va_end(ap);
+
+	if (len < 0)
+		die("BUG: your snprintf is broken");
+	if (len >= max)
+		die("BUG: attempt to snprintf into too-small buffer");
+	return len;
+}
+
 static int write_file_v(const char *path, int fatal,
 			const char *fmt, va_list params)
 {
-- 
2.6.0.rc3.454.g204ad51
