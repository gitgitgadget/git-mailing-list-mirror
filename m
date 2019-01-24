Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220A61F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfAXURL (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:17:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:47792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729275AbfAXTX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:23:27 -0500
Received: (qmail 10455 invoked by uid 109); 24 Jan 2019 19:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 19:23:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31484 invoked by uid 111); 24 Jan 2019 19:23:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 14:23:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 14:23:25 -0500
Date:   Thu, 24 Jan 2019 14:23:25 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Subject: Re: [PATCH 5/6] combine-diff: treat --summary like --stat
Message-ID: <20190124192324.GB31073@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
 <20190124123539.GE11354@sigill.intra.peff.net>
 <CAGZ79kY-xMDDgLgkWdc9CoZucd4S557NEPQdvPrd2+_LJAretA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY-xMDDgLgkWdc9CoZucd4S557NEPQdvPrd2+_LJAretA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 11:14:15AM -0800, Stefan Beller wrote:

> On Thu, Jan 24, 2019 at 4:35 AM Jeff King <peff@peff.net> wrote:
> 
> > Note that we have to tweak t4013's setup a bit to test this case, as the
> > existing merges do not have any --summary results against their first
> > parent. But since the merge at the tip of 'master' does add and remove
> > files with respect to the second parent, we can just make a reversed
> > doppelganger merge where the parents are swapped.
> 
> ...
> 
> > +       # Same merge as master, but with parents reversed. Hide it in a
> > +       # pseudo-ref to avoid impacting tests with --all.
> 
> There are 2 calls with --all, which may be worth testing for as well
> assuming we still have similar bugs as shown in the second patch,
> but I guess this would also allow for other tests (how do we list all
> pseudo refs for example?) to cover more corner cases.
> 
> I am not sure I like this.

The --all tests aren't actually very thorough. In fact, they don't
generate diffs at all, making it especially silly that they are in
t4013-diff-various. They are only looking at --decorate.

It also would not be the end of the world to modify the expected output
for those tests. You can see the extend of the damage by applying the
patch below on top and running t4013 with "-v".

---
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9f8f0e84ad..742c3cdbcb 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -98,11 +98,10 @@ test_expect_success setup '
 	git commit -m "update mode" &&
 	git checkout -f master &&
 
-	# Same merge as master, but with parents reversed. Hide it in a
-	# pseudo-ref to avoid impacting tests with --all.
+	# Same merge as master, but with parents reversed.
 	commit=$(echo reverse |
 		 git commit-tree -p master^2 -p master^1 master^{tree}) &&
-	git update-ref REVERSE $commit &&
+	git update-ref refs/heads/reverse $commit &&
 
 	git config diff.renames false &&
 
@@ -246,7 +245,7 @@ diff-tree --cc --stat --summary master
 diff-tree -c --stat --summary side
 diff-tree --cc --stat --summary side
 diff-tree --cc --shortstat master
-diff-tree --cc --summary REVERSE
+diff-tree --cc --summary reverse
 # improved by Timo's patch
 diff-tree --cc --patch-with-stat master
 # improved by Timo's patch
diff --git a/t/t4013/diff.diff-tree_--cc_--summary_REVERSE b/t/t4013/diff.diff-tree_--cc_--summary_reverse
similarity index 75%
rename from t/t4013/diff.diff-tree_--cc_--summary_REVERSE
rename to t/t4013/diff.diff-tree_--cc_--summary_reverse
index e208dd5682..35da01cf46 100644
--- a/t/t4013/diff.diff-tree_--cc_--summary_REVERSE
+++ b/t/t4013/diff.diff-tree_--cc_--summary_reverse
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --summary REVERSE
+$ git diff-tree --cc --summary reverse
 2562325a7ee916efb2481da93073b82cec801cbc
  create mode 100644 file1
  delete mode 100644 file2
