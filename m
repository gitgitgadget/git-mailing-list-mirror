From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] for-each-ref: refactor refname handling
Date: Tue, 7 Apr 2009 03:06:51 -0400
Message-ID: <20090407070651.GB2924@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 09:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5Qp-00032o-Bc
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbZDGHHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbZDGHHm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:07:42 -0400
Received: from peff.net ([208.65.91.99]:46868 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbZDGHHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:07:41 -0400
Received: (qmail 32757 invoked by uid 107); 7 Apr 2009 07:06:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:06:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:06:51 -0400
Content-Disposition: inline
In-Reply-To: <20090407070254.GA2870@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115910>

This code handles some special magic like *-deref and the
:short formatting specifier. The next patch will add another
field which outputs a ref and wants to use the same code.

This patch splits the "which ref are we outputting" from the
actual formatting. There should be no behavioral change.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff is scary, but it is mostly reindentation.

 builtin-for-each-ref.c |   47 ++++++++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 4aaf75c..b50c93b 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -672,32 +672,37 @@ static void populate_value(struct refinfo *ref)
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
+		const char *refname;
+		const char *formatp;
+
 		if (*name == '*') {
 			deref = 1;
 			name++;
 		}
-		if (!prefixcmp(name, "refname")) {
-			const char *formatp = strchr(name, ':');
-			const char *refname = ref->refname;
-
-			/* look for "short" refname format */
-			if (formatp) {
-				formatp++;
-				if (!strcmp(formatp, "short"))
-					refname = get_short_ref(ref->refname);
-				else
-					die("unknown refname format %s",
-					    formatp);
-			}
 
-			if (!deref)
-				v->s = refname;
-			else {
-				int len = strlen(refname);
-				char *s = xmalloc(len + 4);
-				sprintf(s, "%s^{}", refname);
-				v->s = s;
-			}
+		if (!prefixcmp(name, "refname"))
+			refname = ref->refname;
+		else
+			continue;
+
+		formatp = strchr(name, ':');
+		/* look for "short" refname format */
+		if (formatp) {
+			formatp++;
+			if (!strcmp(formatp, "short"))
+				refname = get_short_ref(refname);
+			else
+				die("unknown %.*s format %s",
+					formatp - name, name, formatp);
+		}
+
+		if (!deref)
+			v->s = refname;
+		else {
+			int len = strlen(refname);
+			char *s = xmalloc(len + 4);
+			sprintf(s, "%s^{}", refname);
+			v->s = s;
 		}
 	}
 
-- 
1.6.2.2.450.gd6aa9.dirty
