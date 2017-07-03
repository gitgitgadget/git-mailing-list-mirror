Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0D8201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbdGCSzy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:55:54 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52998 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751907AbdGCSzt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 16E35280B4;
        Mon,  3 Jul 2017 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108148;
        bh=1ioijUuJBcZk3oWS9Qo3g65YDnbe1ZFJ1pLM3e/ObdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ip6HQBP38eYEg0p4iUpMpb7DdXkcUNZ2H9m9xsPrvreVJtXtJZTnYHyQwcVw542li
         X4+HYN3lQD9+0tvKybk10uZPVzTo49J+kMtm3PtJhHot1bXG1bENaeNgCWhUCv4lwX
         SKHRhAC9nHTY6UoI0IUNM8zg+FyyAtabCRoJVrELCySR0AFVgJsljvVakwxR1te1T3
         kFXCL4Ae6stbZR9B6AQL6lkPPKDJGxET79rAkCsw2yUJ0hD4GGaaSTRDY4vfxPSsNT
         hXTk8MLsuh7/thE7gsk1Ic8tpam1MV+0vIE4zj/b74pgN8eK62iFEyJvOZBpxhsJdd
         63FJy5PkpLP8uU6O/Om+4yxvOrH9yxGEyCdqX/QUMMiAUL5AwYiZXi+JHOTkNjhxH8
         ivKkxp2kxF+QY9OXb4bLxOzKizXhyDnbHohjNIO5dm7e60RGyCl/W7lf4k+Lv35UVt
         CirTxFXJd8fn+jDvzS5EVVupOqi4lR+/61xXwX4m586WPhjHI/G
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 07/12] bisect: convert bisect_checkout to struct object_id
Date:   Mon,  3 Jul 2017 18:55:28 +0000
Message-Id: <20170703185533.51530-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index a9fd9fbc6..2549eaf7b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -680,16 +680,16 @@ static int is_expected_rev(const struct object_id *oid)
 	return res;
 }
 
-static int bisect_checkout(const unsigned char *bisect_rev, int no_checkout)
+static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 
-	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
-	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
+	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev->hash, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	argv_checkout[2] = bisect_rev_hex;
 	if (no_checkout) {
-		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(NULL, "BISECT_HEAD", bisect_rev->hash, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
@@ -796,7 +796,7 @@ static void check_merge_bases(int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(bisect_checkout(mb->hash, no_checkout));
+			exit(bisect_checkout(mb, no_checkout));
 		}
 	}
 
@@ -939,7 +939,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct rev_info revs;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
-	const unsigned char *bisect_rev;
+	struct object_id *bisect_rev;
 	char *steps_msg;
 
 	read_bisect_terms(&term_bad, &term_good);
@@ -977,11 +977,11 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		exit(4);
 	}
 
-	bisect_rev = revs.commits->item->object.oid.hash;
+	bisect_rev = &revs.commits->item->object.oid;
 
-	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
+	if (!oidcmp(bisect_rev, current_bad_oid)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first %s commit\n", sha1_to_hex(bisect_rev),
+		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
