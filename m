From: Jeff King <peff@peff.net>
Subject: [PATCHv2 1/3] teach convert_to_git a "dry run" mode
Date: Fri, 24 Feb 2012 17:02:37 -0500
Message-ID: <20120224220237.GA1809@sigill.intra.peff.net>
References: <20120224211913.GA30942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 23:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S13Dw-0007VK-Jg
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 23:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab2BXWCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 17:02:39 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56104
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681Ab2BXWCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 17:02:39 -0500
Received: (qmail 29849 invoked by uid 107); 24 Feb 2012 22:02:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 17:02:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 17:02:37 -0500
Content-Disposition: inline
In-Reply-To: <20120224211913.GA30942@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191491>

Some callers may want to know whether convert_to_git will
actually do anything before performing the conversion
itself (e.g., to decide whether to stream or handle blobs
in-core). This patch lets callers specify the dry run mode
by passing a NULL destination buffer. The return value,
instead of indicating whether conversion happened, will
indicate whether conversion would occur.

For readability, we also include a wrapper function which
makes it more obvious we are not actually performing the
conversion.

Signed-off-by: Jeff King <peff@peff.net>
---
This splits the 1/2 from the first series into two patches. This part
handles the dry-run aspect. Unlike the previous version, it uses a NULL
destination, rather than a NULL source to indicate the dry-run mode.
Which just makes more sense, and means that the "don't bother doing
source analysis" bit is split off.

No callers introduced in this series actually want to do a dry-run with
a non-NULL source buffer, so that feature is of dubious value. But it's
not any extra code to do it this way, and the resulting commits are much
easier to read, I think.

 convert.c |   17 +++++++++++++++--
 convert.h |    5 +++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 12868ed..65fa9d5 100644
--- a/convert.c
+++ b/convert.c
@@ -231,6 +231,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if (!stats.cr)
 		return 0;
 
+	/*
+	 * At this point all of our source analysis is done, and we are sure we
+	 * would convert. If we are in dry-run mode, we can give an answer.
+	 */
+	if (!buf)
+		return 1;
+
 	/* only grow if not in place */
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
@@ -391,6 +398,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (!cmd)
 		return 0;
 
+	if (!dst)
+		return 1;
+
 	memset(&async, 0, sizeof(async));
 	async.proc = filter_buffer;
 	async.data = &params;
@@ -525,6 +535,9 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 	if (!ident || !count_ident(src, len))
 		return 0;
 
+	if (!buf)
+		return 1;
+
 	/* only grow if not in place */
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
@@ -754,13 +767,13 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		filter = ca.drv->clean;
 
 	ret |= apply_filter(path, src, len, dst, filter);
-	if (ret) {
+	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
 	}
 	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
 	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
-	if (ret) {
+	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
 	}
diff --git a/convert.h b/convert.h
index d799a16..ec5fd69 100644
--- a/convert.h
+++ b/convert.h
@@ -40,6 +40,11 @@ extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
+static inline int would_convert_to_git(const char *path, const char *src,
+				       size_t len, enum safe_crlf checksafe)
+{
+	return convert_to_git(path, src, len, NULL, checksafe);
+}
 
 /*****************************************************************
  *
-- 
1.7.9.11.gca600
