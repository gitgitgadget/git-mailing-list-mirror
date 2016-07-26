Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081DD203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbcGZUp0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:45:26 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:55469 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964789AbcGZUpY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2016 16:45:24 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id B7279230DA;
	Tue, 26 Jul 2016 21:45:22 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id B1BF833CD;
	Tue, 26 Jul 2016 21:45:22 +0100 (BST)
X-Quarantine-ID: <f0ow8GJPNG2Q>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
X-Amavis-Alert:	BAD HEADER SECTION, Duplicate header field: "References"
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id f0ow8GJPNG2Q; Tue, 26 Jul 2016 21:45:20 +0100 (BST)
Received: from river.lan (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id C3EAD36CE;
	Tue, 26 Jul 2016 21:45:14 +0100 (BST)
From:	John Keeping <john@keeping.me.uk>
To:	git@vger.kernel.org
Cc:	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 3/3] push: allow pushing new branches with --force-with-lease
Date:	Tue, 26 Jul 2016 21:44:45 +0100
Message-Id: <f2bf19fd44684202177ae09d034756e0a68e2482.1469565810.git.john@keeping.me.uk>
X-Mailer: git-send-email 2.9.2.639.g855ae9f
In-Reply-To: <cover.1469565810.git.john@keeping.me.uk>
References: <cover.1469565810.git.john@keeping.me.uk>
In-Reply-To: <cover.1469565810.git.john@keeping.me.uk>
References: <cover.1469483499.git.john@keeping.me.uk> <cover.1469565810.git.john@keeping.me.uk>
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
Changes in v3:
- use oidclr()
- final test is now added in the previous patch and now uses the
  explicit --force-with-lease syntax

 remote.c            |  7 +++----
 remote.h            |  1 -
 t/t5533-push-cas.sh | 12 ++++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 42c4a34..d29850a 100644
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
+			oidclr(&ref->old_oid_expect);
 		return;
 	}
 
@@ -2355,7 +2354,7 @@ static void apply_cas(struct push_cas_option *cas,
 
 	ref->expect_old_sha1 = 1;
 	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-		ref->expect_old_no_trackback = 1;
+		oidclr(&ref->old_oid_expect);
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
index ed631c3..09899af 100755
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
-- 
2.9.2.639.g855ae9f

