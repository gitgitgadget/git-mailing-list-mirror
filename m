From: Jeff King <peff@peff.net>
Subject: [PATCH 36/68] upload-archive: convert sprintf to strbuf
Date: Thu, 24 Sep 2015 17:07:25 -0400
Message-ID: <20150924210724.GG30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDk6-00028o-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbbIXVHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:35982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753523AbbIXVH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:27 -0400
Received: (qmail 12041 invoked by uid 102); 24 Sep 2015 21:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:27 -0500
Received: (qmail 29294 invoked by uid 107); 24 Sep 2015 21:07:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278591>

When we report an error to the client, we format it into a
fixed-size buffer using vsprintf(). This can't actually
overflow in practice, since we only format a very tame
subset of strings (mostly strerror() output). However, it's
hard to tell immediately, so let's just use a strbuf so
readers do not have to wonder.

We do add an allocation here, but the performance is not
important; the next step is to call die() anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/upload-archive.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 32ab94c..dbfe14f 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -49,15 +49,14 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 __attribute__((format (printf, 1, 2)))
 static void error_clnt(const char *fmt, ...)
 {
-	char buf[1024];
+	struct strbuf buf = STRBUF_INIT;
 	va_list params;
-	int len;
 
 	va_start(params, fmt);
-	len = vsprintf(buf, fmt, params);
+	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
-	send_sideband(1, 3, buf, len, LARGE_PACKET_MAX);
-	die("sent error to the client: %s", buf);
+	send_sideband(1, 3, buf.buf, buf.len, LARGE_PACKET_MAX);
+	die("sent error to the client: %s", buf.buf);
 }
 
 static ssize_t process_input(int child_fd, int band)
-- 
2.6.0.rc3.454.g204ad51
