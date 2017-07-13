Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23102027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbdGMXtp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:45 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59692 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752833AbdGMXtg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1C95A280B2;
        Thu, 13 Jul 2017 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989775;
        bh=c9bOrC3jiRDSWB4oSIcCzPNOIjHJqj6TiqeRVZKDM48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOiKbUULORVAoG9fBMxcrXTATtCAHGslhZo6Ll3jtgCAp2Fr/hyEBcriIZpmWZCVU
         Nik8AjWL+ZFyBg5UMeWNoQEJsavx35juWcTL4GdbsE2Twaw4cyO8iopilNJD7+ebfD
         xaweZ8yEJ4TMNkOE8NDSyZ06ZHKUY03ozEhAnpjhQAvbqqbzMj8OAM3L9LTpdARQs+
         1VUCl/lyR2VlQ5Klm51lEGm8EZaQxKcLLZryLDRLeNT/KbXNBUnDtqLf1FkJO/Boyd
         R/gtFNEI5F0SBxBzQlLINfyEC9Okmi1/f++QfyoBOT9/gdyd9PoVAfxi2VGtkmOqpF
         NBOw87klqpKLfl7cVgPQByoyTEoWfKXxdeVf295yIUB3FACoHZ1UQrqgcVk2GOD/Jf
         Zq5WlKWhlL8MsOvPcVPuPyu/QkuVVSWe9v55yUeon7V2sGsBfUPJFCDcwlC8/LK0wq
         O/IdEDDddkH94G9Y+RN/5Tfx0Om8o5z/bBSONo01LPvi9WXu0nd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 05/13] sequencer: convert to struct object_id
Date:   Thu, 13 Jul 2017 23:49:22 +0000
Message-Id: <20170713234930.949612-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining instances of unsigned char * to struct object_id.
This removes several calls to get_sha1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3010faf863..16d48a4fb3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -691,7 +691,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 static int is_original_commit_empty(struct commit *commit)
 {
-	const unsigned char *ptree_sha1;
+	const struct object_id *ptree_oid;
 
 	if (parse_commit(commit))
 		return error(_("could not parse commit %s\n"),
@@ -701,12 +701,12 @@ static int is_original_commit_empty(struct commit *commit)
 		if (parse_commit(parent))
 			return error(_("could not parse parent commit %s\n"),
 				oid_to_hex(&parent->object.oid));
-		ptree_sha1 = parent->tree->object.oid.hash;
+		ptree_oid = &parent->tree->object.oid;
 	} else {
-		ptree_sha1 = EMPTY_TREE_SHA1_BIN; /* commit is root */
+		ptree_oid = &empty_tree_oid; /* commit is root */
 	}
 
-	return !hashcmp(ptree_sha1, commit->tree->object.oid.hash);
+	return !oidcmp(ptree_oid, &commit->tree->object.oid);
 }
 
 /*
@@ -896,18 +896,18 @@ static int update_squash_messages(enum todo_command command,
 
 static void flush_rewritten_pending(void) {
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char newsha1[20];
+	struct object_id newoid;
 	FILE *out;
 
-	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), 82) > 0 &&
-	    !get_sha1("HEAD", newsha1) &&
+	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), (GIT_MAX_HEXSZ + 1) * 2) > 0 &&
+	    !get_oid("HEAD", &newoid) &&
 	    (out = fopen_or_warn(rebase_path_rewritten_list(), "a"))) {
 		char *bol = buf.buf, *eol;
 
 		while (*bol) {
 			eol = strchrnul(bol, '\n');
 			fprintf(out, "%.*s %s\n", (int)(eol - bol),
-					bol, sha1_to_hex(newsha1));
+					bol, oid_to_hex(&newoid));
 			if (!*eol)
 				break;
 			bol = eol + 1;
@@ -1594,36 +1594,37 @@ static int rollback_is_safe(void)
 	return !oidcmp(&actual_head, &expected_head);
 }
 
-static int reset_for_rollback(const unsigned char *sha1)
+static int reset_for_rollback(const struct object_id *oid)
 {
 	const char *argv[4];	/* reset --merge <arg> + NULL */
 
 	argv[0] = "reset";
 	argv[1] = "--merge";
