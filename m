From: Jeff King <peff@peff.net>
Subject: [PATCH 6/9] grep: cache userdiff_driver in grep_source
Date: Thu, 2 Feb 2012 03:20:43 -0500
Message-ID: <20120202082043.GF6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:20:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsruV-0000jK-HB
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab2BBIUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:20:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52880
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659Ab2BBIUq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:20:46 -0500
Received: (qmail 17925 invoked by uid 107); 2 Feb 2012 08:27:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:27:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:20:43 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189598>

Right now, grep only uses the userdiff_driver for one thing:
looking up funcname patterns for "-p" and "-W".  As new uses
for userdiff drivers are added to the grep code, we want to
minimize attribute lookups, which can be expensive.

It might seem at first that this would also optimize multiple
lookups when the funcname pattern for a file is needed
multiple times. However, the compiled funcname pattern is
already cached in struct grep_opt's "priv" member, so
multiple lookups are already suppressed.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c |   22 ++++++++++++++++------
 grep.h |    4 ++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index 2a3fe7c..bb18569 100644
--- a/grep.c
+++ b/grep.c
@@ -841,12 +841,9 @@ static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bo
 {
 	xdemitconf_t *xecfg = opt->priv;
 	if (xecfg && !xecfg->find_func) {
-		struct userdiff_driver *drv;
-		grep_attr_lock();
-		drv = userdiff_find_by_path(gs->name);
-		grep_attr_unlock();
-		if (drv && drv->funcname.pattern) {
-			const struct userdiff_funcname *pe = &drv->funcname;
+		grep_source_load_driver(gs);
+		if (gs->driver->funcname.pattern) {
+			const struct userdiff_funcname *pe = &gs->driver->funcname;
 			xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
 		} else {
 			xecfg = opt->priv = NULL;
@@ -1237,6 +1234,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 	gs->name = name ? xstrdup(name) : NULL;
 	gs->buf = NULL;
 	gs->size = 0;
+	gs->driver = NULL;
 
 	switch (type) {
 	case GREP_SOURCE_FILE:
@@ -1340,3 +1338,15 @@ int grep_source_load(struct grep_source *gs)
 	}
 	die("BUG: invalid grep_source type");
 }
+
+void grep_source_load_driver(struct grep_source *gs)
+{
+	if (gs->driver)
+		return;
+
+	grep_attr_lock();
+	gs->driver = userdiff_find_by_path(gs->name);
+	if (!gs->driver)
+		gs->driver = userdiff_find_by_name("default");
+	grep_attr_unlock();
+}
diff --git a/grep.h b/grep.h
index 8bf3001..73b28c2 100644
--- a/grep.h
+++ b/grep.h
@@ -9,6 +9,7 @@ typedef int pcre_extra;
 #endif
 #include "kwset.h"
 #include "thread-utils.h"
+#include "userdiff.h"
 
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -141,6 +142,8 @@ struct grep_source {
 
 	char *buf;
 	unsigned long size;
+
+	struct userdiff_driver *driver;
 };
 
 void grep_source_init(struct grep_source *gs, enum grep_source_type type,
@@ -148,6 +151,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 int grep_source_load(struct grep_source *gs);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
+void grep_source_load_driver(struct grep_source *gs);
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
 
-- 
1.7.9.3.gc3fce1.dirty
