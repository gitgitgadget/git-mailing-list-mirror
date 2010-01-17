From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] branch: allow creating a branch with same name and same starting point.
Date: Sun, 17 Jan 2010 15:06:51 +0100
Message-ID: <1263737212-8101-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 15:07:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWVmq-00031f-1I
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 15:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab0AQOHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 09:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436Ab0AQOHQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 09:07:16 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37816 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab0AQOHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 09:07:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0HE6XZO016794
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 15:06:33 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NWVmU-0005j4-8l; Sun, 17 Jan 2010 15:07:06 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NWVmU-00028F-7c; Sun, 17 Jan 2010 15:07:06 +0100
X-Mailer: git-send-email 1.6.6.198.gbaea2
In-Reply-To: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 17 Jan 2010 15:06:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0HE6XZO016794
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1264341995.72507@MQYda84lOEBIy58tiBP/Ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137298>

Previously, "git branch --track newname old" was rejected if newname
existed, even if it already had the same value. This patch allows it,
even without --force. This has two advantages:

* Not requiring --force for a safe operation, hence allowing the user to
  benefit from the other safety checks.

* Allow changing the configuration of the checked-out branch.

As a result, "git branch --track" becomes a conveinient and safe way to
set up upstream information for an existing branch.

The error message "A branch named '%s' already exists" is no longer
precise enough to refuse to act, since part of the reason of the failure
is the old branch value, so we include this value in the message.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 branch.c                 |   45 ++++++++++++++++++++++++++++++---------------
 t/t6040-tracking-info.sh |    8 ++++++++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index 05ef3f5..d187891 100644
--- a/branch.c
+++ b/branch.c
@@ -128,27 +128,39 @@ void create_branch(const char *head,
 		   const char *name, const char *start_name,
 		   int force, int reflog, enum branch_track track)
 {
-	struct ref_lock *lock;
+	struct ref_lock *lock = NULL;
 	struct commit *commit;
-	unsigned char sha1[20];
+	unsigned char old_sha1[20], sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
+	int dont_change_ref = 0;
 
 	if (strbuf_check_branch_ref(&ref, name))
 		die("'%s' is not a valid branch name.", name);
 
-	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
-		if (!force)
-			die("A branch named '%s' already exists.", name);
-		else if (!is_bare_repository() && !strcmp(head, name))
-			die("Cannot force update the current branch.");
+	if (get_sha1(start_name, sha1))
+		die("Not a valid object name: '%s'.", start_name);
+
+	if (resolve_ref(ref.buf, old_sha1, 1, NULL)) {
+		if (hashcmp(old_sha1, sha1)) {
+			if (!force)
+				die("A branch named '%s' already exists pointing to %.*s.",
+				    name, 8, sha1_to_hex(old_sha1));
+			else if (!is_bare_repository() && !strcmp(head, name))
+				die("Cannot force update the current branch.");
+		} else {
+			/*
+			 * Re-creating a branch with the same value.
+			 * Safe, and usefull to set up the upstream
+			 * branch without touching the ref.
+			 */
+			dont_change_ref = 1;
+		}
 		forcing = 1;
 	}
 
 	real_ref = NULL;
-	if (get_sha1(start_name, sha1))
-		die("Not a valid object name: '%s'.", start_name);
 
 	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
 	case 0:
@@ -170,9 +182,11 @@ void create_branch(const char *head,
 		die("Not a valid branch point: '%s'.", start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	lock = lock_any_ref_for_update(ref.buf, NULL, 0);
-	if (!lock)
-		die_errno("Failed to lock ref for update");
+	if (!dont_change_ref) {
+		lock = lock_any_ref_for_update(ref.buf, NULL, 0);
+		if (!lock)
+			die_errno("Failed to lock ref for update");
+	}
 
 	if (reflog)
 		log_all_ref_updates = 1;
@@ -180,15 +194,16 @@ void create_branch(const char *head,
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset from %s",
 			 start_name);
-	else
+	else if (!dont_change_ref)
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
 	if (real_ref && track)
 		setup_tracking(name, real_ref, track);
 
-	if (write_ref_sha1(lock, sha1, msg) < 0)
-		die_errno("Failed to write ref");
+	if (!dont_change_ref)
+		if (write_ref_sha1(lock, sha1, msg) < 0)
+			die_errno("Failed to write ref");
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 664b0f8..3c200b6 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -89,4 +89,12 @@ test_expect_success 'status when tracking annotated tags' '
 	grep "set up to track" actual &&
 	git checkout heavytrack
 '
+
+test_expect_success 'setup tracking with branch --track on existing branch' '
+	git branch from-master master &&
+	test_must_fail git config branch.from-master.merge > actual &&
+	git branch from-master master --track &&
+	git config branch.from-master.merge > actual &&
+	grep -q "^refs/heads/master$" actual
+'
 test_done
-- 
1.6.6.198.gbaea2
