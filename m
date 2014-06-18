From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] strbuf: add xstrdup_fmt helper
Date: Wed, 18 Jun 2014 16:01:34 -0400
Message-ID: <20140618200133.GA23057@sigill.intra.peff.net>
References: <20140618200000.GA22994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:01:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxM3M-0001Yr-V0
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbaFRUBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:01:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:46978 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754867AbaFRUBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:01:36 -0400
Received: (qmail 31251 invoked by uid 102); 18 Jun 2014 20:01:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:01:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:01:34 -0400
Content-Disposition: inline
In-Reply-To: <20140618200000.GA22994@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252051>

You can use a strbuf to build up a string from parts, and
then detach it. In the general case, you might use multiple
strbuf_add* functions to do the building. However, in many
cases, a single strbuf_addf is sufficient, and we end up
with:

  struct strbuf buf = STRBUF_INIT;
  ...
  strbuf_addf(&buf, fmt, some, args);
  str = strbuf_detach(&buf, NULL);

We can make this much more readable (and avoid introducing
an extra variable, which can clutter the code) by
introducing a convenience function:

  str = xstrdup_fmt(fmt, some, args);

Signed-off-by: Jeff King <peff@peff.net>
---
I'm open to suggestions on the name. This really is the same thing
conceptually as the GNU asprintf(), but the interface is different (that
function takes a pointer-to-pointer as an out-parameter, and returns the
number of characters return).

 strbuf.c | 19 +++++++++++++++++++
 strbuf.h |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index ac62982..6674d74 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -600,3 +600,22 @@ char *xstrdup_tolower(const char *string)
 	result[i] = '\0';
 	return result;
 }
+
+char *xstrdup_vfmt(const char *fmt, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_vaddf(&buf, fmt, ap);
+	return strbuf_detach(&buf, NULL);
+}
+
+char *xstrdup_fmt(const char *fmt, ...)
+{
+	va_list ap;
+	char *ret;
+
+	va_start(ap, fmt);
+	ret = xstrdup_vfmt(fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
diff --git a/strbuf.h b/strbuf.h
index e9ad03e..61818f9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -187,4 +187,13 @@ extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 
+/*
+ * Create a newly allocated string using printf format. You can do this easily
+ * with a strbuf, but this provides a shortcut to save a few lines.
+ */
+__attribute__((format (printf, 1, 0)))
+char *xstrdup_vfmt(const char *fmt, va_list ap);
+__attribute__((format (printf, 1, 2)))
+char *xstrdup_fmt(const char *fmt, ...);
+
 #endif /* STRBUF_H */
-- 
2.0.0.566.gfe3e6b2
