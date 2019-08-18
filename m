Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132011F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfHRUFw (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58026 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbfHRUFu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 175086074A;
        Sun, 18 Aug 2019 20:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158749;
        bh=xOWEmVnpXGXnmnuIuekjcTh784iE81edYoOkwRZfUVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Joa4bKQL4hWFjhvSjVnsLxLAILaKI8Iqo1S0bFk2gqSYmJEDYXR5WmljaxiSo4+Fp
         5AO6cmRVkexXkEjLTxZ79gmGmTgbhVkD7+5jj7+yFo6c7cAA73vs5nwBihxmDPFeU6
         0BiW1u3Da98sxk/3MNC+7qSKHI2Kj3DbFtjCYx5FHHjjbU0+qCkxnBs07jtFhT3r/I
         iTWCLvbCrvVIX+49UGoNpKv6szD8PXXKsAH5B4MJRMtWG8PgAMfqR66pGhcqJgMBph
         ocjSokZOSnRBPQeAGol98bUZrtJmCv9lXU86eOfobjT9GGEljX1Z4HQGOsubqPIsnF
         QpTkye+QvUg4YaN6M96jP9iLpQ68lL3ahTc8jaQ+cB4oKCpslPwadgUQ1fcrLshd1y
         qSIi8tQ4Ly6WmGp6hU0ijV0+8GVPf0/plPAN1XeTH1FPcwPGGFh3e3i/CVbpR1ZhGQ
         OpHd4kIZzNKzk/q5S7yXrZwqSA6LWUFNUKANEMBIDoT6q0Cj1zy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 20/26] wt-status: convert struct wt_status to object_id
Date:   Sun, 18 Aug 2019 20:04:21 +0000
Message-Id: <20190818200427.870753-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change struct wt_status to use struct object_id instead of an array of
unsigned char.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit.c | 4 ++--
 wt-status.c      | 2 +-
 wt-status.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ae7aaf6dc6..e588bc6ad3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -510,7 +510,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->nowarn = nowarn;
 	s->is_initial = get_oid(s->reference, &oid) ? 1 : 0;
 	if (!s->is_initial)
-		hashcpy(s->sha1_commit, oid.hash);
+		oidcpy(&s->oid_commit, &oid);
 	s->status_format = status_format;
 	s->ignore_submodule_arg = ignore_submodule_arg;
 
@@ -1406,7 +1406,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	s.is_initial = get_oid(s.reference, &oid) ? 1 : 0;
 	if (!s.is_initial)
-		hashcpy(s.sha1_commit, oid.hash);
+		oidcpy(&s.oid_commit, &oid);
 
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
diff --git a/wt-status.c b/wt-status.c
index 9f6c65a580..7cf220fed4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2025,7 +2025,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 	char eol = s->null_termination ? '\0' : '\n';
 
 	fprintf(s->fp, "# branch.oid %s%c",
-			(s->is_initial ? "(initial)" : sha1_to_hex(s->sha1_commit)),
+			(s->is_initial ? "(initial)" : oid_to_hex(&s->oid_commit)),
 			eol);
 
 	if (!s->branch)
diff --git a/wt-status.h b/wt-status.h
index 77dad5b920..71c3f25f43 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -116,7 +116,7 @@ struct wt_status {
 	int rename_limit;
 	enum wt_status_format status_format;
 	struct wt_status_state state;
-	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
+	struct object_id oid_commit; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
 	int committable;
