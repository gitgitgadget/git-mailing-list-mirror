From: David Turner <dturner@twopensource.com>
Subject: [PATCH 05/43] refs.c: move update_ref to refs.c
Date: Wed,  2 Sep 2015 21:54:35 -0400
Message-ID: <1441245313-11907-6-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmL-0007FF-Jd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbbICBzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:40 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33415 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195AbbICBzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:31 -0400
Received: by qgev79 with SMTP id v79so18592201qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=srfUHi7NEtSDd3PqkT17zXFGfF1ljDel3awmPKE71Jk=;
        b=YP148w1CGqGr5P7wHLeb4iGivxFrb/aENN2bDB+1vgTnsHjjdVh6uwvpJzgXXdZs2p
         //55oR+kpnRb8sQOkJOO9anDtrKMJjpzIMuP7TllYBsZSOrcf4eSUWMkfjnf7Hd4jNS/
         VFrLzVXfzZl2HxhPv9bbD+XSxkITKFrSjlyl8bB2/JqqNXrL3ozw7b+r4vejxsWVoaJH
         X7l2+eX8CSKbJ0w0eNziXfl4L4i2FMSahGDM76U7opSgyQwAav9d2QlpbF/ul+M8/OtT
         PShnYG4VsYYo9pXUoPcFmZc4vvIkxee8IsCAY6fOJ8ov6XJkOdw/biDp64W2fuIzXpPc
         c/mA==
X-Gm-Message-State: ALoCoQkFcmvzKTxwgdmhelKCfAVf5W3wAsJ0d/O8QEFfTJQAHueMIhOaYLl4oQlTndrE6iJ0Uqlo
X-Received: by 10.140.234.78 with SMTP id f75mr5178482qhc.20.1441245330843;
        Wed, 02 Sep 2015 18:55:30 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277173>

From: Ronnie Sahlberg <sahlberg@google.com>

Move update_ref() to the refs.c file since this function does not
contain any backend specific code.  Move the ref classifier functions
as well, since update_ref depends on them.

Based on Ronnie Sahlberg's patch

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 117 +-------------------------------------------------------
 refs.c          | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 116 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9c29899..ba9796c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2685,8 +2685,6 @@ struct pack_refs_cb_data {
 	struct ref_to_prune *ref_to_prune;
 };
 
-static int is_per_worktree_ref(const char *refname);
-
 /*
  * An each_ref_entry_fn that is run over loose references only.  If
  * the loose reference can be packed, add an entry in the packed ref
@@ -2701,7 +2699,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
 	/* Do not pack per-worktree refs: */
-	if (is_per_worktree_ref(entry->name))
+	if (ref_type(entry->name) == REF_TYPE_PER_WORKTREE)
 		return 0;
 
 	/* ALWAYS pack tags */
@@ -2889,77 +2887,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-static int is_per_worktree_ref(const char *refname)
-{
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
-}
-
-static int is_pseudoref_syntax(const char *refname)
-{
-	const char *c;
-
-	for (c = refname; *c; c++) {
-		if (!isupper(*c) && *c != '-' && *c != '_')
-			return 0;
-	}
-
-	return 1;
-}
-
-enum ref_type ref_type(const char *refname)
-{
-	if (is_per_worktree_ref(refname))
-		return REF_TYPE_PER_WORKTREE;
-	if (is_pseudoref_syntax(refname))
-		return REF_TYPE_PSEUDOREF;
-       return REF_TYPE_NORMAL;
-}
-
-static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
-			   const unsigned char *old_sha1, struct strbuf *err)
-{
-	const char *filename;
-	int fd;
-	static struct lock_file lock;
-	struct strbuf buf = STRBUF_INIT;
-	int ret = -1;
-
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
-
-	filename = git_path("%s", pseudoref);
-	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
-	if (fd < 0) {
-		strbuf_addf(err, "Could not open '%s' for writing: %s",
-			    filename, strerror(errno));
-		return -1;
-	}
-
-	if (old_sha1) {
-		unsigned char actual_old_sha1[20];
-
-		if (read_ref(pseudoref, actual_old_sha1))
-			die("could not read ref '%s'", pseudoref);
-		if (hashcmp(actual_old_sha1, old_sha1)) {
-			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
-			rollback_lock_file(&lock);
-			goto done;
-		}
-	}
-
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
-		strbuf_addf(err, "Could not write to '%s'", filename);
-		rollback_lock_file(&lock);
-		goto done;
-	}
-
-	commit_lock_file(&lock);
-	ret = 0;
-done:
-	strbuf_release(&buf);
-	return ret;
-}
-
 static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
 {
 	static struct lock_file lock;
@@ -4108,48 +4035,6 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
 }
 
