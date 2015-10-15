From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 05/26] refs.c: move update_ref to refs.c
Date: Thu, 15 Oct 2015 15:46:29 -0400
Message-ID: <1444938410-2345-6-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVp-0007pG-6o
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbbJOTsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:48:23 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33362 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbbJOTrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:11 -0400
Received: by qgeo38 with SMTP id o38so36973884qge.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9bwG1C3jWLhLOiKLPGVJg7mu8ff0HTGMqBz2CCE+heo=;
        b=ViRQ9fZl+evr9ucMcVkHk6ce0HgfBhvhsbpZ11TRCdsCEjmZ0AuAJc6D/JMd3B7e0B
         CPciBXee+BeDP6FjOxQ55ld6ZHpLDgbfNEvjlq3M9ikHozu76ELtF7qlz4Jah3txmAKS
         r2j0tvSEQkQq7XRXekICor4KmoN+tH7MG7NDr9g3cNPxXvOr6Ry3qLYLc/0Kz72zFo4j
         aoUm7eoU9ZNoohYb3REK0BwTtlNwxXbE7y6WRbiRf96fv13/WJC/gw7I75c1WN7ryhb4
         MUB9AJ+JFN+R4nnp1jONmnD4JqmmXSL0BCdVWV+Qthl0Hx8n9nOv5Pnjt43yEVv7t5AM
         GYjw==
X-Gm-Message-State: ALoCoQlAAzzS1Y+lecE96zyXKBs8zF2hNYCphrHDJQBOgoMBZqLq4tJMBSgDdnK62c+SlCY0684J
X-Received: by 10.140.106.99 with SMTP id d90mr14343412qgf.6.1444938430766;
        Thu, 15 Oct 2015 12:47:10 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:09 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279706>

From: Ronnie Sahlberg <sahlberg@google.com>

Move update_ref() to the refs.c file since this function does not
contain any backend specific code.  Move the ref classifier functions
as well, since update_ref depends on them.

Based on Ronnie Sahlberg's patch

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 117 +-------------------------------------------------------
 refs.c          | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 116 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 84abc82..72a9bc4 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2675,8 +2675,6 @@ struct pack_refs_cb_data {
 	struct ref_to_prune *ref_to_prune;
 };
 
-static int is_per_worktree_ref(const char *refname);
-
 /*
  * An each_ref_entry_fn that is run over loose references only.  If
  * the loose reference can be packed, add an entry in the packed ref
@@ -2691,7 +2689,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
 	/* Do not pack per-worktree refs: */
-	if (is_per_worktree_ref(entry->name))
+	if (ref_type(entry->name) == REF_TYPE_PER_WORKTREE)
 		return 0;
 
 	/* ALWAYS pack tags */
@@ -2887,77 +2885,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
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
@@ -4106,48 +4033,6 @@ int ref_transaction_verify(struct ref_transaction *transaction,
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
index 77492ff..610fab0 100644
--- a/refs.c
+++ b/refs.c
@@ -1,3 +1,119 @@
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
+
+		if (read_ref(pseudoref, actual_old_sha1))
+			die("could not read ref '%s'", pseudoref);
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
2.4.2.644.g97b850b-twtrsrc
