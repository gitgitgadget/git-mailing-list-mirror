Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E6820248
	for <e@80x24.org>; Wed, 27 Feb 2019 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfB0Ozv (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 09:55:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:59900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727213AbfB0Ozv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 09:55:51 -0500
Received: (qmail 3223 invoked by uid 109); 27 Feb 2019 14:55:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Feb 2019 14:55:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6218 invoked by uid 111); 27 Feb 2019 14:56:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Feb 2019 09:56:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2019 09:55:49 -0500
Date:   Wed, 27 Feb 2019 09:55:49 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] doc/fsck: discuss mix of --connectivity-only and --dangling
Message-ID: <20190227145549.GA3255@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --connectivity-only option avoids opening every object, and instead
just marks reachable objects with a flag, and compares this to the set
of all objects. This strategy is discussed in more detail in 3e3f8bd608
(fsck: prepare dummy objects for --connectivity-check, 2017-01-17).

This means that we report _every_ unreachable object as dangling.
Whereas in a full fsck, we'd have actually opened and parsed each of
those unreachable objects, marking their child objects with the USED
flag, to mean "this was mentioned by another object". And thus we can
report only the tip of an unreachable segment of the object graph as
dangling.

You can see this difference with a trivial example:

  tree=$(git hash-object -t tree -w /dev/null)
  one=$(echo one | git commit-tree $tree)
  two=$(echo two | git commit-tree -p $one $tree)

Running `git fsck` will report only $two as dangling, but with
--connectivity-only, both commits (and the tree) are reported.

We could make the two cases work identically by taking a separate pass
over the unreachable objects, parsing them and marking objects they
refer to as USED. That would still avoid parsing any blobs, but we'd pay
the cost to access any unreachable commits and trees. Since the point of
--connectivity-only is to quickly report whether all reachable objects
are present, I'd argue that it's not worth slowing it down to produce
a better-analyzed dangling list.

Instead, let's document this somewhat surprising property of
connectivity-only. If somebody really wants to the extra analysis, we
can add a separate option to enable it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fsck.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 55950d9eea..02ce7c6282 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -65,6 +65,10 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	Check only the connectivity of tags, commits and tree objects. By
 	avoiding to unpack blobs, this speeds up the operation, at the
 	expense of missing corrupt objects or other problematic issues.
+	Note that this also skips some analysis of unreachable objects,
+	meaning that Git will report the full list of unreachable
+	objects as dangling (unless `--no-dangling` was used), rather
+	than the tips of unreachable segments of history.
 
 --strict::
 	Enable more strict checking, namely to catch a file mode
-- 
2.21.0.675.g01c085a870
