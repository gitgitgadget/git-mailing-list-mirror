From: Jeff King <peff@peff.net>
Subject: [PATCH 12/18] test-path-utils: fix normalize_path_copy output buffer
 size
Date: Mon, 15 Feb 2016 16:55:33 -0500
Message-ID: <20160215215533.GL10287@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:55:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR7M-0003XB-9p
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbcBOVzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:55:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:42506 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbcBOVzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:55:36 -0500
Received: (qmail 2710 invoked by uid 102); 15 Feb 2016 21:55:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:55:36 -0500
Received: (qmail 12567 invoked by uid 107); 15 Feb 2016 21:55:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:55:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:55:33 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286268>

The normalize_path_copy function needs an output buffer that
is at least as long as its input (it may shrink the path,
but never expand it). However, this test program feeds it
static PATH_MAX-sized buffers, which have no relation to the
input size.

In the normalize_ceiling_entry case, we do at least check
the size against PATH_MAX and die(), but that case is even
more convoluted. We normalize into a fixed-size buffer, free
the original, and then replace it with a strdup'd copy of
the result. But normalize_path_copy explicitly allows
normalizing in-place, so we can simply do that.

Signed-off-by: Jeff King <peff@peff.net>
---
 test-path-utils.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index c3adcd8..0c15f18 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -8,21 +8,14 @@
  */
 static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
 {
-	const char *ceil = item->string;
-	int len = strlen(ceil);
-	char buf[PATH_MAX+1];
+	char *ceil = item->string;
 
-	if (len == 0)
+	if (!*ceil)
 		die("Empty path is not supported");
-	if (len > PATH_MAX)
-		die("Path \"%s\" is too long", ceil);
 	if (!is_absolute_path(ceil))
 		die("Path \"%s\" is not absolute", ceil);
-	if (normalize_path_copy(buf, ceil) < 0)
+	if (normalize_path_copy(ceil, ceil) < 0)
 		die("Path \"%s\" could not be normalized", ceil);
-	len = strlen(buf);
-	free(item->string);
-	item->string = xstrdup(buf);
 	return 1;
 }
 
@@ -166,7 +159,7 @@ static struct test_data dirname_data[] = {
 int main(int argc, char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
-		char *buf = xmalloc(PATH_MAX + 1);
+		char *buf = xmallocz(strlen(argv[2]));
 		int rv = normalize_path_copy(buf, argv[2]);
 		if (rv)
 			buf = "++failed++";
-- 
2.7.1.572.gf718037
