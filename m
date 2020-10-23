Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A109C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C232168B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373889AbgJWHJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 03:09:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:40190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373874AbgJWHJk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 03:09:40 -0400
Received: (qmail 26449 invoked by uid 109); 23 Oct 2020 07:09:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 07:09:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13496 invoked by uid 111); 23 Oct 2020 07:09:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 03:09:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 03:09:39 -0400
From:   Jeff King <peff@peff.net>
To:     VenomVendor <info@venomvendor.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH 2/3] am: fix broken email with --committer-date-is-author-date
Message-ID: <20201023070939.GB2913115@coredump.intra.peff.net>
References: <20201023070747.GA2198273@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023070747.GA2198273@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e8cbe2118a (am: stop exporting GIT_COMMITTER_DATE, 2020-08-17)
rewrote the code for setting the committer date to use fmt_ident(),
rather than setting an environment variable and letting commit_tree()
handle it. But it introduced two bugs:

  - we use the author email string instead of the committer email

  - when parsing the committer ident, we used the wrong variable to
    compute the length of the email, resulting in it always being a
    zero-length string

This commit fixes both, which causes our test of this option via the
rebase "apply" backend to now succeed.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c                   | 4 ++--
 t/t3436-rebase-more-options.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 2c7673f74e..4949535a7f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -161,7 +161,7 @@ static void am_state_init(struct am_state *state)
 	state->committer_name =
 		xmemdupz(id.name_begin, id.name_end - id.name_begin);
 	state->committer_email =
-		xmemdupz(id.mail_begin, id.mail_end - id.mail_end);
+		xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
 }
 
 /**
@@ -1595,7 +1595,7 @@ static void do_commit(const struct am_state *state)
 
 	if (state->committer_date_is_author_date)
 		committer = fmt_ident(state->committer_name,
-				      state->author_email, WANT_COMMITTER_IDENT,
+				      state->committer_email, WANT_COMMITTER_IDENT,
 				      state->ignore_date ? NULL
 							 : state->author_date,
 				      IDENT_STRICT);
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 6f2f49717b..3fda2235bd 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -70,7 +70,7 @@ test_ctime_is_atime () {
 	test_cmp authortime committertime
 }
 
-test_expect_failure '--committer-date-is-author-date works with apply backend' '
+test_expect_success '--committer-date-is-author-date works with apply backend' '
 	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
 	git rebase --apply --committer-date-is-author-date HEAD^ &&
 	test_ctime_is_atime -1
-- 
2.29.0.583.g8e3ac41d8f

