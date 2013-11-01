From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] rev-list --exclude: export add/clear-ref-exclusion and ref-excluded API
Date: Fri,  1 Nov 2013 12:34:14 -0700
Message-ID: <1383334455-18623-3-git-send-email-gitster@pobox.com>
References: <52264070.3080909@kdbg.org>
 <1383334455-18623-1-git-send-email-gitster@pobox.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 20:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcKUM-0004QG-UE
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 20:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab3KATe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 15:34:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab3KATe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 15:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B69864ECE7;
	Fri,  1 Nov 2013 15:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7lRC
	QrUx2BBsGxNkaHe/NMJaoH8=; b=LO88aVYFZ/hc8590jdx/5clV7yJcgPSlgKPk
	inuSu9L0pfBqd93sKF1NcVy4oYvfaloWKUo0MRdqn9ZwPs86c3TpvLzO17oqdm+4
	294cPvLayZW8CI4GjqyA/l+oSThhjP3rA98AIi/9J2bqVkBPiGeF39dsVAJmlJKR
	7IaMSRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	D2Pu/2FBtmySSHroA4/BojYgA51vhvwdibAHQqWes28rxDZ0FwLXkOkP47FQ5omu
	atAteA45SA/LYsvaOhwawPemIdwN3N5A8VB8VZH9Z4h+0m4fUhqbWXBOCXFVzC8o
	IEgdlvNRDQL4AtKi6JX9GMU4IeQYDV6JlKmX7I7JYaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A85264ECE6;
	Fri,  1 Nov 2013 15:34:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAF324ECE5;
	Fri,  1 Nov 2013 15:34:24 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <1383334455-18623-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9D5E4682-432C-11E3-BD5B-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237219>

... while updating their function signature.  To be squashed into
the initial patch to rev-list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 46 +++++++++++++++++++++++-----------------------
 revision.h |  5 +++++
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/revision.c b/revision.c
index 3e82874..ddc71b9 100644
--- a/revision.c
+++ b/revision.c
@@ -1180,13 +1180,13 @@ struct all_refs_cb {
 	const char *name_for_errormsg;
 };
 
-static int ref_excluded(struct rev_info *revs, const char *path)
+int ref_excluded(struct string_list *ref_excludes, const char *path)
 {
 	struct string_list_item *item;
 
-	if (!revs->ref_excludes)
+	if (!ref_excludes)
 		return 0;
-	for_each_string_list_item(item, revs->ref_excludes) {
+	for_each_string_list_item(item, ref_excludes) {
 		if (!fnmatch(item->string, path, 0))
 			return 1;
 	}
@@ -1198,7 +1198,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
 
-	if (ref_excluded(cb->all_revs, path))
+	if (ref_excluded(cb->all_revs->ref_excludes, path))
 	    return 0;
 
 	object = get_reference(cb->all_revs, path, sha1, cb->all_flags);
@@ -1214,22 +1214,22 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	cb->all_flags = flags;
 }
 
-static void clear_ref_exclusion(struct rev_info *revs)
+void clear_ref_exclusion(struct string_list **ref_excludes_p)
 {
-	if (revs->ref_excludes) {
-		string_list_clear(revs->ref_excludes, 0);
-		free(revs->ref_excludes);
+	if (*ref_excludes_p) {
+		string_list_clear(*ref_excludes_p, 0);
+		free(*ref_excludes_p);
 	}
-	revs->ref_excludes = NULL;
+	*ref_excludes_p = NULL;
 }
 
-static void add_ref_exclusion(struct rev_info *revs, const char *exclude)
+void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 {
-	if (!revs->ref_excludes) {
-		revs->ref_excludes = xcalloc(1, sizeof(*revs->ref_excludes));
-		revs->ref_excludes->strdup_strings = 1;
+	if (!*ref_excludes_p) {
+		*ref_excludes_p = xcalloc(1, sizeof(**ref_excludes_p));
+		(*ref_excludes_p)->strdup_strings = 1;
 	}
-	string_list_append(revs->ref_excludes, exclude);
+	string_list_append(*ref_excludes_p, exclude);
 }
 
 static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
@@ -1988,44 +1988,44 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs(submodule, revs, *flags, head_ref_submodule);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
 		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
 		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
-		add_ref_exclusion(revs, optarg);
+		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
 	} else if (!prefixcmp(arg, "--branches=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!prefixcmp(arg, "--tags=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!prefixcmp(arg, "--remotes=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
-		clear_ref_exclusion(revs);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		handle_reflog(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
diff --git a/revision.h b/revision.h
index b4dc56c..c67c46d 100644
--- a/revision.h
+++ b/revision.h
@@ -192,6 +192,11 @@ struct rev_info {
 	struct decoration line_log_data;
 };
 
+extern int ref_excluded(struct string_list *, const char *path);
+void clear_ref_exclusion(struct string_list **);
+void add_ref_exclusion(struct string_list **, const char *exclude);
+
+
 #define REV_TREE_SAME		0
 #define REV_TREE_NEW		1	/* Only new files */
 #define REV_TREE_OLD		2	/* Only files removed */
-- 
1.8.5-rc0-281-g8951339
