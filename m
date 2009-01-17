From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v4 5/5] interpret_nth_last_branch(): avoid traversing the reflogs twice
Date: Sat, 17 Jan 2009 17:09:57 +0100
Message-ID: <1232208597-29249-6-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-5-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODm5-0001dD-Ky
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762664AbZAQQKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762389AbZAQQKB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:10:01 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:39223 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760458AbZAQQJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:09:55 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:53 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:52 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232208597-29249-5-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:09:52.0738 (UTC) FILETIME=[07D66420:01C978BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106076>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Instead of traversing them twice, we just build a list of branch switches,
pick the one we're interested in, and free the list again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1_name.c |   61 ++++++++++++++++++++++++----------------------------------
 1 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9e1538e..b21a1f0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,8 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "cache-tree.h"
+#include "string-list.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -684,43 +686,31 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
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
 
-	if (!prefixcmp(message, "checkout: moving from ")) {
-		match = message + strlen("checkout: moving from ");
-		if ((target = strstr(match, " to ")) != NULL)
-			target += 4;
-	}
-
-	if (!match)
+	if (prefixcmp(message, "checkout: moving from "))
 		return 0;
 
-	len = target - match - 4;
-	if (target[len] == '\n' && !strncmp(match, target, len))
-		return 0;
+	match = message + strlen("checkout: moving from ");
 
-	if (cb->counting) {
-		cb->nth++;
-		return 0;
+	/* Is it "moving" from a branch to itself?  Then ignore it. */
+	if ((target = strstr(match, " to ")) != NULL) {
+		target += 4;
+		len = target - match - 4;
+		if (target[len] == '\n' && !strncmp(match, target, len))
+			return 0;
 	}
+	else
+		len = strchrnul(match, ' ') - match;
+
+	string_list_append(xstrndup(match, len), list);
 
-	if (cb->nth-- <= 0) {
-		strbuf_reset(cb->buf);
-		strbuf_add(cb->buf, match, len);
-		return 1;
-	}
 	return 0;
 }
 
@@ -738,7 +728,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 {
 	int nth;
-	struct grab_nth_branch_switch_cbdata cb;
+	struct string_list branch_list = { NULL, 0, 0, 0 };
 	const char *brace;
 	char *num_end;
 
@@ -751,18 +741,17 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 	if (num_end != brace)
 		return -1;
 
-	cb.counting = 1;
-	cb.nth = 0;
-	cb.buf = buf;
-	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	for_each_reflog_ent("HEAD", add_one_branch_switch, &branch_list);
 
-	if (cb.nth < nth)
+	if (branch_list.nr < nth)
 		return 0;
 
-	cb.counting = 0;
-	cb.nth -= nth;
-	cb.buf = buf;
-	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	strbuf_reset(buf);
+	strbuf_addstr(buf, branch_list.items[branch_list.nr - nth].string);
+
+	/* force free()ing the items */
+	branch_list.strdup_strings = 1;
+	string_list_clear(&branch_list, 0);
 
 	return brace-name+1;
 }
-- 
1.6.1.315.g92577
