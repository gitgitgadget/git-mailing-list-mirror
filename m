From: Jeff King <peff@peff.net>
Subject: [PATCH 02/14] log: refactor add_header to drop some magic numbers
Date: Tue, 29 Dec 2015 02:20:48 -0500
Message-ID: <20151229072048.GB8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:20:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoaU-0007Os-UN
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbbL2HUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:20:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:46613 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752074AbbL2HUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:20:51 -0500
Received: (qmail 17709 invoked by uid 102); 29 Dec 2015 07:20:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:20:51 -0600
Received: (qmail 19802 invoked by uid 107); 29 Dec 2015 07:21:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:21:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:20:48 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283093>

We want to chomp newlines off the end of the "value" string.
But because it's const, we must track its length rather than
writing a NUL. This leads to us having to tweak that length
later, to account for moving the pointer forward.

Since we are about to create a copy of it anyway, let's just
wait and chomp at the end.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e00cea7..76823e6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -675,21 +675,18 @@ static struct string_list extra_cc;
 static void add_header(const char *value)
 {
 	struct string_list_item *item;
-	int len = strlen(value);
-	while (len && value[len - 1] == '\n')
-		len--;
+	size_t len;
 
-	if (!strncasecmp(value, "to: ", 4)) {
+	if (!strncasecmp(value, "to: ", 4))
 		item = string_list_append(&extra_to, value + 4);
-		len -= 4;
-	} else if (!strncasecmp(value, "cc: ", 4)) {
+	else if (!strncasecmp(value, "cc: ", 4))
 		item = string_list_append(&extra_cc, value + 4);
-		len -= 4;
-	} else {
+	else
 		item = string_list_append(&extra_hdr, value);
-	}
 
-	item->string[len] = '\0';
+	len = strlen(item->string);
+	while (len && item->string[len - 1] == '\n')
+		item->string[--len] = '\0';
 }
 
 #define THREAD_SHALLOW 1
-- 
2.7.0.rc3.367.g09631da
