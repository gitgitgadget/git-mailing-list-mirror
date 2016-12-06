Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9911FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 20:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbcLFUcE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 15:32:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:52733 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752731AbcLFUcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 15:32:03 -0500
Received: (qmail 12337 invoked by uid 109); 6 Dec 2016 20:25:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 20:25:22 +0000
Received: (qmail 17236 invoked by uid 111); 6 Dec 2016 20:26:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 15:26:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 15:25:21 -0500
Date:   Tue, 6 Dec 2016 15:25:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charles Bailey <charles@hashpling.org>,
        Matthew Patey <matthew.patey2167@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] stash: disable renames when calling git-diff
Message-ID: <20161206202521.zxgxqsetgqejsyl3@sigill.intra.peff.net>
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
 <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
 <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
 <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
 <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
 <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
 <20161206193154.vf7cd7lk5gyxrra5@sigill.intra.peff.net>
 <xmqqd1h425vv.fsf@gitster.mtv.corp.google.com>
 <20161206201130.azfmqvtk3iettlx7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161206201130.azfmqvtk3iettlx7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 03:11:30PM -0500, Jeff King wrote:

> > Yeah, it looks like "add -u" to me, too.  Perhaps the script was old
> > enough that it didn't exist back then?  I dunno.
> 
> Hmm, nope. It _was_ "git add -u" at one point and switched. See
> 7aa5d43cc (stash: Don't overwrite files that have gone from the index,
> 2010-04-18).
> 
> I think you are right that diff-index could work, though. I always
> forget that without "--cached", diff-index looks at the working tree
> files.

Here it is in patch form. Perhaps I am missing some subtle case that
diff-index would not handle, but it does pass the test suite. And
looking over the original thread, I don't see any particular reason to
prefer git-diff.

+cc Charles just in case he remembers anything.

-- >8 --
Subject: [PATCH] stash: prefer plumbing over git-diff

When creating a stash, we need to look at the diff between
the working tree and HEAD, and do so using the git-diff
porcelain.  Because git-diff enables porcelain config like
renames by default, this causes at least one problem. The
--name-only format will not mention the source side of a
rename, meaning we will fail to stash a deletion that is
part of a rename.

We could fix that case by passing --no-renames, but this is
a symptom of a larger problem. We should be using the
diff-index plumbing here, which does not have renames
enabled by default, and also does not respect any
potentially confusing config options.

Reported-by: Matthew Patey <matthew.patey2167@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh     | 2 +-
 t/t3903-stash.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4546abaae..10c284d1a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -115,7 +115,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e1a6ccc00..2de3e18ce 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -766,4 +766,13 @@ test_expect_success 'stash list --cc shows combined diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stash is not confused by partial renames' '
+	mv file renamed &&
+	git add renamed &&
+	git stash &&
+	git stash apply &&
+	test_path_is_file renamed &&
+	test_path_is_missing file
+'
+
 test_done
-- 
2.11.0.191.gdb26c57

