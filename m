Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC241F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932811AbeDWXlg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60662 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932750AbeDWXkf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8CC7460B3D;
        Mon, 23 Apr 2018 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526833;
        bh=vfIbqQd9Mb3VyYJgh0GHOuD3G/weAGKhkOE1ACnXp8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qFYF2rwQKLsJ4mKI/U39Xkme9yKqrzzk2iDKcmbVQPAj7OD6PaBKtEEZAJ/B3dWhu
         E1g/BgrRBNtc1wVBzVszsynia1wRd4Rqif9Uy5voXl64+4fJm1ZAGS9fPhpIfVWUr8
         94u+72tGDuivxUzKhUiCCIHHoKReZwH+skdVcHhxBhx65kQWEYq4rbcHLkRfd9n6jI
         ox3I1ayKmYSjkqVubphb99vrkFBlIYQMUAD5x/+JCr/6079kk88sWQl9+RoATsZ3AM
         yI4TYl+XtUXy1BQmK5RoFiboK5XxGbK22Wo96O3yMNKOQU/mdwiuuGbxB7maKZDSZr
         gLLRf1tv3MbJo9yd+5r2W14G+viBfx5qUUs5x+gAqS1+jUPYDXhAbet2c7cuDOL9wi
         5axxgDLuHM2WdxDQlevYn/nfpZW12xGXuj/TAnVHyHb/TO+iN+FhgZ0ucFp0lvDY4H
         y2FLCFNC6AWMa96bazn7y91klvnTrKpJeuDi+guKpjRWgLIWn9g
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 27/41] builtin/merge: switch tree functions to use object_id
Date:   Mon, 23 Apr 2018 23:39:37 +0000
Message-Id: <20180423233951.276447-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read_empty and reset_hard functions are static and their callers
have already changed to use struct object_id, so convert them as well.
To avoid dependency on the hash algorithm in use, switch from using
EMPTY_TREE_SHA1_HEX to using oid_to_hex with the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..8d75ebe64b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -280,7 +280,7 @@ static int save_state(struct object_id *stash)
 	return rc;
 }
 
-static void read_empty(unsigned const char *sha1, int verbose)
+static void read_empty(const struct object_id *oid, int verbose)
 {
 	int i = 0;
 	const char *args[7];
@@ -290,15 +290,15 @@ static void read_empty(unsigned const char *sha1, int verbose)
 		args[i++] = "-v";
 	args[i++] = "-m";
 	args[i++] = "-u";
-	args[i++] = EMPTY_TREE_SHA1_HEX;
-	args[i++] = sha1_to_hex(sha1);
+	args[i++] = oid_to_hex(the_hash_algo->empty_tree);
+	args[i++] = oid_to_hex(oid);
 	args[i] = NULL;
 
 	if (run_command_v_opt(args, RUN_GIT_CMD))
 		die(_("read-tree failed"));
 }
 
-static void reset_hard(unsigned const char *sha1, int verbose)
+static void reset_hard(const struct object_id *oid, int verbose)
 {
 	int i = 0;
 	const char *args[6];
@@ -308,7 +308,7 @@ static void reset_hard(unsigned const char *sha1, int verbose)
 		args[i++] = "-v";
 	args[i++] = "--reset";
 	args[i++] = "-u";
-	args[i++] = sha1_to_hex(sha1);
+	args[i++] = oid_to_hex(oid);
 	args[i] = NULL;
 
 	if (run_command_v_opt(args, RUN_GIT_CMD))
@@ -324,7 +324,7 @@ static void restore_state(const struct object_id *head,
 	if (is_null_oid(stash))
 		return;
 
-	reset_hard(head->hash, 1);
+	reset_hard(head, 1);
 
 	args[2] = oid_to_hex(stash);
 
@@ -1297,7 +1297,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
 		remote_head_oid = &remoteheads->item->object.oid;
-		read_empty(remote_head_oid->hash, 0);
+		read_empty(remote_head_oid, 0);
 		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 		goto done;
