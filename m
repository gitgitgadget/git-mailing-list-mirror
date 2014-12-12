From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/24] expire_reflog(): extract two policy-related functions
Date: Fri, 12 Dec 2014 09:56:48 +0100
Message-ID: <1418374623-5566-10-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2V-0004Db-H6
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbaLLI50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:26 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43820 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964914AbaLLI5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:25 -0500
X-AuditID: 1207440f-f792a6d000001284-be-548aadf403f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DA.47.04740.4FDAA845; Fri, 12 Dec 2014 03:57:24 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nJ023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:23 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqPtlbVeIwfbNqhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujHlNf5gKZqtUzDu1nbmB8bZsFyMHh4SAicTVVq8uRk4gU0ziwr31bF2MXBxC
	ApcZJXafns0O4Rxjkvj74DITSBWbgK7Eop5mMFtEQE1iYtshFhCbWeAEo8TshhAQW1jAX2L7
	jSOMIDaLgKrE+3+7wOp5BVwk5u/5xgqxWE5i6zpvkDAnUPhiyxOwMUICzhJbV3SyTmDkXcDI
	sIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJLD4dzB2rZc5xCjAwajEw/si
	tStEiDWxrLgy9xCjJAeTkijv98lAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8f6OAcrwpiZVV
	qUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCd64NUCNgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aC4iC8GRgZIigdoL9takL3FBYm5QFGI1lOMilLivK0gcwVAEhml
	eXBjYeniFaM40JfCvHUgVTzAVAPX/QpoMBPQ4OVbOkAGlyQipKQaGHckTd5dyvD2mlzy7iCb
	1cophj/MJKsPNF8907ym5BeH6Q62R7F9yxzvSySs8Lv/d77k18kV0h/m72O2vXXuTouhvz3D
	nPggGc32K1xS5xSPvVDf6Ne4qi9ki8yVQNZdTlcvvjlbvUT7jJ/TFuVlShfERXP+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261323>

Extract two functions, reflog_expiry_prepare() and
reflog_expiry_cleanup(), from expire_reflog(). This is a further step
towards separating the code for deciding on expiration policy from the
code that manages the physical deletion of reflog entries.

This change requires a couple of local variables from expire_reflog()
to be turned into fields of "struct expire_reflog_cb". More
reorganization of the callback data will follow in later commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 94 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 06ce8b1..8db52d7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -43,6 +43,8 @@ struct expire_reflog_cb {
 	unsigned long mark_limit;
 	struct cmd_reflog_expire_cb *cmd;
 	unsigned char last_kept_sha1[20];
+	struct commit *tip_commit;
+	struct commit_list *tips;
 };
 
 struct collected_reflog {
@@ -363,6 +365,54 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 	return 0;
 }
 
+static void reflog_expiry_prepare(const char *refname,
+				  const unsigned char *sha1,
+				  struct expire_reflog_cb *cb)
+{
+	if (!cb->cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
+		cb->tip_commit = NULL;
+		cb->unreachable_expire_kind = UE_HEAD;
+	} else {
+		cb->tip_commit = lookup_commit_reference_gently(sha1, 1);
+		if (!cb->tip_commit)
+			cb->unreachable_expire_kind = UE_ALWAYS;
+		else
+			cb->unreachable_expire_kind = UE_NORMAL;
+	}
+
+	if (cb->cmd->expire_unreachable <= cb->cmd->expire_total)
+		cb->unreachable_expire_kind = UE_ALWAYS;
+
+	cb->mark_list = NULL;
+	cb->tips = NULL;
+	if (cb->unreachable_expire_kind != UE_ALWAYS) {
+		if (cb->unreachable_expire_kind == UE_HEAD) {
+			struct commit_list *elem;
+			for_each_ref(push_tip_to_list, &cb->tips);
+			for (elem = cb->tips; elem; elem = elem->next)
+				commit_list_insert(elem->item, &cb->mark_list);
+		} else {
+			commit_list_insert(cb->tip_commit, &cb->mark_list);
+		}
+		cb->mark_limit = cb->cmd->expire_total;
+		mark_reachable(cb);
+	}
+}
+
+static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
+{
+	if (cb->unreachable_expire_kind != UE_ALWAYS) {
+		if (cb->unreachable_expire_kind == UE_HEAD) {
+			struct commit_list *elem;
+			for (elem = cb->tips; elem; elem = elem->next)
+				clear_commit_marks(elem->item, REACHABLE);
+			free_commit_list(cb->tips);
+		} else {
+			clear_commit_marks(cb->tip_commit, REACHABLE);
+		}
+	}
+}
+
 static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 struct cmd_reflog_expire_cb *cmd)
 {
@@ -370,8 +420,6 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
 	char *log_file;
-	struct commit *tip_commit;
-	struct commit_list *tips;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
@@ -415,47 +463,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 
 	cb.cmd = cmd;
 
-	if (!cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
-		tip_commit = NULL;
-		cb.unreachable_expire_kind = UE_HEAD;
-	} else {
-		tip_commit = lookup_commit_reference_gently(sha1, 1);
-		if (!tip_commit)
-			cb.unreachable_expire_kind = UE_ALWAYS;
-		else
-			cb.unreachable_expire_kind = UE_NORMAL;
-	}
-
-	if (cmd->expire_unreachable <= cmd->expire_total)
-		cb.unreachable_expire_kind = UE_ALWAYS;
-
-	cb.mark_list = NULL;
-	tips = NULL;
-	if (cb.unreachable_expire_kind != UE_ALWAYS) {
-		if (cb.unreachable_expire_kind == UE_HEAD) {
-			struct commit_list *elem;
-			for_each_ref(push_tip_to_list, &tips);
-			for (elem = tips; elem; elem = elem->next)
-				commit_list_insert(elem->item, &cb.mark_list);
-		} else {
-			commit_list_insert(tip_commit, &cb.mark_list);
-		}
-		cb.mark_limit = cmd->expire_total;
-		mark_reachable(&cb);
-	}
-
+	reflog_expiry_prepare(refname, sha1, &cb);
 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
-
-	if (cb.unreachable_expire_kind != UE_ALWAYS) {
-		if (cb.unreachable_expire_kind == UE_HEAD) {
-			struct commit_list *elem;
-			for (elem = tips; elem; elem = elem->next)
-				clear_commit_marks(elem->item, REACHABLE);
-			free_commit_list(tips);
-		} else {
-			clear_commit_marks(tip_commit, REACHABLE);
-		}
-	}
+	reflog_expiry_cleanup(&cb);
 
 	if (cb.newlog) {
 		if (close_lock_file(&reflog_lock)) {
-- 
2.1.3
