From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] refactor get_textconv to not require diff_filespec
Date: Mon, 23 May 2011 16:30:14 -0400
Message-ID: <20110523203014.GD6298@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:30:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOblx-0006Wb-7f
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab1EWUa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:30:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58970
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934118Ab1EWUaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:30:16 -0400
Received: (qmail 23110 invoked by uid 107); 23 May 2011 20:32:20 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 16:32:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 16:30:14 -0400
Content-Disposition: inline
In-Reply-To: <20110523201529.GA6281@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174270>

This function actually does two things:

  1. Load the userdiff driver for the filespec.

  2. Decide whether the driver has a textconv component, and
     initialize the textconv cache if applicable.

Only part (1) requires the filespec object, and some callers
may not have a filespec at all. So let's split them it into
two functions, and put part (2) with the userdiff code,
which is a better fit.

Signed-off-by: Jeff King <peff@peff.net>
---
It's a little funny to have "userdiff_get_textconv(foo)" return either
NULL or "foo"; you are not really getting the textconv but rather seeing
if there is a textconv available, and if so, preparing it. But that is
not a new thing; get_textconv was already like that.

One possible refactoring would be that the textconv (including the
cache) should be a sub-structure of the userdiff driver. I chose not to
do that refactoring because of the amount of noise it would introduce in
diff.c. But I can do it if we care.

 diff.c     |   14 +-------------
 userdiff.c |   17 +++++++++++++++++
 userdiff.h |    2 ++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index ba5f7aa..3f538f5 100644
--- a/diff.c
+++ b/diff.c
@@ -1976,19 +1976,7 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one)
 		return NULL;
 
 	diff_filespec_load_driver(one);
-	if (!one->driver->textconv)
-		return NULL;
-
-	if (one->driver->textconv_want_cache && !one->driver->textconv_cache) {
-		struct notes_cache *c = xmalloc(sizeof(*c));
-		struct strbuf name = STRBUF_INIT;
-
-		strbuf_addf(&name, "textconv/%s", one->driver->name);
-		notes_cache_init(c, name.buf, one->driver->textconv);
-		one->driver->textconv_cache = c;
-	}
-
-	return one->driver;
+	return userdiff_get_textconv(one->driver);
 }
 
 static void builtin_diff(const char *name_a,
diff --git a/userdiff.c b/userdiff.c
index 1ff4797..5d62e79 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -267,3 +267,20 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 		return NULL;
 	return userdiff_find_by_name(check.value);
 }
+
+struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver)
+{
+	if (!driver->textconv)
+		return NULL;
+
+	if (driver->textconv_want_cache && !driver->textconv_cache) {
+		struct notes_cache *c = xmalloc(sizeof(*c));
+		struct strbuf name = STRBUF_INIT;
+
+		strbuf_addf(&name, "textconv/%s", driver->name);
+		notes_cache_init(c, name.buf, driver->textconv);
+		driver->textconv_cache = c;
+	}
+
+	return driver;
+}
diff --git a/userdiff.h b/userdiff.h
index 942d594..4a7e78f 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -23,4 +23,6 @@ int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
 struct userdiff_driver *userdiff_find_by_path(const char *path);
 
+struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver);
+
 #endif /* USERDIFF */
-- 
1.7.5.2.4.g43415
