From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 16/44] refs.c: move ref iterators to the common code
Date: Mon, 12 Oct 2015 17:51:36 -0400
Message-ID: <1444686725-27660-17-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1G-0004N7-D3
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbbJLVwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:32 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33989 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbJLVwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:30 -0400
Received: by qkdo1 with SMTP id o1so53970647qkd.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gx8EsuK1qLdGa2vcbEq6XsxZuZo6aqq0PHxhb/TzNKI=;
        b=YAiKerwliQ/dBCc0r/UiKJWOoskK3NVBfCXszYJ9Z/3oGAKsem0Vn2kI8mo72aqVxF
         rFGSNknDY5Rmy2NTbM2wJyRHLZlZwosG+Od0INM6xRZq7PHJnWeg07EF342/7nzoUhQd
         8hpe8CaFAxdzbnc3C67p/TLX4P5Pny0PhXntJXyU9RMjTYT+gqLBtkAs+GA/c1JiqNXz
         sZCbVrN0HyvaiaUIJomQBBL5cael2vtO/lKRyKc1bpUjdduLu7go+CXYnR2NRHilMoiv
         nB2NohttRG4yvDV40eMvb+Mj9nzMdEcaAfFedalW27VNcNiaVosqLYYNrSJE6k/L+h/J
         Vw2w==
X-Gm-Message-State: ALoCoQlWJkmOWzMQc9UaZBVeCWSCBXW1BN1PoDX2jm/7O0oVH5BTrmdYAd1DlY0Cm5jUNYIUTuP3
X-Received: by 10.55.192.81 with SMTP id o78mr34596286qki.97.1444686749750;
        Mon, 12 Oct 2015 14:52:29 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279425>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 82 ---------------------------------------------------------
 refs.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 82 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index ecf2b33..46fa43c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1668,23 +1668,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-/* The argument to filter_refs */
-struct ref_filter {
-	const char *pattern;
-	each_ref_fn *fn;
-	void *cb_data;
-};
-
-static int filter_refs(const char *refname, const struct object_id *oid,
-			   int flags, void *data)
-{
-	struct ref_filter *filter = (struct ref_filter *)data;
-
-	if (wildmatch(filter->pattern, refname, 0, NULL))
-		return 0;
-	return filter->fn(refname, oid, flags, filter->cb_data);
-}
-
 enum peel_status {
 	/* object was peeled successfully: */
 	PEEL_PEELED = 0,
@@ -1950,37 +1933,6 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 {
 	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
-
-int for_each_tag_ref(each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in("refs/tags/", fn, cb_data);
-}
-
-int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
-}
-
-int for_each_branch_ref(each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in("refs/heads/", fn, cb_data);
-}
-
-int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
-}
-
-int for_each_remote_ref(each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in("refs/remotes/", fn, cb_data);
-}
-
-int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
-}
-
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
@@ -2012,40 +1964,6 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-	const char *prefix, void *cb_data)
-{
-	struct strbuf real_pattern = STRBUF_INIT;
-	struct ref_filter filter;
-	int ret;
-
-	if (!prefix && !starts_with(pattern, "refs/"))
-		strbuf_addstr(&real_pattern, "refs/");
-	else if (prefix)
-		strbuf_addstr(&real_pattern, prefix);
-	strbuf_addstr(&real_pattern, pattern);
-
-	if (!has_glob_specials(pattern)) {
-		/* Append implied '/' '*' if not present. */
-		strbuf_complete(&real_pattern, '/');
-		/* No need to check for '*', there is none. */
-		strbuf_addch(&real_pattern, '*');
-	}
-
-	filter.pattern = real_pattern.buf;
-	filter.fn = fn;
-	filter.cb_data = cb_data;
-	ret = for_each_ref(filter_refs, &filter);
-
-	strbuf_release(&real_pattern);
-	return ret;
-}
-
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
-{
-	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
-}
-
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
diff --git a/refs.c b/refs.c
index 44ee4f4..7714dad 100644
--- a/refs.c
+++ b/refs.c
@@ -781,3 +781,84 @@ const char *prettify_refname(const char *name)
 		starts_with(name, "refs/remotes/") ? 13 :
 		0);
 }
+
+/* The argument to filter_refs */
+struct ref_filter {
+	const char *pattern;
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
+static int filter_refs(const char *refname, const struct object_id *oid, int flags,
+		       void *data)
+{
+	struct ref_filter *filter = (struct ref_filter *)data;
+	if (wildmatch(filter->pattern, refname, 0, NULL))
+		return 0;
+	return filter->fn(refname, oid, flags, filter->cb_data);
+}
+
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+	const char *prefix, void *cb_data)
+{
+	struct strbuf real_pattern = STRBUF_INIT;
+	struct ref_filter filter;
+	int ret;
+
+	if (!prefix && !starts_with(pattern, "refs/"))
+		strbuf_addstr(&real_pattern, "refs/");
+	else if (prefix)
+		strbuf_addstr(&real_pattern, prefix);
+	strbuf_addstr(&real_pattern, pattern);
+
+	if (!has_glob_specials(pattern)) {
+		/* Append implied '/' '*' if not present. */
+		if (real_pattern.buf[real_pattern.len - 1] != '/')
+			strbuf_addch(&real_pattern, '/');
+		/* No need to check for '*', there is none. */
+		strbuf_addch(&real_pattern, '*');
+	}
+
+	filter.pattern = real_pattern.buf;
+	filter.fn = fn;
+	filter.cb_data = cb_data;
+	ret = for_each_ref(filter_refs, &filter);
+
+	strbuf_release(&real_pattern);
+	return ret;
+}
+
+int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
+{
+	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
+}
+
+int for_each_tag_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/tags/", fn, cb_data);
+}
+
+int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
+}
+
+int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/heads/", fn, cb_data);
+}
+
+int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
+}
+
+int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/remotes/", fn, cb_data);
+}
+
+int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
+}
-- 
2.4.2.644.g97b850b-twtrsrc
