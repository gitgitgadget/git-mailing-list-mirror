Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6EB203C1
	for <e@80x24.org>; Sat, 23 Jul 2016 15:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbcGWPcP (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 11:32:15 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:45592 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075AbcGWPcO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2016 11:32:14 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 0DC12C46EB;
	Sat, 23 Jul 2016 16:32:13 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 0110D20D1F;
	Sat, 23 Jul 2016 16:32:13 +0100 (BST)
X-Quarantine-ID: <m5iG6hUkosRO>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m5iG6hUkosRO; Sat, 23 Jul 2016 16:32:09 +0100 (BST)
Received: from river.lan (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id D799962118;
	Sat, 23 Jul 2016 16:32:06 +0100 (BST)
From:	John Keeping <john@keeping.me.uk>
To:	git@vger.kernel.org
Cc:	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] push: allow pushing new branches with --force-with-lease
Date:	Sat, 23 Jul 2016 16:31:57 +0100
Message-Id: <6b401124e734d4f5486003459e586cc05c7843e8.1469287889.git.john@keeping.me.uk>
X-Mailer: git-send-email 2.9.2.637.g8b832fc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If there is no upstream information for a branch, it is likely that it
is newly created and can safely be pushed under the normal fast-forward
rules.  Relax the --force-with-lease check so that we do not reject
these branches immediately but rather attempt to push them as new
branches, using the null SHA-1 as the expected value.

In fact, it is already possible to push new branches using the explicit
--force-with-lease=<branch>:<expect> syntax, so all we do here is make
this behaviour the default if no explicit "expect" value is specified.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 remote.c            |  7 +++----
 remote.h            |  1 -
 t/t5533-push-cas.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index a326e4e..cd2ee52 100644
--- a/remote.c
+++ b/remote.c
@@ -1544,8 +1544,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 * branch.
 		 */
 		if (ref->expect_old_sha1) {
-			if (ref->expect_old_no_trackback ||
-			    oidcmp(&ref->old_oid, &ref->old_oid_expect))
+			if (oidcmp(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
 			else
 				/* If the ref isn't stale then force the update. */
@@ -2343,7 +2342,7 @@ static void apply_cas(struct push_cas_option *cas,
 		if (!entry->use_tracking)
 			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-			ref->expect_old_no_trackback = 1;
+			memset(&ref->old_oid_expect, 0, sizeof(ref->old_oid_expect));
 		return;
 	}
 
@@ -2353,7 +2352,7 @@ static void apply_cas(struct push_cas_option *cas,
 
 	ref->expect_old_sha1 = 1;
 	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-		ref->expect_old_no_trackback = 1;
+		memset(&ref->old_oid_expect, 0, sizeof(ref->old_oid_expect));
 }
 
 void apply_push_cas(struct push_cas_option *cas,
diff --git a/remote.h b/remote.h
index c21fd37..9248811 100644
--- a/remote.h
+++ b/remote.h
@@ -89,7 +89,6 @@ struct ref {
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
-		expect_old_no_trackback:1,
 		deletion:1,
 		matched:1;
 
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index c732012..4276b1b 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -191,4 +191,42 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'new branch covered by force-with-lease' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git branch branch master &&
+		git push --force-with-lease=branch origin branch
+	) &&
+	git ls-remote dst refs/heads/branch >expect &&
+	git ls-remote src refs/heads/branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'new branch covered by force-with-lease (explicit)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git branch branch master &&
+		git push --force-with-lease=branch:0000000000000000000000000000000000000000 origin branch
+	) &&
+	git ls-remote dst refs/heads/branch >expect &&
+	git ls-remote src refs/heads/branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'new branch already exists' '
+	setup_srcdst_basic &&
+	(
+		cd src &&
+		git checkout -b branch master &&
+		test_commit c
+	) &&
+	(
+		cd dst &&
+		git branch branch master &&
+		test_must_fail git push --force-with-lease=branch origin branch
+	)
+'
+
 test_done
-- 
2.9.2.637.g8b832fc

