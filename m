Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C44C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 04:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbhKZENy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 23:13:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:38244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346389AbhKZELy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 23:11:54 -0500
Received: (qmail 9646 invoked by uid 109); 26 Nov 2021 04:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Nov 2021 04:08:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31990 invoked by uid 111); 26 Nov 2021 04:08:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Nov 2021 23:08:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Nov 2021 23:08:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: t4216-log-bloom.sh fails with -v (but not --verbose-log)
Message-ID: <YaBdxL3QH1/GrWY1@coredump.intra.peff.net>
References: <64ffddd791160895b8e6730ebcddfac8458653f2.1621362768.git.gitgitgadget@gmail.com>
 <211125.86pmqoifp8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211125.86pmqoifp8.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 25, 2021 at 01:14:45PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I haven't looked much into $subject, but there's an interesting
> regression in 2ca245f8be5 (csum-file.h: increase hashfile buffer size,
> 2021-05-18) where it fails with -v, but not --verbose-log. Discovered
> while running it manually.
> 
> This is a regression in v2.33.0 (not v2.34.0!), so nothing urgent, and
> this is pretty obscure anyway.
> 
> For the original change see:
> https://lore.kernel.org/git/64ffddd791160895b8e6730ebcddfac8458653f2.1621362768.git.gitgitgadget@gmail.com/

Interesting. This patch makes it go away (the "5" is cargo-culted from
earlier in the script):

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 50f206db55..2f3a1cd210 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -231,6 +231,7 @@ test_expect_success 'correctly report changes over limit' '
 
 		# Commit has 7 file and 4 directory adds
 		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
+			GIT_TRACE2_EVENT_NESTING=5 \
 			GIT_TRACE2_EVENT="$(pwd)/trace" \
 			git commit-graph write --reachable --changed-paths &&
 		test_max_changed_paths 10 trace &&
@@ -263,6 +264,7 @@ test_expect_success 'correctly report changes over limit' '
 		# start from scratch and rebuild
 		rm -f .git/objects/info/commit-graph &&
 		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
+			GIT_TRACE2_EVENT_NESTING=5 \
 			GIT_TRACE2_EVENT="$(pwd)/trace-edit" \
 			git commit-graph write --reachable --changed-paths &&
 		test_max_changed_paths 10 trace-edit &&
@@ -280,6 +282,7 @@ test_expect_success 'correctly report changes over limit' '
 		# start from scratch and rebuild
 		rm -f .git/objects/info/commit-graph &&
 		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=11 \
+			GIT_TRACE2_EVENT_NESTING=5 \
 			GIT_TRACE2_EVENT="$(pwd)/trace-update" \
 			git commit-graph write --reachable --changed-paths &&
 		test_max_changed_paths 11 trace-update &&

The commit in question (2ca245f8be) puts the writing into a new trace2
region ("chunkfile"), so it makes sense that the nesting increases by
one. But what's interesting is that the nesting is different depending
on whether stderr is a terminal. I guess because the progress code
starts its own region.

The default nesting max for trace2 is 2. That seems kind of low given
this example, but I don't know enough about the tradeoffs to say what
bad things might happen if it's raised. But the above patch really seems
like a hack, and that this quiet omission would absolutely confuse real
users who are trying to use trace2 for debugging.

-Peff
