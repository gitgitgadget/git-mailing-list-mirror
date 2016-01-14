From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 04/20] refs: add do_for_each_per_worktree_ref
Date: Thu, 14 Jan 2016 11:26:01 -0500
Message-ID: <1452788777-24954-5-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkkK-0002pO-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbcANQ13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:29 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34127 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbcANQ0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:36 -0500
Received: by mail-qg0-f50.google.com with SMTP id 6so407850855qgy.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BHaClks0r8vpLLlb5cZ2sLgNxfyYyJ9QEOLASgEmyBs=;
        b=nCtBX7bOK9yWvI0SxiUoTuMMFcWLtLrvND2oFgo3uWhNa8gNwHIpfgKKnHKZRmyr+G
         aTc2NRBJ0O03yDtiShz0F3QUi1+t74qPcjptYhzlz1EpZ6HjWJJKcS0clKDPOfQVrQpy
         iUuSFvFT3ayZFFADVXI3/N4wr3udODIYTduZS59bhOr9CjoQMw5SuIUqvKJhkQyVt+7V
         /g06cy+HSu92PDG89pHisLbOnOPs366fqtuy/RZnfYsRnKd/8JwpuoZWFUCjD2pAVE0g
         MRVuXzCFYuPEnp6ZFzBW41BYcY0KpPEnkIt1TKhy1JmSleNAHkuJxlxwbMRx4UPoC7gB
         2USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BHaClks0r8vpLLlb5cZ2sLgNxfyYyJ9QEOLASgEmyBs=;
        b=ahAJNiPclfBU1e7rvtOP4ITjZFo7/BlqoxwDCrQLu5kVOhkexVyjihiW97p7nvVBp3
         uPkFYV54yojaxu9HQpNAKXrpBiQnWiC9RB3uonI5CpWZfk+gsrmhNpDPVc7RqUKYyt7O
         yMv4uVpnFtZjM1bCMseGJC8uWDJlrC7CDxmmkg59jrfnRUzysDCwPF1Y7WOEPJkkFv2l
         +mRX04KmW0K7fmFTV5qWS3pBjaUEpaf7UplwMjP9Uy7FS89RSX0eeN1BeitabKSsU2IB
         hwiq0KszbIG20f6c2iAxHh2IY3Iv7stMcgF/jvjri37+CTvmARMx4oXUp+PhRJdnMG8I
         k4iw==
X-Gm-Message-State: ALoCoQndu6ZDsG5k2DxJLoi5SXXhXMWtHK+1Y0KQXd/I/OTuSu3cKS5WKbgccRI322j5B4Md6pP+BmDMLou7N6T7W8KUyMir4w==
X-Received: by 10.140.181.195 with SMTP id c186mr7512988qha.4.1452788795826;
        Thu, 14 Jan 2016 08:26:35 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:34 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284054>

Alternate refs backends might still use files to store per-worktree
refs.  So the files backend's ref-loading infrastructure should be
available to those backends, just for use on per-worktree refs.  Add
do_for_each_per_worktree_ref, which iterates over per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++++---
 refs/refs-internal.h | 10 ++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dcaf9eb..68f310e 100644
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
@@ -568,6 +565,10 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
+	if (data->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+	    ref_type(entry->name) != REF_TYPE_PER_WORKTREE)
+		return 0;
+
 	if (!starts_with(entry->name, data->base))
 		return 0;
 
@@ -1738,6 +1739,14 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
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
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index cd338f9..d3cc8d0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -57,6 +57,16 @@
  */
 int refname_is_safe(const char *refname);
 
+/* Include broken references in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
+
+/* Only include per-worktree refs in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data);
+
 enum peel_status {
 	/* object was peeled successfully: */
 	PEEL_PEELED = 0,
-- 
2.4.2.749.g730654d-twtrsrc
