From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 21/27] refs: check submodules' ref storage config
Date: Thu, 18 Feb 2016 00:17:44 -0500
Message-ID: <1455772670-21142-22-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:19:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWH0P-0002CB-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425010AbcBRFTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:19:52 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33853 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424927AbcBRFS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:57 -0500
Received: by mail-qg0-f50.google.com with SMTP id b67so29446467qgb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BO9K/Yg2jckBGWgSguPXSuxg3L8cRwSY5gh5UxJ61BY=;
        b=CkQhCgSphtsM8OJ4iMVE/O3AjSvK+rRhp6zXvyzrCBr4EHowMB5ytPHJgXOMtkvJ2O
         qh0EC/Vri8HmH9Va9EI8WU0xzENiJj64ymvJFXBYm0LTctXv7rzgDMtnGdueGliMOq6l
         UM+HNrtcC3QP0mVcvNBEDouYgdWypaQzIcKE3R5cljfW1ufeOuSfSD8QTTSiD6FVYrLt
         kJQHkwcC9GcnSknqSaGiEAoS7vdH+Yvldo6a2h/Q63cqwLAgcNJ1TVt4guJ0dPAWIi0S
         w+3zGsuzBh338L7I3v914wAn/76ZdFgunEE8/MFd9/WYMfeLaU742BEKWURCExyaOmE0
         mV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BO9K/Yg2jckBGWgSguPXSuxg3L8cRwSY5gh5UxJ61BY=;
        b=a8yyDQI3uCFw3T5S5mfUc3rOjiCJlJqi7GhgxRHlAorVUX4q255kxBi1coksOsinzl
         KxGjn1puIFeHVo1gDBmYjIAfRjIPm+n72VJA1oVJOYzYFYU6MeFfNtGaYWOsfIRytE3Y
         YL0rc5yJ7hetFEFHPFPm+5BxoyTNTA1J30yK3s3pagCu6j6mkHKBjyCgTz4n0a+QFhjp
         MCK9G6FTgivWbeVhwN7NPkFuM3oVrtzgfsZgTppdCRHBn/t+D0I9Fanpp/GNvnRqCIml
         2okeT4yqyp9Y14fO2U23sIRQJAqjlhx/xNf7kWNNleWaqlv+S/DEawu36FVtuomxd+oE
         9uRA==
X-Gm-Message-State: AG10YOQQqvkpTEVuPg6+WHg4+QSL+TYR46VobPGFYz8JycG+N2Rhf1tVIHy8ywP2F/CWhA==
X-Received: by 10.140.97.202 with SMTP id m68mr6583727qge.102.1455772736549;
        Wed, 17 Feb 2016 21:18:56 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:55 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286593>

All submodules must have the same ref storage (for now).  Confirm that
this is so before attempting to do anything with submodule refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h               |  2 +-
 refs/files-backend.c |  8 ++------
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 64d4150..ea7e0eb 100644
--- a/refs.c
+++ b/refs.c
@@ -308,6 +308,54 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
+static int submodule_backend(const char *key, const char *value, void *data)
+{
+	const char **path = data;
+	char **old_path = data;
+	if (!strcmp(key, "extensions.refstorage") &&
+	    !git_config_string(path, key, "extensions.refstorage"))
+			free(*old_path);
+
+	return 0;
+}
+
+/*
+ * Check that a submodule exists. If its ref storage backend differs
+ * from the current backend, die.  If the submodule exists, return
+ * 0. Else return -1.
+ */
+static int check_submodule_backend(const char *submodule)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char *submodule_storage_backend;
+	int result = -1;
+
+	if (!submodule)
+		return 0;
+
+	submodule_storage_backend = xstrdup("files");
+
+	strbuf_addstr(&sb, submodule);
+	if (!is_nonbare_repository_dir(&sb))
+		goto done;
+
+	strbuf_reset(&sb);
+	strbuf_git_path_submodule(&sb, submodule, "config");
+
+	git_config_from_file(submodule_backend, sb.buf,
+			     &submodule_storage_backend);
+	if (strcmp(submodule_storage_backend, ref_storage_backend))
+		die(_("Ref storage '%s' for submodule '%s' does not match our storage, '%s'"),
+		    submodule_storage_backend, submodule, ref_storage_backend);
+
+	result = 0;
+done:
+	free(submodule_storage_backend);
+	strbuf_release(&sb);
+
+	return result;
+}
+
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
@@ -320,6 +368,7 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
@@ -330,6 +379,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
@@ -1141,6 +1191,7 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 	int flag;
 
 	if (submodule) {
+		check_submodule_backend(submodule);
 		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
 			return fn("HEAD", &oid, 0, cb_data);
 
@@ -1447,6 +1498,9 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int resolve_gitlink_ref(const char *path, const char *refname,
 			unsigned char *sha1)
 {
+	if (check_submodule_backend(path))
+		return -1;
+
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
 
diff --git a/refs.h b/refs.h
index 4992aa4..e659882 100644
--- a/refs.h
+++ b/refs.h
@@ -511,7 +511,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data);
 
 /*
- * Read the refdb storage backend name out of the config file
+ * Read the ref storage backend name out of the config file
  */
 int ref_storage_backend_config(const char *var, const char *value, void *ptr);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3cca8e..4bddfb3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1357,13 +1357,9 @@ static int files_resolve_gitlink_ref(const char *path, const char *refname,
 
 	strbuf_add(&submodule, path, len);
 	refs = lookup_ref_cache(submodule.buf);
-	if (!refs) {
-		if (!is_nonbare_repository_dir(&submodule)) {
-			strbuf_release(&submodule);
-			return -1;
-		}
+	if (!refs)
 		refs = create_ref_cache(submodule.buf);
-	}
+
 	strbuf_release(&submodule);
 
 	retval = resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-- 
2.4.2.767.g62658d5-twtrsrc
