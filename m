Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC4720A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdJAWJF (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751926AbdJAWIv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 56DDC60D9E;
        Sun,  1 Oct 2017 22:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895730;
        bh=qHX5QGT/EEiOllE4M/1nvc6zj8o4DeEGdXa4NrcZWc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2k7Ne5Tw0RPD4GLrqS66JYmjWdWhIzoPghcENWt1GBj4mLXGt3yVnTTn8mmEjZ3q
         3Fu5mbgRDA0Vf+q9tYGLm0Ma9zIhjwDd1cE1PqbECORrsvdInP+KrKnggUbciqInvy
         LxMCgb/9h0/i1Kn3wB859MGLKfYhdPXVbq3spttFhDK7lTLyj0fIa9mzIZGiN3BZBX
         51VQkYbyn7QKF7Ee92XRNqEltijBikBa+L2cu2qtyzLrjhgVV1JW2wgugV1RuCn76b
         hQNFni9bDSLiFEiMszCLDYOhKxhVXgSFxvy3vsILQpashDRWQ6NFzwhpdwHKoYXr15
         O6/SdohOGeAjmNfLTmfTNWJ01cXc1rXKn7837tWNzpCy1YsDw8Z5Ew35z0m71BWlf7
         03Axs2K+NS7CStTLaHrBM0oIcKjSfiCsG7j3HMXiEUYBwd36PlTr2zy3RPq11b66C8
         p62kFNFlXOQylSTI1s7N6iS3w/0Evu0h+xr+t8EdCUHs43xPeFO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/24] Convert check_connected to use struct object_id
Date:   Sun,  1 Oct 2017 22:08:13 +0000
Message-Id: <20171001220831.214705-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert check_connected and the callbacks it takes to use struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/clone.c        |  4 ++--
 builtin/fetch.c        |  4 ++--
 builtin/receive-pack.c | 10 +++++-----
 connected.c            | 18 +++++++++---------
 connected.h            |  4 ++--
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 665a0e2673..5cd1b02d53 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -615,7 +615,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 	}
 }
 
-static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
+static int iterate_ref_map(void *cb_data, struct object_id *oid)
 {
 	struct ref **rm = cb_data;
 	struct ref *ref = *rm;
@@ -630,7 +630,7 @@ static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
 	if (!ref)
 		return -1;
 
-	hashcpy(sha1, ref->old_oid.hash);
+	oidcpy(oid, &ref->old_oid);
 	*rm = ref->next;
 	return 0;
 }
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 859be91d6c..e705237fa9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -727,7 +727,7 @@ static int update_local_ref(struct ref *ref,
 	}
 }
 
-static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
+static int iterate_ref_map(void *cb_data, struct object_id *oid)
 {
 	struct ref **rm = cb_data;
 	struct ref *ref = *rm;
@@ -737,7 +737,7 @@ static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
 	if (!ref)
 		return -1; /* end of the list */
 	*rm = ref->next;
-	hashcpy(sha1, ref->old_oid.hash);
+	oidcpy(oid, &ref->old_oid);
 	return 0;
 }
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 39defd4e3c..046b600b11 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -870,7 +870,7 @@ static void refuse_unconfigured_deny_delete_current(void)
 	rp_error("%s", _(refuse_unconfigured_deny_delete_current_msg));
 }
 
-static int command_singleton_iterator(void *cb_data, unsigned char sha1[20]);
+static int command_singleton_iterator(void *cb_data, struct object_id *oid);
 static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
 	static struct lock_file shallow_lock;
@@ -1270,7 +1270,7 @@ static void check_aliased_updates(struct command *commands)
 	string_list_clear(&ref_list, 0);
 }
 
-static int command_singleton_iterator(void *cb_data, unsigned char sha1[20])
+static int command_singleton_iterator(void *cb_data, struct object_id *oid)
 {
 	struct command **cmd_list = cb_data;
 	struct command *cmd = *cmd_list;
@@ -1278,7 +1278,7 @@ static int command_singleton_iterator(void *cb_data, unsigned char sha1[20])
 	if (!cmd || is_null_oid(&cmd->new_oid))
 		return -1; /* end of list */
 	*cmd_list = NULL; /* this returns only one */
-	hashcpy(sha1, cmd->new_oid.hash);
+	oidcpy(oid, &cmd->new_oid);
 	return 0;
 }
 
