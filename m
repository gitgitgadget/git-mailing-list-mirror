From: David Turner <dturner@twopensource.com>
Subject: [PATCH 09/16] refs: add method to rename refs
Date: Wed,  2 Dec 2015 19:35:14 -0500
Message-ID: <1449102921-7707-10-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HtE-0007rt-IH
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948AbbLCAgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:19 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:33100 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757456AbbLCAfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:50 -0500
Received: by iouu10 with SMTP id u10so66088802iou.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qExD/paJWoF1fkN2o1IyjKpaR0h2nB4yIBUC7+q39SE=;
        b=cMoccW2sSUMYvwVCW8s3ceamWzA76Jkmn1IUJwlBoGAE4QvJdyMaM8muwXgntRtDJl
         +V2TVRrTzji3mrNlyZnBv9aFwegXtDvMJMtDx431HYaoAvwxf/KvII7WI5AtQtLytnhN
         LIs4HoblNqn5r2ex9JDW3ru20HX/56L4EQkIsTBIuijS96iRcZLw9/7MF3CAQIPUg3Ag
         9gBgcsYQ5bJnFrCml1SRbW63sFDzpXFiHzclyCYGv9ii21X3UkeBiRcOc4FBygca3Aan
         6hXOLAssL0yP+rRNgx3qPOSIGseigKwesWYt2r75r+UHh4UL5CCWckIIOrYK18zCFLY1
         f3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qExD/paJWoF1fkN2o1IyjKpaR0h2nB4yIBUC7+q39SE=;
        b=K++u9AlYDsYBWJ8ooKgUdPCCHt7dWJ1I+yobjpheyeG6IwCH9OC7V3fQTFjvztIQQO
         eF1HvVuDSzVPzvs6KtVSiKBBqMdGmhx1VpePiyNmcLCFvzCiTRQMyWkZow0JhTsR6j/a
         FnVs52kNE2x1rHh/oXNFy243O8RBTHuYIHROXXZYOYu+t3W+udfysMkwuQNrkBph/3/+
         +OIsSp+jzMdrqJ0wskgAGERwYXHL3R9eY+CuqQDhV3zq8zaeoekt718/QuCIRshOrxxF
         leFPOhR96I5YxvN4Gelp/jvCrvabLck1iIDlW53zs2ACB9KYffyqqXg+Q9zb8HQoDFzh
         d3Eg==
X-Gm-Message-State: ALoCoQkCKIAfROi/ppU0n/+yePPpiKrwEaXGC4nRR+/L7BF6GqeLYlwqtzT+/xIyEyxO4jntstEY
X-Received: by 10.107.4.65 with SMTP id 62mr6021884ioe.92.1449102949587;
        Wed, 02 Dec 2015 16:35:49 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:48 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281936>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 37 +++++++++++++++++++++----------------
 refs/files-backend.c |  4 +++-
 refs/refs-internal.h |  9 +++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index bdeb276..1b79630 100644
--- a/refs.c
+++ b/refs.c
@@ -1093,22 +1093,6 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
-int rename_ref_available(const char *oldname, const char *newname)
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
 /* backend functions */
 int refs_init_db(struct strbuf *err, int shared)
 {
@@ -1126,6 +1110,11 @@ int delete_refs(struct string_list *refnames)
 	return the_refs_backend->delete_refs(refnames);
 }
 
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
+
 const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
@@ -1139,6 +1128,22 @@ int verify_refname_available(const char *refname, struct string_list *extra,
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
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6600c02..0af0818 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2478,7 +2478,8 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3575,6 +3576,7 @@ struct ref_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 85a0b91..36a024f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -53,6 +53,13 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 				 void *cb_data);
 
 /*
+ * Check if the new name does not conflict with any existing refs
+ * (other than possibly the old ref).  Return 0 if the ref can be
+ * renamed to the new name.
+ */
+int rename_ref_available(const char *oldname, const char *newname);
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
@@ -247,6 +254,7 @@ typedef const char *resolve_ref_unsafe_fn(const char *ref,
 typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
+typedef int rename_ref_fn(const char *oldref, const char *newref, const char *logmsg);
 
 /* iteration methods */
 typedef int head_ref_fn(each_ref_fn fn, void *cb_data);
@@ -286,6 +294,7 @@ struct ref_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
+	rename_ref_fn *rename_ref;
 
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.749.g0ed01d8-twtrsrc
