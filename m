From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] quote: provide sq_dequote_to_argv_array
Date: Tue, 13 Sep 2011 17:58:08 -0400
Message-ID: <20110913215808.GD24490@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:58:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3azi-0001gD-Ju
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926Ab1IMV6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:58:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51532
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMV6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:58:11 -0400
Received: (qmail 2050 invoked by uid 107); 13 Sep 2011 21:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:59:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:58:08 -0400
Content-Disposition: inline
In-Reply-To: <20110913215026.GA26743@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181311>

This is similar to sq_dequote_to_argv, but more convenient
if you have an argv_array. It's tempting to just feed the
components of the argv_array to sq_dequote_to_argv instead,
but:

  1. It wouldn't maintain the NULL-termination invariant
     of argv_array.

  2. It doesn't match the memory ownership policy of
     argv_array (in which each component is free-able, not a
     pointer into a separate buffer).

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c |   23 ++++++++++++++++++++---
 quote.h |    8 ++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/quote.c b/quote.c
index 63d3b01..87bc65e 100644
--- a/quote.c
+++ b/quote.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "quote.h"
+#include "argv-array.h"
 
 int quote_path_fully = 1;
 
@@ -120,7 +121,9 @@ void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 	return sq_dequote_step(arg, NULL);
 }
 
-int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc)
+static int sq_dequote_to_argv_internal(char *arg,
+				       const char ***argv, int *nr, int *alloc,
+				       struct argv_array *array)
 {
 	char *next = arg;
 
@@ -130,13 +133,27 @@ int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc)
 		char *dequoted = sq_dequote_step(next, &next);
 		if (!dequoted)
 			return -1;
-		ALLOC_GROW(*argv, *nr + 1, *alloc);
-		(*argv)[(*nr)++] = dequoted;
+		if (argv) {
+			ALLOC_GROW(*argv, *nr + 1, *alloc);
+			(*argv)[(*nr)++] = dequoted;
+		}
+		if (array)
+			argv_array_push(array, dequoted);
 	} while (next);
 
 	return 0;
 }
 
+int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc)
+{
+	return sq_dequote_to_argv_internal(arg, argv, nr, alloc, NULL);
+}
+
+int sq_dequote_to_argv_array(char *arg, struct argv_array *array)
+{
+	return sq_dequote_to_argv_internal(arg, NULL, NULL, NULL, array);
+}
+
 /* 1 means: quote as octal
  * 0 means: quote as octal if (quote_path_fully)
  * -1 means: never quote
diff --git a/quote.h b/quote.h
index 252b0df..133155a 100644
--- a/quote.h
+++ b/quote.h
@@ -45,6 +45,14 @@
  */
 extern int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
 
+/*
+ * Same as above, but store the unquoted strings in an argv_array. We will
+ * still modify arg in place, but unlike sq_dequote_to_argv, the argv_array
+ * will duplicate and take ownership of the strings.
+ */
+struct argv_array;
+extern int sq_dequote_to_argv_array(char *arg, struct argv_array *);
+
 extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
 extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
-- 
1.7.7.rc1.2.gb2409
