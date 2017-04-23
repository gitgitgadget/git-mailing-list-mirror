Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B0F207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046090AbdDWVfa (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:35:30 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37278 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933022AbdDWVf3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E242A280AF;
        Sun, 23 Apr 2017 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983327;
        bh=h9W3L+QwvS0DDr/kNKuG+G3DeBZCstp/h+WQHhiJ/dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qm1d1mTdODvP8jlbtrRa+Gsrv61M7Jtt3/+NPe6WEEGM2Lhwrd+a8MwDvfD3f/EK6
         GhEAwJ8QYCJnkFUbgrL9yYMY/FA9wiyxJ6znGPL0TybmJMCktDkWwJTnDfBmAIgWHJ
         TOe9I1iKz2uQTlF8K9bskwg54a4fWBjnQ0fhkZg6hodR9AZ52Z5rwl59ZM1NSFr01w
         N6eIyafMjymGXkGGDRVZ7RlGZiumv/RWgUYSUqRKz7ZJIObch9BZm0P4edK9FosKC/
         EJXpgUyFJHeKt4ZRzFomGA5tpr5LQKKAoTZhgetN4jOUC7C8k7zoFvzME7A1boqYt4
         SexZ2SudyS/Fr+8s6jyY7nby2h1DmwkoETDuWTUykO6ZMSnGa+6+/UnnAimG+H3ek4
         9ELiqDB1WjnGAIAKKL82pymLLqXnoDI2ikPbPAIFjfVM1a1gsE0U5VMlJRK40PjKcz
         4sBHQTi6VsxwGKo4PE8Rus33n7eKdzMpz7nyXgYEJD7gW/oyDza
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/53] Clean up outstanding object_id transforms.
Date:   Sun, 23 Apr 2017 21:34:02 +0000
Message-Id: <20170423213453.253425-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
