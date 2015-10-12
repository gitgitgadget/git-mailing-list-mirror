From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 34/44] refs-be-files.c: add method to rename refs
Date: Mon, 12 Oct 2015 17:51:55 -0400
Message-ID: <1444686725-27660-36-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2G-0005Rn-81
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbbJLVxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:31 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34088 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbbJLVwv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:51 -0400
Received: by qkdo1 with SMTP id o1so53973218qkd.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pnw1Z+kt20FlUmXjx1W8NN7jmj6f3oOlkJrhaa2uF4M=;
        b=kDQFMxJLLtq92pGYL+mgTDJEXmYX44P954oix1hzcrTRqBXu75V113g/Og6+08+DIq
         R/drOZm6t80q7vPYOQ49bfbWuTf1gc0ocuErTiJ1LNInJRU/zz+aB/82rgntkz/OhhMP
         tR1GfZqTUOFke8ONfJ3WdEGv6czkKB2wkPLLhaY8RnJDVQS6VmEM8w5cjQxFLdN5E8qp
         cMKXIeYp8GbvmNzf8Bqikmn6YIycBU4H3z7cRlQSGEXqAjDmhbYcYRF9eZFjPzkUKCtV
         UGABIlFgt5pjBapdP/SSpGCKMa7Aq6lPlpUsr0ntqeMhKmK6Cjyo4Re7hQYe0Ly5B3E6
         0zpA==
X-Gm-Message-State: ALoCoQmLGkHKZQA3JnsUk4kGVyU1hF2E+SjU9dqeQj2nKT4mJBNeAVIiQPixwvWwu5440J7VgdBK
X-Received: by 10.55.33.214 with SMTP id f83mr33536367qki.69.1444686771072;
        Mon, 12 Oct 2015 14:52:51 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279447>

We also have to make rename_ref_available public, since alternate
backends for rename_ref will need it.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 20 +++-----------------
 refs.c          | 21 +++++++++++++++++++++
 refs.h          |  7 ++++++-
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 5f2602c..4e6f032 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2444,29 +2444,14 @@ out:
 	return ret;
 }
 
-static int rename_ref_available(const char *oldname, const char *newname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip, &err);
-	if (!ret)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ret;
-}
-
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3561,6 +3546,7 @@ struct ref_be refs_be_files = {
 	files_initdb,
 	files_transaction_commit,
 	files_initial_transaction_commit,
+	files_rename_ref,
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
 	files_for_each_reflog,
diff --git a/refs.c b/refs.c
index 5fc8eb7..5a3125d 100644
--- a/refs.c
+++ b/refs.c
@@ -1113,6 +1113,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	return the_refs_backend->transaction_commit(transaction, err);
 }
 
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
+
 const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
@@ -1126,6 +1131,22 @@ int verify_refname_available(const char *refname, struct string_list *extra,
 	return the_refs_backend->verify_refname_available(refname, extra, skip, err);
 }
 
+int rename_ref_available(const char *oldname, const char *newname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	string_list_insert(&skip, oldname);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
+	if (!ret)
+		error("%s", err.buf);
+
+	string_list_clear(&skip, 0);
+	strbuf_release(&err);
+	return ret;
+}
+
 int pack_refs(unsigned int flags)
 {
 	return the_refs_backend->pack_refs(flags);
diff --git a/refs.h b/refs.h
index ce71d33..87d5801 100644
--- a/refs.h
+++ b/refs.h
@@ -464,10 +464,13 @@ extern const char *prettify_refname(const char *refname);
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
+extern int rename_ref(const char *oldref, const char *newref,
+		      const char *logmsg);
 
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 
+int rename_ref_available(const char *oldname, const char *newname);
+
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
 	UPDATE_REFS_DIE_ON_ERR,
@@ -703,6 +706,7 @@ typedef int reflog_expire_fn(const char *refname, const unsigned char *sha1,
 			     void *policy_cb_data);
 
 /* resolution functions */
+typedef int rename_ref_fn(const char *oldref, const char *newref, const char *logmsg);
 typedef const char *resolve_ref_unsafe_fn(const char *ref,
 					  int resolve_flags,
 					  unsigned char *sha1, int *flags);
@@ -743,6 +747,7 @@ struct ref_be {
 	ref_backend_initdb_fn *initdb;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
+	rename_ref_fn *rename_ref;
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
 	for_each_reflog_fn *for_each_reflog;
-- 
2.4.2.644.g97b850b-twtrsrc
