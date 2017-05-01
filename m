Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3051FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999533AbdEACbV (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:21 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36054 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642368AbdEACah (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 37228280C4;
        Mon,  1 May 2017 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605808;
        bh=3SFryVeYXyciA7xjw8vT7s0DrzGYgkX/5tWcKZWCz8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDKi7wluhOvkHAbqmiSEvck6KNkb6sFsSa2QYYq1KF1H6s/oyQi+ljIgU+hmtI8cT
         aBE1u2JwY7mVJocWRLJ34DG5aWUqZtH3BE9bapMLBlJ6OBqE4pXMac5Vz3IjivByJB
         xqtISni1Kb9qK1+z+8e9Toq9CUiEBUdreAyiF9K1dJ22p9yIvpDW8ueLG4aFiVmmFr
         +mN6h7kpE5XWX0MLH6Oti3X3AgMjva3IrXQRATmY08hj/iwR5KccmkwkG74Jn2AdiL
         jfNxemSHvlKNipjYHnc2Dql8BuhlNF+kOSn9+zOwqYRW3wsXXlYYcZiiUqLFX+QiRZ
         r72005u4kIohZXccar24ZTyQrNuU6wQK5HErlKixaPcwwGkUE1R0DLVKz3mTjACdmJ
         edSB7Ir8y4/hHECit8oZk6o6l/fqzVe8qPWyP9r94VfG8RpOkqyEAHQ3QCUR8Z4mI1
         VNtHhV/7y5Tac4Lx0MZKdW69o8tABmclw0sxMsM8P+ti7DAZvQI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 22/53] sequencer: convert some functions to struct object_id
Date:   Mon,  1 May 2017 02:29:15 +0000
Message-Id: <20170501022946.258735-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
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
index d119baa51..1a4729d9d 100644
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
