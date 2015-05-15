From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] http-backend: fix die recursion with custom handler
Date: Fri, 15 May 2015 02:29:27 -0400
Message-ID: <20150515062926.GA30890@peff.net>
References: <20150515062901.GA30768@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 08:29:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt97m-0001ji-6U
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 08:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbbEOG33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 02:29:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:59050 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753670AbbEOG33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 02:29:29 -0400
Received: (qmail 22819 invoked by uid 102); 15 May 2015 06:29:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 01:29:29 -0500
Received: (qmail 31478 invoked by uid 107); 15 May 2015 06:29:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 02:29:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 02:29:27 -0400
Content-Disposition: inline
In-Reply-To: <20150515062901.GA30768@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269129>

When we die() in http-backend, we call a custom handler that
writes an HTTP 500 response to stdout, then reports the
error to stderr. Our routines for writing out the HTTP
response may themselves die, leading to us entering die()
again.

When it was originally written, that was OK; our custom
handler keeps a variable to notice this and does not
recurse. However, since cd163d4 (usage.c: detect recursion
in die routines and bail out immediately, 2012-11-14), the
main die() implementation detects recursion before we even
get to our custom handler, and bails without printing
anything useful.

We can handle this case by doing two things:

  1. Installing a custom die_is_recursing handler that
     allows us to enter up to one level of recursion. Only
     the first call to our custom handler will try to write
     out the error response. So if we die again, that is OK.
     If we end up dying more than that, it is a sign that we
     are in an infinite recursion.

  2. Reporting the error to stderr before trying to write
     out the HTTP response. In the current code, if we do
     die() trying to write out the response, we'll exit
     immediately from this second die(), and never get a
     chance to output the original error (which is almost
     certainly the more interesting one; the second die is
     just going to be along the lines of "I tried to write
     to stdout but it was closed").

Signed-off-by: Jeff King <peff@peff.net>
---
 http-backend.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index b6c0484..3ad82a8 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -500,21 +500,24 @@ static void service_rpc(char *service_name)
 	strbuf_release(&buf);
 }
 
+static int dead;
 static NORETURN void die_webcgi(const char *err, va_list params)
 {
-	static int dead;
+	if (dead <= 1) {
+		vreportf("fatal: ", err, params);
 
-	if (!dead) {
-		dead = 1;
 		http_status(500, "Internal Server Error");
 		hdr_nocache();
 		end_headers();
-
-		vreportf("fatal: ", err, params);
 	}
 	exit(0); /* we successfully reported a failure ;-) */
 }
 
+static int die_webcgi_recursing(void)
+{
+	return dead++ > 1;
+}
+
 static char* getdir(void)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -569,6 +572,7 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 	set_die_routine(die_webcgi);
+	set_die_is_recursing_routine(die_webcgi_recursing);
 
 	if (!method)
 		die("No REQUEST_METHOD from server");
-- 
2.4.1.396.g7ba6d7b
