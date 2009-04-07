From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] for-each-ref: refactor get_short_ref function
Date: Tue, 7 Apr 2009 03:05:01 -0400
Message-ID: <20090407070501.GA2924@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 09:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5OM-0002I0-Le
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbZDGHFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbZDGHFH
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:05:07 -0400
Received: from peff.net ([208.65.91.99]:46865 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbZDGHFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:05:06 -0400
Received: (qmail 32725 invoked by uid 107); 7 Apr 2009 07:05:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:05:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:05:01 -0400
Content-Disposition: inline
In-Reply-To: <20090407070254.GA2870@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115909>

This function took a "refinfo" object which is unnecessarily
restrictive; it only ever looked at the refname field. This
patch refactors it to take just the ref name as a string.

While we're touching the relevant lines, let's give it
consistent memory semantics. Previously, some code paths
would return an allocated string and some would return the
original string; now it will always return a malloc'd
string.

This doesn't actually fix a bug or a leak, because
for-each-ref doesn't clean up its memory, but it makes the
function a lot less surprising for reuse (which will
happen in a later patch).

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, as the modified version is always prefix-shortened,
it should be possible to rewrite this in a way that never allocates
memory. I picked the least-invasive and most lazy approach.

 builtin-for-each-ref.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 5cbb4b0..4aaf75c 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -569,7 +569,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
 /*
  * Shorten the refname to an non-ambiguous form
  */
-static char *get_short_ref(struct refinfo *ref)
+static char *get_short_ref(const char *ref)
 {
 	int i;
 	static char **scanf_fmts;
@@ -598,17 +598,17 @@ static char *get_short_ref(struct refinfo *ref)
 
 	/* bail out if there are no rules */
 	if (!nr_rules)
-		return ref->refname;
+		return xstrdup(ref);
 
-	/* buffer for scanf result, at most ref->refname must fit */
-	short_name = xstrdup(ref->refname);
+	/* buffer for scanf result, at most ref must fit */
+	short_name = xstrdup(ref);
 
 	/* skip first rule, it will always match */
 	for (i = nr_rules - 1; i > 0 ; --i) {
 		int j;
 		int short_name_len;
 
-		if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
+		if (1 != sscanf(ref, scanf_fmts[i], short_name))
 			continue;
 
 		short_name_len = strlen(short_name);
@@ -642,7 +642,7 @@ static char *get_short_ref(struct refinfo *ref)
 	}
 
 	free(short_name);
-	return ref->refname;
+	return xstrdup(ref);
 }
 
 
@@ -684,7 +684,7 @@ static void populate_value(struct refinfo *ref)
 			if (formatp) {
 				formatp++;
 				if (!strcmp(formatp, "short"))
-					refname = get_short_ref(ref);
+					refname = get_short_ref(ref->refname);
 				else
 					die("unknown refname format %s",
 					    formatp);
-- 
1.6.2.2.450.gd6aa9.dirty
