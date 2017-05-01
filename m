Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84EB1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642323AbdEACaL (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:11 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35602 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642311AbdEACaE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 92AD3280AF;
        Mon,  1 May 2017 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605802;
        bh=h9W3L+QwvS0DDr/kNKuG+G3DeBZCstp/h+WQHhiJ/dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shQUo8e5mT2r7XCswTp9nlasyrQ5KyBogwMoSTvv6JpyuR4YWVwu4oQJ6LG9DazD7
         be3s+raSsswYiNlx3/ONkVImXG9ElmarnU5R8zg+gvJLdy1TuaBxz/dLo6I2x376ii
         FJsdc2Mk4aVU4KcYOMxkE1hMaKn+kLhkh4mdyjJs0daal9TRIevhpFPivp06N+jp8v
         96iPrsbXk56PSbHdro78OTJAiPCZ5F6SoTdWC0q0BQZ9RCiiGPH0NCuZwLv3mfel14
         Nidv/FuJVmMgH93LP4CPRJhM6AU5XuhnfJrIeSLYGQ9z1nDXTR38nBoopzkGOT+TOd
         oN9Bn0tcGYp7aD34f+EhCyp4scHjFYqAwxjYWEoj54/Qib14btMaDqz9aD2cLhicoy
         +cfenuyUwbvvMIRNF+HIjK4jb7smHlQ4ueMqNmxsJbxLQG8gnRo+sKmIBFfWx+dK8X
         4SQ3tLlf03QjejuvdQUcN41bPVzZLDnqXrO2pxTMFsJJs7WAwAu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/53] Clean up outstanding object_id transforms.
Date:   Mon,  1 May 2017 02:28:55 +0000
Message-Id: <20170501022946.258735-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The semantic patch for standard object_id transforms found two
outstanding places where we could make a transformation automatically.
Apply these changes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/diff.c | 2 +-
 reflog-walk.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index d184aafab..a25b4e4ae 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -408,7 +408,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		} else if (obj->type == OBJ_BLOB) {
 			if (2 <= blobs)
 				die(_("more than two blobs given: '%s'"), name);
-			hashcpy(blob[blobs].oid.hash, obj->oid.hash);
+			oidcpy(&blob[blobs].oid, &obj->oid);
 			blob[blobs].name = name;
 			blob[blobs].mode = entry->mode;
 			blobs++;
diff --git a/reflog-walk.c b/reflog-walk.c
index 99679f582..c8fdf051d 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -241,7 +241,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 		logobj = parse_object(reflog->ooid.hash);
 	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));
 
-	if (!logobj && commit_reflog->recno >= 0 && is_null_sha1(reflog->ooid.hash)) {
+	if (!logobj && commit_reflog->recno >= 0 && is_null_oid(&reflog->ooid)) {
 		/* a root commit, but there are still more entries to show */
 		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 		logobj = parse_object(reflog->noid.hash);
