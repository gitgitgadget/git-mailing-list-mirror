Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8321B1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbdJFOii (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:38:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752468AbdJFOid (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:38:33 -0400
Received: (qmail 7412 invoked by uid 109); 6 Oct 2017 14:38:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 14:38:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6725 invoked by uid 111); 6 Oct 2017 14:38:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 10:38:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 10:38:30 -0400
Date:   Fri, 6 Oct 2017 10:38:30 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: [PATCH 1/2] t3308: create a real ref directory/file conflict
Message-ID: <20171006143830.7sdfpv7jrsdjefxa@sigill.intra.peff.net>
References: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A test in t3308 wants to make sure that we don't
accidentally merge into "refs/notes/dir" when it exists as a
directory, so it does:

  mkdir .git/refs/notes/dir
  git -c core.notesRef=refs/notes/dir merge ...

and expects the second command to fail. But that
understimates the refs code, which is smart enough to remove
useless directories in the refs hierarchy. The test
succeeded only because of a bug which prevented resolving
refs/notes/dir for writing, even though an actual ref update
would succeed.

In preparation for fixing that bug, let's switch to creating
a real ref in refs/notes/dir, which is a more realistic
situation.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3308-notes-merge.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 19aed7ec95..ab946a5153 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -79,7 +79,7 @@ test_expect_success 'fail to merge empty notes ref into empty notes ref (z => y)
 test_expect_success 'fail to merge into various non-notes refs' '
 	test_must_fail git -c "core.notesRef=refs/notes" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/" notes merge x &&
-	mkdir -p .git/refs/notes/dir &&
+	git update-ref refs/notes/dir/foo HEAD &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir/" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/heads/master" notes merge x &&
-- 
2.15.0.rc0.413.g9bb4ac64e2

