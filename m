Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44A520A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbdJAWJb (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54210 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752130AbdJAWJJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1A84B60DBB;
        Sun,  1 Oct 2017 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895747;
        bh=aHjY2BJpucncuoH1V0e99PfwCtAaC5hIJcXhi2FtSws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0O3AdnwkoYVwmFmwuuAY2lUQYp98qHD+n8a6H5u8P66eVwTnmLWCp9D7J8vevkGkz
         AbS4FfNqHueT0SJzD0OB0PMrrARAYYTk6zGXU+bzkA5jQp9ZKR/CxfIP0SH1+CFC/e
         z4IvQdOsNvZf8D9axvWedFoKdnguz81+iBEeH1HPt5B6JtlszefhReGzssgv4uDI6H
         UafEZLV34R3nbpFZPX53cRlZ97ISN3wMRm0LxbNr7g9k9zM3vQSbWQIueKv5/r2h2g
         PDs05twEgaaXBqNDlBJmn4x0haTPC6QSCkAK9Yqcq+fZtUTI1NeE9mgeB8QOMDUXul
         CtaKVewkVHFd5czh1or04rKU9YFgHygMopU1E+ZHd7wFO1o/jAqVij/WlI5Bp46W6d
         uRFz9BmOluRuehTIdoJmIPinNuJsr+8546J98TGlhMuVjhSSfUMd02A7nJii4JUsOC
         04Sb+c5trinq5l1ccHpnJt46RvAkNJCpayv9D7mbsYwv01rCuvi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 20/24] worktree: convert struct worktree to object_id
Date:   Sun,  1 Oct 2017 22:08:27 +0000
Message-Id: <20171001220831.214705-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the head_sha1 member to be head_oid instead.  This is required
to convert resolve_ref_unsafe.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/worktree.c | 6 +++---
 worktree.c         | 2 +-
 worktree.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index de26849f55..d9fe6f694e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -392,7 +392,7 @@ static void show_worktree_porcelain(struct worktree *wt)
 	if (wt->is_bare)
 		printf("bare\n");
 	else {
-		printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
+		printf("HEAD %s\n", oid_to_hex(&wt->head_oid));
 		if (wt->is_detached)
 			printf("detached\n");
 		else if (wt->head_ref)
@@ -412,7 +412,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 		strbuf_addstr(&sb, "(bare)");
 	else {
 		strbuf_addf(&sb, "%-*s ", abbrev_len,
-				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
+				find_unique_abbrev(wt->head_oid.hash, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
 		else if (wt->head_ref) {
@@ -437,7 +437,7 @@ static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 
 		if (path_len > *maxlen)
 			*maxlen = path_len;
-		sha1_len = strlen(find_unique_abbrev(wt[i]->head_sha1, *abbrev));
+		sha1_len = strlen(find_unique_abbrev(wt[i]->head_oid.hash, *abbrev));
 		if (sha1_len > *abbrev)
 			*abbrev = sha1_len;
 	}
diff --git a/worktree.c b/worktree.c
index 70015629dc..cb35db03fa 100644
--- a/worktree.c
+++ b/worktree.c
@@ -31,7 +31,7 @@ static void add_head_info(struct worktree *wt)
 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
 					 0,
-					 wt->head_sha1, &flags);
+					 wt->head_oid.hash, &flags);
 	if (!target)
 		return;
 
diff --git a/worktree.h b/worktree.h
index 9276c81ae7..c28a880e18 100644
--- a/worktree.h
+++ b/worktree.h
@@ -8,7 +8,7 @@ struct worktree {
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
 	char *lock_reason;	/* internal use */
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
 	int is_current;
-- 
2.14.2.822.g60be5d43e6

