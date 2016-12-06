Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B90A1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 15:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbcLFPlY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 10:41:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:52476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753982AbcLFPlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 10:41:22 -0500
Received: (qmail 26820 invoked by uid 109); 6 Dec 2016 15:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 15:41:22 +0000
Received: (qmail 14544 invoked by uid 111); 6 Dec 2016 15:42:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 10:42:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 10:41:21 -0500
Date:   Tue, 6 Dec 2016 10:41:21 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew Patey <matthew.patey2167@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] stash: disable renames when calling git-diff
Message-ID: <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
 <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
 <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
 <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 10:25:30AM -0500, Jeff King wrote:

> I agree that the second stash not saving the deletion seems like a bug.
> Oddly, just stashing a deletion, like:
> 
>   rm a
>   git stash
>   git stash apply
> 
> does store it. So it's not like we can't represent the deletion. Somehow
> the presence of "b" in the index matters.
> 
> It looks like the culprit may be this part of create_stash():
> 
>   git diff --name-only -z HEAD -- >"$TMP-stagenames"
> 
> That is using the "git diff" porcelain, which will respect renames, and
> the --name-only bit mentions only "b".
> 
> If you run:
> 
>   git -c diff.renames=false stash
> 
> then it works.

And here's a patch to fix it.

-- >8 --
Subject: [PATCH] stash: disable renames when calling git-diff

When creating a stash, we need to look at the diff between
the working tree and HEAD. There's no plumbing command that
covers this case, so we do so by calling the git-diff
porcelain. This means we also inherit the usual list of
porcelain options, which can impact the output in confusing
ways.

There's at least one known problem: --name-only will not
mention the source side of a rename, meaning that we will
fail to stash a deletion in such a case.

The correct solution is to move to an appropriate plumbing
command. But since there isn't one available, in the short
term we can plug this particular problem by manually asking
git-diff not to respect renames.

Reported-by: Matthew Patey <matthew.patey2167@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
There may be other similar problems lurking depending on the various
config options you have set, but I don't think so. Most of the options
only affect --patch output.

I do find it interesting that --name-only does not mention the source
side of a rename. The longer forms like --name-status mention both
sides. Certainly --name-status does not have any way of saying "this is
the source side of a rename", but I'd think it would simply mention both
sides. Anyway, even if that were changed (which would fix this bug), I
think adding --no-renames is still a good thing to be doing here.

 git-stash.sh     | 2 +-
 t/t3903-stash.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4546abaae..40ab2710e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -115,7 +115,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff --name-only -z --no-renames HEAD -- >"$TMP-stagenames" &&
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

