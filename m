From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff: add some heuristics to detect java method names
Date: Mon, 26 Feb 2007 21:32:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702262127470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 21:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLmWr-0002Ia-MN
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 21:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbXBZUc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 15:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbXBZUc4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 15:32:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:39009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751336AbXBZUcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 15:32:55 -0500
Received: (qmail invoked by alias); 26 Feb 2007 20:32:54 -0000
X-Provags-ID: V01U2FsdGVkX1+5gdprzdy5Jbf/FLe6L8reoAwLNvpOB/SAphXaQG
	UeCg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40664>


The heuristics to identify function names for use in hunk headers used to 
match the lines defining classes in java source code. This issue was 
brought up by Shawn Pearce.

This patch adds the following heuristics:

If the candidate contains the word "class", we search between the current 
line and the "class" line for a line defining a method.

A line is taken to define a method when it starts with at least two 
identifiers (a word starting with a letter or underscore, continuing with 
letters, underscores, digits, brackets or stars) followed by a left 
bracket.

This heuristics should also work in C++ header files with inlined methods.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 xdiff/xemit.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index e291dc7..0267476 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -69,6 +69,68 @@ static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
 }
 
 
+static int is_identifier(const char *rec, long len) {
+	long i;
+	if (!len)
+		return -1;
+	for (i = 0; i < len; i++) {
+		char c = rec[i];
+		if (!isalnum(c) && c != '_' && (i == 0 ||
+					(!isdigit(c)  && !strchr("_[]*", c))))
+			return i;
+	}
+	return i;
+}
+
+static void xdl_find_method(xdfile_t *xf, long i, long i_class,
+		char *buf, long sz, long *ll) {
+	/*
+	 * A "class" line has been found in line i_class. Find a method
+	 * name between that line and line i.
+	 *
+	 * The heuristics is this: the line begins with at least two
+	 * identifiers, followed by an opening parenthesis.
+	 */
+	const char *rec;
+	long len;
+
+	while (i-- > i_class) {
+		long off, count, identifier_count = 0;
+		len = xdl_get_rec(xf, i, &rec);
+		for (off = 0; off < len && isspace(rec[off]); off++)
+			; /* do nothing */
+		for(;;) {
+			if ((count = is_identifier(rec + off, len - off)) <= 0)
+				break;
+			for (off += count;
+					off < len && isspace(rec[off]);
+					off++)
+				; /* do nothing */
+			if (++identifier_count > 1 && rec[off] == '(') {
+				for (off = 0; isspace(rec[off]); off++)
+					; /* do nothing */
+				for (; isspace(rec[len - 1]); len--)
+					; /* do nothing */
+				len -= off;
+				if (len > sz)
+					len = sz;
+				memcpy(buf, rec + off, len);
+				*ll = len;
+				return;
+			}
+		}
+	}
+
+	/* fall back to class line */
+	len = xdl_get_rec(xf, i_class, &rec);
+	while (len > 0 && isspace(rec[len - 1]))
+		len--;
+	if (len > sz)
+		len = sz;
+	memcpy(buf, rec, len);
+	*ll = len;
+}
+
 static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll) {
 
 	/*
@@ -78,7 +140,7 @@ static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll) {
 	 */
 
 	const char *rec;
-	long len;
+	long len, i_start = i;
 
 	*ll = 0;
 	while (i-- > 0) {
@@ -87,6 +149,12 @@ static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll) {
 		    (isalpha((unsigned char)*rec) || /* identifier? */
 		     *rec == '_' ||	/* also identifier? */
 		     *rec == '$')) {	/* mysterious GNU diff's invention */
+			const char *is_class = strstr(rec, "class ");
+			if (is_class && (rec == is_class ||
+						isspace(is_class[-1]))) {
+				xdl_find_method(xf, i_start, i, buf, sz, ll);
+				return;
+			}
 			if (len > sz)
 				len = sz;
 			while (0 < len && isspace((unsigned char)rec[len - 1]))
-- 
1.5.0.1.2441.gaf8e-dirty
