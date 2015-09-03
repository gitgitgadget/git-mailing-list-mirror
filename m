From: David Turner <dturner@twopensource.com>
Subject: [PATCH 22/43] refs-be-files.c: add do_for_each_per_worktree_ref
Date: Wed,  2 Sep 2015 21:54:52 -0400
Message-ID: <1441245313-11907-23-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkn-0006Bo-5a
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbbICBzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:50 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34230 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbbICBzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:47 -0400
Received: by qgez77 with SMTP id z77so18747614qge.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3a0IumJ+rsO+PG+tL635Y+AEZjuxw9Mg6/VYVfPCZHs=;
        b=ixgKzUgwGM263w6BPWBzMfKdIEoK14r9uyDwqUbX835EI4rNxZPaTIsUymY10XT++d
         +1BmRrXrfjriNIs9xauGiOnPomupjA10nNeJDOIhjcxe+CZGaubcMZ5g1jVQTEV/AvFk
         ZIxNIrgPUGq05azCcY+ZEXOpBTrenhJfyFMOBt6WyimKi2JqKDEv+ZVIUxqmwBVAnodj
         1xwlYOfJ/K2rIXaJEAHcR+8YVHNS273PlA96hoHrdktxpP03frYwE152gZibxARndJki
         1bdOcMiXcWm1O9kJSaXwICsRODhbp0evsU1KQ1PbIRri3yWNgwovBTNFv5d/DvssQksL
         IOqA==
X-Gm-Message-State: ALoCoQl6n7VhfFtmwjkx+mbhIw1eKJrjYPMybxuciEx/UNbXzZGGyx5ZfZw3Zk/RUtCEZXPjSvrA
X-Received: by 10.140.135.202 with SMTP id 193mr14112672qhh.3.1441245346772;
        Wed, 02 Sep 2015 18:55:46 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277143>

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
index 85257b9..ff9dd6f 100644
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
 
@@ -1888,6 +1889,14 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
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
index 234496f..0c5c8e0 100644
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
2.0.4.315.gad8727a-twtrsrc
