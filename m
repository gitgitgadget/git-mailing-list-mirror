X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-branch: let caller specify logmsg
Date: Thu, 30 Nov 2006 03:16:56 +0100
Message-ID: <11648530161016-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Thu, 30 Nov 2006 02:26:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.gf0df
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32698>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpbdN-000558-CX for gcvg-git@gmane.org; Thu, 30 Nov
 2006 03:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936131AbWK3C0n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 21:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936144AbWK3C0m
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 21:26:42 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:64426 "EHLO
 mail42.e.nsc.no") by vger.kernel.org with ESMTP id S936131AbWK3C0m (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 21:26:42 -0500
Received: from localhost.localdomain (ti231210a080-2784.bb.online.no
 [80.213.122.226]) by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id
 kAU2Qcru006653; Thu, 30 Nov 2006 03:26:38 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This changes the signature of rename_ref() in refs.[hc] to include a
logmessage for the reflogs.

Also, builtin-branch.c is modified to provide a proper logmessage + call
setup_ident() before any logmessages are written.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |    8 ++++++--
 refs.c           |   10 +++-------
 refs.h           |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3e206b9..abf23c4 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -247,7 +247,7 @@ static void create_branch(const char *name, const char *start,
 
 static void rename_branch(const char *oldname, const char *newname, int force)
 {
-	char oldref[PATH_MAX], newref[PATH_MAX];
+	char oldref[PATH_MAX], newref[PATH_MAX], logmsg[PATH_MAX*2 + 100];
 	unsigned char sha1[20];
 
 	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > sizeof(oldref))
@@ -265,7 +265,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (resolve_ref(newref, sha1, 1, NULL) && !force)
 		die("A branch named '%s' already exists.", newname);
 
-	if (rename_ref(oldref, newref))
+	snprintf(logmsg, sizeof(logmsg), "Branch: renamed %s to %s",
+		 oldref, newref);
+
+	if (rename_ref(oldref, newref, logmsg))
 		die("Branch rename failed");
 
 	if (!strcmp(oldname, head) && create_symref("HEAD", newref))
@@ -281,6 +284,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
+	setup_ident();
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
diff --git a/refs.c b/refs.c
index d8c19e6..d45f267 100644
--- a/refs.c
+++ b/refs.c
@@ -784,13 +784,12 @@ int delete_ref(const char *refname, unsigned char *sha1)
 	return ret;
 }
 
-int rename_ref(const char *oldref, const char *newref)
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
 	static const char renamed_ref[] = "RENAMED-REF";
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
-	char msg[PATH_MAX*2 + 100];
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
 
@@ -806,14 +805,11 @@ int rename_ref(const char *oldref, const char *newref)
 	if (!is_refname_available(newref, oldref, get_loose_refs(), 0))
 		return 1;
 
-	if (snprintf(msg, sizeof(msg), "renamed %s to %s", oldref, newref) > sizeof(msg))
-		return error("Refnames to long");
-
 	lock = lock_ref_sha1_basic(renamed_ref, NULL, NULL);
 	if (!lock)
 		return error("unable to lock %s", renamed_ref);
 	lock->force_write = 1;
-	if (write_ref_sha1(lock, orig_sha1, msg))
+	if (write_ref_sha1(lock, orig_sha1, logmsg))
 		return error("unable to save current sha1 in %s", renamed_ref);
 
 	if (log && rename(git_path("logs/%s", oldref), git_path("tmp-renamed-log")))
@@ -866,7 +862,7 @@ int rename_ref(const char *oldref, const char *newref)
 
 	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
-	if (write_ref_sha1(lock, orig_sha1, msg)) {
+	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
 		error("unable to write current sha1 into %s", newref);
 		goto rollback;
 	}
diff --git a/refs.h b/refs.h
index ce73d5c..51aab1e 100644
--- a/refs.h
+++ b/refs.h
@@ -48,6 +48,6 @@ extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned
 extern int check_ref_format(const char *target);
 
 /** rename ref, return 0 on success **/
-extern int rename_ref(const char *oldref, const char *newref);
+extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
 #endif /* REFS_H */
-- 
1.4.4.1.gf0df
