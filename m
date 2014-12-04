From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/23] expire_reflog(): extract two policy-related functions
Date: Fri,  5 Dec 2014 00:08:21 +0100
Message-ID: <1417734515-11812-10-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWE-0002vY-Cs
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbaLDXI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:56 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44999 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754811AbaLDXIz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:55 -0500
X-AuditID: 1207440f-f792a6d000001284-d6-5480e986618b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id BC.89.04740.689E0845; Thu,  4 Dec 2014 18:08:54 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de6027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:53 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNv2siHE4M4jdYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3Rt/542wFP9Ur5i3YzdbAeFuhi5GTQ0LARKJp4R9WCFtM4sK99WxdjFwcQgKX
	GSUurZjKDJIQEjjGJHHvbjWIzSagK7Gop5kJxBYRUJOYuWo2WAOzwAlGiV+TuxlBEsICPhIL
	V7wDKuLgYBFQlfj21xckzCvgKjH93iGwsISAnMTWdd4gYU6g8NSZrYwQq1wknm1ayD6BkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJDA4t/B2LVe5hCjAAejEg9v
	we76ECHWxLLiytxDjJIcTEqivGefNoQI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE1PgKU401J
	rKxKLcqHSUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ8HK9AGoULEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB8VFfDEwMkBSPEB7/z4H2VtckJgLFIVoPcWoKCXOexYkIQCS
	yCjNgxsLSxevGMWBvhTm/QNSxQNMNXDdr4AGMwENPttQCzK4JBEhJdXA6O1p4qP88KXp9o0P
	Kt/9aToievZ/hnxJi6qA7+/0sk+lF6e1Kuj6u36uDrrs/2taiPrOE1sNwhlyeay0bdoUVk/m
	vrPIwfn/tXVlny4uNmRoO7LEyOJn0u2Uh3KhuUozziVf6DNQZZJ8/X+nx65Jqef0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260817>

Extract two functions, reflog_expiry_prepare() and
reflog_expiry_cleanup(), from expire_reflog(). This is a further step
towards separating the code for deciding on expiration policy from the
code that manages the physical expiration.

This change requires a couple of local variables from expire_reflog()
to be turned into fields of "struct expire_reflog_cb". More
reorganization of the callback data will follow in later commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
In fact, the work done in reflog_expire_cleanup() doesn't really need
to be done via a callback, because it doesn't need to be done while
the reference lock is held. But the symmetry between prepare and
cleanup is kindof nice. Perhaps some future policy decision will want
to do some final work under the reference lock?

But it would be easy to get rid of this third callback function and
have the callers do the work themselves after calling expire_reflog().
I don't have a string feeling either way.

 builtin/reflog.c | 94 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7bc6e0f..ebfa635 100644
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
 static struct lock_file reflog_lock;
 
 static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
@@ -371,8 +421,6 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
 	char *log_file;
-	struct commit *tip_commit;
-	struct commit_list *tips;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
@@ -400,47 +448,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
 
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
