From: Jeff King <peff@peff.net>
Subject: [PATCHv2 4/8] userdiff: drop parse_driver function
Date: Wed, 23 Jan 2013 01:25:07 -0500
Message-ID: <20130123062507.GD5036@sigill.intra.peff.net>
References: <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:25:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxtmJ-0007md-GP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab3AWGZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:25:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44609 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575Ab3AWGZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:25:10 -0500
Received: (qmail 1301 invoked by uid 107); 23 Jan 2013 06:26:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:26:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:25:07 -0500
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214285>

When we parse userdiff config, we generally assume that

  diff.name.key

will affect the "key" value of the "name" driver. However,
without confirming that the key is a valid userdiff key, we
may accidentally conflict with the ancient "diff.color.*"
namespace. The current code is careful not to even create a
driver struct if we do not see a key that is known by the
diff-driver code.

However, this carefulness is unnecessary; the default driver
with no keys set behaves exactly the same as having no
driver at all. We can simply set up the driver struct as
soon as we see we have a config key that looks like a
driver. This makes the code a bit more readable.

Signed-off-by: Jeff King <peff@peff.net>
---
 userdiff.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index a4ea1e9..ea43a03 100644
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
-	if (parse_config_key(var, "diff", &name, &namelen, &key) < 0 ||
-	    !name || strcmp(type, key))
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
+	if (parse_config_key(k, "diff", &name, &namelen, &type) || !name)
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
1.8.0.2.15.g815dc66
