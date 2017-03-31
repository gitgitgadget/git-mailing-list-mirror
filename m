Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B14A20966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935134AbdCaBk5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:57 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59216 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934934AbdCaBkJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:09 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 22497280B3;
        Fri, 31 Mar 2017 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924408;
        bh=+8zITxruKFGO+47MhCmdMVj3imDFugfKprFOpY8wiUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpTlg3XDSDN16KQ+yqgByUPuztl2w8xNgyCgzQqIBBaWf41+6m012v+dPKyxCF62H
         ZZNgENbaWIjY9Pa6jzzMCGVBzF1eo0Myq16SrSOe7iRTn++3EBFQ/sFIgCMkJ+g+zT
         wZ1fpP9OCyOPC8En7ylcU9uU5iSCsf07MrGjLBPwmHvptOwmg8k1+UyRbJlSZ7O8eq
         NYHZtS+9zB2WLiZATVP6IWRVmlWLzmH+AfDnX0pvyPF1YRtF9ynj0yZ9mNnGbM61GP
         P+gKQuERjU7SrJiC4CUAS1xG0oZA4pY0x+qwIi4rxqqy2B9e/a9OmKdAuX8uOjLuQS
         8ymi4WFELRDXsyr6CQ4SiAeCpADzusQTcw+VWaQ0Ife1MLYszbnwGhz7qCnfkx0n32
         na8hmvZdP5qxcKGMJL2YRKFhAXa4jIkywpHtyiTGDw9u8qWjXytG6Hi5KQqPP1VIlu
         gjIMsLuLr/DMjSxAQ8uRsKgLnef5SEKSRVaSpJRcIWXjJq04f8Z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/20] builtin/receive-pack: convert portions to struct object_id
Date:   Fri, 31 Mar 2017 01:39:47 +0000
Message-Id: <20170331014001.953484-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert some hardcoded constants into uses of parse_oid_hex.
Additionally, convert all uses of struct command, and miscellaneous
other functions necessary for that.  This work is necessary to be able
to convert sha1_array_append later on.

To avoid needing to specify a constant, reject shallow lines with the
wrong length instead of simply ignoring them.

Note that in queue_command we are guaranteed to have a NUL-terminated
buffer or at least one byte of overflow that we can safely read, so the
linelen check can be elided.  We would die in such a case, but not read
invalid memory.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 98 +++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index feafb076a4..62b7c5e25c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -309,8 +309,8 @@ struct command {
 	unsigned int skip_update:1,
 		     did_not_exist:1;
 	int index;
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
+	struct object_id old_oid;
+	struct object_id new_oid;
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
@@ -723,7 +723,7 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 		return -1; /* EOF */
 	strbuf_reset(&state->buf);
 	strbuf_addf(&state->buf, "%s %s %s\n",
-		    sha1_to_hex(cmd->old_sha1), sha1_to_hex(cmd->new_sha1),
+		    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
 		    cmd->ref_name);
 	state->cmd = cmd->next;
 	if (bufp) {
@@ -764,8 +764,8 @@ static int run_update_hook(struct command *cmd)
 		return 0;
 
 	argv[1] = cmd->ref_name;
-	argv[2] = sha1_to_hex(cmd->old_sha1);
-	argv[3] = sha1_to_hex(cmd->new_sha1);
+	argv[2] = oid_to_hex(&cmd->old_oid);
+	argv[3] = oid_to_hex(&cmd->new_oid);
 	argv[4] = NULL;
 
 	proc.no_stdin = 1;
@@ -988,8 +988,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
 	const char *namespaced_name, *ret;
-	unsigned char *old_sha1 = cmd->old_sha1;
-	unsigned char *new_sha1 = cmd->new_sha1;
+	struct object_id *old_oid = &cmd->old_oid;
+	struct object_id *new_oid = &cmd->new_oid;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -1014,20 +1014,20 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				refuse_unconfigured_deny();
 			return "branch is currently checked out";
 		case DENY_UPDATE_INSTEAD:
-			ret = update_worktree(new_sha1);
+			ret = update_worktree(new_oid->hash);
 			if (ret)
 				return ret;
 			break;
 		}
 	}
 
