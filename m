From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] strbuf: add strbuf_percentquote_buf
Date: Tue, 12 Jan 2010 10:41:53 -0500
Message-ID: <20100112154153.GB24957@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:42:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUisi-0005uR-Aq
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab0ALPmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988Ab0ALPmE
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:42:04 -0500
Received: from peff.net ([208.65.91.99]:54263 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab0ALPmC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:42:02 -0500
Received: (qmail 8040 invoked by uid 107); 12 Jan 2010 15:46:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 10:46:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 10:41:53 -0500
Content-Disposition: inline
In-Reply-To: <20100112153656.GA24840@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136730>

This is handy for creating strings which will be fed to
strbuf_expand or printf.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-strbuf.txt |    7 +++++++
 strbuf.c                               |   10 ++++++++++
 strbuf.h                               |    1 +
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index a0e0f85..d5ae3b0 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -214,6 +214,13 @@ which can be used by the programmer of the callback as she sees fit.
 	placeholder and replacement string.  The array needs to be
 	terminated by an entry with placeholder set to NULL.
 
+`strbuf_percentquote_buf`::
+
+	Append the contents of one strbuf to another, quoting any
+	percent signs ("%") into double-percents ("%%") in the
+	destination. This is useful for literal data to be fed to either
+	strbuf_expand or to the *printf family of functions.
+
 `strbuf_addf`::
 
 	Add a formatted string to the buffer.
diff --git a/strbuf.c b/strbuf.c
index 6cbc1fc..b5183c6 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -257,6 +257,16 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
 	return 0;
 }
 
+void strbuf_percentquote_buf(struct strbuf *dest, struct strbuf *src)
+{
+	int i;
+	for (i = 0; i < src->len; i++) {
+		if (src->buf[i] == '%')
+			strbuf_addch(dest, '%');
+		strbuf_addch(dest, src->buf[i]);
+	}
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index fa07ecf..f6bf055 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -116,6 +116,7 @@ struct strbuf_expand_dict_entry {
 	const char *value;
 };
 extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
+extern void strbuf_percentquote_buf(struct strbuf *dest, struct strbuf *src);
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
-- 
1.6.6.138.g309fc.dirty
