Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C8C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeKFRPO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 12:15:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:41834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729160AbeKFRPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 12:15:13 -0500
Received: (qmail 17760 invoked by uid 109); 6 Nov 2018 07:51:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 07:51:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29103 invoked by uid 111); 6 Nov 2018 07:50:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 02:50:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 02:51:15 -0500
Date:   Tue, 6 Nov 2018 02:51:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Felix Eckhofer <felix@eckhofer.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] merge: handle --verify-signatures for unborn branch
Message-ID: <20181106075115.GB22021@sigill.intra.peff.net>
References: <20181106074910.GA31978@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106074910.GA31978@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-merge sees that we are on an unborn branch (i.e., there is no
HEAD), it follows a totally separate code path than the usual merge
logic. This code path does not know about verify_signatures, and so we
fail to notice bad or missing signatures.

This has been broken since --verify-signatures was added in efed002249
(merge/pull: verify GPG signatures of commits being merged, 2013-03-31).
In an ideal world, we'd unify the flow for this case with the regular
merge logic, which would fix this bug and avoid introducing similar
ones. But because the unborn case is so different, it would be a burden
on the rest of the function to continually handle the missing HEAD. So
let's just port the verification check to this special case.

Reported-by: Felix Eckhofer <felix@eckhofer.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c                    | 4 ++++
 t/t7612-merge-verify-signatures.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index c677f9375e..be156b122d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1336,6 +1336,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("%s - not something we can merge"), argv[0]);
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
+
+		if (verify_signatures)
+			verify_merge_signature(remoteheads->item, verbosity);
+
 		remote_head_oid = &remoteheads->item->object.oid;
 		read_empty(remote_head_oid, 0);
 		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index e2b1df817a..d99218a725 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -103,4 +103,11 @@ test_expect_success GPG 'merge commit with bad signature with merge.verifySignat
 	git merge --no-verify-signatures $(cat forged.commit)
 '
 
+test_expect_success GPG 'merge unsigned commit into unborn branch' '
+	test_when_finished "git checkout initial" &&
+	git checkout --orphan unborn &&
+	test_must_fail git merge --verify-signatures side-unsigned 2>mergeerror &&
+	test_i18ngrep "does not have a GPG signature" mergeerror
+'
+
 test_done
-- 
2.19.1.1533.g982fead9fb

