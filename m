Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60BBE1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 14:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbdLTOnC (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 09:43:02 -0500
Received: from siwi.pair.com ([209.68.5.199]:14283 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754746AbdLTOm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 09:42:56 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4F557845F0;
        Wed, 20 Dec 2017 09:42:56 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DC3D9845D4;
        Wed, 20 Dec 2017 09:42:55 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 2/4] stat_tracking_info: return +1 when branch and upstream differ
Date:   Wed, 20 Dec 2017 14:42:43 +0000
Message-Id: <20171220144245.39401-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171220144245.39401-1-git@jeffhostetler.com>
References: <20171220144245.39401-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Extend stat_tracking_info() to return 1 when the branch is
not up to date with its upstream branch and only return 0
when they are equal.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 ref-filter.c | 4 ++--
 remote.c     | 6 ++++--
 wt-status.c  | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e728b15..10ab4cd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1239,7 +1239,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL)) {
+				       &num_theirs, NULL) < 0) {
 			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = "";
@@ -1257,7 +1257,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL) < 0)
 			return;
 
 		if (!num_ours && !num_theirs)
diff --git a/remote.c b/remote.c
index b220f0d..a38b42e 100644
--- a/remote.c
+++ b/remote.c
@@ -1983,7 +1983,9 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
  * is not itself NULL.
  *
  * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
- * upstream defined, or ref does not exist), 0 otherwise.
+ * upstream defined, or ref does not exist).
+ * Returns 0 if the commits are the same (the branch is up to date).
+ * Returns 1 if the commits are different (the branch is not up to date).
  */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name)
@@ -2051,7 +2053,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
 
 	argv_array_clear(&argv);
-	return 0;
+	return 1;
 }
 
 /*
diff --git a/wt-status.c b/wt-status.c
index 1bc53e1..471ba15 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1935,7 +1935,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 			base = branch_get_upstream(branch, NULL);
 			ab_info = 0;
 		} else {
-			ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+			ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) >= 0);
 		}
 
 		if (base) {
-- 
2.9.3

