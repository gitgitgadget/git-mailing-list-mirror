From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v4 2/5] sha1_name: tweak @{-N} lookup
Date: Sat, 17 Jan 2009 17:09:54 +0100
Message-ID: <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODlc-0001Pe-9Q
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758652AbZAQQJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761986AbZAQQJ5
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:09:57 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:7146 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758160AbZAQQJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:09:54 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:09:51.0675 (UTC) FILETIME=[073430B0:01C978BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106074>

Have the lookup only look at "interesting" checkouts, meaning those
that tell you "Already on ..." don't count even though they also cause
a reflog entry.

Let interpret_nth_last_branch() return the number of characters
parsed, so that git-checkout can verify that the branch spec was
@{-N}, not @{-1}^2 or something like that.  (The latter will be added
later.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-checkout.c |    4 ++-
 sha1_name.c        |   53 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index a3b69d6..dc1de06 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -361,8 +361,10 @@ struct branch_info {
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
+	int ret;
 
-	if (!interpret_nth_last_branch(branch->name, &buf)) {
+	if ((ret = interpret_nth_last_branch(branch->name, &buf))
+	    && ret == strlen(branch->name)) {
 		branch->name = xstrdup(buf.buf);
 		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
 	} else {
diff --git a/sha1_name.c b/sha1_name.c
index 6377264..34e39db 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -685,29 +685,28 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
-	const char *match = NULL;
-
-	if (!prefixcmp(message, "checkout: moving to "))
-		match = message + strlen("checkout: moving to ");
-	else if (!prefixcmp(message, "checkout: moving from ")) {
-		const char *cp = message + strlen("checkout: moving from ");
-		if ((cp = strstr(cp, " to ")) != NULL) {
-			match = cp + 4;
-		}
+	const char *match = NULL, *target = NULL;
+	size_t len;
+
+	if (!prefixcmp(message, "checkout: moving from ")) {
+		match = message + strlen("checkout: moving from ");
+		if ((target = strstr(match, " to ")) != NULL)
+			target += 4;
 	}
 
 	if (!match)
 		return 0;
 
+	len = target - match - 4;
+	if (target[len] == '\n' && !strncmp(match, target, len))
+		return 0;
+
 	if (cb->counting) {
 		cb->nth++;
 		return 0;
 	}
 
-	if (--cb->nth <= 0) {
-		size_t len = strlen(match);
-		while (match[len-1] == '\n')
-			len--;
+	if (cb->nth-- <= 0) {
 		strbuf_reset(cb->buf);
 		strbuf_add(cb->buf, match, len);
 		return 1;
@@ -718,26 +717,28 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 /*
  * This reads "@{-N}" syntax, finds the name of the Nth previous
  * branch we were on, and places the name of the branch in the given
- * buf and returns 0 if successful.
+ * buf and returns the number of characters parsed if successful.
  *
  * If the input is not of the accepted format, it returns a negative
  * number to signal an error.
+ *
+ * If the input was ok but there are not N branch switches in the
+ * reflog, it returns 0.
  */
 int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 {
-	int nth, i;
+	int nth;
 	struct grab_nth_branch_switch_cbdata cb;
+	const char *brace;
+	char *num_end;
 
 	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
 		return -1;
-	for (i = 3, nth = 0; name[i] && name[i] != '}'; i++) {
-		char ch = name[i];
-		if ('0' <= ch && ch <= '9')
-			nth = nth * 10 + ch - '0';
-		else
-			return -1;
-	}
-	if (nth < 0 || 10 <= nth)
+	brace = strchr(name, '}');
+	if (!brace)
+		return -1;
+	nth = strtol(name+3, &num_end, 10);
+	if (num_end != brace)
 		return -1;
 
 	cb.counting = 1;
@@ -745,11 +746,15 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 	cb.buf = buf;
 	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
 
+	if (cb.nth < nth)
+		return 0;
+
 	cb.counting = 0;
 	cb.nth -= nth;
 	cb.buf = buf;
 	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
-	return 0;
+
+	return brace-name+1;
 }
 
 /*
-- 
1.6.1.315.g92577
