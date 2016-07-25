Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A7F203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbcGYWAg (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:00:36 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:55425 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755517AbcGYWAc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 18:00:32 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 842E8C4738;
	Mon, 25 Jul 2016 23:00:30 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 7E76120B69;
	Mon, 25 Jul 2016 23:00:30 +0100 (BST)
X-Quarantine-ID: <4Zk34vtme9-r>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
X-Amavis-Alert:	BAD HEADER SECTION, Duplicate header field: "References"
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4Zk34vtme9-r; Mon, 25 Jul 2016 23:00:29 +0100 (BST)
Received: from river.lan (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id B1EB962128;
	Mon, 25 Jul 2016 23:00:24 +0100 (BST)
From:	John Keeping <john@keeping.me.uk>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 3/3] push: allow pushing new branches with --force-with-lease
Date:	Mon, 25 Jul 2016 22:59:57 +0100
Message-Id: <665bb0aaaac14790521738efe93904bfeabf38f1.1469483499.git.john@keeping.me.uk>
X-Mailer: git-send-email 2.9.2.639.g855ae9f
In-Reply-To: <cover.1469483499.git.john@keeping.me.uk>
References: <cover.1469483499.git.john@keeping.me.uk>
In-Reply-To: <cover.1469483499.git.john@keeping.me.uk>
References: <xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com> <cover.1469483499.git.john@keeping.me.uk>
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
Changes in v2:
- The "explicit" test was previously in this patch but is now added in
  patch 2/3.

 remote.c            |  7 +++----
 remote.h            |  1 -
 t/t5533-push-cas.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index af94892..20e174d 100644
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
@@ -2345,7 +2344,7 @@ static void apply_cas(struct push_cas_option *cas,
 		if (!entry->use_tracking)
 			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-			ref->expect_old_no_trackback = 1;
+			memset(&ref->old_oid_expect, 0, sizeof(ref->old_oid_expect));
 		return;
 	}
 
@@ -2355,7 +2354,7 @@ static void apply_cas(struct push_cas_option *cas,
 
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
index 5e7f6e9..5f29664 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -191,6 +191,18 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
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
 test_expect_success 'new branch covered by force-with-lease (explicit)' '
 	setup_srcdst_basic &&
 	(
@@ -203,4 +215,18 @@ test_expect_success 'new branch covered by force-with-lease (explicit)' '
 	test_cmp expect actual
 '
 
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
2.9.2.639.g855ae9f

