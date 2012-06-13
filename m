From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/19] apply: refactor "previous patch" logic
Date: Wed, 13 Jun 2012 12:32:48 -0700
Message-ID: <1339615980-19727-8-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJj-0007rf-Qu
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab2FMTdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 343CF870C
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mVX5
	GNSym7Ffh47eCq2c8pkS7y8=; b=osTq6K0BpZuNf1faUPSm74jYAkZxjvAwrhi6
	LWcqov6Mq0Yb2k49tfQ9jedv7nmfxN8E2mi4LCT+c9jlREbb974HNtclfDqgQEiZ
	++VgXsGJ9fZpweDnav7zOdNxRlTWsMwjMeuBZR6uN5PqxnMNE1c4GWz8jXuVa6nJ
	MjmmuDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=m0O07X
	o/4s4uLu1eBBGXsI+3n5uX7yygrbT8Y/BAOXm3RXzHmgCwFzYnGqWC08IpRqW+Rs
	82VEfYQsYce1p292Fe2yOtxz/eJmIcLP0ywqqWO6eeQ0wKy7ElU7bZV2L2uMyxJ9
	It+L/39U7w11WetI4W3IMyFx2QtgvTmzy27qs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C191870B
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76353870A for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9EF91A08-B58E-11E1-BD12-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199922>

The code to grab the result of application of a previous patch in the
input was mixed with error message generation for a case where a later
patch tries to modify contents of a path that has been removed.

The same code is duplicated elsewhere in the code.  Introduce a helper
to clarify what is going on.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 76 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8496db5..78dc1a8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3046,22 +3046,50 @@ static int checkout_target(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
+static struct patch *previous_patch(struct patch *patch, int *gone)
+{
+	struct patch *previous;
+
+	*gone = 0;
+	if (patch->is_copy || patch->is_rename)
+		return NULL; /* "git" patches do not depend on the order */
+
+	previous = in_fn_table(patch->old_name);
+	if (!previous)
+		return NULL;
+
+	if (to_be_deleted(previous))
+		return NULL; /* the deletion hasn't happened yet */
+
+	if (was_deleted(previous))
+		*gone = 1;
+
+	return previous;
+}
+
+/*
+ * We are about to apply "patch"; populate the "image" with the
+ * current version we have, from the working tree or from the index,
+ * depending on the situation e.g. --cached/--index.  If we are
+ * applying a non-git patch that incrementally updates the tree,
+ * we read from the result of a previous diff.
+ */
 static int load_preimage(struct image *image,
 			 struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
 	char *img;
-	struct patch *tpatch;
+	struct patch *previous;
+	int status;
 
-	if (!(patch->is_copy || patch->is_rename) &&
-	    (tpatch = in_fn_table(patch->old_name)) != NULL && !to_be_deleted(tpatch)) {
-		if (was_deleted(tpatch)) {
-			return error(_("patch %s has been renamed/deleted"),
-				patch->old_name);
-		}
+	previous = previous_patch(patch, &status);
+	if (status)
+		return error(_("path %s has been renamed/deleted"),
+			     patch->old_name);
+	if (previous) {
 		/* We have a patched copy in memory; use that. */
-		strbuf_add(&buf, tpatch->result, tpatch->resultsize);
+		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else if (cached) {
 		if (read_file_or_gitlink(ce, &buf))
 			return error(_("read of %s failed"), patch->old_name);
@@ -3143,39 +3171,35 @@ static int verify_index_match(struct cache_entry *ce, struct stat *st)
 	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
+/*
+ * If "patch" that we are looking at modifies or deletes what we have,
+ * we would want it not to lose any local modification we have, either
+ * in the working tree or in the index.
+ */
 static int check_preimage(struct patch *patch, struct cache_entry **ce, struct stat *st)
 {
 	const char *old_name = patch->old_name;
-	struct patch *tpatch = NULL;
-	int stat_ret = 0;
+	struct patch *previous = NULL;
+	int stat_ret = 0, status;
 	unsigned st_mode = 0;
 
-	/*
-	 * Make sure that we do not have local modifications from the
-	 * index when we are looking at the index.  Also make sure
-	 * we have the preimage file to be patched in the work tree,
-	 * unless --cached, which tells git to apply only in the index.
-	 */
 	if (!old_name)
 		return 0;
 
 	assert(patch->is_new <= 0);
+	previous = previous_patch(patch, &status);
 
-	if (!(patch->is_copy || patch->is_rename) &&
-	    (tpatch = in_fn_table(old_name)) != NULL && !to_be_deleted(tpatch)) {
-		if (was_deleted(tpatch))
-			return error(_("%s: has been deleted/renamed"), old_name);
-		st_mode = tpatch->new_mode;
+	if (status)
+		return error(_("path %s has been renamed/deleted"), old_name);
+	if (previous) {
+		st_mode = previous->new_mode;
 	} else if (!cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
 			return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (to_be_deleted(tpatch))
-		tpatch = NULL;
-
-	if (check_index && !tpatch) {
+	if (check_index && !previous) {
 		int pos = cache_name_pos(old_name, strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
@@ -3197,7 +3221,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (!cached && !tpatch)
+	if (!cached && !previous)
 		st_mode = ce_mode_from_stat(*ce, st->st_mode);
 
 	if (patch->is_new < 0)
-- 
1.7.11.rc3.30.g3bdace2
