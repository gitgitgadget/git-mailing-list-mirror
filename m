From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 20/43] refs-be-files.c: add methods for the ref iterators
Date: Mon, 28 Sep 2015 18:01:55 -0400
Message-ID: <1443477738-32023-21-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggW6-0000rV-8X
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbbI1WDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:22 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34563 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbbI1WDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:18 -0400
Received: by qkfq186 with SMTP id q186so74136158qkf.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94nd0Hkn1MJFyyk+LHPNl8vUnGox4Wi4B2XcRNNYcVU=;
        b=eUC7K+lranbkMwmraZ+P9P3sE2CSBeJp3H8PxJajTNXjEtAJRSjDu/0LcRWXSbtVun
         yT/8bHxV2kIKZosH4WWGKRB5ZV1SmPMqAB+GTpZU0sbY8sP+kCwWwHOJnoGD8X5TXtI+
         feKCrjqKP3bMpUhJtqu5G259Y/ASMP6H8YGmTce7l31HiWHtCFx5s+X4ts0lsjicJD57
         J6INKlCULTYeZ1Z1GahXx07XurSmLhsnswOMKrkbuq1QLEFRXYLjfaIsvwHeI9JKIa0m
         vgqHou+Eu9MM5KfUGQKd4QpTYarA/bs50vd1Yg+EsmJzzxOB2elOdp8BZ+SgUoxmauUK
         /3qA==
X-Gm-Message-State: ALoCoQmkz6huCmnMWrP0ZXzghEzGv41xR+pw6N6Cs+dlPaMewi7UB2XcK2d+eF6SILY3PLQ9QsUF
X-Received: by 10.55.204.204 with SMTP id n73mr6529884qkl.20.1443477797339;
        Mon, 28 Sep 2015 15:03:17 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278760>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 41 +++++++++++++++++++++++++++++------------
 refs.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 26 ++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 7101e31..9b45468 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1909,32 +1909,36 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+static int files_head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_head_ref_submodule(const char *submodule, each_ref_fn fn,
+				    void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_submodule(const char *submodule, each_ref_fn fn,
+					void *cb_data)
 {
 	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_in(const char *prefix, each_ref_fn fn,
+				 void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+static int files_for_each_fullref_in(const char *prefix, each_ref_fn fn,
+				     void *cb_data, unsigned int broken)
 {
 	unsigned int flag = 0;
 
@@ -1943,18 +1947,21 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 	return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_in_submodule(const char *submodule,
+					   const char *prefix,
+					   each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule), prefix, fn,
+			       strlen(prefix), 0, cb_data);
 }
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+
+static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -1964,7 +1971,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3846,4 +3853,14 @@ struct ref_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_resolve_gitlink_ref,
+	files_head_ref,
+	files_head_ref_submodule,
+	files_for_each_ref,
+	files_for_each_ref_submodule,
+	files_for_each_ref_in,
+	files_for_each_fullref_in,
+	files_for_each_ref_in_submodule,
+	files_for_each_rawref,
+	files_for_each_namespaced_ref,
+	files_for_each_replace_ref,
 };
diff --git a/refs.c b/refs.c
index a9901f3..0375bb5 100644
--- a/refs.c
+++ b/refs.c
@@ -1002,3 +1002,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
+
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->head_ref(fn, cb_data);
+}
+
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->head_ref_submodule(submodule, fn, cb_data);
+}
+
+int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref(fn, cb_data);
+}
+
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_submodule(submodule, fn, cb_data);
+}
+
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_in(prefix, fn, cb_data);
+}
+
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
+			unsigned int broken)
+{
+	return the_refs_backend->for_each_fullref_in(prefix, fn, cb_data,
+						     broken);
+}
+
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+			      each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_in_submodule(submodule, prefix,
+							   fn, cb_data);
+}
+
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_rawref(fn, cb_data);
+}
+
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_namespaced_ref(fn, cb_data);
+}
+
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_replace_ref(fn, cb_data);
+}
diff --git a/refs.h b/refs.h
index 6e88909..b26cffc 100644
--- a/refs.h
+++ b/refs.h
@@ -564,6 +564,22 @@ typedef int (*create_symref_fn)(struct ref_transaction *transaction,
 				const char *logmsg);
 typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
 				      unsigned char *sha1);
+typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
+				     void *cb_data);
+typedef int (*for_each_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
+					 void *cb_data);
+typedef int (*for_each_ref_in_fn)(const char *prefix, each_ref_fn fn,
+				  void *cb_data);
+typedef int (*for_each_fullref_in_fn)(const char *prefix, each_ref_fn fn,
+				      void *cb_data, unsigned int broken);
+typedef int (*for_each_ref_in_submodule_fn)(const char *submodule,
+					    const char *prefix,
+					    each_ref_fn fn, void *cb_data);
+typedef int (*for_each_rawref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_namespaced_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_replace_ref_fn)(each_ref_fn fn, void *cb_data);
 
 struct ref_be {
 	struct ref_be *next;
@@ -581,6 +597,16 @@ struct ref_be {
 	peel_ref_fn peel_ref;
 	create_symref_fn create_symref;
 	resolve_gitlink_ref_fn resolve_gitlink_ref;
+	head_ref_fn head_ref;
+	head_ref_submodule_fn head_ref_submodule;
+	for_each_ref_fn for_each_ref;
+	for_each_ref_submodule_fn for_each_ref_submodule;
+	for_each_ref_in_fn for_each_ref_in;
+	for_each_fullref_in_fn for_each_fullref_in;
+	for_each_ref_in_submodule_fn for_each_ref_in_submodule;
+	for_each_rawref_fn for_each_rawref;
+	for_each_namespaced_ref_fn for_each_namespaced_ref;
+	for_each_replace_ref_fn for_each_replace_ref;
 };
 
 
-- 
2.4.2.644.g97b850b-twtrsrc
