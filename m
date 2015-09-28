From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 35/43] refs-be-files.c: add method to rename refs
Date: Mon, 28 Sep 2015 18:02:10 -0400
Message-ID: <1443477738-32023-36-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWM-00019y-AD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbbI1WDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:35 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:32943 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbbI1WDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:32 -0400
Received: by qgev79 with SMTP id v79so133381437qge.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EgE0h6LuUpvDVz8F+MVplzRNjHmZqpG+SwFDy2Mj2e8=;
        b=Aq6EXjSri0ciBOrqT2GZSjHHQip3X9FiPwqvVRR3ULCZZspjhwPAHfg6wTNalNrYnk
         yI0KL/uetbBbeEcwMeNV5lcFH1RDFr4xZcmHE6FxKx84LnqdSGa92J2xNUFUC+Eh1V3G
         F6z3T1PUkvCRcrqjItnD8aPWcSAPVdVxtsIUkrpMclPuTum0nzg/wnfGzJ61AmyMsmCU
         uR7WxtRdwZJJx8QYygC3QiqL33p30WJleB91O8OB6PkErO7Z6ynjGE4v/TjsQAbPY5de
         wd/c5oJr2D5Extx89xAVYbE9EDC9rk/ZHyqCAdMwpXKZNLM45deJHziaU7N+ykHHgS75
         Onlw==
X-Gm-Message-State: ALoCoQl5EmYo3NHkv2eOo1r1F4BzAxTAZovFLAB8c+iYFpu1jmuWwvtTcBDyfBstCdutNLRil7Iy
X-Received: by 10.140.194.148 with SMTP id p142mr27445806qha.84.1443477811685;
        Mon, 28 Sep 2015 15:03:31 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278768>

We also have to make rename_ref_available public, since alternate
backends for rename_ref will need it.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 20 +++-----------------
 refs.c          | 21 +++++++++++++++++++++
 refs.h          |  7 ++++++-
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 3f2d194..3bcfab3 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2491,29 +2491,14 @@ out:
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
@@ -3777,6 +3762,7 @@ struct ref_be refs_be_files = {
 	files_transaction_commit,
 	files_initial_transaction_commit,
 	files_transaction_free,
+	files_rename_ref,
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
 	files_for_each_reflog,
diff --git a/refs.c b/refs.c
index 930c85c..1c2dd79 100644
--- a/refs.c
+++ b/refs.c
@@ -1052,6 +1052,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	return the_refs_backend->transaction_free(transaction);
 }
 
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
+
 const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
@@ -1066,6 +1071,22 @@ int verify_refname_available(const char *refname, struct string_list *extra,
 							  err);
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
index 02001ef..823983b 100644
--- a/refs.h
+++ b/refs.h
@@ -378,10 +378,13 @@ extern const char *prettify_refname(const char *refname);
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
@@ -633,6 +636,7 @@ typedef int (*reflog_expire_fn)(const char *refname, const unsigned char *sha1,
 
 /* resolution functions */
 typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
+typedef int (*rename_ref_fn)(const char *oldref, const char *newref, const char *logmsg);
 typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
 					     int resolve_flags,
 					     unsigned char *sha1, int *flags);
@@ -682,6 +686,7 @@ struct ref_be {
 	ref_transaction_commit_fn transaction_commit;
 	ref_transaction_commit_fn initial_transaction_commit;
 	ref_transaction_free_fn transaction_free;
+	rename_ref_fn rename_ref;
 	for_each_reflog_ent_fn for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
 	for_each_reflog_fn for_each_reflog;
-- 
2.4.2.644.g97b850b-twtrsrc