-	argv[2] = sha1_to_hex(sha1);
+	argv[2] = oid_to_hex(oid);
 	argv[3] = NULL;
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
 static int rollback_single_pick(void)
 {
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 
 	if (!file_exists(git_path_cherry_pick_head()) &&
 	    !file_exists(git_path_revert_head()))
 		return error(_("no cherry-pick or revert in progress"));
-	if (read_ref_full("HEAD", 0, head_sha1, NULL))
+	if (read_ref_full("HEAD", 0, head_oid.hash, NULL))
 		return error(_("cannot resolve HEAD"));
-	if (is_null_sha1(head_sha1))
+	if (is_null_oid(&head_oid))
 		return error(_("cannot abort from a branch yet to be born"));
-	return reset_for_rollback(head_sha1);
+	return reset_for_rollback(&head_oid);
 }
 
 int sequencer_rollback(struct replay_opts *opts)
 {
 	FILE *f;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct strbuf buf = STRBUF_INIT;
+	const char *p;
 
 	f = fopen(git_path_head_file(), "r");
 	if (!f && errno == ENOENT) {
@@ -1643,12 +1644,12 @@ int sequencer_rollback(struct replay_opts *opts)
 		goto fail;
 	}
 	fclose(f);
-	if (get_sha1_hex(buf.buf, sha1) || buf.buf[40] != '\0') {
+	if (parse_oid_hex(buf.buf, &oid, &p) || *p != '\0') {
 		error(_("stored pre-cherry-pick HEAD file '%s' is corrupt"),
 			git_path_head_file());
 		goto fail;
 	}
-	if (is_null_sha1(sha1)) {
+	if (is_null_oid(&oid)) {
 		error(_("cannot abort from a branch yet to be born"));
 		goto fail;
 	}
@@ -1658,7 +1659,7 @@ int sequencer_rollback(struct replay_opts *opts)
 		warning(_("You seem to have moved HEAD. "
 			  "Not rewinding, check your HEAD!"));
 	} else
-	if (reset_for_rollback(sha1))
+	if (reset_for_rollback(&oid))
 		goto fail;
 	strbuf_release(&buf);
 	return sequencer_remove_state(opts);
@@ -1788,13 +1789,13 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 
 static int intend_to_amend(void)
 {
-	unsigned char head[20];
+	struct object_id head;
 	char *p;
 
-	if (get_sha1("HEAD", head))
+	if (get_oid("HEAD", &head))
 		return error(_("cannot read HEAD"));
 
-	p = sha1_to_hex(head);
+	p = oid_to_hex(&head);
 	return write_message(p, strlen(p), rebase_path_amend(), 1);
 }
 
@@ -2079,10 +2080,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
 				starts_with(head_ref.buf, "refs/")) {
 			const char *msg;
-			unsigned char head[20], orig[20];
+			struct object_id head, orig;
 			int res;
 
-			if (get_sha1("HEAD", head)) {
+			if (get_oid("HEAD", &head)) {
 				res = error(_("cannot read HEAD"));
 cleanup_head_ref:
 				strbuf_release(&head_ref);
@@ -2090,7 +2091,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				return res;
 			}
 			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
-					get_sha1_hex(buf.buf, orig)) {
+					get_oid_hex(buf.buf, &orig)) {
 				res = error(_("could not read orig-head"));
 				goto cleanup_head_ref;
 			}
@@ -2101,7 +2102,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			}
 			msg = reflog_message(opts, "finish", "%s onto %s",
 				head_ref.buf, buf.buf);
-			if (update_ref(msg, head_ref.buf, head, orig,
+			if (update_ref(msg, head_ref.buf, head.hash, orig.hash,
 					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
@@ -2205,16 +2206,16 @@ static int commit_staged_changes(struct replay_opts *opts)
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
-		unsigned char head[20], to_amend[20];
+		struct object_id head, to_amend;
 
-		if (get_sha1("HEAD", head))
+		if (get_oid("HEAD", &head))
 			return error(_("cannot amend non-existing commit"));
 		if (!read_oneliner(&rev, rebase_path_amend(), 0))
 			return error(_("invalid file: '%s'"), rebase_path_amend());
-		if (get_sha1_hex(rev.buf, to_amend))
+		if (get_oid_hex(rev.buf, &to_amend))
 			return error(_("invalid contents: '%s'"),
 				rebase_path_amend());
-		if (hashcmp(head, to_amend))
+		if (oidcmp(&head, &to_amend))
 			return error(_("\nYou have uncommitted changes in your "
 				       "working tree. Please, commit them\n"
 				       "first and then run 'git rebase "
