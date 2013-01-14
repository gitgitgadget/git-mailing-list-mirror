From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] userdiff: drop parse_driver function
Date: Mon, 14 Jan 2013 07:04:14 -0800
Message-ID: <20130114150414.GD16828@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:04:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TulaZ-0007Zt-4L
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 16:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab3ANPES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 10:04:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32914 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512Ab3ANPES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 10:04:18 -0500
Received: (qmail 19921 invoked by uid 107); 14 Jan 2013 15:05:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:05:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 07:04:14 -0800
Content-Disposition: inline
In-Reply-To: <20130114145845.GA16497@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213494>

When we parse userdiff config, we generally assume that

  diff.name.key

will affect the "key" value of the "name" driver. However,
without checking the key, we conflict with the ancient
"diff.color.*" namespace. The current code is careful not to
even create a driver struct if we do not see a key that is
known by the diff-driver code.

However, this carefulness is unnecessary; the default driver
with no keys set behaves exactly the same as having no
driver at all. We can simply set up the driver struct as
soon as we see we have a config key that looks like a
driver. This makes the code a bit more readable.

Signed-off-by: Jeff King <peff@peff.net>
---
This is not strictly related to the series, but I noticed it as a
cleanup while doing the previous patch.

 userdiff.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 1a6a0fa..c6cdec4 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -184,28 +184,6 @@ static struct userdiff_driver *userdiff_find_by_namelen(const char *k, int len)
 	return NULL;
 }
 
-static struct userdiff_driver *parse_driver(const char *var,
-		const char *value, const char *type)
-{
-	struct userdiff_driver *drv;
-	const char *name, *key;
-	int namelen;
-
-	if (match_config_key(var, "diff", &name, &namelen, &key) < 0 ||
-	    strcmp(type, key))
-		return NULL;
-
-	drv = userdiff_find_by_namelen(name, namelen);
-	if (!drv) {
-		ALLOC_GROW(drivers, ndrivers+1, drivers_alloc);
-		drv = &drivers[ndrivers++];
-		memset(drv, 0, sizeof(*drv));
-		drv->name = xmemdupz(name, namelen);
-		drv->binary = -1;
-	}
-	return drv;
-}
-
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
 		const char *v, int cflags)
 {
@@ -233,20 +211,34 @@ int userdiff_config(const char *k, const char *v)
 int userdiff_config(const char *k, const char *v)
 {
 	struct userdiff_driver *drv;
+	const char *name, *type;
+	int namelen;
+
+	if (match_config_key(k, "diff", &name, &namelen, &type) || !name)
+		return 0;
+
+	drv = userdiff_find_by_namelen(name, namelen);
+	if (!drv) {
+		ALLOC_GROW(drivers, ndrivers+1, drivers_alloc);
+		drv = &drivers[ndrivers++];
+		memset(drv, 0, sizeof(*drv));
+		drv->name = xmemdupz(name, namelen);
+		drv->binary = -1;
+	}
 
-	if ((drv = parse_driver(k, v, "funcname")))
+	if (!strcmp(type, "funcname"))
 		return parse_funcname(&drv->funcname, k, v, 0);
-	if ((drv = parse_driver(k, v, "xfuncname")))
+	if (!strcmp(type, "xfuncname"))
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
-	if ((drv = parse_driver(k, v, "binary")))
+	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
-	if ((drv = parse_driver(k, v, "command")))
+	if (!strcmp(type, "command"))
 		return git_config_string(&drv->external, k, v);
-	if ((drv = parse_driver(k, v, "textconv")))
+	if (!strcmp(type, "textconv"))
 		return git_config_string(&drv->textconv, k, v);
-	if ((drv = parse_driver(k, v, "cachetextconv")))
+	if (!strcmp(type, "cachetextconv"))
 		return parse_bool(&drv->textconv_want_cache, k, v);
-	if ((drv = parse_driver(k, v, "wordregex")))
+	if (!strcmp(type, "wordregex"))
 		return git_config_string(&drv->word_regex, k, v);
 
 	return 0;
-- 
1.8.1.rc1.10.g7d71f7b
