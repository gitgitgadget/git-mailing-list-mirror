From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Sanitize for_each_reflog_ent()
Date: Mon, 8 Jan 2007 01:59:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jan 08 02:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3iro-00068O-TI
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbXAHA75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 19:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXAHA75
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 19:59:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:36893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965260AbXAHA74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 19:59:56 -0500
Received: (qmail invoked by alias); 08 Jan 2007 00:59:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 08 Jan 2007 01:59:54 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36211>


It used to ignore the return value of the helper function; now, it
expects it to return 0, and stops iteration upon non-zero return
values; this value is then passed on as the return value of
for_each_reflog_ent().

Further, it makes no sense to force the parsing upon the helper
functions; for_each_reflog_ent() now calls the helper function with
old and new sha1, the email, the timestamp & timezone, and the message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	IMHO it'd be a good idea to sanitize all for_each_*() functions
	to take a callback pointer.

 builtin-reflog.c |   17 +++++------------
 fsck-objects.c   |    4 +++-
 reachable.c      |    4 +++-
 refs.c           |   26 +++++++++++++++++++++-----
 refs.h           |    4 ++--
 revision.c       |    4 +++-
 6 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index a967117..ede051a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -195,19 +195,12 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 }
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-			     char *data, void *cb_data)
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
-	unsigned long timestamp;
-	char *cp, *ep;
 	struct commit *old, *new;
 
-	cp = strchr(data, '>');
-	if (!cp || *++cp != ' ')
-		goto prune;
-	timestamp = strtoul(cp, &ep, 10);
-	if (*ep != ' ')
-		goto prune;
 	if (timestamp < cb->cmd->expire_total)
 		goto prune;
 
@@ -223,13 +216,13 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	if (cb->newlog)
 		fprintf(cb->newlog, "%s %s %s",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1), data);
+			sha1_to_hex(osha1), sha1_to_hex(nsha1), message);
 	if (cb->cmd->verbose)
-		printf("keep %s", data);
+		printf("keep %s", message);
 	return 0;
  prune:
 	if (!cb->newlog || cb->cmd->verbose)
-		printf("%sprune %s", cb->newlog ? "" : "would ", data);
+		printf("%sprune %s", cb->newlog ? "" : "would ", message);
 	return 0;
 }
 
diff --git a/fsck-objects.c b/fsck-objects.c
index 1cc3b39..0d8a8eb 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -399,7 +399,9 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
-static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *datail, void *cb_data)
+static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
 {
 	struct object *obj;
 
diff --git a/reachable.c b/reachable.c
index 4dfee1d..a6a3348 100644
--- a/reachable.c
+++ b/reachable.c
@@ -104,7 +104,9 @@ static void walk_commit_list(struct rev_info *revs)
 	}
 }
 
-static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *datail, void *cb_data)
+static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
 {
 	struct object *object;
 	struct rev_info *revs = (struct rev_info *)cb_data;
diff --git a/refs.c b/refs.c
index 5205745..ea670d4 100644
--- a/refs.c
+++ b/refs.c
@@ -1097,7 +1097,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	return 0;
 }
 
-void for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
+int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 {
 	const char *logfile;
 	FILE *logfp;
@@ -1106,19 +1106,35 @@ void for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 	logfile = git_path("logs/%s", ref);
 	logfp = fopen(logfile, "r");
 	if (!logfp)
-		return;
+		return -1;
 	while (fgets(buf, sizeof(buf), logfp)) {
 		unsigned char osha1[20], nsha1[20];
-		int len;
+		char *email_end, *message;
+		unsigned long timestamp;
+		int len, ret, tz;
 
 		/* old SP new SP name <email> SP time TAB msg LF */
 		len = strlen(buf);
 		if (len < 83 || buf[len-1] != '\n' ||
 		    get_sha1_hex(buf, osha1) || buf[40] != ' ' ||
-		    get_sha1_hex(buf + 41, nsha1) || buf[81] != ' ')
+		    get_sha1_hex(buf + 41, nsha1) || buf[81] != ' ' ||
+		    !(email_end = strchr(buf + 82, '>')) ||
+		    email_end[1] != ' ' ||
+		    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
+		    !message || message[0] != ' ' ||
+		    (message[1] != '+' && message[1] != '-') ||
+		    !isdigit(message[2]) || !isdigit(message[3]) ||
+		    !isdigit(message[4]) || !isdigit(message[5]) ||
+		    message[6] != '\t')
 			continue; /* corrupt? */
-		fn(osha1, nsha1, buf+82, cb_data);
+		email_end[1] = '\0';
+		tz = strtol(message + 1, NULL, 10);
+		message += 7;
+		ret = fn(osha1, nsha1, buf+82, timestamp, tz, message, cb_data);
+		if (ret)
+			return ret;
 	}
 	fclose(logfp);
+	return 0;
 }
 
diff --git a/refs.h b/refs.h
index de43cc7..0e877e8 100644
--- a/refs.h
+++ b/refs.h
@@ -45,8 +45,8 @@ extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, cons
 extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1);
 
 /* iterate over reflog entries */
-typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, char *, void *);
-void for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
+typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
+int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
 
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
diff --git a/revision.c b/revision.c
index 6e4ec46..1e3b29a 100644
--- a/revision.c
+++ b/revision.c
@@ -505,7 +505,9 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 	}
 }
 
-static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *detail, void *cb_data)
+static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
 {
 	handle_one_reflog_commit(osha1, cb_data);
 	handle_one_reflog_commit(nsha1, cb_data);
-- 
1.5.0.rc0.gcbf41-dirty
