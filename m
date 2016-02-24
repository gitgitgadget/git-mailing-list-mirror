From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 24/32] refs: check submodules' ref storage config
Date: Wed, 24 Feb 2016 17:58:56 -0500
Message-ID: <1456354744-8022-25-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQP-0004YF-4w
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208AbcBXXAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:00:39 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34449 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759193AbcBXW7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:42 -0500
Received: by mail-qk0-f171.google.com with SMTP id x1so13257113qkc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPfuWt/7fqDDT4aT8516fKyPxqo21GLLK1MNGBy7RPQ=;
        b=aKRIIY6Izy+gfCsMHtKlOvTaDUGM0lefy2iMkSXj3F5zsc69S384ScGa4+R6dN/yOU
         ZTD+3VyymjgzCpHXyJ/I+9IbbWeOdfN52WMeXcARDhUfgiiqRogvG8i/1/Gj07fK8f1x
         T2DMvo5ORDS6qWMbWJ1VrkgnmGmsGGAVlS6+aeY2PRgi7FCyWbWivprEqBOgaXgs5tjN
         R1hoJuQx/vuF/VBtTJcS7exYsjhYOwIJ/jlc3j4iphtuXqJD1Ryp/6EJtRkj39AtryhB
         SuUFQBfo4gUCjUmOBPYook0l4olk4CFaFks9QXCUv5u4BAPzW+xDMcfF4MPgaFArDDZc
         yDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPfuWt/7fqDDT4aT8516fKyPxqo21GLLK1MNGBy7RPQ=;
        b=CFOqFp+fby2s4NHpPxM7HeEj2YqLGb3HYH+5sE6nXTIHnskI6elnhloExJAXKJOM4G
         1hd/VMIUYumxhzVpgyp24YvMzn8zNEQ11pyvtIj4r46pqKXUCWR+aVITcBS3PrS99qfm
         W/gp0gBhEU/vDI+a2yORgjLX8wtwXyGPxJ/472FNbMwp4s6ie9ye+s/4+22TpeD0K9zX
         HNNS3YoRq22G4TdgUXHSEMFMriH7+qkw5toQVOiHfeg/3fmbCzrCz8xqGcXIU3qcJx6J
         omh6MWhcc5aycPnQzhJPOSduo0R8mJcrh6HC0fCCxbKiNOKZbX7zp32Gfi/Eryb5vqcl
         PiqQ==
X-Gm-Message-State: AG10YORWESnHPbSM53PzgAbKYarV5uV56XF8nHGyOkw1fYdbKH5nL7Se51hvoYCoA55mbw==
X-Received: by 10.55.200.215 with SMTP id t84mr36745304qkl.55.1456354781446;
        Wed, 24 Feb 2016 14:59:41 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287263>

All submodules must have the same ref storage (for now).  Confirm that
this is so before attempting to do anything with submodule refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h               |  2 +-
 refs/files-backend.c |  8 ++------
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 04d8f0c..27c82ec 100644
--- a/refs.c
+++ b/refs.c
@@ -302,6 +302,54 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
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
@@ -314,6 +362,7 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
@@ -324,6 +373,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
@@ -1135,6 +1185,7 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 	int flag;
 
 	if (submodule) {
+		check_submodule_backend(submodule);
 		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
 			return fn("HEAD", &oid, 0, cb_data);
 
@@ -1558,6 +1609,9 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int resolve_gitlink_ref(const char *path, const char *refname,
 			unsigned char *sha1)
 {
+	if (check_submodule_backend(path))
+		return -1;
+
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
 
diff --git a/refs.h b/refs.h
index f08e886..456e729 100644
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
index f378f06..6f13b70 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1355,13 +1355,9 @@ static int files_resolve_gitlink_ref(const char *path, const char *refname,
 
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
