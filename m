Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D918201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbdBUXsX (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:48:23 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39886 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753427AbdBUXry (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:47:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C2BCB280B8;
        Tue, 21 Feb 2017 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720864;
        bh=+h+9VqLVJR8nAQGXsxteIiLpSIw0Ib10zPysaAmHmAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVLOoSVi2h031oj7dXlDTxv/muh4gp/zzTJyaKQi/R3yS34iMaxAHxiCPF90Brbjg
         6YiMOSLqyPHuw3T+a9cxXJp3qjXArX4zZ0TT2l3os9eBQuI2+ojofDcHZHRuEQd7Pg
         Cs7qyNabIA5ak0ywmEZMtsxE+owmAWEIrK6HvsQmoac34AcNaHpG6lE2eln2OADl3U
         MiGtsXhO3y9mhMOnmEwFCCvnt7nW8GoFe4OUQg+0Dl5GaO4HYB6QY57AtwdZnIOrVK
         5KueirejF/x8U+R2oUDi2UBx7vFw4y+YtBI0LgFvsoo7KJ8bth2HVwTNdbQjhKdW7S
         S/QHILtLgm8kEOeGrsNcTdohYM+s5nD4NSAVD7dY+PTPN+E1u1eWF1awcCzLgu+JQ3
         5eBwUbA3RIbinKDcb5iwOVPWbir7W19ASDgoFxjuPqrDZ+5w5OZRFA9J1UEDs15R6/
         QgwBoC4gQPGucTeEyJ/DqtDjtQ28sLXvon8IRYQWnvyWkwml5DA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 11/19] Convert remaining callers of resolve_refdup to object_id
Date:   Tue, 21 Feb 2017 23:47:29 +0000
Message-Id: <20170221234737.894681-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few leaf functions in various files that call
resolve_refdup.  Convert these functions to use struct object_id
internally to prepare for transitioning resolve_refdup itself.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/notes.c        | 18 +++++++++---------
 builtin/receive-pack.c |  4 ++--
 ref-filter.c           |  4 ++--
 reflog-walk.c          | 12 ++++++------
 transport.c            |  4 ++--
 wt-status.c            |  4 ++--
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 5248a9bad8..8c569a49a0 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -693,7 +693,7 @@ static int merge_abort(struct notes_merge_options *o)
 static int merge_commit(struct notes_merge_options *o)
 {
 	struct strbuf msg = STRBUF_INIT;
-	unsigned char sha1[20], parent_sha1[20];
+	struct object_id oid, parent_oid;
 	struct notes_tree *t;
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
@@ -705,27 +705,27 @@ static int merge_commit(struct notes_merge_options *o)
 	 * and target notes ref from .git/NOTES_MERGE_REF.
 	 */
 
-	if (get_sha1("NOTES_MERGE_PARTIAL", sha1))
+	if (get_oid("NOTES_MERGE_PARTIAL", &oid))
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
-	else if (!(partial = lookup_commit_reference(sha1)))
+	else if (!(partial = lookup_commit_reference(oid.hash)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
 	else if (parse_commit(partial))
 		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
 
 	if (partial->parents)
-		hashcpy(parent_sha1, partial->parents->item->object.oid.hash);
+		oidcpy(&parent_oid, &partial->parents->item->object.oid);
 	else
-		hashclr(parent_sha1);
+		oidclr(&parent_oid);
 
 	t = xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
-		resolve_refdup("NOTES_MERGE_REF", 0, sha1, NULL);
+		resolve_refdup("NOTES_MERGE_REF", 0, oid.hash, NULL);
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
 
-	if (notes_merge_commit(o, t, partial, sha1))
+	if (notes_merge_commit(o, t, partial, oid.hash))
 		die(_("failed to finalize notes merge"));
 
 	/* Reuse existing commit message in reflog message */
@@ -733,8 +733,8 @@ static int merge_commit(struct notes_merge_options *o)
 	format_commit_message(partial, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insert(&msg, 0, "notes: ", 7);
-	update_ref(msg.buf, o->local_ref, sha1,
-		   is_null_sha1(parent_sha1) ? NULL : parent_sha1,
+	update_ref(msg.buf, o->local_ref, oid.hash,
+		   is_null_oid(&parent_oid) ? NULL : parent_oid.hash,
 		   0, UPDATE_REFS_DIE_ON_ERR);
 
 	free_notes(t);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1dbb8a0692..7966f4f4df 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1414,7 +1414,7 @@ static void execute_commands(struct command *commands,
 {
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	struct command *cmd;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
@@ -1471,7 +1471,7 @@ static void execute_commands(struct command *commands,
 	check_aliased_updates(commands);
 
 	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
+	head_name = head_name_to_free = resolve_refdup("HEAD", 0, oid.hash, NULL);
 
 	if (use_atomic)
 		execute_commands_atomic(commands, si);
diff --git a/ref-filter.c b/ref-filter.c
index 3820b21cc7..f0de30e2ef 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -961,9 +961,9 @@ static void populate_value(struct ref_array_item *ref)
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
-		unsigned char unused1[20];
+		struct object_id unused1;
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
-					     unused1, NULL);
+					     unused1.hash, NULL);
 		if (!ref->symref)
 			ref->symref = "";
 	}
diff --git a/reflog-walk.c b/reflog-walk.c
index a246af2767..f98748e2ae 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -45,11 +45,11 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 	reflogs->ref = xstrdup(ref);
 	for_each_reflog_ent(ref, read_one_reflog, reflogs);
 	if (reflogs->nr == 0) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *name;
 		void *name_to_free;
 		name = name_to_free = resolve_refdup(ref, RESOLVE_REF_READING,
-						     sha1, NULL);
+						     oid.hash, NULL);
 		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 			free(name_to_free);
@@ -172,18 +172,18 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		reflogs = item->util;
 	else {
 		if (*branch == '\0') {
-			unsigned char sha1[20];
+			struct object_id oid;
 			free(branch);
-			branch = resolve_refdup("HEAD", 0, sha1, NULL);
+			branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
 			if (!branch)
 				die ("No current branch");
 
 		}
 		reflogs = read_complete_reflog(branch);
 		if (!reflogs || reflogs->nr == 0) {
-			unsigned char sha1[20];
+			struct object_id oid;
 			char *b;
-			if (dwim_log(branch, strlen(branch), sha1, &b) == 1) {
+			if (dwim_log(branch, strlen(branch), oid.hash, &b) == 1) {
 				if (reflogs) {
 					free(reflogs->ref);
 					free(reflogs);
diff --git a/transport.c b/transport.c
index d72e089484..141af31e8e 100644
--- a/transport.c
+++ b/transport.c
@@ -467,11 +467,11 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 {
 	struct ref *ref;
 	int n = 0;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	char *head;
 	int summary_width = transport_summary_width(refs);
 
-	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
diff --git a/wt-status.c b/wt-status.c
index d47012048f..0ec090a338 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -121,7 +121,7 @@ static void status_printf_more(struct wt_status *s, const char *color,
 
 void wt_status_prepare(struct wt_status *s)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	memset(s, 0, sizeof(*s));
 	memcpy(s->color_palette, default_wt_status_colors,
@@ -129,7 +129,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = -1;
 	s->relative_paths = 1;
-	s->branch = resolve_refdup("HEAD", 0, sha1, NULL);
+	s->branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
-- 
2.11.0

