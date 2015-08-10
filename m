From: Jeff King <peff@peff.net>
Subject: [PATCH 02/17] cache.h: complete set of git_path_submodule helpers
Date: Mon, 10 Aug 2015 05:32:22 -0400
Message-ID: <20150810093222.GB30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:32:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjRY-0002hD-0z
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbbHJJc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:32:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:42805 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753812AbbHJJc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:32:27 -0400
Received: (qmail 30738 invoked by uid 102); 10 Aug 2015 09:32:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:32:27 -0500
Received: (qmail 3023 invoked by uid 107); 10 Aug 2015 09:32:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:32:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:32:22 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275568>

The git_path function has "git_pathdup" and
"strbuf_git_path" variants, but git_submodule_path only
comes in the dangerous, static-buffer variant. That makes
refactoring callers to use the safer functions hard (since
they don't exist).

Since we're already using a strbuf behind the scenes, it's
easy to expose all three of these interfaces with thin
wrappers.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  5 +++++
 path.c  | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 8db884e..6f74f33 100644
--- a/cache.h
+++ b/cache.h
@@ -724,10 +724,15 @@ extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
+extern void strbuf_git_path_submodule(struct strbuf *sb, const char *path,
+				      const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 extern char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
+extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
 
 extern void report_linked_checkout_garbage(void);
 
diff --git a/path.c b/path.c
index 10f4cbf..9aad9a1 100644
--- a/path.c
+++ b/path.c
@@ -224,11 +224,10 @@ const char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
 
-const char *git_path_submodule(const char *path, const char *fmt, ...)
+static void do_submodule_path(struct strbuf *buf, const char *path,
+			      const char *fmt, va_list args)
 {
-	struct strbuf *buf = get_pathname();
 	const char *git_dir;
-	va_list args;
 
 	strbuf_addstr(buf, path);
 	if (buf->len && buf->buf[buf->len - 1] != '/')
@@ -242,13 +241,39 @@ const char *git_path_submodule(const char *path, const char *fmt, ...)
 	}
 	strbuf_addch(buf, '/');
 
-	va_start(args, fmt);
 	strbuf_vaddf(buf, fmt, args);
-	va_end(args);
 	strbuf_cleanup_path(buf);
+}
+
+const char *git_path_submodule(const char *path, const char *fmt, ...)
+{
+	va_list args;
+	struct strbuf *buf = get_pathname();
+	va_start(args, fmt);
+	do_submodule_path(buf, path, fmt, args);
+	va_end(args);
 	return buf->buf;
 }
 
+char *git_pathdup_submodule(const char *path, const char *fmt, ...)
+{
+	va_list args;
+	struct strbuf buf = STRBUF_INIT;
+	va_start(args, fmt);
+	do_submodule_path(&buf, path, fmt, args);
+	va_end(args);
+	return strbuf_detach(&buf, NULL);
+}
+
+void strbuf_git_path_submodule(struct strbuf *buf, const char *path,
+			       const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	do_submodule_path(buf, path, fmt, args);
+	va_end(args);
+}
+
 int validate_headref(const char *path)
 {
 	struct stat st;
-- 
2.5.0.414.g670f2a4
