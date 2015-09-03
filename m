From: David Turner <dturner@twopensource.com>
Subject: [PATCH 16/43] refs.c: move ref iterators to the common code
Date: Wed,  2 Sep 2015 21:54:46 -0400
Message-ID: <1441245313-11907-17-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmD-00079K-G9
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbbICB5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:13 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35006 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbbICBzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:42 -0400
Received: by qgt47 with SMTP id 47so18595065qgt.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8SDDLTmv17INNiLgVqnkv4AG1vBe1EyxVOIC1V/8Es=;
        b=YAWhgf2zExCQ0BgQrTPyJaUgW4N+HWxl9tWstWFWeiUB0Np0ONNc8w9LC/JLZVUmv9
         cuMYid+T/6zXs3gnT79LV9dJkt/i9xrtTPrfbIWJMNUvZsJyB2zBl+mwJAKk/o/V21p+
         X3L3SC0sKbbazDikxHOQKIUzQhW7aUZR+4zLh5YfYKi1+T3yMKGVfFunqTNvnUphWTMx
         jXuTJ9VByKkV+z2rKJ0P4ce1gdbfTurAcg8XXQFGUJD0v5XgFM6MnyUHaJ0HxDxkoTFc
         avBR2VDdI47v2XprTRp0/n24bzQQ1q0YLz4T1YxHW1KkXN4dUT2oA6foSCxNoXQpTv2g
         sHzw==
X-Gm-Message-State: ALoCoQnog84dpjWEXO/ZYpxfL6byFNVUxdkWc4KSZ/jQmSrkSDMOKNVu8jhveDSQgvaZMrJIxIQj
X-Received: by 10.140.19.226 with SMTP id 89mr2342619qgh.23.1441245341142;
        Wed, 02 Sep 2015 18:55:41 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277171>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 83 ---------------------------------------------------------
 refs.c          | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 6b5b290..a36568f 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1677,23 +1677,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
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
@@ -2021,41 +1973,6 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
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
-		if (real_pattern.buf[real_pattern.len - 1] != '/')
-			strbuf_addch(&real_pattern, '/');
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
2.0.4.315.gad8727a-twtrsrc
