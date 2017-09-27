Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4E02047F
	for <e@80x24.org>; Wed, 27 Sep 2017 22:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbdI0Wcm (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:32:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:52796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752128AbdI0Wcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:32:41 -0400
Received: (qmail 2558 invoked by uid 109); 27 Sep 2017 22:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 22:32:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20595 invoked by uid 111); 27 Sep 2017 22:33:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 18:33:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 18:32:39 -0400
Date:   Wed, 27 Sep 2017 18:32:39 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
Message-ID: <20170927223239.t6gvfztkdjn2vltb@sigill.intra.peff.net>
References: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
 <20170927215852.20163-1-sbeller@google.com>
 <20170927220925.u622metv2fcdtcfq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927220925.u622metv2fcdtcfq@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 06:09:25PM -0400, Jeff King wrote:

> > diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
> > index 9c48e5c2c9..514056dd10 100755
> > --- a/t/t4016-diff-quote.sh
> > +++ b/t/t4016-diff-quote.sh
> > @@ -30,6 +30,7 @@ test_expect_success setup '
> >  	git add . &&
> >  	git commit -m initial &&
> >  	git mv "$P0.0" "R$P0.0" &&
> > +	chmod a+x "R$P0.0" &&
> >  	git mv "$P0.1" "R$P1.0" &&
> >  	git mv "$P0.2" "R$P2.0" &&
> >  	git mv "$P0.3" "R$P3.0" &&
> 
> Won't this chmod be a problem for platforms without an executable bit?
> I think you'd need to use "update-index --chmod=+x" here, or require the
> FILEMODE prereq.
> 
> The whole script is marked as !MINGW, so that makes it less of a
> problem, but it's still possible have !FILEMODE on a Linux system, if
> you're on a funny filesystem. That also seems like a good reason to make
> sure this is in a script which is run more widely, since Windows folks
> would want to run this test, too.

The most appropriate place seems like t4013. I tried adding to its big
list of tested formats, but it's quite fragile. The patch below is what
I came up with, but it still needs updated to cover the cases which call
"log --all".

I think we'd do better to just do a set of new tests at the end (or even
a new test script for diffing mode changes in various formats).

-- >8 --
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index d09acfe48e..c515e3e53f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -90,6 +90,14 @@ test_expect_success setup '
 	git commit -m "Rearranged lines in dir/sub" &&
 	git checkout master &&
 
+	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
+	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+	git checkout -b mode initial &&
+	git update-index --chmod=+x file0 &&
+	git commit -m "update mode" &&
+	git checkout -f master &&
+
 	git config diff.renames false &&
 
 	git show-branch
@@ -192,6 +200,10 @@ diff-tree --pretty side
 diff-tree --pretty -p side
 diff-tree --pretty --patch-with-stat side
 
+diff-tree initial mode
+diff-tree --stat initial mode
+diff-tree --summary initial mode
+
 diff-tree master
 diff-tree -p master
 diff-tree -p -m master
diff --git a/t/t4013/diff.diff-tree_--stat_initial_mode b/t/t4013/diff.diff-tree_--stat_initial_mode
new file mode 100644
index 0000000000..0e5943c2c6
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--stat_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree --stat initial mode
+ file0 | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_--summary_initial_mode b/t/t4013/diff.diff-tree_--summary_initial_mode
new file mode 100644
index 0000000000..25846b6af8
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--summary_initial_mode
@@ -0,0 +1,3 @@
+$ git diff-tree --summary initial mode
+ mode change 100644 => 100755 file0
+$
diff --git a/t/t4013/diff.diff-tree_initial_mode b/t/t4013/diff.diff-tree_initial_mode
new file mode 100644
index 0000000000..c47c09423e
--- /dev/null
+++ b/t/t4013/diff.diff-tree_initial_mode
@@ -0,0 +1,3 @@
+$ git diff-tree initial mode
+:100644 100755 01e79c32a8c99c557f0757da7cb6d65b3414466d 01e79c32a8c99c557f0757da7cb6d65b3414466d M	file0
+$
