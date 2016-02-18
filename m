From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 02/27] refs: move for_each_*ref* functions into common code
Date: Thu, 18 Feb 2016 00:17:25 -0500
Message-ID: <1455772670-21142-3-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGz6-00013V-RV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424744AbcBRFSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:34 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35031 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcBRFS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:27 -0500
Received: by mail-qg0-f54.google.com with SMTP id y89so29367335qge.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WNHjhPUT1w8SWjx1k6C+E8RVOanNTnULIB7vur5W77o=;
        b=1kn9lK0TwrYbKmKXZ8eNbe8S05vI9v25FoZBYZKuCdHglGCPxKfOBf7k3NCu8ijZ7K
         NlgBjx9w8EcAogKdzlZqsCx4BfRIMKSNRFKviUHh1On+9y/6p/Qo9bT1vqyRlnTcMp9B
         NylrzmRBCP8FEff8sydmKfazL7I/p/c8JN3/PNrfhaHV4SJ2xbhT7RESVHVCwm8WYC82
         bbmCZ7ikUKqdzADTPfGRH6HZN1WSG5n/lS7ysvMD1fB329FZHIJT/oWybhP9hkh9/Ztb
         1mnm1Z0kuXvDi3mKIZmeXbQxt6+X6bMNKDj8KDXtvOtJPUThrpWebdYTXja79KHALMNN
         Wr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WNHjhPUT1w8SWjx1k6C+E8RVOanNTnULIB7vur5W77o=;
        b=jPzVFOYH2yLRyTJnkocI6xVqaCmxVzIgBG8z1hUpQCOPtN9rHA/8WbmZIYvBXVafe0
         MOAmzo3JYyI5QQimUnqmLVKgZUpGS1el4ltjZ+UhcbrUT0f3uK2xQ/RzsL64gE8bc90o
         zRklbRvsEw/a68WosxwcimWqNhxAcOWLZ9ZLcVtSBVEm8+Mlp88DL92fbpUfydrjESMj
         oYUqvoxutQNC24/zwAkM4cCgBpZXg0tWzuGTRpBgfL/PgmDfbuAiz3TsPX6uRm85nFnf
         hskbSxKZgOVckwiPSy8eABYN11W88Dmx4dEpxljkU1Gk7g8QVA8rf+1tCT0QDX7qnOru
         Lt0A==
X-Gm-Message-State: AG10YOQ2XdFrwmDD2M98UahDd0lQ4yWDgrTVFL84okH0A4ppDyBsgeg7xhI2SBK+xwW1PQ==
X-Received: by 10.140.99.69 with SMTP id p63mr6554984qge.97.1455772707104;
        Wed, 17 Feb 2016 21:18:27 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:26 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286574>

Make do_for_each_ref take a submodule as an argument instead of a
ref_cache.  Since all for_each_*ref* functions are defined in terms of
do_for_each_ref, we can then move them into the common code.

Later, we can simply make do_for_each_ref into a backend function.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 52 +++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 62 +++++-----------------------------------------------
 refs/refs-internal.h |  9 ++++++++
 3 files changed, 66 insertions(+), 57 deletions(-)

diff --git a/refs.c b/refs.c
index 4367c14..c38311b 100644
--- a/refs.c
+++ b/refs.c
@@ -1105,3 +1105,55 @@ int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return head_ref_submodule(NULL, fn, cb_data);
 }
+
+int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
+}
+
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(submodule, "", fn, 0, 0, cb_data);
+}
+
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
+}
+
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(NULL, prefix, fn, 0, flag, cb_data);
+}
+
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+		each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(submodule, prefix, fn, strlen(prefix), 0, cb_data);
+}
+
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, git_replace_ref_base, fn,
+			       strlen(git_replace_ref_base), 0, cb_data);
+}
+
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+	strbuf_addf(&buf, "%srefs/", get_git_namespace());
+	ret = do_for_each_ref(NULL, buf.buf, fn, 0, 0, cb_data);
+	strbuf_release(&buf);
+	return ret;
+}
+
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(NULL, "", fn, 0,
+			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2e2a6d9..fd664d6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -518,9 +518,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
  * Return true iff the reference described by entry can be resolved to
  * an object in the database.  Emit a warning if the referred-to
@@ -1735,10 +1732,13 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_ref(struct ref_cache *refs, const char *base,
-			   each_ref_fn fn, int trim, int flags, void *cb_data)
+int do_for_each_ref(const char *submodule, const char *base,
+		    each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
+	struct ref_cache *refs;
+
+	refs = get_ref_cache(submodule);
 	data.base = base;
 	data.trim = trim;
 	data.flags = flags;
@@ -1753,58 +1753,6 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
-}
-
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
-}
-
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
-}
-
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
-{
-	unsigned int flag = 0;
-
-	if (broken)
-		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
-}
-
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
-}
-
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base), 0, cb_data);
-}
-
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret;
-	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(&ref_cache, buf.buf, fn, 0, 0, cb_data);
-	strbuf_release(&buf);
-	return ret;
-}
-
-int for_each_rawref(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7dded3..92aae80 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,4 +197,13 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
+
+/* Include broken references in a do_for_each_ref*() iteration: */
+#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
+
+/*
+ * The common backend for the for_each_*ref* functions
+ */
+int do_for_each_ref(const char *submodule, const char *base,
+		    each_ref_fn fn, int trim, int flags, void *cb_data);
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.767.g62658d5-twtrsrc