-	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
+	if (!is_null_oid(new_oid) && !has_object_file(new_oid)) {
 		error("unpack should have generated %s, "
-		      "but I can't find it!", sha1_to_hex(new_sha1));
+		      "but I can't find it!", oid_to_hex(new_oid));
 		return "bad pack";
 	}
 
-	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
+	if (!is_null_oid(old_oid) && is_null_oid(new_oid)) {
 		if (deny_deletes && starts_with(name, "refs/heads/")) {
 			rp_error("denying ref deletion for %s", name);
 			return "deletion prohibited";
@@ -1053,14 +1053,14 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 	}
 
-	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
-	    !is_null_sha1(old_sha1) &&
+	if (deny_non_fast_forwards && !is_null_oid(new_oid) &&
+	    !is_null_oid(old_oid) &&
 	    starts_with(name, "refs/heads/")) {
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
 
-		old_object = parse_object(old_sha1);
-		new_object = parse_object(new_sha1);
+		old_object = parse_object(old_oid->hash);
+		new_object = parse_object(new_oid->hash);
 
 		if (!old_object || !new_object ||
 		    old_object->type != OBJ_COMMIT ||
@@ -1081,10 +1081,10 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return "hook declined";
 	}
 
-	if (is_null_sha1(new_sha1)) {
+	if (is_null_oid(new_oid)) {
 		struct strbuf err = STRBUF_INIT;
-		if (!parse_object(old_sha1)) {
-			old_sha1 = NULL;
+		if (!parse_object(old_oid->hash)) {
+			old_oid = NULL;
 			if (ref_exists(name)) {
 				rp_warning("Allowing deletion of corrupt ref.");
 			} else {
@@ -1094,7 +1094,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
-					   old_sha1,
+					   old_oid->hash,
 					   0, "push", &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
@@ -1111,7 +1111,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 		if (ref_transaction_update(transaction,
 					   namespaced_name,
-					   new_sha1, old_sha1,
+					   new_oid->hash, old_oid->hash,
 					   0, "push",
 					   &err)) {
 			rp_error("%s", err.buf);
@@ -1187,8 +1187,8 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 
 	dst_cmd = (struct command *) item->util;
 
-	if (!hashcmp(cmd->old_sha1, dst_cmd->old_sha1) &&
-	    !hashcmp(cmd->new_sha1, dst_cmd->new_sha1))
+	if (!oidcmp(&cmd->old_oid, &dst_cmd->old_oid) &&
+	    !oidcmp(&cmd->new_oid, &dst_cmd->new_oid))
 		return;
 
 	dst_cmd->skip_update = 1;
@@ -1196,11 +1196,11 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
 		 " its target '%s' (%s..%s)",
 		 cmd->ref_name,
-		 find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV),
-		 find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV),
+		 find_unique_abbrev(cmd->old_oid.hash, DEFAULT_ABBREV),
+		 find_unique_abbrev(cmd->new_oid.hash, DEFAULT_ABBREV),
 		 dst_cmd->ref_name,
-		 find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV),
-		 find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV));
+		 find_unique_abbrev(dst_cmd->old_oid.hash, DEFAULT_ABBREV),
+		 find_unique_abbrev(dst_cmd->new_oid.hash, DEFAULT_ABBREV));
 
 	cmd->error_string = dst_cmd->error_string =
 		"inconsistent aliased update";
@@ -1231,10 +1231,10 @@ static int command_singleton_iterator(void *cb_data, unsigned char sha1[20])
 	struct command **cmd_list = cb_data;
 	struct command *cmd = *cmd_list;
 
-	if (!cmd || is_null_sha1(cmd->new_sha1))
+	if (!cmd || is_null_oid(&cmd->new_oid))
 		return -1; /* end of list */
 	*cmd_list = NULL; /* this returns only one */
-	hashcpy(sha1, cmd->new_sha1);
+	hashcpy(sha1, cmd->new_oid.hash);
 	return 0;
 }
 
@@ -1275,8 +1275,8 @@ static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
 		if (shallow_update && data->si->shallow_ref[cmd->index])
 			/* to be checked in update_shallow_ref() */
 			continue;
-		if (!is_null_sha1(cmd->new_sha1) && !cmd->skip_update) {
-			hashcpy(sha1, cmd->new_sha1);
+		if (!is_null_oid(&cmd->new_oid) && !cmd->skip_update) {
+			hashcpy(sha1, cmd->new_oid.hash);
 			*cmd_list = cmd->next;
 			return 0;
 		}
@@ -1303,7 +1303,7 @@ static void reject_updates_to_hidden(struct command *commands)
 
 		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
 			continue;
-		if (is_null_sha1(cmd->new_sha1))
+		if (is_null_oid(&cmd->new_oid))
 			cmd->error_string = "deny deleting a hidden ref";
 		else
 			cmd->error_string = "deny updating a hidden ref";
@@ -1486,23 +1486,23 @@ static struct command **queue_command(struct command **tail,
 				      const char *line,
 				      int linelen)
 {
-	unsigned char old_sha1[20], new_sha1[20];
+	struct object_id old_oid, new_oid;
 	struct command *cmd;
 	const char *refname;
 	int reflen;
+	const char *p;
 
-	if (linelen < 83 ||
-	    line[40] != ' ' ||
-	    line[81] != ' ' ||
-	    get_sha1_hex(line, old_sha1) ||
-	    get_sha1_hex(line + 41, new_sha1))
+	if (parse_oid_hex(line, &old_oid, &p) ||
+	    *p++ != ' ' ||
+	    parse_oid_hex(p, &new_oid, &p) ||
+	    *p++ != ' ')
 		die("protocol error: expected old/new/ref, got '%s'", line);
 
-	refname = line + 82;
-	reflen = linelen - 82;
+	refname = p;
+	reflen = linelen - (p - line);
 	FLEX_ALLOC_MEM(cmd, ref_name, refname, reflen);
-	hashcpy(cmd->old_sha1, old_sha1);
-	hashcpy(cmd->new_sha1, new_sha1);
+	oidcpy(&cmd->old_oid, &old_oid);
+	oidcpy(&cmd->new_oid, &new_oid);
 	*tail = cmd;
 	return &cmd->next;
 }
@@ -1541,12 +1541,12 @@ static struct command *read_head_info(struct sha1_array *shallow)
 		if (!line)
 			break;
 
-		if (len == 48 && starts_with(line, "shallow ")) {
-			unsigned char sha1[20];
-			if (get_sha1_hex(line + 8, sha1))
+		if (len > 8 && starts_with(line, "shallow ")) {
+			struct object_id oid;
+			if (get_oid_hex(line + 8, &oid))
 				die("protocol error: expected shallow sha, got '%s'",
 				    line + 8);
-			sha1_array_append(shallow, sha1);
+			sha1_array_append(shallow, oid.hash);
 			continue;
 		}
 
@@ -1815,9 +1815,9 @@ static void update_shallow_info(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (is_null_sha1(cmd->new_sha1))
+		if (is_null_oid(&cmd->new_oid))
 			continue;
-		sha1_array_append(ref, cmd->new_sha1);
+		sha1_array_append(ref, cmd->new_oid.hash);
 		cmd->index = ref->nr - 1;
 	}
 	si->ref = ref;
@@ -1830,7 +1830,7 @@ static void update_shallow_info(struct command *commands,
 	ALLOC_ARRAY(ref_status, ref->nr);
 	assign_shallow_commits_to_refs(si, NULL, ref_status);
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (is_null_sha1(cmd->new_sha1))
+		if (is_null_oid(&cmd->new_oid))
 			continue;
 		if (ref_status[cmd->index]) {
 			cmd->error_string = "shallow update not allowed";
@@ -1868,7 +1868,7 @@ static int delete_only(struct command *commands)
 {
 	struct command *cmd;
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!is_null_sha1(cmd->new_sha1))
+		if (!is_null_oid(&cmd->new_oid))
 			return 0;
 	}
 	return 1;
