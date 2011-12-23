From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pretty: refactor --format "magic" placeholders
Date: Fri, 23 Dec 2011 05:35:59 -0500
Message-ID: <20111223103558.GA28036@sigill.intra.peff.net>
References: <20111223100957.GA1247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 23 11:36:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re2U8-0003Db-Ax
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 11:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669Ab1LWKgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 05:36:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51727
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551Ab1LWKgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 05:36:01 -0500
Received: (qmail 32365 invoked by uid 107); 23 Dec 2011 10:42:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Dec 2011 05:42:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2011 05:35:59 -0500
Content-Disposition: inline
In-Reply-To: <20111223100957.GA1247@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187625>

Instead of assuming each magic token is a single character,
let's handle arbitrary-sized magic.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index 230fe1c..7b4d098 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1018,6 +1018,7 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 				 void *context)
 {
 	int consumed;
+	int magic_len = 0;
 	size_t orig_len;
 	enum {
 		NO_MAGIC,
@@ -1039,13 +1040,13 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	default:
 		break;
 	}
-	if (magic != NO_MAGIC)
+	if (magic != NO_MAGIC) {
+		magic_len++;
 		placeholder++;
+	}
 
 	orig_len = sb->len;
 	consumed = format_commit_one(sb, placeholder, context);
-	if (magic == NO_MAGIC)
-		return consumed;
 
 	if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
 		while (sb->len && sb->buf[sb->len - 1] == '\n')
@@ -1056,7 +1057,7 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
 			strbuf_insert(sb, orig_len, " ", 1);
 	}
-	return consumed + 1;
+	return consumed + magic_len;
 }
 
 static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
-- 
1.7.8.1.3.gba11d
