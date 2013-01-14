From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] convert some config callbacks to match_config_key
Date: Mon, 14 Jan 2013 07:03:22 -0800
Message-ID: <20130114150322.GC16828@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:03:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TulZj-0006lC-3k
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 16:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239Ab3ANPD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 10:03:27 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32909 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755903Ab3ANPD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 10:03:26 -0500
Received: (qmail 19874 invoked by uid 107); 14 Jan 2013 15:04:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:04:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 07:03:22 -0800
Content-Disposition: inline
In-Reply-To: <20130114145845.GA16497@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213493>

This is easier to read and avoids magic offset constants
which need to be in sync with the section-name we provide.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c  |  6 +-----
 ll-merge.c |  6 +-----
 userdiff.c | 13 +++----------
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/convert.c b/convert.c
index 6602155..e3ecb30 100644
--- a/convert.c
+++ b/convert.c
@@ -465,10 +465,8 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	 * External conversion drivers are configured using
 	 * "filter.<name>.variable".
 	 */
-	if (prefixcmp(var, "filter.") || (ep = strrchr(var, '.')) == var + 6)
+	if (match_config_key(var, "filter", &name, &namelen, &ep) < 0 || !name)
 		return 0;
-	name = var + 7;
-	namelen = ep - name;
 	for (drv = user_convert; drv; drv = drv->next)
 		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
 			break;
@@ -479,8 +477,6 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 		user_convert_tail = &(drv->next);
 	}
 
-	ep++;
-
 	/*
 	 * filter.<name>.smudge and filter.<name>.clean specifies
 	 * the command line:
diff --git a/ll-merge.c b/ll-merge.c
index acea33b..d4c4ff6 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -236,15 +236,13 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 	 * especially, we do not want to look at variables such as
 	 * "merge.summary", "merge.tool", and "merge.verbosity".
 	 */
-	if (prefixcmp(var, "merge.") || (ep = strrchr(var, '.')) == var + 5)
+	if (match_config_key(var, "merge", &name, &namelen, &ep) < 0 || !name)
 		return 0;
 
 	/*
 	 * Find existing one as we might be processing merge.<name>.var2
 	 * after seeing merge.<name>.var1.
 	 */
-	name = var + 6;
-	namelen = ep - name;
 	for (fn = ll_user_merge; fn; fn = fn->next)
 		if (!strncmp(fn->name, name, namelen) && !fn->name[namelen])
 			break;
@@ -256,8 +254,6 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		ll_user_merge_tail = &(fn->next);
 	}
 
-	ep++;
-
 	if (!strcmp("name", ep)) {
 		if (!value)
 			return error("%s: lacks value", var);
diff --git a/userdiff.c b/userdiff.c
index ed958ef..1a6a0fa 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -188,20 +188,13 @@ static struct userdiff_driver *parse_driver(const char *var,
 		const char *value, const char *type)
 {
 	struct userdiff_driver *drv;
-	const char *dot;
-	const char *name;
+	const char *name, *key;
 	int namelen;
 
-	if (prefixcmp(var, "diff."))
-		return NULL;
-	dot = strrchr(var, '.');
-	if (dot == var + 4)
-		return NULL;
-	if (strcmp(type, dot+1))
+	if (match_config_key(var, "diff", &name, &namelen, &key) < 0 ||
+	    strcmp(type, key))
 		return NULL;
 
-	name = var + 5;
-	namelen = dot - name;
 	drv = userdiff_find_by_namelen(name, namelen);
 	if (!drv) {
 		ALLOC_GROW(drivers, ndrivers+1, drivers_alloc);
-- 
1.8.1.rc1.10.g7d71f7b
