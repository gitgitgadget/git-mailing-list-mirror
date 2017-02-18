Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DCD201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbdBRAHp (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:07:45 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59996 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750824AbdBRAHA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 19:07:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 73773280AE;
        Sat, 18 Feb 2017 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487376418;
        bh=eQ/tajx1wJdp6ksBcl2O/A7+lCJtUXqjKQV+4Q7cA9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCuS3X7kfc2rhsBbKk9U54SqAe6xtcIxUSEu/Z/ERaeySzW5Sw8n/5ZmYB4u6uMrN
         w9FjcgwAMC/OK3BvB0NaRAvkTlemEFZ+VgVf2SQGoMPDFdnFNmL0wqYJncy3fXP9uV
         tM3QIiYTpoeMgZ+OAss/4N7rPql712v7g+EbUsneP4CFek5XlTZbV07boUIF7sGkcv
         ZSdyw86Kd8pTkJtFGlNCwOwLleUZVNYCyq777qSi/2MLOZxLBZqWLBsOmtmATlKyYO
         D2XMIWieWVUT6Azo+YoK8YcSwvr3/pNoJk2B1ByFjtJwZNlkeNSZgQ79M0Yfz4T7EZ
         n8bbL4Yf75gJLThJDj4IDSkzE/FtDeWnVWh/ZvGNxpFrn6PlrunsYCXqmiwectHV9J
         2Sqt8GHFfxxx0IAuChufdprM0rR26A5aTICAB95TJmrbD5QLxqbX9RkXsLf75cvwxl
         GIJaN9rrLcGAYuijD2OmvuDTYerW1QCW0tEi+PB6JZz8iFG1jVi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/19] builtin/commit: convert to struct object_id
Date:   Sat, 18 Feb 2017 00:06:34 +0000
Message-Id: <20170218000652.375129-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170218000652.375129-1-sandals@crustytoothpaste.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert most leaf functions to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2de5f6cc64..4e288bc513 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -496,7 +496,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
 		      struct wt_status *s)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (s->relative_paths)
 		s->prefix = prefix;
@@ -509,9 +509,9 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->index_file = index_file;
 	s->fp = fp;
 	s->nowarn = nowarn;
-	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	s->is_initial = get_sha1(s->reference, oid.hash) ? 1 : 0;
 	if (!s->is_initial)
-		hashcpy(s->sha1_commit, sha1);
+		hashcpy(s->sha1_commit, oid.hash);
 	s->status_format = status_format;
 	s->ignore_submodule_arg = ignore_submodule_arg;
 
@@ -885,7 +885,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		commitable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 	} else {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *parent = "HEAD";
 
 		if (!active_nr && read_cache() < 0)
@@ -894,7 +894,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (amend)
 			parent = "HEAD^1";
 
-		if (get_sha1(parent, sha1)) {
+		if (get_sha1(parent, oid.hash)) {
 			int i, ita_nr = 0;
 
 			for (i = 0; i < active_nr; i++)
@@ -1332,7 +1332,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
 	int fd;
-	unsigned char sha1[20];
+	struct object_id oid;
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_SET_INT('s', "short", &status_format,
@@ -1382,9 +1382,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	fd = hold_locked_index(&index_lock, 0);
 
-	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
+	s.is_initial = get_sha1(s.reference, oid.hash) ? 1 : 0;
 	if (!s.is_initial)
-		hashcpy(s.sha1_commit, sha1);
+		hashcpy(s.sha1_commit, oid.hash);
 
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
@@ -1418,19 +1418,19 @@ static const char *implicit_ident_advice(void)
 
 }
 
-static void print_summary(const char *prefix, const unsigned char *sha1,
+static void print_summary(const char *prefix, const struct object_id *oid,
 			  int initial_commit)
 {
 	struct rev_info rev;
 	struct commit *commit;
 	struct strbuf format = STRBUF_INIT;
-	unsigned char junk_sha1[20];
+	struct object_id junk_oid;
 	const char *head;
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 
-	commit = lookup_commit(sha1);
+	commit = lookup_commit(oid->hash);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
 	if (parse_commit(commit))
@@ -1477,7 +1477,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	head = resolve_ref_unsafe("HEAD", 0, junk_sha1, NULL);
+	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
@@ -1522,8 +1522,8 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
-static int run_rewrite_hook(const unsigned char *oldsha1,
-			    const unsigned char *newsha1)
+static int run_rewrite_hook(const struct object_id *oldoid,
+			    const struct object_id *newoid)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *argv[3];
@@ -1544,7 +1544,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	code = start_command(&proc);
 	if (code)
 		return code;
-	strbuf_addf(&sb, "%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
 	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(proc.in, sb.buf, sb.len);
 	close(proc.in);
@@ -1636,7 +1636,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit_list *parents = NULL;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
@@ -1651,10 +1651,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
-	if (get_sha1("HEAD", sha1))
+	if (get_sha1("HEAD", oid.hash))
 		current_head = NULL;
 	else {
-		current_head = lookup_commit_or_die(sha1, "HEAD");
+		current_head = lookup_commit_or_die(oid.hash, "HEAD");
 		if (parse_commit(current_head))
 			die(_("could not parse HEAD commit"));
 	}
@@ -1759,7 +1759,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
-			 parents, sha1, author_ident.buf, sign_commit, extra)) {
+			 parents, oid.hash, author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
@@ -1776,7 +1776,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", sha1,
+	    ref_transaction_update(transaction, "HEAD", oid.hash,
 				   current_head
 				   ? current_head->object.oid.hash : null_sha1,
 				   0, sb.buf, &err) ||
@@ -1805,13 +1805,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		cfg = init_copy_notes_for_rewrite("amend");
 		if (cfg) {
 			/* we are amending, so current_head is not NULL */
-			copy_note_for_rewrite(cfg, current_head->object.oid.hash, sha1);
+			copy_note_for_rewrite(cfg, current_head->object.oid.hash, oid.hash);
 			finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
 		}
-		run_rewrite_hook(current_head->object.oid.hash, sha1);
+		run_rewrite_hook(&current_head->object.oid, &oid);
 	}
 	if (!quiet)
-		print_summary(prefix, sha1, !current_head);
+		print_summary(prefix, &oid, !current_head);
 
 	strbuf_release(&err);
 	return 0;
-- 
2.11.0

