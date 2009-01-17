From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs
 twice
Date: Sat, 17 Jan 2009 16:04:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOCji-000576-LR
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761132AbZAQPDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761862AbZAQPD3
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:03:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:37533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757911AbZAQPD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:03:28 -0500
Received: (qmail invoked by alias); 17 Jan 2009 15:03:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 17 Jan 2009 16:03:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+F/o8AO7+h8G1XutPv+P5LKnIMViYoqDzc6Z7t/
	hVGTmMrTuefAcy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901171438.22504.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106054>


Instead of traversing them twice, we just build a list of branch switches,
pick the one we're interested in, and free the list again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 17 Jan 2009, Thomas Rast wrote:

	> Johannes Schindelin wrote:
	> 
	> > I really have to ask: why did you not work on top of Junio's 
	> > patch, just adding docs, tests, and checkout -?  And then -- maybe -- 
	> > the string_list...

	Of course, I meant the patch as-is, with Junio as author.  But 
	hey, if he does not care...

	> > Although I have to admit that I am not _that_ convinced the 
	> > string_list is worth it: reflogs are not evaluated all the time, so 
	> > it is definitely not performance critical.
	>
	> I take it you have some idea where and how string_list fits into 
	> this topic?

	Indeed.

	This patch was generated using --collapse-non-alnums for readability.
	Did not really help much.

 sha1_name.c |   72 ++++++++++++++++++++++++----------------------------------
 1 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2bbc5f1..306d04b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -6,6 +6,7 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "cache-tree.h"
+#include "string-list.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -691,43 +692,31 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	return retval;
 }
 
-struct grab_nth_branch_switch_cbdata {
-	int counting;
-	int nth;
-	struct strbuf *buf;
-};
-
-static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
+static int add_one_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 				  const char *email, unsigned long timestamp, int tz,
 				  const char *message, void *cb_data)
 {
-	struct grab_nth_branch_switch_cbdata *cb = cb_data;
+	struct string_list *list = cb_data;
 	const char *match = NULL, *target = NULL;
 	size_t len;
-
-	if (!prefixcmp(message, "checkout: moving from ")) {
-		match = message + strlen("checkout: moving from ");
-		if ((target = strstr(match, " to ")) != NULL)
-			target += 4;
-	}
-
-	if (!match)
+
+	if (prefixcmp(message, "checkout: moving from "))
 		return 0;
 
-	len = target - match - 4;
-	if (target[len] == '\n' && !strncmp(match, target, len))
-		return 0;
-
-	if (cb->counting) {
-		cb->nth++;
-		return 0;
-	}
-
-	if (cb->nth-- <= 0) {
-		strbuf_reset(cb->buf);
-		strbuf_add(cb->buf, match, len);
-		return 1;
-	}
+	match = message + strlen("checkout: moving from ");
+
+	/* Is it "moving" from a branch to itself?  Then ignore it. */
+	if ((target = strstr(match, " to ")) != NULL) {
+		target += 4;
+		len = target - match - 4;
+		if (target[len] == '\n' && !strncmp(match, target, len))
+			return 0;
+	}
+	else
+		len = strchrnul(match, ' ') - match;
+
+	string_list_append(xstrndup(match, len), list);
+
 	return 0;
 }
 
@@ -745,7 +734,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 {
 	int nth;
-	struct grab_nth_branch_switch_cbdata cb;
+	struct string_list branch_list = { NULL, 0, 0, 0 };
 	const char *brace;
 	char *num_end;
 
@@ -758,18 +747,17 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 	if (num_end != brace)
 		return -1;
 
-	cb.counting = 1;
-	cb.nth = 0;
-	cb.buf = buf;
-	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
-
-	if (cb.nth < nth)
+	for_each_reflog_ent("HEAD", add_one_branch_switch, &branch_list);
+
+	if (branch_list.nr < nth)
 		return 0;
-
-	cb.counting = 0;
-	cb.nth -= nth;
-	cb.buf = buf;
-	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+
+	strbuf_reset(buf);
+	strbuf_addstr(buf, branch_list.items[branch_list.nr - nth].string);
+
+	/* force free()ing the items */
+	branch_list.strdup_strings = 1;
+	string_list_clear(&branch_list, 0);
 
 	return brace-name+1;
 }
-- 
1.6.1.325.g062d4
