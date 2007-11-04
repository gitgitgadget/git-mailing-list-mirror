From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] pretty=format: Avoid some expensive calculations when
 not needed
Date: Sun, 4 Nov 2007 19:15:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041915290.4362@racer.site>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 04 20:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iokxk-0006Et-QM
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXKDTQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753542AbXKDTQe
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:16:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:46254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753372AbXKDTQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:16:33 -0500
Received: (qmail invoked by alias); 04 Nov 2007 19:16:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp005) with SMTP; 04 Nov 2007 20:16:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w9ThF+vLwTRQDUhdQQiSx4ktcmhOzd5lbpLsAA/
	gJxcSdSy22Cgk8
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711041912190.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63434>


Use the new function interp_find_active() to avoid calculating the
unique hash names, and other things, when they are not even asked for.

Unfortunately, we cannot reuse the result of that function, which
would be cleaner: there are more users than just git log.  Most
notably, git-archive with "$Format:...$" substitution.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	So I found another reason why the function has to be called
	everytime.  But this reason appeals to me much more.

	Originally, I wanted to do this differently, by providing a
	function which generates the substitutions, but the header
	parsing makes that infeasible.

 pretty.c |   55 ++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/pretty.c b/pretty.c
index 490cede..241e91c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -393,6 +393,7 @@ void format_commit_message(const struct commit *commit,
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
 	const char *msg = commit->buffer;
+	char *active = interp_find_active(format, table, ARRAY_SIZE(table));
 
 	if (ILEFT_RIGHT + 1 != ARRAY_SIZE(table))
 		die("invalid interp table!");
@@ -407,12 +408,18 @@ void format_commit_message(const struct commit *commit,
 	/* these depend on the commit */
 	if (!commit->object.parsed)
 		parse_object(commit->object.sha1);
-	interp_set_entry(table, IHASH, sha1_to_hex(commit->object.sha1));
-	interp_set_entry(table, IHASH_ABBREV,
+	if (active[IHASH])
+		interp_set_entry(table, IHASH,
+				sha1_to_hex(commit->object.sha1));
+	if (active[IHASH_ABBREV])
+		interp_set_entry(table, IHASH_ABBREV,
 			find_unique_abbrev(commit->object.sha1,
 				DEFAULT_ABBREV));
-	interp_set_entry(table, ITREE, sha1_to_hex(commit->tree->object.sha1));
-	interp_set_entry(table, ITREE_ABBREV,
+	if (active[ITREE])
+		interp_set_entry(table, ITREE,
+				sha1_to_hex(commit->tree->object.sha1));
+	if (active[ITREE_ABBREV])
+		interp_set_entry(table, ITREE_ABBREV,
 			find_unique_abbrev(commit->tree->object.sha1,
 				DEFAULT_ABBREV));
 	interp_set_entry(table, ILEFT_RIGHT,
@@ -422,22 +429,27 @@ void format_commit_message(const struct commit *commit,
 			 ? "<"
 			 : ">");
 
-	parents[1] = 0;
-	for (i = 0, p = commit->parents;
-			p && i < sizeof(parents) - 1;
-			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			sha1_to_hex(p->item->object.sha1));
-	interp_set_entry(table, IPARENTS, parents + 1);
-
-	parents[1] = 0;
-	for (i = 0, p = commit->parents;
-			p && i < sizeof(parents) - 1;
-			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			find_unique_abbrev(p->item->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
+	if (active[IPARENTS]) {
+		parents[1] = 0;
+		for (i = 0, p = commit->parents;
+				p && i < sizeof(parents) - 1;
+				p = p->next)
+			i += snprintf(parents + i, sizeof(parents) - i - 1,
+				" %s", sha1_to_hex(p->item->object.sha1));
+		interp_set_entry(table, IPARENTS, parents + 1);
+	}
+
+	if (active[IPARENTS_ABBREV]) {
+		parents[1] = 0;
+		for (i = 0, p = commit->parents;
+				p && i < sizeof(parents) - 1;
+				p = p->next)
+			i += snprintf(parents + i, sizeof(parents) - i - 1,
+				" %s",
+				find_unique_abbrev(p->item->object.sha1,
+					DEFAULT_ABBREV));
+		interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
+	}
 
 	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
 		int eol;
@@ -464,7 +476,7 @@ void format_commit_message(const struct commit *commit,
 				xmemdupz(msg + i + 9, eol - i - 9);
 		i = eol;
 	}
-	if (msg[i])
+	if (active[IBODY] && msg[i])
 		table[IBODY].value = xstrdup(msg + i);
 
 	len = interpolate(sb->buf + sb->len, strbuf_avail(sb),
@@ -476,6 +488,7 @@ void format_commit_message(const struct commit *commit,
 	}
 	strbuf_setlen(sb, sb->len + len);
 	interp_clear_table(table, ARRAY_SIZE(table));
+	free(active);
 }
 
 static void pp_header(enum cmit_fmt fmt,
-- 
1.5.3.5.1549.g91a3
