From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] teach convert_to_git a "dry run" mode
Date: Fri, 24 Feb 2012 04:41:55 -0500
Message-ID: <20120224094151.GA11846@sigill.intra.peff.net>
References: <20120224093924.GA11680@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 10:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rfK-00050q-3T
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 10:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298Ab2BXJmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 04:42:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55472
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab2BXJmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 04:42:08 -0500
Received: (qmail 22395 invoked by uid 107); 24 Feb 2012 09:42:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 04:42:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 04:41:55 -0500
Content-Disposition: inline
In-Reply-To: <20120224093924.GA11680@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191420>

Some callers may want to know whether convert_to_git will do
any conversion without actually feeding file data to it
(e.g., if you are using the decision to decide how to
acquire the data that might be converted). Rather than
replicate convert_to_git's logic in a separate function,
this patch lets callers pass a NULL buffer. The function
runs through its usual logic, except that it does not do any
actual conversion; the return value, instead of specifying
whether conversion happened, indicates whether conversion
might occur.

Note the use of the word "might" above. We cannot know for
sure whether conversion will occur without seeing the buffer
itself (because CRLF conversion may decide the file is
binary and do nothing). However, "might" is close enough for
callers which are trying to find out whether filters are in
used; they can be conservative and assume that the filters
will be used in such a case.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 12868ed..33aa72f 100644
--- a/convert.c
+++ b/convert.c
@@ -195,9 +195,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	char *dst;
 
 	if (crlf_action == CRLF_BINARY ||
-	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE) || !len)
+	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE) ||
+	    (src && !len))
 		return 0;
 
+	if (!src)
+		return 1;
+
 	gather_stats(src, len, &stats);
 
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS) {
@@ -391,6 +395,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (!cmd)
 		return 0;
 
+	if (!src)
+		return 1;
+
 	memset(&async, 0, sizeof(async));
 	async.proc = filter_buffer;
 	async.data = &params;
@@ -522,9 +529,12 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 {
 	char *dst, *dollar;
 
-	if (!ident || !count_ident(src, len))
+	if (!ident || (src && !count_ident(src, len)))
 		return 0;
 
+	if (!src)
+		return 1;
+
 	/* only grow if not in place */
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
@@ -754,13 +764,13 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		filter = ca.drv->clean;
 
 	ret |= apply_filter(path, src, len, dst, filter);
-	if (ret) {
+	if (ret && src) {
 		src = dst->buf;
 		len = dst->len;
 	}
 	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
 	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
-	if (ret) {
+	if (ret && src) {
 		src = dst->buf;
 		len = dst->len;
 	}
-- 
1.7.9.9.g04d94
