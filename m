From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 16/21] refs: check submodules ref storage config
Date: Fri,  5 Feb 2016 14:44:17 -0500
Message-ID: <1454701462-3817-17-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJy-0001oO-R2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbcBETp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:45:27 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34217 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbcBETpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:45:01 -0500
Received: by mail-qk0-f182.google.com with SMTP id x1so38256476qkc.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGLVj2YxVbUssW25v9CGBPRS3w0/Q7AaNjQ6ELMOM5Q=;
        b=GU1uDlQIgze5hPxeSPS7qn+aN9gsEn5kw1v2CvPPTlJCBpco8m/teOvMuIumPKI20J
         yGisr3QbxYYKK/Ojsao5hPcVpfNoNGhKFn6njJZJdeWmNRzVSbqLZkTcjFKMRFNYv3Rn
         iB6MbiNso+g8PM68JXmZWf3xSR0qQsP8EIpiSLpdanhEJcupBaPuU9dLh290WUxWJGP+
         JInZ/osY6HxjYD8UBqtKUOyPnedfbgrYLWOKqf8p3sQx5ZuWLimmmjqtmjfNxvACFGBO
         V1PdZy0h+sUI0O2odiGWAR8c/j4Z5qXhU714sQtVoeeRMV9GufSNAsz39flVLkBBZWtt
         8DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KGLVj2YxVbUssW25v9CGBPRS3w0/Q7AaNjQ6ELMOM5Q=;
        b=F56YDWyaiO+BlLxVZUpaXTxy4H4PqVQSbXlvlCPVJFlfp7Cq/bzf0x98MeOuvOYX9o
         wcSYacwXuThfLDhmV1VH//02/pWgRiyImMOaFZ6z92raZ8oAdv85eNCEDJNYCizS9n55
         kJltZPqznx9Y005hONnOkOw9o6M4//YVsFeSyMwWiJIIJ4Lh6j/pi4mqAL7UB94hW8oE
         hkbZQIjXr8N3eZBAdX1xYvgLcZKF/rVIUYC3kELEfCmuHz+X28rTnXyiH2t+p+sAaVte
         ds+l1COBwaImJoYc8HwwrgV17KX7Hs4/fR3zgv7UZD/zLzhOTtrqPGCUYbx5Mk0qm8IB
         R6Nw==
X-Gm-Message-State: AG10YOTRDJz4gP3WSm+6F896u8s9P4RXP9lTTjejmQ8mbtTtGzW7WtQwgCXvvgTzD8PNXA==
X-Received: by 10.55.76.11 with SMTP id z11mr18544263qka.83.1454701501099;
        Fri, 05 Feb 2016 11:45:01 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.45.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:45:00 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285615>

All submodules must have the same ref storage (for now).  Confirm that
this is so before attempting to do anything with submodule refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c |  8 ++------
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 191b0a2..715a492 100644
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
 
@@ -1377,6 +1427,9 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int resolve_gitlink_ref(const char *path, const char *refname,
 			unsigned char *sha1)
 {
+	if (check_submodule_backend(path))
+		return -1;
+
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
 
@@ -1387,6 +1440,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->head_ref_submodule(submodule, fn, cb_data);
 }
 
@@ -1397,6 +1451,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->for_each_ref_submodule(submodule, fn, cb_data);
 }
 
@@ -1415,6 +1470,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 			      each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->for_each_ref_in_submodule(submodule, prefix,
 							   fn, cb_data);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d4f9040..00cd1be 100644
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
2.4.2.749.g730654d-twtrsrc
