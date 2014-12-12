From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/24] expire_reflog(): treat the policy callback data as opaque
Date: Fri, 12 Dec 2014 09:56:58 +0100
Message-ID: <1418374623-5566-20-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2p-0004eU-19
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934693AbaLLI5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:39 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43826 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934683AbaLLI5i (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:38 -0500
X-AuditID: 1207440f-f792a6d000001284-06-548aae0168f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.47.04740.10EAA845; Fri, 12 Dec 2014 03:57:37 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nT023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:36 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqMu4rivE4OZnZYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xt/zJ1kL7rhV3LmwiqmBcb9lFyMHh4SAicTeX1JdjJxAppjEhXvr2UBsIYHL
	jBIrLpVD2MeYJBY/zAax2QR0JRb1NDOB2CICahIT2w6xgNjMAicYJWY3hIDYwgLBEr2bO1lA
	xrMIqEqcXcgLEuYVcJHYcGk5M8RWOYmt67xBwpxA4YstT1ggNjlLbF3RyTqBkXcBI8MqRrnE
	nNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJCQ4t/B2LVe5hCjAAejEg/vi9SuECHW
	xLLiytxDjJIcTEqivN8nA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8P6NAsrxpiRWVqUW5cOk
	pDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR449YANQoWpaanVqRl5pQgpJk4OEGGc0mJ
	FKfmpaQWJZaWZMSDIiK+GBgTICkeoL1sa0H2Fhck5gJFIVpPMSpKifO2gswVAElklObBjYUl
	ileM4kBfCvPWgVTxAJMMXPcroMFMQIOXb+kAGVySiJCSamBUTW6vtnr8//VkSdEtywU5/330
	cPzcFfdK7M56zU+xsffFWJq6Vgho7UlurpF9mfnVJOcBy/NEdfYbFsus0+dfiV6eJ2VUqzhV
	6f4Xz18tOtVqrIYFiRfd97sd6P9q9OeMnZWsj/En0c0Cj4xLpS78Wvh7UVSLc/F0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261328>

Now that expire_reflog() doesn't actually look in the
expire_reflog_policy_cb data structure, we can make it opaque:

* Change the callers of expire_reflog() to pass it a pointer to an
  entire "struct expire_reflog_policy_cb" rather than a pointer to a
  "struct cmd_reflog_expire_cb".

* Change expire_reflog() to accept the argument as a "void *" and
  simply pass it through to the policy functions.

* Change the policy functions, reflog_expiry_prepare(),
  reflog_expiry_cleanup(), and should_expire_reflog_ent(), to accept
  "void *cb_data" arguments and cast them back to "struct
  expire_reflog_policy_cb" internally.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 72 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index d36c2c6..0df5721 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -43,7 +43,7 @@ struct expire_reflog_policy_cb {
 	} unreachable_expire_kind;
 	struct commit_list *mark_list;
 	unsigned long mark_limit;
-	struct cmd_reflog_expire_cb *cmd;
+	struct cmd_reflog_expire_cb cmd;
 	struct commit *tip_commit;
 	struct commit_list *tips;
 };
@@ -309,22 +309,22 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit *old, *new;
 
-	if (timestamp < cb->cmd->expire_total)
+	if (timestamp < cb->cmd.expire_total)
 		return 1;
 
 	old = new = NULL;
