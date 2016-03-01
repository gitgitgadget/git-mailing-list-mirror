From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 25/33] refs: check submodules' ref storage config
Date: Mon, 29 Feb 2016 19:52:58 -0500
Message-ID: <1456793586-22082-26-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZm-0007F1-3j
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbcCAAyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:04 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33271 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcCAAx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:56 -0500
Received: by mail-qk0-f181.google.com with SMTP id s5so63751030qkd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhMyNvn3dZXb9whEo5DkynIZzdadeoJQT9xxkiJPrl0=;
        b=cJ2yigoI06UN/Oc+qjmnXrrRYv2+EUKihn1qjNASr53zzqXnU8Glmc79InoMTstNr0
         mY8Q/6jcThNugAPnP9wocoqHbXOBTGJ9HjMQFa2jeD6dizDk+xvinowELSgSwbmWARZn
         cB0MMopHt1c/XoaS/xplpsAhY0dS8I2N3nhVsjWX+scpCL3GbWEvwNa/XPYucyeNiEDB
         HXgYTERYalS2sU/Dl6O6ezSG4RmXgRytMm2C6iclUdxc/l0gVglwJoTEmhH9Ad0HESw3
         SCLJ11FTWNb+6ZwHXeiSSGUp6MDzhhwnthfdafI9bXT+6J/Dqer9WbU6utr1fDn+Jgir
         Cosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhMyNvn3dZXb9whEo5DkynIZzdadeoJQT9xxkiJPrl0=;
        b=ZkVlqlsIDsbF5EPk8XRSuuvgJON2JgdN8myjHjWCsRH23Xfj5yQGAYEdqmNzcJkP7o
         kBU4uyYJWYjja5At0BIHpQSdfGJ0x9GexlnhBCY+fs2PXRkD6ZLpa6uXe+JzxzwIYVKU
         6yhm+wyX4HUucnxrePeBlWhgP9b1u14FAEPyVqBb2ztk4R9uk6PgX7VvZWmvbvpwxMFF
         kQRGy6eqFYRWmBI7v5wDzIwzg4OtR+L+UVG3cdm/7pjsu8bas8yxZrKXSChlibR/p/sN
         NwpaeR+2eBPFYI4NvxRmxSEEJLK2xrQ4ByrnjssF0aAAYNsmD5VfeWdxwKY9fccwj+mq
         H/+g==
X-Gm-Message-State: AD7BkJKKDfVLbbiQMlTIPyBaidz5LIcOjilfPsOqDcGBsZz7h3teJFdz91qf8ckto/jXWQ==
X-Received: by 10.55.82.85 with SMTP id g82mr23239601qkb.107.1456793636101;
        Mon, 29 Feb 2016 16:53:56 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:55 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287959>

All submodules must have the same ref storage (for now).  Confirm that
this is so before attempting to do anything with submodule refs.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h               |  2 +-
 refs/files-backend.c |  8 ++------
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index a18cb4d..5d69179 100644
--- a/refs.c
+++ b/refs.c
@@ -301,6 +301,54 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
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
@@ -313,6 +361,7 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
@@ -323,6 +372,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
@@ -1138,6 +1188,7 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 	int flag;
 
 	if (submodule) {
+		check_submodule_backend(submodule);
 		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
 			return fn("HEAD", &oid, 0, cb_data);
 
@@ -1561,6 +1612,9 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int resolve_gitlink_ref(const char *path, const char *refname,
 			unsigned char *sha1)
 {
+	if (check_submodule_backend(path))
+		return -1;
+
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
 
diff --git a/refs.h b/refs.h
index 09486b2..1888ad8 100644
--- a/refs.h
+++ b/refs.h
@@ -512,7 +512,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data);
 
 /*
- * Read the refdb storage backend name out of the config file
+ * Read the ref storage backend name out of the config file
  */
 int ref_storage_backend_config(const char *var, const char *value, void *ptr);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7ccaf88..a13d419 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1347,13 +1347,9 @@ static int files_resolve_gitlink_ref(const char *path, const char *refname,
 
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
