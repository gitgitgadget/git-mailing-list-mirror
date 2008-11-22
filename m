From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/4] remove the unused files interpolate.c and interpolate.h
Date: Sun, 23 Nov 2008 00:16:59 +0100
Message-ID: <492892EB.4040102@lsrfire.ath.cx>
References: <4928912A.5050307@lsrfire.ath.cx> <492891FC.6000908@lsrfire.ath.cx> <49289275.7090003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@freescale.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 00:18:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L41kC-0002vs-L6
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 00:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbYKVXRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 18:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbYKVXRH
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 18:17:07 -0500
Received: from india601.server4you.de ([85.25.151.105]:55869 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbYKVXRG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 18:17:06 -0500
Received: from [10.0.1.101] (p57B7B890.dip.t-dialin.net [87.183.184.144])
	by india601.server4you.de (Postfix) with ESMTPSA id 23E762F8057;
	Sun, 23 Nov 2008 00:17:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <49289275.7090003@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101563>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile      |    1 -
 interpolate.c |  103 ---------------------------------------------------------
 interpolate.h |   26 --------------
 3 files changed, 0 insertions(+), 130 deletions(-)
 delete mode 100644 interpolate.c
 delete mode 100644 interpolate.h

diff --git a/Makefile b/Makefile
index 35adafa..54e0745 100644
--- a/Makefile
+++ b/Makefile
@@ -437,7 +437,6 @@ LIB_OBJS += grep.o
 LIB_OBJS += hash.o
 LIB_OBJS += help.o
 LIB_OBJS += ident.o
-LIB_OBJS += interpolate.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
diff --git a/interpolate.c b/interpolate.c
deleted file mode 100644
index 7f03bd9..0000000
--- a/interpolate.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * Copyright 2006 Jon Loeliger
- */
-
-#include "git-compat-util.h"
-#include "interpolate.h"
-
-
-void interp_set_entry(struct interp *table, int slot, const char *value)
-{
-	char *oldval = table[slot].value;
-	char *newval = NULL;
-
-	free(oldval);
-
-	if (value)
-		newval = xstrdup(value);
-
-	table[slot].value = newval;
-}
-
-
-void interp_clear_table(struct interp *table, int ninterps)
-{
-	int i;
-
-	for (i = 0; i < ninterps; i++) {
-		interp_set_entry(table, i, NULL);
-	}
-}
-
-
-/*
- * Convert a NUL-terminated string in buffer orig
- * into the supplied buffer, result, whose length is reslen,
- * performing substitutions on %-named sub-strings from
- * the table, interps, with ninterps entries.
- *
- * Example interps:
- *    {
- *        { "%H", "example.org"},
- *        { "%port", "123"},
- *        { "%%", "%"},
- *    }
- *
- * Returns the length of the substituted string (not including the final \0).
- * Like with snprintf, if the result is >= reslen, then it overflowed.
- */
-
-unsigned long interpolate(char *result, unsigned long reslen,
-		const char *orig,
-		const struct interp *interps, int ninterps)
-{
-	const char *src = orig;
-	char *dest = result;
-	unsigned long newlen = 0;
-	const char *name, *value;
-	unsigned long namelen, valuelen;
-	int i;
-	char c;
-
-	while ((c = *src)) {
-		if (c == '%') {
-			/* Try to match an interpolation string. */
-			for (i = 0; i < ninterps; i++) {
-				name = interps[i].name;
-				namelen = strlen(name);
-				if (strncmp(src, name, namelen) == 0)
-					break;
-			}
-
-			/* Check for valid interpolation. */
-			if (i < ninterps) {
-				value = interps[i].value;
-				if (!value) {
-					src += namelen;
-					continue;
-				}
-
-				valuelen = strlen(value);
-				if (newlen + valuelen < reslen) {
-					/* Substitute. */
-					memcpy(dest, value, valuelen);
-					dest += valuelen;
-				}
-				newlen += valuelen;
-				src += namelen;
-				continue;
-			}
-		}
-		/* Straight copy one non-interpolation character. */
-		if (newlen + 1 < reslen)
-			*dest++ = *src;
-		src++;
-		newlen++;
-	}
-
-	/* XXX: the previous loop always keep room for the ending NUL,
-	   we just need to check if there was room for a NUL in the first place */
-	if (reslen > 0)
-		*dest = '\0';
-	return newlen;
-}
diff --git a/interpolate.h b/interpolate.h
deleted file mode 100644
index 77407e6..0000000
--- a/interpolate.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright 2006 Jon Loeliger
- */
-
-#ifndef INTERPOLATE_H
-#define INTERPOLATE_H
-
-/*
- * Convert a NUL-terminated string in buffer orig,
- * performing substitutions on %-named sub-strings from
- * the interpretation table.
- */
-
-struct interp {
-	const char *name;
-	char *value;
-};
-
-extern void interp_set_entry(struct interp *table, int slot, const char *value);
-extern void interp_clear_table(struct interp *table, int ninterps);
-
-extern unsigned long interpolate(char *result, unsigned long reslen,
-				 const char *orig,
-				 const struct interp *interps, int ninterps);
-
-#endif /* INTERPOLATE_H */
-- 
1.6.0.4.755.g6e139
