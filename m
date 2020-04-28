Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C8C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 03:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160A7206D9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 03:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1Dek (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:34:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:41766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726047AbgD1Dek (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 23:34:40 -0400
Received: (qmail 17739 invoked by uid 109); 28 Apr 2020 03:34:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 03:34:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30541 invoked by uid 111); 28 Apr 2020 03:46:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 23:46:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 23:34:38 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as
 read-only
Message-ID: <20200428033438.GA2369457@coredump.intra.peff.net>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
 <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
 <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
 <20200427235935.GA14984@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200427235935.GA14984@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 05:59:35PM -0600, Taylor Blau wrote:

> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > index fb0aae61c3..901eb3ecfb 100755
> > --- a/t/t5318-commit-graph.sh
> > +++ b/t/t5318-commit-graph.sh
> > @@ -12,6 +12,10 @@ test_expect_success 'setup full repo' '
> >  	test_oid_init
> >  '
> >
> > +test_expect_success POSIXPERM 'tweak umask for modebit tests' '
> > +	umask 022
> > +'
> > +
> >  test_expect_success 'verify graph with no graph file' '
> >  	cd "$TRASH_DIRECTORY/full" &&
> >  	git commit-graph verify
> 
> Looks good to me; this is definitely necessary. For what it's worth, it
> passes for me, but my system may not have as restrictive a umask as
> others.

If we're just doing this for a single test, perhaps it would be better
to set the umask in that test (perhaps even in a subshell to avoid
touching other tests). I guess that's a little awkward here because the
write and the mode-check happen in separate snippets.

Or going in the opposite direction: if we think that covering the rest
of the test suite with a diversity of umasks isn't worthwhile, we could
just set "umask" in test-lib.sh. That would solve this problem and any
future ones.

I also wondered if it would be simpler to just limit the scope of the
test, like so:

diff --git b/t/t5318-commit-graph.sh a/t/t5318-commit-graph.sh
index fb0aae61c3..5f1c746ad1 100755
--- b/t/t5318-commit-graph.sh
+++ a/t/t5318-commit-graph.sh
@@ -98,9 +98,10 @@ test_expect_success 'write graph' '
 
 test_expect_success POSIXPERM 'write graph has correct permissions' '
 	test_path_is_file $objdir/info/commit-graph &&
-	echo "-r--r--r--" >expect &&
 	test_modebits $objdir/info/commit-graph >actual &&
-	test_cmp expect actual
+	# check only user mode bits, as we do not want to rely on
+	# test environment umask
+	grep ^-r-- actual
 '
 
 graph_git_behavior 'graph exists' full commits/3 commits/1

but maybe there's some value in checking the whole thing.

-Peff
