Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCB0201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 01:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdBUBK5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 20:10:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60381 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751119AbdBUBKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 20:10:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF624696CA;
        Mon, 20 Feb 2017 20:10:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=PC1Q
        pb1yhwLQP5DiCnt9Z+el5BY=; b=TPb4lC6uhKcIR3JDhDUdcmSWGxod/+TJUpzc
        G4us4VCRjrToxZKx9NN7tEFrYXL916/WyFJJ1g5I0ufRocD2hbZHrrBWE/2eBVy7
        Pobxf4oZF60KRJUuaUjiVyNd2ZDOrg5WTOXB6FARkkXkb8TAvY7g9bmRoDdruDi7
        EfTN7zY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6E9D696C9;
        Mon, 20 Feb 2017 20:10:51 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0ADF9696C4;
        Mon, 20 Feb 2017 20:10:50 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH v2 3/4] rename_ref: replace empty message in HEAD's log
Date:   Mon, 20 Feb 2017 20:10:34 -0500
Message-Id: <20170221011035.847-4-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170221011035.847-1-kyle@kyleam.com>
References: <20170217035800.13214-1-kyle@kyleam.com>
 <20170221011035.847-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 95EB9374-F7D2-11E6-A11D-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=PC1Qpb1yhwLQP5DiCnt9Z+el5BY=;
 b=r1gUUkkll4Gyqpv9OwEJKbyGFVpm/XqPNJ62NNAfDdpMEkTA22clsQH137GKDIbMVafofL9lTmLehztq9EQBrCHVgiDEY95RBdoq2G69v+ex1y9bgDT7inPpd01yoAlNSvwk1D1aIXf2ZhH6eIIsM0NmxBJIuTFt/jhSAOpwIP4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the current branch is renamed, the deletion of the old ref is
recorded in HEAD's log with an empty message.  Now that delete_ref()
accepts a reflog message, provide a more descriptive message by
passing along the log message that is given to rename_ref().

The next step will be to extend HEAD's log to also include the second
part of the rename, the creation of the new branch.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 refs/files-backend.c | 2 +-
 t/t3200-branch.sh    | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 299eb4d8a..f6e7c192c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2616,7 +2616,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
-	if (delete_ref(NULL, oldrefname, orig_sha1, REF_NODEREF)) {
+	if (delete_ref(logmsg, oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 8a833f354..0dbc54003 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -139,6 +139,11 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 	test $(git rev-parse --abbrev-ref HEAD) = bam
 '
 
+test_expect_success 'git branch -M baz bam should add entry to .git/logs/HEAD' '
+        msg="Branch: renamed refs/heads/baz to refs/heads/bam" &&
+	grep " 0\{40\}.*$msg$" .git/logs/HEAD
+'
+
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
 	git checkout master &&
 	git worktree add -b baz bazdir &&
-- 
2.11.1

