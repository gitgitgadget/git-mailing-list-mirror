From: Jeff King <peff@peff.net>
Subject: [PATCHv2 3/8] convert some config callbacks to parse_config_key
Date: Wed, 23 Jan 2013 01:24:23 -0500
Message-ID: <20130123062422.GC5036@sigill.intra.peff.net>
References: <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:24:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxtlP-0007Hs-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab3AWGY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:24:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44602 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350Ab3AWGY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:24:26 -0500
Received: (qmail 1281 invoked by uid 107); 23 Jan 2013 06:25:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:25:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:24:23 -0500
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214284>

These callers can drop some inline pointer arithmetic and
magic offset constants, making them more readable and less
error-prone (those constants had to match the lengths of
strings, but there is no automatic verification of that
fact).

The "ep" pointer (presumably for "end pointer"), which
points to the final key segment of the config variable, is
given the more standard name "key" to describe its function
rather than its derivation.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c  | 14 +++++---------
 ll-merge.c | 14 +++++---------
 userdiff.c | 13 +++----------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/convert.c b/convert.c
index 6602155..3520252 100644
--- a/convert.c
+++ b/convert.c
@@ -457,7 +457,7 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 
 static int read_convert_config(const char *var, const char *value, void *cb)
 {
-	const char *ep, *name;
+	const char *key, *name;
 	int namelen;
 	struct convert_driver *drv;
 
@@ -465,10 +465,8 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	 * External conversion drivers are configured using
 	 * "filter.<name>.variable".
 	 */
-	if (prefixcmp(var, "filter.") || (ep = strrchr(var, '.')) == var + 6)
+	if (parse_config_key(var, "filter", &name, &namelen, &key) < 0 || !name)
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
@@ -490,13 +486,13 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	 * The command-line will not be interpolated in any way.
 	 */
 
-	if (!strcmp("smudge", ep))
+	if (!strcmp("smudge", key))
 		return git_config_string(&drv->smudge, var, value);
 
-	if (!strcmp("clean", ep))
+	if (!strcmp("clean", key))
 		return git_config_string(&drv->clean, var, value);
 
-	if (!strcmp("required", ep)) {
+	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
 		return 0;
 	}
diff --git a/ll-merge.c b/ll-merge.c
index acea33b..fb61ea6 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -222,7 +222,7 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 static int read_merge_config(const char *var, const char *value, void *cb)
 {
 	struct ll_merge_driver *fn;
-	const char *ep, *name;
+	const char *key, *name;
 	int namelen;
 
 	if (!strcmp(var, "merge.default")) {
@@ -236,15 +236,13 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 	 * especially, we do not want to look at variables such as
 	 * "merge.summary", "merge.tool", and "merge.verbosity".
 	 */
-	if (prefixcmp(var, "merge.") || (ep = strrchr(var, '.')) == var + 5)
+	if (parse_config_key(var, "merge", &name, &namelen, &key) < 0 || !name)
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
@@ -256,16 +254,14 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		ll_user_merge_tail = &(fn->next);
 	}
 
-	ep++;
-
-	if (!strcmp("name", ep)) {
+	if (!strcmp("name", key)) {
 		if (!value)
 			return error("%s: lacks value", var);
 		fn->description = xstrdup(value);
 		return 0;
 	}
 
-	if (!strcmp("driver", ep)) {
+	if (!strcmp("driver", key)) {
 		if (!value)
 			return error("%s: lacks value", var);
 		/*
@@ -289,7 +285,7 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp("recursive", ep)) {
+	if (!strcmp("recursive", key)) {
 		if (!value)
 			return error("%s: lacks value", var);
 		fn->recursive = xstrdup(value);
diff --git a/userdiff.c b/userdiff.c
index ed958ef..a4ea1e9 100644
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
+	if (parse_config_key(var, "diff", &name, &namelen, &key) < 0 ||
+	    !name || strcmp(type, key))
 		return NULL;
 
-	name = var + 5;
-	namelen = dot - name;
 	drv = userdiff_find_by_namelen(name, namelen);
 	if (!drv) {
 		ALLOC_GROW(drivers, ndrivers+1, drivers_alloc);
-- 
1.8.0.2.15.g815dc66
