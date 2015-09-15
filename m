From: Jeff King <peff@peff.net>
Subject: [PATCH 35/67] upload-archive: convert sprintf to strbuf
Date: Tue, 15 Sep 2015 11:51:05 -0400
Message-ID: <20150915155104.GI29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:51:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsVx-0005LX-27
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbbIOPvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:51:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:59373 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753700AbbIOPvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:51:07 -0400
Received: (qmail 12666 invoked by uid 102); 15 Sep 2015 15:51:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:51:07 -0500
Received: (qmail 7410 invoked by uid 107); 15 Sep 2015 15:51:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:51:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:51:05 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277936>

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
2.6.0.rc2.408.ga2926b9
