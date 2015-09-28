From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 22/43] refs-be-files.c: add do_for_each_per_worktree_ref
Date: Mon, 28 Sep 2015 18:01:57 -0400
Message-ID: <1443477738-32023-23-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXF-0002Ea-Av
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbbI1WEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:34 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:32792 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbbI1WDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:20 -0400
Received: by qgev79 with SMTP id v79so133377531qge.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hv3jodBafnQNkDn1YMedYgcycCKb8w1Q90cuSeWUNw4=;
        b=daFCWZipYeTsP9LiYP4/RTY0HlM5WYXP/yE7O3Pui+Ed6RV3yIF8slKCG/YVHCwrUN
         qWYna6TqMfexHpH2McXvXgqXgzYg+HAxZlxxCUQEIncpt7/8z6tDxxgdb9QWrr6qWQEd
         6+WLLrN2pLBhz9J1jaCDor6RRhEpRPlE1naoOLx2+J/zBi0/K5zUIbhrVipRvEv/K02Y
         vkOJprPI9GhkKpXGWbM7r4wxrGyKUXcf/BCJ/xtaCprB36co2cERaC1nOHAywW5nZCvs
         S5a34NOE+81+7D/Mhur7xiMOQ/FhhLKQcO2w6h2zWNGWXn698PEIs8A8EzzU1bSoEwvo
         v+rg==
X-Gm-Message-State: ALoCoQlvFqiBZ7wRUYXo+9MTdGFyKuZDJLpigLhPLXmqm7YPUCefQ0UpP6HFSGT810QGuMAEWZxr
X-Received: by 10.140.237.14 with SMTP id i14mr26707053qhc.28.1443477799379;
        Mon, 28 Sep 2015 15:03:19 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278785>

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
index eb18a20..dc89289 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -587,9 +587,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
  * Return true iff the reference described by entry can be resolved to
  * an object in the database.  Emit a warning if the referred-to
@@ -637,6 +634,10 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
+	if (data->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+	    ref_type(entry->name) != REF_TYPE_PER_WORKTREE)
+		return 0;
+
 	if (!starts_with(entry->name, data->base))
 		return 0;
 
@@ -1891,6 +1892,14 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
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
index 5875fe5..09d140d 100644
--- a/refs.h
+++ b/refs.h
@@ -152,6 +152,12 @@ struct ref_transaction;
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
@@ -195,6 +201,11 @@ extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
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
