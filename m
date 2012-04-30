From: mhagger@alum.mit.edu
Subject: [RFC 7/7] check_refname_format(): implement REFNAME_RELAXED option
Date: Tue,  1 May 2012 01:02:55 +0200
Message-ID: <1335826975-3093-8-git-send-email-mhagger@alum.mit.edu>
References: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzcw-0000Ul-3L
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388Ab2D3XDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41757 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285Ab2D3XDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:16 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xbG028766;
	Tue, 1 May 2012 01:03:10 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196629>

From: Michael Haggerty <mhagger@alum.mit.edu>

Implement a new option, REFNAME_RELAXED, which accepts "slightly"
illegal refnames--those that might cause confusion with notations
like "R1..R2", "^R1", etc. but are unlikely to cause internal errors.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   31 +++++++++++++++++++------------
 refs.h |    6 +++++-
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index c4ab64d..3a35e5e 100644
--- a/refs.c
+++ b/refs.c
@@ -17,14 +17,20 @@
  */
 
 /* Return true iff ch is not allowed in reference names. */
-static inline int bad_ref_char(int ch)
+static inline int bad_ref_char(int ch, int flags)
 {
-	if (((unsigned) ch) <= ' ' || ch == 0x7f ||
-	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
-		return 1;
-	/* 2.13 Pattern Matching Notation */
-	if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
-		return 1;
+	if (flags & REFNAME_RELAXED) {
+		if (ch == '\0' || ch == '\n' || ch == ' ' ||
+		    ch == ':' || ch == '\\')
+			return 1;
+	} else {
+		if (((unsigned) ch) <= ' ' || ch == 0x7f ||
+		    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
+			return 1;
+		/* 2.13 Pattern Matching Notation */
+		if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
+			return 1;
+	}
 	return 0;
 }
 
@@ -46,12 +52,12 @@ static int parse_refname_component(const char *refname, int refnamelen, int flag
 		char ch = refname[i];
 		if (ch == '/') {
 			break;
-		} else if (bad_ref_char(ch)) {
+		} else if (bad_ref_char(ch, flags)) {
 			break; /* Component terminated by illegal character. */
-		} else if (last == '.' && ch == '.') {
+		} else if (!(flags & REFNAME_RELAXED) && last == '.' && ch == '.') {
 			i--;
 			break; /* Component terminated by "..". */
-		} else if (last == '@' && ch == '{') {
+		} else if (!(flags & REFNAME_RELAXED) && last == '@' && ch == '{') {
 			i--;
 			break; /* Refname terminated by "@{". */
 		}
@@ -64,11 +70,12 @@ static int parse_refname_component(const char *refname, int refnamelen, int flag
 			return -1; /* Component starts with '.'. */
 		/*
 		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is treated as a terminator by
-		 * a rule above).
+		 * or ".."  as a component.
 		 */
 		if (i == 1)
 			return -1; /* Component equals ".". */
+		if (i == 2 && refname[1] == '.')
+			return -1; /* Component equals "..". */
 	}
 	if (i >= 5 && !memcmp(&refname[i - 5], ".lock", 5))
 		return -1; /* Component is not allowed to end with ".lock". */
diff --git a/refs.h b/refs.h
index efe13bb..dd6cfe5 100644
--- a/refs.h
+++ b/refs.h
@@ -115,6 +115,7 @@ extern int for_each_reflog(each_ref_fn, void *);
 #define REFNAME_REFSPEC_PATTERN 0x02
 #define REFNAME_DOT_COMPONENT 0x04
 #define REFNAME_FULL 0x08
+#define REFNAME_RELAXED 0x10
 
 /*
  * Return 0 iff refname has the correct format for a refname according
@@ -128,7 +129,10 @@ extern int for_each_reflog(each_ref_fn, void *);
  * "." or "..").  If REFNAME_FULL is set in flags, then additionally
  * verify that the refname is a valid full refname--that it either
  * starts with "refs/" or that it consists of only capital letters and
- * underscores (like "HEAD" or "MERGE_HEAD").
+ * underscores (like "HEAD" or "MERGE_HEAD").  If REFNAME_RELAXED is
+ * set in flags, then relax the rules to allow control characters
+ * except for SP and LF, wildcard characters '?', '*', and '[', ".."
+ * (but not as a complete refname component), and "@{".
  */
 extern int check_refname_format(const char *refname, int flags);
 
-- 
1.7.10
