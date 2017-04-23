Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA648207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046189AbdDWVga (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:30 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37320 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046084AbdDWVfk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6DCA6280C3;
        Sun, 23 Apr 2017 21:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983334;
        bh=05NWRd0cNzhwXiD+K09elenFCqQ6Vr4Rw4dmGv62WmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=myxiDPoLtRTUuJCktlU5aFncxV+rAp/Vbopujuobbbe6eXixpo1NCrWZKaHpllsUh
         3Kh6iqpShmWwQJSfzvK4bgjZ47lr6xQnjQMQECITZAloKzXI35T3FzdXpabpXQVPQX
         C7EfCvAG20hrAOjxAR6qh8PYz3mq4MRMypD69CuHi0QT8juTyIw/3U1kF8zVkJO94F
         ZY6KQGNnE+yMhDbT4/mTkzz7ZKNX111PlcGJcFTFQ/h4PBJ9okWMO6bN5FAmj5bvYk
         tuMsaSCSdaUxLZHWh+T9i1+plkJAqvZr1OSbI2ND84aXe1WdxZyNfdiyLJAiW6DS2I
         ZJ9DKSkg9RL22Rch9yUIoiCoQtpWgirfgq4w4CoqDyr0U7a5ChJS4B8euDshPmJ7bp
         cWHkVy+6pJpf+vPI2MUyjU6zeua3wYvBiYx450/7hJhYYzwqwoZvf9Gvtn+agT1HnG
         18o8JUtWE1ZEhCHe2KbXLEjkIoAmfYUQqng5g3DTvVzyrb38JhP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/53] sequencer: convert some functions to struct object_id
Date:   Sun, 23 Apr 2017 21:34:22 +0000
Message-Id: <20170423213453.253425-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert update_squash_messages and is_index_unchanged to struct
object_id.  These are callers of lookup_commit and
lookup_commit_reference, which we want to convert.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e13a25b91..0562d7b9a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -482,13 +482,13 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 static int is_index_unchanged(void)
 {
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	struct commit *head_commit;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		return error(_("could not resolve HEAD commit\n"));
 
-	head_commit = lookup_commit(head_sha1);
+	head_commit = lookup_commit(head_oid.hash);
 
 	/*
 	 * If head_commit is NULL, check_commit, called from
@@ -835,13 +835,13 @@ static int update_squash_messages(enum todo_command command,
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 	} else {
-		unsigned char head[20];
+		struct object_id head;
 		struct commit *head_commit;
 		const char *head_message, *body;
 
-		if (get_sha1("HEAD", head))
+		if (get_oid("HEAD", &head))
 			return error(_("need a HEAD to fixup"));
-		if (!(head_commit = lookup_commit_reference(head)))
+		if (!(head_commit = lookup_commit_reference(head.hash)))
 			return error(_("could not read HEAD"));
 		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
