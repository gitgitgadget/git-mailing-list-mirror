From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/23] expire_reflog(): treat the policy callback data as opaque
Date: Fri,  5 Dec 2014 00:08:31 +0100
Message-ID: <1417734515-11812-20-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWM-0002yQ-HK
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933353AbaLDXJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:10 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45007 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933350AbaLDXJI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:08 -0500
X-AuditID: 1207440f-f792a6d000001284-fb-5480e993a9bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 40.99.04740.399E0845; Thu,  4 Dec 2014 18:09:07 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deG027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:06 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqDv5ZUOIwY+dJhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujBVXZQsOuFZM3bqCpYFxj0UXIyeHhICJxOz9+5ggbDGJC/fWs3UxcnEICVxm
	lJhy+Ak7hHOMSeLljd3MIFVsAroSi3qawTpEBNQkZq6aDdbBLHCCUeLX5G5GkISwQIDEh7ev
	WEBsFgFViWXvb7KD2LwCrhIdmx8ANXMArZOT2LrOGyTMCRSeOrMVrFVIwEXi2aaF7BMYeRcw
	MqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3ECAkt/h2MXetlDjEKcDAq8fAW
	7K4PEWJNLCuuzD3EKMnBpCTKe/ZpQ4gQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7jI0A53pTE
	yqrUonyYlDQHi5I4r/oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb+kLoEbBotT01Iq0zJwShDQT
	ByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7S3DKSdt7ggMRcoCtF6ilFRSpzXGiQhAJLI
	KM2DGwtLGK8YxYG+FOa1BKniASYbuO5XQIOZgAafbagFGVySiJCSamBcwXi3zb++XXWJu+6k
	FOnZ/OvC3nxs7J45M8ZnYuBPv9fqK3Y3bSxujjpQWvniewR3ge5+gbklq9U4dixjns9+ITgs
	nmHB7Ftc5nVuhfOnqige8tVNjg+6eHGL6pfZrT864+KWfhFMzI/6IhKlFfC+QmRt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260820>

Now that expire_reflog() doesn't actually look in the
expire_reflog_policy_cb data structure, we can make it opaque:

* Change its callers to pass it a pointer to an entire "struct
  expire_reflog_policy_cb".

* Change it to pass the pointer through as a "void *".

* Change the policy functions, reflog_expiry_prepare(),
  reflog_expiry_cleanup(), and should_expire_reflog_ent(), to accept
  "void *cb_data" arguments and cast them to "struct
  expire_reflog_policy_cb" internally.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 73 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 01b76d0..c30936bb 100644
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
@@ -427,19 +431,16 @@ static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
 static struct lock_file reflog_lock;
 
 static int expire_reflog(const char *refname, const unsigned char *sha1,
-			 unsigned int flags, void *cb_data)
+			 unsigned int flags, void *policy_cb_data)
 {
-	struct cmd_reflog_expire_cb *cmd = cb_data;
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
 	 * we take the lock for the ref itself to prevent it from
@@ -462,11 +463,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			goto failure;
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
@@ -639,7 +638,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
-	struct cmd_reflog_expire_cb cb;
+	struct expire_reflog_policy_cb cb;
 	unsigned long now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
@@ -653,25 +652,25 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
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
@@ -695,11 +694,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
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
@@ -712,7 +711,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for_each_reflog(collect_reflog, &collected);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
-			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
+			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
 			status |= expire_reflog(e->reflog, e->sha1, flags, &cb);
 			free(e);
 		}
@@ -726,7 +725,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
-		set_reflog_expiry_param(&cb, explicit_expiry, ref);
+		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
 		status |= expire_reflog(ref, sha1, flags, &cb);
 	}
 	return status;
@@ -736,15 +735,15 @@ static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
 
@@ -791,12 +790,12 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
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
