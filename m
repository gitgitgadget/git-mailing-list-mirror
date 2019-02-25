Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F63720248
	for <e@80x24.org>; Mon, 25 Feb 2019 17:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfBYRcv (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 12:32:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:56986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728595AbfBYRcv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 12:32:51 -0500
Received: (qmail 14557 invoked by uid 109); 25 Feb 2019 17:32:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Feb 2019 17:32:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18812 invoked by uid 111); 25 Feb 2019 17:33:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Feb 2019 12:33:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2019 12:32:49 -0500
Date:   Mon, 25 Feb 2019 12:32:49 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew Booth <mbooth@redhat.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] line-log: suppress diff output with "-s"
Message-ID: <20190225173248.GB17524@sigill.intra.peff.net>
References: <CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com>
 <20190225171817.GA17524@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225171817.GA17524@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 12:18:17PM -0500, Jeff King wrote:

> > git log docs suggest it should not do this:
> > 
> >        -s, --no-patch
> >            Suppress diff output. Useful for commands like git show
> > that show the patch by default, or to cancel
> >            the effect of --patch.
> > 
> > Couldn't find anything in a search of the archives of this mailing
> > list, although that's obviously far from conclusive. Seems to be
> > longstanding, as it was mentioned on StackOverflow back in 2015:
> 
> I think the issue is just that "-L" follows a very different code path
> than the normal diff generator. Perhaps something like this helps?

Here it is with a test and a commit message (I don't think any doc
update is necessary; as you noted, the docs already imply this is what
should happen).

-- >8 --
Subject: [PATCH] line-log: suppress diff output with "-s"

When "-L" is in use, we ignore any diff output format that the user
provides to us, and just always print a patch (with extra context lines
covering the whole area of interest). It's not entirely clear what we
should do with all formats (e.g., should "--stat" show just the diffstat
of the touched lines, or the stat for the whole file?).

But "-s" is pretty clear: the user probably wants to see just the
commits that touched those lines, without any diff at all. Let's at
least make that work.

Signed-off-by: Jeff King <peff@peff.net>
---
This punts completely on the larger question of what should happen with
other formats like "--stat", "--raw", etc. They'll continue to be
ignored entirely and we'll generate the line-log patch. Possibly we
should detect and complain?

 line-log.c          | 3 ++-
 t/t4211-line-log.sh | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 24e21731c4..863f5cbe0f 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1106,7 +1106,8 @@ int line_log_print(struct rev_info *rev, struct commit *commit)
 	struct line_log_data *range = lookup_line_range(rev, commit);
 
 	show_log(rev);
-	dump_diff_hacky(rev, range);
+	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT))
+		dump_diff_hacky(rev, range);
 	return 1;
 }
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index bd5fe4d148..c9f2036f68 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -115,4 +115,11 @@ test_expect_success 'range_set_union' '
 	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
 '
 
+test_expect_success '-s shows only line-log commits' '
+	git log --format="commit %s" -L1,24:b.c >expect.raw &&
+	grep ^commit expect.raw >expect &&
+	git log --format="commit %s" -L1,24:b.c -s >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.21.0.672.g12e864cee7

