From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v4 1/5] checkout: implement "@{-N}" shortcut name for N-th last branch
Date: Sat, 17 Jan 2009 17:09:53 +0100
Message-ID: <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODlb-0001Pe-JS
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762220AbZAQQJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758652AbZAQQJz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:09:55 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:7146 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757200AbZAQQJw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:09:52 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:09:51.0410 (UTC) FILETIME=[070BC120:01C978BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106075>

From: Junio C Hamano <gitster@pobox.com>

Implement a shortcut @{-N} for the N-th last branch checked out, that
works by parsing the reflog for the message added by previous
git-checkout invocations.  We expand the @{-N} to the branch name, so
that you end up on an attached HEAD on that branch.
---
 builtin-checkout.c |   10 +++++-
 cache.h            |    1 +
 sha1_name.c        |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b5dd9c0..a3b69d6 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -361,8 +361,14 @@ struct branch_info {
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addstr(&buf, "refs/heads/");
-	strbuf_addstr(&buf, branch->name);
+
+	if (!interpret_nth_last_branch(branch->name, &buf)) {
+		branch->name = xstrdup(buf.buf);
+		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
+	} else {
+		strbuf_addstr(&buf, "refs/heads/");
+		strbuf_addstr(&buf, branch->name);
+	}
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
diff --git a/cache.h b/cache.h
index 8e1af26..0dd9168 100644
--- a/cache.h
+++ b/cache.h
@@ -663,6 +663,7 @@ static inline unsigned int hexval(unsigned char c)
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+extern int interpret_nth_last_branch(const char *str, struct strbuf *);
 
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
diff --git a/sha1_name.c b/sha1_name.c
index 159c2ab..6377264 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -674,6 +674,84 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	return retval;
 }
 
+struct grab_nth_branch_switch_cbdata {
+	int counting;
+	int nth;
+	struct strbuf *buf;
+};
+
+static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
+				  const char *email, unsigned long timestamp, int tz,
+				  const char *message, void *cb_data)
+{
+	struct grab_nth_branch_switch_cbdata *cb = cb_data;
+	const char *match = NULL;
+
+	if (!prefixcmp(message, "checkout: moving to "))
+		match = message + strlen("checkout: moving to ");
+	else if (!prefixcmp(message, "checkout: moving from ")) {
+		const char *cp = message + strlen("checkout: moving from ");
+		if ((cp = strstr(cp, " to ")) != NULL) {
+			match = cp + 4;
+		}
+	}
+
+	if (!match)
+		return 0;
+
+	if (cb->counting) {
+		cb->nth++;
+		return 0;
+	}
+
+	if (--cb->nth <= 0) {
+		size_t len = strlen(match);
+		while (match[len-1] == '\n')
+			len--;
+		strbuf_reset(cb->buf);
+		strbuf_add(cb->buf, match, len);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * This reads "@{-N}" syntax, finds the name of the Nth previous
+ * branch we were on, and places the name of the branch in the given
+ * buf and returns 0 if successful.
+ *
+ * If the input is not of the accepted format, it returns a negative
+ * number to signal an error.
+ */
+int interpret_nth_last_branch(const char *name, struct strbuf *buf)
+{
+	int nth, i;
+	struct grab_nth_branch_switch_cbdata cb;
+
+	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
+		return -1;
+	for (i = 3, nth = 0; name[i] && name[i] != '}'; i++) {
+		char ch = name[i];
+		if ('0' <= ch && ch <= '9')
+			nth = nth * 10 + ch - '0';
+		else
+			return -1;
+	}
+	if (nth < 0 || 10 <= nth)
+		return -1;
+
+	cb.counting = 1;
+	cb.nth = 0;
+	cb.buf = buf;
+	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+
+	cb.counting = 0;
+	cb.nth -= nth;
+	cb.buf = buf;
+	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	return 0;
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
-- 
1.6.1.315.g92577