-int update_ref(const char *msg, const char *refname,
-	       const unsigned char *new_sha1, const unsigned char *old_sha1,
-	       unsigned int flags, enum action_on_err onerr)
-{
-	struct ref_transaction *t = NULL;
-	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
-
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
-	} else {
-		t = ref_transaction_begin(&err);
-		if (!t ||
-		    ref_transaction_update(t, refname, new_sha1, old_sha1,
-					   flags, msg, &err) ||
-		    ref_transaction_commit(t, &err)) {
-			ret = 1;
-			ref_transaction_free(t);
-		}
-	}
-	if (ret) {
-		const char *str = "update_ref failed for ref '%s': %s";
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR:
-			error(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_DIE_ON_ERR:
-			die(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_QUIET_ON_ERR:
-			break;
-		}
-		strbuf_release(&err);
-		return 1;
-	}
-	strbuf_release(&err);
-	if (t)
-		ref_transaction_free(t);
-	return 0;
-}
-
 static int ref_update_reject_duplicates(struct string_list *refnames,
 					struct strbuf *err)
 {
diff --git a/refs.c b/refs.c
index 77492ff..2d10708 100644
--- a/refs.c
+++ b/refs.c
@@ -1,3 +1,118 @@
 /*
  * Common refs code for all backends.
  */
+#include "cache.h"
+#include "refs.h"
+#include "lockfile.h"
+
+static int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/bisect/");
+}
+
+static int is_pseudoref_syntax(const char *refname)
+{
+	const char *c;
+
+	for (c = refname; *c; c++) {
+		if (!isupper(*c) && *c != '-' && *c != '_')
+			return 0;
+	}
+
+	return 1;
+}
+
+enum ref_type ref_type(const char *refname)
+{
+	if (is_per_worktree_ref(refname))
+		return REF_TYPE_PER_WORKTREE;
+	if (is_pseudoref_syntax(refname))
+		return REF_TYPE_PSEUDOREF;
+       return REF_TYPE_NORMAL;
+}
+
+static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
+			   const unsigned char *old_sha1, struct strbuf *err)
+{
+	const char *filename;
+	int fd;
+	static struct lock_file lock;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = -1;
+
+	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
+
+	filename = git_path("%s", pseudoref);
+	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	if (fd < 0) {
+		strbuf_addf(err, "Could not open '%s' for writing: %s",
+			    filename, strerror(errno));
+		return -1;
+	}
+
+	if (old_sha1) {
+		unsigned char actual_old_sha1[20];
+		read_ref(pseudoref, actual_old_sha1);
+		if (hashcmp(actual_old_sha1, old_sha1)) {
+			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		}
+	}
+
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
+		strbuf_addf(err, "Could not write to '%s'", filename);
+		rollback_lock_file(&lock);
+		goto done;
+	}
+
+	commit_lock_file(&lock);
+	ret = 0;
+done:
+	strbuf_release(&buf);
+	return ret;
+}
+
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1, const unsigned char *old_sha1,
+	       unsigned int flags, enum action_on_err onerr)
+{
+	struct ref_transaction *t = NULL;
+	struct strbuf err = STRBUF_INIT;
+	int ret = 0;
+
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
+	} else {
+		t = ref_transaction_begin(&err);
+		if (!t ||
+		    ref_transaction_update(t, refname, new_sha1, old_sha1,
+					   flags, msg, &err) ||
+		    ref_transaction_commit(t, &err)) {
+			ret = 1;
+			ref_transaction_free(t);
+		}
+	}
+
+	if (ret) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
+		}
+		strbuf_release(&err);
+		return 1;
+	}
+	strbuf_release(&err);
+	if (t)
+		ref_transaction_free(t);
+	return 0;
+}
-- 
2.0.4.315.gad8727a-twtrsrc
