Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A935F21847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeEBA1E (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753477AbeEBA0u (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE30860B4E;
        Wed,  2 May 2018 00:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220809;
        bh=x51PJMsrCH5heIzxhVXS+KU8rIN0bdw+Iobv6FGrHDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qXTyZFJmNy0huA86wxgW8L0zP4XAWbtlek9pns7fF8MS1TCiVpjuOtmakzIA/B8uw
         NOLfcJUJKqkWmTcYNcj0MnrL4InpR4O4kZekcWpw6sR6yfZwOhjCuXFJ0+MCe1ydyZ
         grNo95HjCGKOz7dHWNeZOfE8MmaXCgfagERaoX1MMnhc0PZPIzzKJDi5mT0aG8MgG/
         K0dDQ9UOr16f9ORJunHeh9ki/GD4whiORYtkpUjZJ7dPRRVJgsyPFooAc1XOZ/QhLy
         +bZ76uXnIWxA3GHPAc3sMIOype8NSymRh6+l+IF2rolJQnN+GS2Mr6kLwG9Oi2h+Lv
         1l3mVfzztLPlnzVJ2m1nxLLp57exI876Xhglov4d6GGStSmnbpewcnzqRpMXLN7KTQ
         MSSiYO9Jd6HigYcozaNuDUzR12wN14Py6Sw9ayZAn2xQI200/1J/CmK3hTk/cPQlHd
         uo6o/XyGGsR5j30S9bBH1Xq7lhHK1G8HR5RwFNtGn8pdHmvRC2C
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 28/42] builtin/merge: switch tree functions to use object_id
Date:   Wed,  2 May 2018 00:25:56 +0000
Message-Id: <20180502002610.915892-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read_empty and reset_hard functions are static and their callers
have already changed to use struct object_id, so convert them as well.
To avoid dependency on the hash algorithm in use, switch from using
EMPTY_TREE_SHA1_HEX to using empty_tree_oid_hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..7084bcfdea 100644
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
+	args[i++] = empty_tree_oid_hex();
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
