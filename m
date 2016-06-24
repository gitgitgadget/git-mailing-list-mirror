Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4021FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcFXXJl (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:41 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52554 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415AbcFXXJj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:39 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 70247280A2;
	Fri, 24 Jun 2016 23:09:38 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809778;
	bh=RAAHgv5ZuoIboTkFx0y6i5e7yQjTn/bd54Lznx0VwwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uK5LMyqh5JdIhuY8FniPGdj+vvhgjcXr/70xb9DzNfeHOY4lfGkQiuj/i9U9RQiae
	 ygVI1ppbIVoCauNvMNBaH0WqQO6TWU7qmDImql9l82KZxN+KB+yMqhrOiCmxn9lxKq
	 xQ77Av95eF/BYUEcprhrZpjCBSFgyQVwhph43ER8TIQfegzRTiDZS+qhKnj6b6uOq+
	 7tG28hhiypRkQiW2DEyyuqJEMWWPYj071C4LOApEP4pHdAr14DIILAXTy/jOaYn55m
	 7iR1qU0366HJTlvPo0DD2G4nVE7zeM/PmBYqEuQj8zEyIW3FOr3qiwWP95TXEB8fwQ
	 VOfHf45ikQP29fGpR58GGzbgVXwKl31VgzNyaEE78fESLadbDla68l7mPvaa84njqs
	 9eJzwnS8BS3lffBLjZ9R1XwZ5bYMlvvkVN9W3hCxEM1BnyLo1vOV/plDOmgIIgsoor
	 WHy3zBcKk3BV8WLlDIh6D/o/f6ggT3F5K7Kr4We5mcEsPut0CaI
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 03/11] Convert hashcpy with null_sha1 to hashclr.
Date:	Fri, 24 Jun 2016 23:09:21 +0000
Message-Id: <20160624230929.82222-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

hashcpy with null_sha1 as the source is equivalent to hashclr.  In
addition to being simpler, using hashclr may give the compiler a chance
to optimize better.  Convert instances of hashcpy with the source
argument of null_sha1 to hashclr.

This transformation was implemented using the following semantic patch:

@@
expression E1;
@@
-hashcpy(E1, null_sha1);
+hashclr(E1);

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge.c                  | 2 +-
 builtin/unpack-objects.c         | 4 ++--
 diff.c                           | 2 +-
 submodule-config.c               | 2 +-
 t/helper/test-submodule-config.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1bf..a9b99c9f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1530,7 +1530,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	     * Stash away the local changes so that we can try more than one.
 	     */
 	    save_state(stash))
-		hashcpy(stash, null_sha1);
+		hashclr(stash);
 
 	for (i = 0; i < use_strategies_nr; i++) {
 		int ret;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 875e7ed9..172470bf 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -355,7 +355,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			return; /* we are done */
 		else {
 			/* cannot resolve yet --- queue it */
-			hashcpy(obj_list[nr].sha1, null_sha1);
+			hashclr(obj_list[nr].sha1);
 			add_delta_to_list(nr, base_sha1, 0, delta_data, delta_size);
 			return;
 		}
@@ -406,7 +406,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			 * The delta base object is itself a delta that
 			 * has not been resolved yet.
 			 */
-			hashcpy(obj_list[nr].sha1, null_sha1);
+			hashclr(obj_list[nr].sha1);
 			add_delta_to_list(nr, null_sha1, base_offset, delta_data, delta_size);
 			return;
 		}
diff --git a/diff.c b/diff.c
index fa78fc18..f2234012 100644
--- a/diff.c
+++ b/diff.c
@@ -3134,7 +3134,7 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 		if (!one->sha1_valid) {
 			struct stat st;
 			if (one->is_stdin) {
-				hashcpy(one->sha1, null_sha1);
+				hashclr(one->sha1);
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
diff --git a/submodule-config.c b/submodule-config.c
index db1847ff..077db405 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -377,7 +377,7 @@ static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 	int ret = 0;
 
 	if (is_null_sha1(commit_sha1)) {
-		hashcpy(gitmodules_sha1, null_sha1);
+		hashclr(gitmodules_sha1);
 		return 1;
 	}
 
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index dab8c277..7922ffba 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -49,7 +49,7 @@ int main(int argc, char **argv)
 		path_or_name = arg[1];
 
 		if (commit[0] == '\0')
-			hashcpy(commit_sha1, null_sha1);
+			hashclr(commit_sha1);
 		else if (get_sha1(commit, commit_sha1) < 0)
 			die_usage(argc, argv, "Commit not found.");
 
