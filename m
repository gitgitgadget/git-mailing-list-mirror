From: Jeff King <peff@peff.net>
Subject: [PATCH 06/68] add git_path_buf helper function
Date: Thu, 24 Sep 2015 17:05:40 -0400
Message-ID: <20150924210540.GC30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:05:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDiA-0000OS-3q
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbbIXVFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:05:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:35906 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753958AbbIXVFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:05:42 -0400
Received: (qmail 11805 invoked by uid 102); 24 Sep 2015 21:05:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:05:42 -0500
Received: (qmail 28876 invoked by uid 107); 24 Sep 2015 21:05:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:05:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:05:40 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278565>

If you have a function that uses git_path a lot, but would
prefer to avoid the static buffers, it's useful to keep a
single scratch buffer locally and reuse it for each call.
You used to be able to do this with git_snpath:

  char buf[PATH_MAX];

  foo(git_snpath(buf, sizeof(buf), "foo"));
  bar(git_snpath(buf, sizeof(buf), "bar"));

but since 1a83c24, git_snpath has been replaced with
strbuf_git_path. This is good, because it removes the
arbitrary PATH_MAX limit. But using strbuf_git_path is more
awkward for two reasons:

  1. It adds to the buffer, rather than replacing it. This
     is consistent with other strbuf functions, but makes
     reuse of a single buffer more tedious.

  2. It doesn't return the buffer, so you can't format
     as part of a function's arguments.

The new git_path_buf solves both of these, so you can use it
like:

  struct strbuf buf = STRBUF_INIT;

  foo(git_path_buf(&buf, "foo"));
  bar(git_path_buf(&buf, "bar"));

  strbuf_release(&buf);

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  2 ++
 path.c  | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/cache.h b/cache.h
index 79066e5..e231e47 100644
--- a/cache.h
+++ b/cache.h
@@ -723,6 +723,8 @@ extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
+extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
 extern void strbuf_git_path_submodule(struct strbuf *sb, const char *path,
 				      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
diff --git a/path.c b/path.c
index 95acbaf..46a4d27 100644
--- a/path.c
+++ b/path.c
@@ -175,6 +175,16 @@ static void do_git_path(struct strbuf *buf, const char *fmt, va_list args)
 	strbuf_cleanup_path(buf);
 }
 
+char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
+{
+	va_list args;
+	strbuf_reset(buf);
+	va_start(args, fmt);
+	do_git_path(buf, fmt, args);
+	va_end(args);
+	return buf->buf;
+}
+
 void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 {
 	va_list args;
-- 
2.6.0.rc3.454.g204ad51
