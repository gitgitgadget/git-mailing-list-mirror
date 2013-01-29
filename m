From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] strbuf: add string-chomping functions
Date: Tue, 29 Jan 2013 04:15:40 -0500
Message-ID: <20130129091540.GB9999@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 10:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U07IV-0007lP-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 10:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab3A2JPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 04:15:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53243 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab3A2JPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 04:15:44 -0500
Received: (qmail 19989 invoked by uid 107); 29 Jan 2013 09:17:06 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 04:17:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 04:15:40 -0500
Content-Disposition: inline
In-Reply-To: <20130129091434.GA6975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214918>

Sometimes it is handy to cut a trailing string off the end
of a strbuf (e.g., a file extension). These helper functions
make it a one-liner.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 11 +++++++++++
 strbuf.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 9a373be..8199ced 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -106,6 +106,17 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_chompmem(struct strbuf *sb, const void *data, size_t len)
+{
+	if (sb->len >= len && !memcmp(data, sb->buf + sb->len - len, len))
+		strbuf_setlen(sb, sb->len - len);
+}
+
+void strbuf_chompstr(struct strbuf *sb, const char *str)
+{
+	strbuf_chompmem(sb, str, strlen(str));
+}
+
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 				 int terminator, int max)
 {
diff --git a/strbuf.h b/strbuf.h
index ecae4e2..3aeb815 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -42,6 +42,8 @@ extern void strbuf_ltrim(struct strbuf *);
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
+extern void strbuf_chompmem(struct strbuf *, const void *, size_t);
+extern void strbuf_chompstr(struct strbuf *, const char *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 /*
-- 
1.8.0.2.16.g72e2fc9