@@ -1309,7 +1309,7 @@ struct iterate_data {
 	struct shallow_info *si;
 };
 
-static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
+static int iterate_receive_command_list(void *cb_data, struct object_id *oid)
 {
 	struct iterate_data *data = cb_data;
 	struct command **cmd_list = &data->cmds;
@@ -1320,7 +1320,7 @@ static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
 			/* to be checked in update_shallow_ref() */
 			continue;
 		if (!is_null_oid(&cmd->new_oid) && !cmd->skip_update) {
-			hashcpy(sha1, cmd->new_oid.hash);
+			oidcpy(oid, &cmd->new_oid);
 			*cmd_list = cmd->next;
 			return 0;
 		}
diff --git a/connected.c b/connected.c
index f416b05051..4a47f33270 100644
--- a/connected.c
+++ b/connected.c
@@ -16,13 +16,13 @@
  *
  * Returns 0 if everything is connected, non-zero otherwise.
  */
-int check_connected(sha1_iterate_fn fn, void *cb_data,
+int check_connected(oid_iterate_fn fn, void *cb_data,
 		    struct check_connected_options *opt)
 {
 	struct child_process rev_list = CHILD_PROCESS_INIT;
 	struct check_connected_options defaults = CHECK_CONNECTED_INIT;
-	char commit[41];
-	unsigned char sha1[20];
+	char commit[GIT_MAX_HEXSZ + 1];
+	struct object_id oid;
 	int err = 0;
 	struct packed_git *new_pack = NULL;
 	struct transport *transport;
@@ -32,7 +32,7 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 		opt = &defaults;
 	transport = opt->transport;
 
-	if (fn(cb_data, sha1)) {
+	if (fn(cb_data, &oid)) {
 		if (opt->err_fd)
 			close(opt->err_fd);
 		return err;
@@ -77,7 +77,7 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	commit[40] = '\n';
+	commit[GIT_SHA1_HEXSZ] = '\n';
 	do {
 		/*
 		 * If index-pack already checked that:
@@ -87,17 +87,17 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 		 * are sure the ref is good and not sending it to
 		 * rev-list for verification.
 		 */
-		if (new_pack && find_pack_entry_one(sha1, new_pack))
+		if (new_pack && find_pack_entry_one(oid.hash, new_pack))
 			continue;
 
-		memcpy(commit, sha1_to_hex(sha1), 40);
-		if (write_in_full(rev_list.in, commit, 41) < 0) {
+		memcpy(commit, oid_to_hex(&oid), GIT_SHA1_HEXSZ);
+		if (write_in_full(rev_list.in, commit, GIT_SHA1_HEXSZ + 1) < 0) {
 			if (errno != EPIPE && errno != EINVAL)
 				error_errno(_("failed write to rev-list"));
 			err = -1;
 			break;
 		}
-	} while (!fn(cb_data, sha1));
+	} while (!fn(cb_data, &oid));
 
 	if (close(rev_list.in))
 		err = error_errno(_("failed to close rev-list's stdin"));
diff --git a/connected.h b/connected.h
index 4ca325f79d..a53f03a61a 100644
--- a/connected.h
+++ b/connected.h
@@ -8,7 +8,7 @@ struct transport;
  * When called after returning the name for the last object, return -1
  * to signal EOF, otherwise return 0.
  */
-typedef int (*sha1_iterate_fn)(void *, unsigned char [20]);
+typedef int (*oid_iterate_fn)(void *, struct object_id *oid);
 
 /*
  * Named-arguments struct for check_connected. All arguments are
@@ -51,7 +51,7 @@ struct check_connected_options {
  *
  * If "opt" is NULL, behaves as if CHECK_CONNECTED_INIT was passed.
  */
-int check_connected(sha1_iterate_fn fn, void *cb_data,
+int check_connected(oid_iterate_fn fn, void *cb_data,
 		    struct check_connected_options *opt);
 
 #endif /* CONNECTED_H */
-- 
2.14.2.822.g60be5d43e6