-	if (cb->cmd->stalefix &&
+	if (cb->cmd.stalefix &&
 	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
 		return 1;
 
-	if (timestamp < cb->cmd->expire_unreachable) {
+	if (timestamp < cb->cmd.expire_unreachable) {
 		if (cb->unreachable_expire_kind == UE_ALWAYS)
 			return 1;
 		if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
 			return 1;
 	}
 
-	if (cb->cmd->recno && --(cb->cmd->recno) == 0)
+	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
 		return 1;
 
 	return 0;
@@ -378,9 +378,11 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1,
 
 static void reflog_expiry_prepare(const char *refname,
 				  const unsigned char *sha1,
-				  struct expire_reflog_policy_cb *cb)
+				  void *cb_data)
 {
-	if (!cb->cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
+	struct expire_reflog_policy_cb *cb = cb_data;
+
+	if (!cb->cmd.expire_unreachable || !strcmp(refname, "HEAD")) {
 		cb->tip_commit = NULL;
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
@@ -391,7 +393,7 @@ static void reflog_expiry_prepare(const char *refname,
 			cb->unreachable_expire_kind = UE_NORMAL;
 	}
 
-	if (cb->cmd->expire_unreachable <= cb->cmd->expire_total)
+	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
 		cb->unreachable_expire_kind = UE_ALWAYS;
 
 	cb->mark_list = NULL;
@@ -405,13 +407,15 @@ static void reflog_expiry_prepare(const char *refname,
 		} else {
 			commit_list_insert(cb->tip_commit, &cb->mark_list);
 		}
-		cb->mark_limit = cb->cmd->expire_total;
+		cb->mark_limit = cb->cmd.expire_total;
 		mark_reachable(cb);
 	}
 }
 
-static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
+static void reflog_expiry_cleanup(void *cb_data)
 {
+	struct expire_reflog_policy_cb *cb = cb_data;
+
 	if (cb->unreachable_expire_kind != UE_ALWAYS) {
 		if (cb->unreachable_expire_kind == UE_HEAD) {
 			struct commit_list *elem;
@@ -425,19 +429,17 @@ static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
 }
 
 static int expire_reflog(const char *refname, const unsigned char *sha1,
-			 unsigned int flags, struct cmd_reflog_expire_cb *cmd)
+			 unsigned int flags, void *policy_cb_data)
 {
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
-	struct expire_reflog_policy_cb policy_cb;
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
-	memset(&policy_cb, 0, sizeof(policy_cb));
 	cb.flags = flags;
-	cb.policy_cb = &policy_cb;
+	cb.policy_cb = policy_cb_data;
 
 	/*
 	 * The reflog file is locked by holding the lock on the
@@ -476,11 +478,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 		}
 	}
 
-	policy_cb.cmd = cmd;
-
-	reflog_expiry_prepare(refname, sha1, &policy_cb);
+	reflog_expiry_prepare(refname, sha1, cb.policy_cb);
 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
-	reflog_expiry_cleanup(&policy_cb);
+	reflog_expiry_cleanup(cb.policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (close_lock_file(&reflog_lock)) {
@@ -653,7 +653,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
-	struct cmd_reflog_expire_cb cb;
+	struct expire_reflog_policy_cb cb;
 	unsigned long now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
@@ -667,25 +667,25 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	do_all = status = 0;
 	memset(&cb, 0, sizeof(cb));
 
-	cb.expire_total = default_reflog_expire;
-	cb.expire_unreachable = default_reflog_expire_unreachable;
+	cb.cmd.expire_total = default_reflog_expire;
+	cb.cmd.expire_unreachable = default_reflog_expire_unreachable;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			flags |= EXPIRE_REFLOGS_DRY_RUN;
 		else if (starts_with(arg, "--expire=")) {
-			if (parse_expiry_date(arg + 9, &cb.expire_total))
+			if (parse_expiry_date(arg + 9, &cb.cmd.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
 		else if (starts_with(arg, "--expire-unreachable=")) {
-			if (parse_expiry_date(arg + 21, &cb.expire_unreachable))
+			if (parse_expiry_date(arg + 21, &cb.cmd.expire_unreachable))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_UNREACH;
 		}
 		else if (!strcmp(arg, "--stale-fix"))
-			cb.stalefix = 1;
+			cb.cmd.stalefix = 1;
 		else if (!strcmp(arg, "--rewrite"))
 			flags |= EXPIRE_REFLOGS_REWRITE;
 		else if (!strcmp(arg, "--updateref"))
@@ -709,11 +709,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * even in older repository.  We cannot trust what's reachable
 	 * from reflog if the repository was pruned with older git.
 	 */
-	if (cb.stalefix) {
-		init_revisions(&cb.revs, prefix);
+	if (cb.cmd.stalefix) {
+		init_revisions(&cb.cmd.revs, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
-		mark_reachable_objects(&cb.revs, 0, 0, NULL);
+		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
@@ -726,7 +726,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for_each_reflog(collect_reflog, &collected);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
-			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
+			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
 			status |= expire_reflog(e->reflog, e->sha1, flags, &cb);
 			free(e);
 		}
@@ -740,7 +740,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
-		set_reflog_expiry_param(&cb, explicit_expiry, ref);
+		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
 		status |= expire_reflog(ref, sha1, flags, &cb);
 	}
 	return status;
@@ -750,15 +750,15 @@ static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct cmd_reflog_expire_cb *cb = cb_data;
-	if (!cb->expire_total || timestamp < cb->expire_total)
-		cb->recno++;
+	struct expire_reflog_policy_cb *cb = cb_data;
+	if (!cb->cmd.expire_total || timestamp < cb->cmd.expire_total)
+		cb->cmd.recno++;
 	return 0;
 }
 
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
-	struct cmd_reflog_expire_cb cb;
+	struct expire_reflog_policy_cb cb;
 	int i, status = 0;
 	unsigned int flags = 0;
 
@@ -805,12 +805,12 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 		recno = strtoul(spec + 2, &ep, 10);
 		if (*ep == '}') {
-			cb.recno = -recno;
+			cb.cmd.recno = -recno;
 			for_each_reflog_ent(ref, count_reflog_ent, &cb);
 		} else {
-			cb.expire_total = approxidate(spec + 2);
+			cb.cmd.expire_total = approxidate(spec + 2);
 			for_each_reflog_ent(ref, count_reflog_ent, &cb);
-			cb.expire_total = 0;
+			cb.cmd.expire_total = 0;
 		}
 
 		status |= expire_reflog(ref, sha1, flags, &cb);
-- 
2.1.3
