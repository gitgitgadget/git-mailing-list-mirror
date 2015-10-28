From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 25/26] refs: break out ref conflict checks
Date: Tue, 27 Oct 2015 22:14:26 -0400
Message-ID: <1445998467-11511-26-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGH5-0001WA-HX
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbbJ1CPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:35 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36514 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbbJ1CPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:24 -0400
Received: by ioll68 with SMTP id l68so243565527iol.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ydp7OwBSs11e6wUwbADAI235grtj4h3rzmlN7Ebt60Q=;
        b=JqoVff92C7Z5FKeuTwgvSSTnoj8RGCpMEcDogpiK6ZV+8Ke3Z+fGqbKK1WFHJhDrZ1
         KFFPU+4VqeafdoG5NS5nGCjOiB7o9+VMguL02Y4XPY+PfztfifdWfFJovOATnivH8mJ3
         5bUPhNOHmohetIUhOHxxZKVYgl5yundoeteZkdCtA5L9Q3Lv+TVKAU6td9QB/+wlImXs
         x8HNNs5kJp5ns5kpzdzALjc++rEwKFolLmJbkliLZR5suywDaeipo97tpPyF+0S5U57w
         rzn2IK9rlh7CQemJBrjnfeaCq9NxChwz0al06tQCg2FvhtxT13BhJbMjelDz7MCcZmjE
         4udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ydp7OwBSs11e6wUwbADAI235grtj4h3rzmlN7Ebt60Q=;
        b=UIf8rHsAUySbdAwdnsK51beSGkeh5TP9n4jELyEU/H2P6QF5UY3mb+ZHUxINY8Zb+D
         01gWvAvbUSf36Z9/jljODDxfL2+DziaR0WNFX5+Z5tWIyeS8ZQyvd4Chk3fEEmPumrTs
         lwV1VP+f5NImdx+IHkcIHogt8RbrZ3Bj/NTYYU9jtAJUtjqtqEPsBTYMhD7WJ2NhKY2P
         XteHMDarPLTyrDvPzSwFaGkhusaAO4HB1i6o7DiNJtPsf6IhB6Ysl7XrXHw9Vz8TmPnC
         X8OvBQgfL3EQ9kY5duPFwWyAtBPHGe6wYcj7k9L/9Jh9PXRuBQFeJnhl2VqekyfphM91
         yeVQ==
X-Gm-Message-State: ALoCoQkMucCUR9k+GNHwic1LW5HktnvD3B9XnYPrLrc6Y32hNMahv+Mn8L4kX82xtdME99racfzc
X-Received: by 10.107.18.91 with SMTP id a88mr47696634ioj.91.1445998523836;
        Tue, 27 Oct 2015 19:15:23 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280343>

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
index 0eabea9..97a5983 100644
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
@@ -2460,22 +2443,6 @@ out:
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
index 056c172..5d8b6ea 100644
--- a/refs.c
+++ b/refs.c
@@ -1027,3 +1027,41 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
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
index f97a2e4..88fea3e 100644
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
2.4.2.658.g6d8523e-twtrsrc
