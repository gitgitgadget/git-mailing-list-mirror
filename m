From: David Turner <dturner@twopensource.com>
Subject: [PATCH 34/43] refs-be-files.c: add method to rename refs
Date: Wed,  2 Sep 2015 21:55:04 -0400
Message-ID: <1441245313-11907-35-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlK-0006YS-50
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbbICB4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:21 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33849 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391AbbICB4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:18 -0400
Received: by qkfq186 with SMTP id q186so15076291qkf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v9pBtxeMH1BGaAndnUf364zXeijJsNU1WAcDv0XOxqw=;
        b=IZGc2ZzZC9MTM4D3xR/EQ/DOl09QrBR0jAXgpsQxp2Rojr+ggYf+V+bA62xEweSpAr
         m1kRyqJxh9N2TaJYE6pHk/waFeHXugFpz5Hj/6DmOIdU/eCGS21wU7EZ259URWCqHwam
         haZrtpxq2/rZ2sDAJuYP+NGSoJyhKsTBWhc/ojp0liNBA1AiFnVwT1Wtm/IJh8S47NGS
         CvWNTdMyPxJUbQ0j4iQxp41uQFd4HHzqEq94LkIrb6ah4Fr5fxoDrtLQvKCu3imoLDHl
         CurmfY5Pevcvj8+9V66FqFMipF0gartgbJdg2SdlxjeRd2RACox0bb39SCbYjKD2ipSA
         NyeQ==
X-Gm-Message-State: ALoCoQmkKbqUqDbGhrPp+MSW5SwX3BdOAOUPK9AHhp7YRlr9vz8Yz9aAwM4OmqcE5mYnbO5Fu7eC
X-Received: by 10.55.26.35 with SMTP id a35mr32349206qka.99.1441245377345;
        Wed, 02 Sep 2015 18:56:17 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277154>

We also have to make rename_ref_available public, since alternate
backends for rename_ref will need it.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 19 ++-----------------
 refs.c          | 21 +++++++++++++++++++++
 refs.h          |  4 ++++
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index af99666..5170c5c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2476,29 +2476,13 @@ out:
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
+static int files_rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3757,6 +3741,7 @@ struct ref_be refs_be_files = {
 	files_transaction_commit,
 	files_initial_transaction_commit,
 	files_transaction_free,
+	files_rename_ref,
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
 	files_for_each_reflog,
diff --git a/refs.c b/refs.c
index 72dd66c..ae394fa 100644
--- a/refs.c
+++ b/refs.c
@@ -1050,6 +1050,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -1063,6 +1068,22 @@ int verify_refname_available(const char *refname, struct string_list *extra,
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
index e64d3c4..76661ef 100644
--- a/refs.h
+++ b/refs.h
@@ -382,6 +382,8 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
 
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 
+int rename_ref_available(const char *oldname, const char *newname);
+
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
 	UPDATE_REFS_DIE_ON_ERR,
@@ -626,6 +628,7 @@ typedef int (*delete_reflog_fn)(const char *refname);
 
 /* resolution functions */
 typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
+typedef int (*rename_ref_fn)(const char *oldref, const char *newref, const char *logmsg);
 typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
 					     int resolve_flags,
 					     unsigned char *sha1, int *flags);
@@ -669,6 +672,7 @@ struct ref_be {
 	ref_transaction_commit_fn transaction_commit;
 	ref_transaction_commit_fn initial_transaction_commit;
 	ref_transaction_free_fn transaction_free;
+	rename_ref_fn rename_ref;
 	for_each_reflog_ent_fn for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
 	for_each_reflog_fn for_each_reflog;
-- 
2.0.4.315.gad8727a-twtrsrc
