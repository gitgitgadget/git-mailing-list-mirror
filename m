From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 23/44] refs-be-files.c: add do_for_each_per_worktree_ref
Date: Mon, 12 Oct 2015 17:51:44 -0400
Message-ID: <1444686725-27660-25-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2h-0005nc-43
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbbJLVxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:52 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34443 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbbJLVwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:40 -0400
Received: by qgez77 with SMTP id z77so130220723qge.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7WxIUjuoOQ16q8dvmFvbhFk460MzSvkLjM2jWVB9uk=;
        b=P5l/dI2lNi9s7OzUxkfU9hYXEJv18CcxLfTYdfbijTaCVTFQvN8ssIxh6M9IS8IM6Q
         iVh4vIapKUkQQzjyD/tshHzfJo6FKkyKur9f7a/co9j4RyoxTPk0NoqTgSmcC5vrNsE0
         Hk4Fm+YSC5FPR8wLTt7xUGaPo1pQtcDw5xjrC2uGflQxfmd1gBbrAhwUki+33OXz7hPV
         XpfinpJs9KLfO3pCot2rkuB2asbpSlAMyR7AemBbqzIS5dyWicdxM4wPN1lKb4j+VIf0
         6DA4usymaDIz0kHEUDNn8uwnNWAQs8E15Hhfi0TREP08b2E+H4tcGe/WTujQ5NvDXygA
         XnUw==
X-Gm-Message-State: ALoCoQlWJ9chd+8zdUV1Z1/RcFQrTu1gKAIaFR62TD7Y+SdJNibQ6U2GQaWi25hGEc97+WTrQbYI
X-Received: by 10.140.133.10 with SMTP id 10mr36774106qhf.95.1444686758821;
        Mon, 12 Oct 2015 14:52:38 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279453>

Alternate refs backends might still use files to store per-worktree
refs.  So the files backend's ref-loading infrastructure should be
available to those backends, just for use on per-worktree refs.  Add
do_for_each_per_worktree_ref, which iterates over per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 15 ++++++++++++---
 refs.h          | 11 +++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index c99319f..9548fb3 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -552,9 +552,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
  * Return true iff the reference described by entry can be resolved to
  * an object in the database.  Emit a warning if the referred-to
@@ -602,6 +599,10 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
+	if (data->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+	    ref_type(entry->name) != REF_TYPE_PER_WORKTREE)
+		return 0;
+
 	if (!starts_with(entry->name, data->base))
 		return 0;
 
@@ -1844,6 +1845,14 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data)
+{
+	return do_for_each_ref(get_ref_cache(submodule), base, fn, trim,
+			       flags | DO_FOR_EACH_PER_WORKTREE_ONLY, cb_data);
+}
+
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
diff --git a/refs.h b/refs.h
index 491aa1d..e2ba725 100644
--- a/refs.h
+++ b/refs.h
@@ -241,6 +241,12 @@ struct ref_transaction {
  */
 #define REF_BAD_NAME 0x08
 
+/* Include broken references in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
+
+/* Only include per-worktree refs in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+
 /*
  * The signature for the callback function for the for_each_*()
  * functions below.  The memory pointed to by the refname and sha1
@@ -284,6 +290,11 @@ extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn fn, void *cb_data);
 
+
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data);
+
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
-- 
2.4.2.644.g97b850b-twtrsrc
