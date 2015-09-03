From: David Turner <dturner@twopensource.com>
Subject: [PATCH 20/43] refs-be-files.c: add methods for the ref iterators
Date: Wed,  2 Sep 2015 21:54:50 -0400
Message-ID: <1441245313-11907-21-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkn-0006Bo-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbbICBzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:51 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33524 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbbICBzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:45 -0400
Received: by qgev79 with SMTP id v79so18595014qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=90vhN/ejFJDAgKXGXWQAqD2+6hFk0q0nMMIeUyVNByA=;
        b=f1TSkInvK1W8euJ6+ORz7vXsWQSlv5bBJ6/1KZmT5pNzu2rLJ9ex20tQIrxndKF+B1
         3p05b0cAxKy5OAkGdbhJdCSbMfnR5dOlFfjyuNtfqfpjO3QEX0zkYZ0QP9opY7nea4d1
         5wck2T8qKZQw8XWGjEHPiR2kFu89UVSIJot0e1lP+NY3xUVXTLAPI7houkAOih/GIhe3
         dvLhhQT9ZUBy1WXrmxBl3DQeRBEIuuMoWtGv3plvRt9zBO0gRAP7cSQxn3+Hhy8Hzii7
         zEL45RM9alatvn2JGA+qiqofYldEP+5CYZD0LBjHR1FLMQ1MfyQaGD8SsR5NM1p6nleL
         T/6A==
X-Gm-Message-State: ALoCoQm8L4JdXxbZjj6iUlTVOFv69HzFhsgFbWHr6IDDcsLh0w4M+NqzDlPd9nJZAjDNYmls4HGo
X-Received: by 10.140.216.194 with SMTP id m185mr64915949qhb.98.1441245344696;
        Wed, 02 Sep 2015 18:55:44 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277145>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 36 +++++++++++++++++++++++++-----------
 refs.c          | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 23 +++++++++++++++++++++++
 3 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 15212bd..19bf12b 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1906,37 +1906,42 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
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
+static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base), 0, cb_data);
@@ -1951,7 +1956,7 @@ int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, v
 	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -1961,7 +1966,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3843,4 +3848,13 @@ struct ref_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_resolve_gitlink_ref,
+	files_head_ref,
+	files_head_ref_submodule,
+	files_for_each_ref,
+	files_for_each_ref_submodule,
+	files_for_each_ref_in,
+	files_for_each_ref_in_submodule,
+	files_for_each_rawref,
+	files_for_each_namespaced_ref,
+	files_for_each_replace_ref,
 };
diff --git a/refs.c b/refs.c
index c1154e0..c478683 100644
--- a/refs.c
+++ b/refs.c
@@ -999,3 +999,50 @@ int resolve_gitlink_ref(const char *path, const char *refname,
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
index 0c16aad..8376abb 100644
--- a/refs.h
+++ b/refs.h
@@ -561,6 +561,20 @@ typedef int (*create_symref_fn)(struct ref_transaction *transaction,
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
+typedef int (*for_each_ref_in_submodule_fn)(const char *submodule,
+					    const char *prefix,
+					    each_ref_fn fn, void *cb_data);
+typedef int (*for_each_rawref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_namespaced_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_replace_ref_fn)(each_ref_fn fn, void *cb_data);
 
 struct ref_be {
 	struct ref_be *next;
@@ -578,6 +592,15 @@ struct ref_be {
 	peel_ref_fn peel_ref;
 	create_symref_fn create_symref;
 	resolve_gitlink_ref_fn resolve_gitlink_ref;
+	head_ref_fn head_ref;
+	head_ref_submodule_fn head_ref_submodule;
+	for_each_ref_fn for_each_ref;
+	for_each_ref_submodule_fn for_each_ref_submodule;
+	for_each_ref_in_fn for_each_ref_in;
+	for_each_ref_in_submodule_fn for_each_ref_in_submodule;
+	for_each_rawref_fn for_each_rawref;
+	for_each_namespaced_ref_fn for_each_namespaced_ref;
+	for_each_replace_ref_fn for_each_replace_ref;
 };
 
 
-- 
2.0.4.315.gad8727a-twtrsrc
