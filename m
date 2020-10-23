Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BBCC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BC72168B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375609AbgJWHKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 03:10:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:40198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373896AbgJWHKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 03:10:16 -0400
Received: (qmail 26467 invoked by uid 109); 23 Oct 2020 07:10:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 07:10:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13520 invoked by uid 111); 23 Oct 2020 07:10:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 03:10:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 03:10:15 -0400
From:   Jeff King <peff@peff.net>
To:     VenomVendor <info@venomvendor.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH 3/3] rebase: fix broken email with
 --committer-date-is-author-date
Message-ID: <20201023071015.GC2913115@coredump.intra.peff.net>
References: <20201023070747.GA2198273@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023070747.GA2198273@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 7573cec52c (rebase -i: support --committer-date-is-author-date,
2020-08-17) copied the committer ident-parsing code from builtin/am.c.
And in doing so, it copied a bug in which we always set the email to an
empty string. We fixed the version in git-am in the previous commit;
this commit fixes the copied code.

Reported-by: VenomVendor <info@venomvendor.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c                    | 2 +-
 t/t3436-rebase-more-options.sh | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 00acb12496..d76cbded00 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4478,7 +4478,7 @@ static int init_committer(struct replay_opts *opts)
 	opts->committer_name =
 		xmemdupz(id.name_begin, id.name_end - id.name_begin);
 	opts->committer_email =
-		xmemdupz(id.mail_begin, id.mail_end - id.mail_end);
+		xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
 
 	return 0;
 }
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 3fda2235bd..eaaf4c8d1d 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -76,20 +76,20 @@ test_expect_success '--committer-date-is-author-date works with apply backend' '
 	test_ctime_is_atime -1
 '
 
-test_expect_failure '--committer-date-is-author-date works with merge backend' '
+test_expect_success '--committer-date-is-author-date works with merge backend' '
 	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
 	git rebase -m --committer-date-is-author-date HEAD^ &&
 	test_ctime_is_atime -1
 '
 
-test_expect_failure '--committer-date-is-author-date works with rebase -r' '
+test_expect_success '--committer-date-is-author-date works with rebase -r' '
 	git checkout side &&
 	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
 	git rebase -r --root --committer-date-is-author-date &&
 	test_ctime_is_atime
 '
 
-test_expect_failure '--committer-date-is-author-date works when forking merge' '
+test_expect_success '--committer-date-is-author-date works when forking merge' '
 	git checkout side &&
 	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
 	PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
@@ -145,7 +145,7 @@ test_expect_success '--reset-author-date works with rebase -r' '
 	test_atime_is_ignored
 '
 
-test_expect_failure '--reset-author-date with --committer-date-is-author-date works' '
+test_expect_success '--reset-author-date with --committer-date-is-author-date works' '
 	test_must_fail git rebase -m --committer-date-is-author-date \
 		--reset-author-date --onto commit2^^ commit2^ commit3 &&
 	git checkout --theirs foo &&
-- 
2.29.0.583.g8e3ac41d8f
