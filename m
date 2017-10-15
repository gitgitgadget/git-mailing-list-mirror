Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEDF20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbdJOWIW (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751705AbdJOWIA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:08:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E9B2960462;
        Sun, 15 Oct 2017 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105279;
        bh=q+Yn5VzDO6DzBcymi/4Wgk5cYzirXCGugQ7NfUvhJGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=c1eIEHKp1Ny2aL5kMyqoj6CKBJgtJ4FYzKYHfm6JCY/H+llftRoUO/Ud93bR4q3F+
         MAor97ulGZOIDq4cZg1Go/4nRICDDgEpIxcNKbMZLxe95/dRMUOpgdUL90DN3b6uYf
         M37Ael+mhJf/36FOKABGfjhS9ISiGJCTDmZo5yzOalEDVTRj2irUqXBfYE3ZPV+xaH
         uYduESmqbehSJV8n0xDzH4KR7TJEDbGasul5mieV8YOFSNoDfGMBnmgO2rj0CAdkWQ
         F0ZpRXolKiy9VSUQpkIFGtfNcJtlbYUbceZofz2Er6GntSeKXXum/PETja7Q9nJLwf
         jwh8UWwo46yftbIyrfoRl+Gh65UuMmKQFNuR11QFguVcpM8Dohe5gnzPLO5HMLuHCb
         JmntV+qWGIc96Uf623uLXBDMS8rsTKIXy/XtSjGPek6z4QhCiCPKKi2UYe1RAFfnny
         ofiR5Ce2bEGyHAOFTmUuuBtDa4CC1zcdIpp3ORETjv4hETG7G2S
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 21/25] worktree: convert struct worktree to object_id
Date:   Sun, 15 Oct 2017 22:07:08 +0000
Message-Id: <20171015220712.97308-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
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
index 7b9307aa58..ed043d5f1c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -410,7 +410,7 @@ static void show_worktree_porcelain(struct worktree *wt)
 	if (wt->is_bare)
 		printf("bare\n");
 	else {
-		printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
+		printf("HEAD %s\n", oid_to_hex(&wt->head_oid));
 		if (wt->is_detached)
 			printf("detached\n");
 		else if (wt->head_ref)
@@ -430,7 +430,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 		strbuf_addstr(&sb, "(bare)");
 	else {
 		strbuf_addf(&sb, "%-*s ", abbrev_len,
-				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
+				find_unique_abbrev(wt->head_oid.hash, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
 		else if (wt->head_ref) {
@@ -455,7 +455,7 @@ static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 
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
2.15.0.rc0.271.g36b669edcc

