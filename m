Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A53C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA59621481
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgIGIKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:10:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:50264 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgIGIJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 04:09:05 -0400
Received: (qmail 12984 invoked by uid 109); 7 Sep 2020 08:08:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Sep 2020 08:08:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14375 invoked by uid 111); 7 Sep 2020 08:08:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Sep 2020 04:08:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Sep 2020 04:08:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Tom Hale <tomnott@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] add-patch: fix inverted return code of repo_read_index()
Message-ID: <20200907080853.GA1263923@coredump.intra.peff.net>
References: <20200907080632.GA1261825@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907080632.GA1261825@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After applying hunks to a file with "add -p", the C patch_update_file()
function tries to refresh the index (just like the perl version does).
We can only refresh the index if we're able to read it in, so we first
check the return value of repo_read_index(). But unlike many functions,
where "0" is success, that function is documented to return the number
of entries in the index.  Hence we should be checking for success with a
non-negative return value.

Neither the tests nor any users seem to have noticed this, probably due
to a combination of:

  - this affects only the C version, which is not yet the default

  - following it up with any porcelain command like "git diff" or "git
    commit" would refresh the index automatically.

But you can see the problem by running the plumbing "git diff-files"
immediately after "add -p" stages all hunks. Running the new test with
GIT_TEST_ADD_I_USE_BUILTIN=1 fails without the matching code change.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-patch.c                | 2 +-
 t/t3701-add-interactive.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 457b8c550e..9544437247 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1641,7 +1641,7 @@ static int patch_update_file(struct add_p_state *s,
 					 NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (!repo_read_index(s->s.r))
+		if (repo_read_index(s->s.r) >= 0)
 			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
 	}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fb73a847cb..67d1c36cef 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -569,6 +569,13 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	diff_cmp expected diff
 '
 
+test_expect_success 'index is refreshed after applying patch' '
+	git reset --hard &&
+	echo content >test &&
+	printf y | git add -p &&
+	git diff-files --exit-code
+'
+
 test_expect_success 'diffs can be colorized' '
 	git reset --hard &&
 
-- 
2.28.0.889.g64d3ad7607

