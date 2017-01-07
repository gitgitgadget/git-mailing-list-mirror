Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCAAA1FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939141AbdAGBMc (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:12:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58044 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936656AbdAGBMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:12:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1E4C5D691;
        Fri,  6 Jan 2017 20:12:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=rzDV
        r/EaGhc6CJOh/qFqV+CpNHM=; b=MaZRnAp2jPq0difSVzWCgk2zGhHcccM/MW+1
        78jQLKpvPip+qoI/+y7vQzVUZzmFNrIMHWvU6wJKvIZ6J4aU2hcSLyUUxLYBr9bn
        gNpaMbXwwlXCwTi+QIN9j4vBfFxYgBJtj0uGolyWce8PDaqRdCrs51upUm4Tw/cM
        1H8q85M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9C345D690;
        Fri,  6 Jan 2017 20:12:29 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 529E15D68F;
        Fri,  6 Jan 2017 20:12:29 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH v2] branch_get_push: do not segfault when HEAD is detached
Date:   Fri,  6 Jan 2017 20:12:15 -0500
Message-Id: <20170107011215.29691-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170106045623.21118-1-kyle@kyleam.com>
References: <20170106045623.21118-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 5BE7C776-D476-11E6-ACC1-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=rzDVr/EaGhc6CJOh/qFqV+CpNHM=;
 b=zd22l92NQ3pU15JfKT6dHmqvXJmQRMOJeIzoL/1gO1+kzPk+rGcdXbiC9DpEdkKpUGeVbebMAiBAwP2Qy1ZRtK2gzQ6YjFZycbMsdfBaTvopLLwW5tp3b9q96BObzCoaDpPWfmETYl1GnsGL0rEHhto4s1EpThGu/txSYDJDjco=
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
index 7214f5b33..623a32aa6 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -60,4 +60,10 @@ test_expect_success '@{push} with push refspecs' '
 	resolve topic@{push} refs/remotes/origin/magic/topic
 '
 
+test_expect_success 'resolving @{push} fails with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	test_must_fail git rev-parse @{push}
+'
+
 test_done
-- 
2.11.0

