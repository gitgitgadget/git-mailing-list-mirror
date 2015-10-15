From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 25/26] refs: break out ref conflict checks
Date: Thu, 15 Oct 2015 15:46:49 -0400
Message-ID: <1444938410-2345-26-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVK-0007IP-9W
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbbJOTrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:46 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33776 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbbJOTrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:35 -0400
Received: by qgeo38 with SMTP id o38so36984138qge.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ZnUoLigs6Y6V39nV8MW6dZ8xnPvq9Ze39c2cUzUJ5o=;
        b=TYriL4Trs0dn1ag3X8ZSE0178nMXTVU/D3OcNfEYqpozIZoUjdx6vuomEYTX2S6V7B
         Nx29N1sxAQeqk6ImirAFwHOrRRHv30mIPJrC1sNMzCTqYrmMlWrcIyOKFSkk2PnBFkdl
         Z6bIA9o3LZQqSkJR8ZbfIQUd9GHqwGr8+WGv4Q5BhBKM5a4D2k9SRRsOUPV/l9etSlFh
         fuqOPssXoil+AT3WuZSH673BVzK6DpsJ+p6vHNEsh+6IH5KvhdjhxtI8jrWztrvc6eGL
         nyF06d1pn8ifmcjeMm/yTPPKfZlgMHxy+Rit3abaCSvUT4zP599JPU9qfMAQutDVjFtQ
         MHBQ==
X-Gm-Message-State: ALoCoQl+SrrPGdltkzVxN3RjV70DmGPK5ps9M+aTY3wul9vvaBcvuaFAQHIt0o2MmXFyAtwtoHs0
X-Received: by 10.140.151.81 with SMTP id 78mr15344643qhx.101.1444938454700;
        Thu, 15 Oct 2015 12:47:34 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279699>

Create new function verify_no_descendants, to hold one of the ref
conflict checks used in verify_refname_available.  Multiple backends
will need this function, so it goes in the common code.

rename_ref_available also moves to the common code, because alternate
backends might need it and it has no files-backend-specific code.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 49 ++++++++-----------------------------------------
 refs.c          | 38 ++++++++++++++++++++++++++++++++++++++
 refs.h          | 15 +++++++++++++++
 3 files changed, 61 insertions(+), 41 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 1bda3e4..1f17348 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -729,6 +729,7 @@ static int verify_refname_available_dir(const char *refname,
 					struct strbuf *err)
 {
 	const char *slash;
+	const char *extra_refname;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
 	int ret = -1;
@@ -834,33 +835,15 @@ static int verify_refname_available_dir(const char *refname,
 		}
 	}
 
-	if (extras) {
-		/*
-		 * Check for entries in extras that start with
-		 * "$refname/". We do that by looking for the place
-		 * where "$refname/" would be inserted in extras. If
-		 * there is an entry at that position that starts with
-		 * "$refname/" and is not in skip, then we have a
-		 * conflict.
-		 */
-		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
-		     pos < extras->nr; pos++) {
-			const char *extra_refname = extras->items[pos].string;
-
-			if (!starts_with(extra_refname, dirname.buf))
-				break;
-
-			if (!skip || !string_list_has_string(skip, extra_refname)) {
-				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-					    refname, extra_refname);
-				goto cleanup;
-			}
-		}
+	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
+	if (extra_refname) {
+		strbuf_addf(err,
+			    "cannot process '%s' and '%s' at the same time",
+			    refname, extra_refname);
+	} else {
+		ret = 0;
 	}
 
-	/* No conflicts were found */
-	ret = 0;
-
 cleanup:
 	strbuf_release(&dirname);
 	return ret;
@@ -2461,22 +2444,6 @@ out:
 	return ret;
 }
 
-static int rename_ref_available(const char *oldname, const char *newname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip, &err);
-	if (!ret)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ret;
-}
-
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
diff --git a/refs.c b/refs.c
index efc1c47..72d96ed 100644
--- a/refs.c
+++ b/refs.c
@@ -1028,3 +1028,41 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 	hashcpy(sha1, o->sha1);
 	return PEEL_PEELED;
 }
+
+const char *find_descendant_ref(const char *dirname,
+				const struct string_list *extras,
+				const struct string_list *skip)
+{
+	int pos;
+	if (!extras)
+		return NULL;
+
+	/* Look for the place where dirname would be inserted in extras. */
+	for (pos = string_list_find_insert_index(extras, dirname, 0);
+	     pos < extras->nr; pos++) {
+		const char *extra_refname = extras->items[pos].string;
+
+		if (!starts_with(extra_refname, dirname))
+			break;
+
+		if (!skip || !string_list_has_string(skip, extra_refname))
+			return extra_refname;
+	}
+	return NULL;
+}
+
+int rename_ref_available(const char *oldname, const char *newname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	string_list_insert(&skip, oldname);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
+	if (!ret)
+		error("%s", err.buf);
+
+	string_list_clear(&skip, 0);
+	strbuf_release(&err);
+	return ret;
+}
diff --git a/refs.h b/refs.h
index 7aed0a2..69fa4df 100644
--- a/refs.h
+++ b/refs.h
@@ -362,6 +362,8 @@ int pack_refs(unsigned int flags);
 int verify_refname_available(const char *newname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err);
 
+int rename_ref_available(const char *oldname, const char *newname);
+
 extern int is_branch(const char *refname);
 
 /*
@@ -623,6 +625,19 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err);
 
+/*
+ * Check for entries in extras that are within the specified
+ * directory, where dirname is a reference directory name including
+ * the trailing slash (e.g., "refs/heads/master/"). Ignore any
+ * conflicting references that are found in skip. If there is a
+ * conflicting reference, return its name.
+ *
+ * extras and skip must be sorted lists of reference names. skip can
+ * be NULL; extras cannot.
+ */
+const char *find_descendant_ref(const char *dirname,
+				const struct string_list *extras,
+				const struct string_list *skip);
 
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
-- 
2.4.2.644.g97b850b-twtrsrc
