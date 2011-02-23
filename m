From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] strbuf: add fixed-length version of add_wrapped_text
Date: Wed, 23 Feb 2011 04:50:19 -0500
Message-ID: <20110223095018.GA9222@sigill.intra.peff.net>
References: <20110223094844.GA9205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 10:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsBMZ-0005hT-Ax
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 10:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab1BWJuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 04:50:21 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57802 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab1BWJuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 04:50:20 -0500
Received: (qmail 10704 invoked by uid 111); 23 Feb 2011 09:50:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 09:50:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 04:50:19 -0500
Content-Disposition: inline
In-Reply-To: <20110223094844.GA9205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167681>

The function strbuf_add_wrapped_text takes a NUL-terminated
string. This makes it annoying to wrap strings we have as a
pointer and a length.

Refactoring strbuf_add_wrapped_text and all of its
sub-functions to handle fixed-length strings turned out to
be really ugly. So this implementation is lame; it just
strdups the text and operates on the NUL-terminated version.
This should be fine as the strings we are wrapping are
generally pretty short.  If it becomes a problem, we can
optimize later.

Signed-off-by: Jeff King <peff@peff.net>
---
 utf8.c |    9 +++++++++
 utf8.h |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/utf8.c b/utf8.c
index 84cfc72..8acbc66 100644
--- a/utf8.c
+++ b/utf8.c
@@ -405,6 +405,15 @@ new_line:
 	}
 }
 
+int strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
+			     int indent, int indent2, int width)
+{
+	char *tmp = xstrndup(data, len);
+	int r = strbuf_add_wrapped_text(buf, tmp, indent, indent2, width);
+	free(tmp);
+	return r;
+}
+
 int is_encoding_utf8(const char *name)
 {
 	if (!name)
diff --git a/utf8.h b/utf8.h
index ebc4d2f..81f2c82 100644
--- a/utf8.h
+++ b/utf8.h
@@ -10,6 +10,8 @@ int is_encoding_utf8(const char *name);
 
 int strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
+int strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
+			     int indent, int indent2, int width);
 
 #ifndef NO_ICONV
 char *reencode_string(const char *in, const char *out_encoding, const char *in_encoding);
-- 
1.7.2.5.15.gfdd1c
