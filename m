From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] add missing "format" function attributes
Date: Tue, 9 Jul 2013 20:18:40 -0400
Message-ID: <20130710001840.GA19423@sigill.intra.peff.net>
References: <20130710001659.GA11643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Jul 10 02:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwi7Q-0005Yo-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 02:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab3GJASq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 20:18:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:43258 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab3GJASo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 20:18:44 -0400
Received: (qmail 25727 invoked by uid 102); 10 Jul 2013 00:20:00 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 19:20:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 20:18:40 -0400
Content-Disposition: inline
In-Reply-To: <20130710001659.GA11643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230017>

For most of our functions that take printf-like formats, we
use gcc's __attribute__((format)) to get compiler warnings
when the functions are misused. Let's give a few more
functions the same protection.

In most cases, the annotations do not uncover any actual
bugs; the only code change needed is that we passed a size_t
to transfer_debug, which expected an int. Since we expect
the passed-in value to be a relatively small buffer size
(and cast a similar value to int directly below), we can
just cast away the problem.

Signed-off-by: Jeff King <peff@peff.net>
---
 advice.h           | 1 +
 trace.c            | 1 +
 transport-helper.c | 3 ++-
 utf8.h             | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index 93a7d11..08fbc8e 100644
--- a/advice.h
+++ b/advice.h
@@ -21,6 +21,7 @@ int git_default_advice_config(const char *var, const char *value);
 extern int advice_rm_hints;
 
 int git_default_advice_config(const char *var, const char *value);
+__attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
diff --git a/trace.c b/trace.c
index 5ec0e3b..3d744d1 100644
--- a/trace.c
+++ b/trace.c
@@ -75,6 +75,7 @@ static void trace_vprintf(const char *key, const char *fmt, va_list ap)
 	strbuf_release(&buf);
 }
 
+__attribute__((format (printf, 2, 3)))
 static void trace_printf_key(const char *key, const char *fmt, ...)
 {
 	va_list ap;
diff --git a/transport-helper.c b/transport-helper.c
index db9bd18..45a35df 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -982,6 +982,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 #define PBUFFERSIZE 8192
 
 /* Print bidirectional transfer loop debug message. */
+__attribute__((format (printf, 1, 2)))
 static void transfer_debug(const char *fmt, ...)
 {
 	va_list args;
@@ -1067,7 +1068,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 		return -1;
 	} else if (bytes == 0) {
 		transfer_debug("%s EOF (with %i bytes in buffer)",
-			t->src_name, t->bufuse);
+			t->src_name, (int)t->bufuse);
 		t->state = SSTATE_FLUSHING;
 	} else if (bytes > 0) {
 		t->bufuse += bytes;
diff --git a/utf8.h b/utf8.h
index 32a7bfb..65d0e42 100644
--- a/utf8.h
+++ b/utf8.h
@@ -10,6 +10,7 @@ int same_encoding(const char *, const char *);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);
+__attribute__((format (printf, 2, 3)))
 int utf8_fprintf(FILE *, const char *, ...);
 
 void strbuf_add_wrapped_text(struct strbuf *buf,
-- 
1.8.3.rc3.24.gec82cb9
