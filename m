From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] strbuf: add strbuf_addbuf_percentquote
Date: Wed, 13 Jan 2010 12:36:42 -0500
Message-ID: <20100113173642.GB16786@coredump.intra.peff.net>
References: <20100113173408.GA16652@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:36:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV79N-0004QP-V3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab0AMRgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181Ab0AMRgx
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:36:53 -0500
Received: from peff.net ([208.65.91.99]:46156 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223Ab0AMRgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:36:52 -0500
Received: (qmail 25339 invoked by uid 107); 13 Jan 2010 17:41:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 12:41:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 12:36:42 -0500
Content-Disposition: inline
In-Reply-To: <20100113173408.GA16652@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136850>

This is handy for creating strings which will be fed to
strbuf_expand or printf.

Signed-off-by: Jeff King <peff@coredump.intra.peff.net>
---
Changes since v1:
  - better name
  - style: s/dest/dst/
  - const src
  - no infinite loop for src == dst

 Documentation/technical/api-strbuf.txt |    7 +++++++
 strbuf.c                               |   11 +++++++++++
 strbuf.h                               |    1 +
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 3b1da10..afe2759 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -218,6 +218,13 @@ which can be used by the programmer of the callback as she sees fit.
 	placeholder and replacement string.  The array needs to be
 	terminated by an entry with placeholder set to NULL.
 
+`strbuf_addbuf_percentquote`::
+
+	Append the contents of one strbuf to another, quoting any
+	percent signs ("%") into double-percents ("%%") in the
+	destination. This is useful for literal data to be fed to either
+	strbuf_expand or to the *printf family of functions.
+
 `strbuf_addf`::
 
 	Add a formatted string to the buffer.
diff --git a/strbuf.c b/strbuf.c
index 6cbc1fc..0c46054 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -257,6 +257,17 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
 	return 0;
 }
 
+void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src)
+{
+	int i;
+	assert(dst != src);
+	for (i = 0; i < src->len; i++) {
+		if (src->buf[i] == '%')
+			strbuf_addch(dst, '%');
+		strbuf_addch(dst, src->buf[i]);
+	}
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index fa07ecf..84ac942 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -116,6 +116,7 @@ struct strbuf_expand_dict_entry {
 	const char *value;
 };
 extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
+extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
-- 
1.6.6.140.g92e4d.dirty
