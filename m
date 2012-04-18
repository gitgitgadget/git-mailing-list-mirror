From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] argv-array: add a new "pushl" method
Date: Wed, 18 Apr 2012 14:10:05 -0700
Message-ID: <20120418211005.GB21301@sigill.intra.peff.net>
References: <20120418210740.GA21214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:10:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKc8l-0004tr-NF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab2DRVKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 17:10:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38005
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab2DRVKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 17:10:08 -0400
Received: (qmail 20778 invoked by uid 107); 18 Apr 2012 21:10:17 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Apr 2012 17:10:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 14:10:05 -0700
Content-Disposition: inline
In-Reply-To: <20120418210740.GA21214@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195905>

It can be convenient to push many strings in a single line
(e.g., if you are initializing an array with defaults). This
patch provides a convenience wrapper to allow this.

Signed-off-by: Jeff King <peff@peff.net>
---
I called this "pushl" after "execl", with the intent that we might
eventually have "pushv" if somebody wants it. Hopefully that makes
sense to others, but if not, I can name it something more verbose.

 Documentation/technical/api-argv-array.txt |    5 +++++
 argv-array.c                               |   11 +++++++++++
 argv-array.h                               |    1 +
 3 files changed, 17 insertions(+)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index 49b3d52..1b7d8f1 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -37,6 +37,11 @@ Functions
 `argv_array_push`::
 	Push a copy of a string onto the end of the array.
 
+`argv_array_pushl`::
+	Push a list of strings onto the end of the array. The arguments
+	should be a list of `const char *` strings, terminated by a NULL
+	argument.
+
 `argv_array_pushf`::
 	Format a string and push it onto the end of the array. This is a
 	convenience wrapper combining `strbuf_addf` and `argv_array_push`.
diff --git a/argv-array.c b/argv-array.c
index 110a61b..0b5f889 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -38,6 +38,17 @@ void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
 	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
 }
 
+void argv_array_pushl(struct argv_array *array, ...)
+{
+	va_list ap;
+	const char *arg;
+
+	va_start(ap, array);
+	while((arg = va_arg(ap, const char *)))
+		argv_array_push(array, arg);
+	va_end(ap);
+}
+
 void argv_array_clear(struct argv_array *array)
 {
 	if (array->argv != empty_argv) {
diff --git a/argv-array.h b/argv-array.h
index c45c698..b93a69c 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -15,6 +15,7 @@ void argv_array_init(struct argv_array *);
 void argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
+void argv_array_pushl(struct argv_array *, ...);
 void argv_array_clear(struct argv_array *);
 
 #endif /* ARGV_ARRAY_H */
-- 
1.7.9.6.8.g992e5
