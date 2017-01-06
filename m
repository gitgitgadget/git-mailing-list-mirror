Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94CB205C9
	for <e@80x24.org>; Fri,  6 Jan 2017 05:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdAFFH2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 00:07:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55102 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750809AbdAFFH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 00:07:26 -0500
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jan 2017 00:07:26 EST
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C6C260B5F;
        Thu,  5 Jan 2017 23:57:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=j9RM+8Lob6hBqjJvG/EfqCKqmkc
        =; b=w+F56N5S2FhvZek9GKTyCoRBy642Sh1iFvuIp7MPRPTiNtVomq3J48jXpJ9
        gcbCys7mU+ceyIU3+zI+F1RNQfrQYR6e6SxUK1aJrnuQSocYeiPQ3jedk9+yUech
        wHlN4U+GQ/wO5To3VOx6OcPb+Cp/6vFQjq1ymtZfokCAcSuE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3580460B5E;
        Thu,  5 Jan 2017 23:57:20 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 613C160B5D;
        Thu,  5 Jan 2017 23:57:19 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] branch_get_push: do not segfault when HEAD is detached
Date:   Thu,  5 Jan 2017 23:56:23 -0500
Message-Id: <20170106045623.21118-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.0
X-Pobox-Relay-ID: 9A2EFDF6-D3CC-11E6-A4D6-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=j9RM+8Lob6hBqjJvG/EfqCKqmkc=;
 b=0M9Fuun2ngVpuvhNfKQznlRXTkTTvNjS6vSBs+Im5e/DQVzYMB3Vye3bMg1PVqbjuVIkY/xLoqYFjaP/s6+uZWEWwlkBwBO6jGLDtEwyxtFX+Y9pha6smjrMJYhcyEk+/TeNgl3B3CP3fMcMOvauBGFnlvqL7Ds2Wofl8T48xnI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the detached HEAD check from branch_get_push_1() to
branch_get_push() to avoid setting branch->push_tracking_ref when
branch is NULL.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 remote.c                  | 6 +++---
 t/t1514-rev-parse-push.sh | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index ad6c5424e..d5eaec737 100644
--- a/remote.c
+++ b/remote.c
@@ -1716,9 +1716,6 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
 
-	if (!branch)
-		return error_buf(err, _("HEAD does not point to a branch"));
-
 	remote = remote_get(pushremote_for_branch(branch, NULL));
 	if (!remote)
 		return error_buf(err,
@@ -1778,6 +1775,9 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 
 const char *branch_get_push(struct branch *branch, struct strbuf *err)
 {
+	if (!branch)
+		return error_buf(err, _("HEAD does not point to a branch"));
+
 	if (!branch->push_tracking_ref)
 		branch->push_tracking_ref = branch_get_push_1(branch, err);
 	return branch->push_tracking_ref;
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 7214f5b33..90c639ae1 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -60,4 +60,10 @@ test_expect_success '@{push} with push refspecs' '
 	resolve topic@{push} refs/remotes/origin/magic/topic
 '
 
+test_expect_success 'resolving @{push} fails with a detached HEAD' '
+	git checkout HEAD^{} &&
+	test_when_finished "git checkout -" &&
+	test_must_fail git rev-parse @{push}
+'
+
 test_done
-- 
2.11.0

