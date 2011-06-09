From: Jeff King <peff@peff.net>
Subject: [PATCH 01/10] strbuf_split: add a max parameter
Date: Thu, 9 Jun 2011 11:51:22 -0400
Message-ID: <20110609155121.GA25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhW7-0006b0-1Q
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab1FIPv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:51:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52487
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab1FIPvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:51:25 -0400
Received: (qmail 13871 invoked by uid 107); 9 Jun 2011 15:51:32 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:51:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:51:22 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175533>

Sometimes when splitting, you only want a limited number of
fields, and for the final field to contain "everything
else", even if it includes the delimiter.

This patch introduces strbuf_split_max, which provides a
"max number of fields" parameter; it behaves similarly to
perl's "split" with a 3rd field.

The existing 2-argument form of strbuf_split is retained for
compatibility and ease-of-use.

Signed-off-by: Jeff King <peff@peff.net>
---
I am tempted to just call this new one strbuf_split and update all
callers. There aren't that many.

 strbuf.c |    7 +++++--
 strbuf.h |    7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 09c43ae..64f6c1e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -103,7 +103,7 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
+struct strbuf **strbuf_split_max(const struct strbuf *sb, int delim, int max)
 {
 	int alloc = 2, pos = 0;
 	char *n, *p;
@@ -114,7 +114,10 @@ struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
 	p = n = sb->buf;
 	while (n < sb->buf + sb->len) {
 		int len;
-		n = memchr(n, delim, sb->len - (n - sb->buf));
+		if (max <= 0 || pos + 1 < max)
+			n = memchr(n, delim, sb->len - (n - sb->buf));
+		else
+			n = NULL;
 		if (pos + 1 >= alloc) {
 			alloc = alloc * 2;
 			ret = xrealloc(ret, sizeof(struct strbuf *) * alloc);
diff --git a/strbuf.h b/strbuf.h
index 9e6d9fa..4cf1dcd 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -44,7 +44,12 @@ extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
-extern struct strbuf **strbuf_split(const struct strbuf *, int delim);
+extern struct strbuf **strbuf_split_max(const struct strbuf *,
+					int delim, int max);
+static inline struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
+{
+	return strbuf_split_max(sb, delim, 0);
+}
 extern void strbuf_list_free(struct strbuf **);
 
 /*----- add data in your buffer -----*/
-- 
1.7.6.rc1.36.g91167
