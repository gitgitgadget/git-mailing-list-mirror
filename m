Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC2C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 10:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858A523A1E
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 10:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbhAIKer (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 05:34:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:50890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbhAIKer (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 05:34:47 -0500
Received: (qmail 7254 invoked by uid 109); 9 Jan 2021 10:34:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 09 Jan 2021 10:34:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8925 invoked by uid 111); 9 Jan 2021 10:34:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 09 Jan 2021 05:34:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 9 Jan 2021 05:34:05 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is t5516 somehow flakey only on macOS?
Message-ID: <X/mGnY3wR1fGoxcf@coredump.intra.peff.net>
References: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
 <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 09, 2021 at 04:11:09AM -0500, Eric Sunshine wrote:

> In a successful run, the content of `err` is:
> 
>     fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
>     fatal: remote error: upload-pack: not our ref
> 64ea4c133d59fa98e86a771eda009872d6ab2886
> 
> However, in the unsuccessful run from CI, it is:
> 
>     fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
>     fatal: unable to write to remote: Broken pipe
> 
> Perhaps this means something to someone familiar with this area of the code.

This is the same issue discussed in this sub-thread:

  https://lore.kernel.org/git/20190828153944.GA29715@sigill.intra.peff.net/

It's not macOS-specific, but for whatever reason it's much easier to
trigger there. There's a reliable reproduction with a sleep() in:

  https://lore.kernel.org/git/20190829220630.GH8571@szeder.dev/

The solution is something like the "after a write() error, pump the read
channel to see if we got an ERR packet" patch Gábor showed in the reply
to that message.

But an interesting thing to note: this particular race only happens with
protocol v0 (and the test is forcing v0, because v2 would not produce a
"not our ref" error in the first place). In general I'd suspect that v2
is a bit less susceptible to these types of races, because it has more
of a request/response flow. But it's still possible (e.g., if the server
side ever aborts before reading the whole request).

For this _particular_ test, since we know that it is testing a v0-only
behavior, we might want to just loosen the test. This goes against the
point of adding it in 014ade7484 (upload-pack: send ERR packet for
non-tip objects, 2019-04-13), but it's the best we can do for now.
Something like this:

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 01004ff680..8726d80250 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1260,7 +1260,20 @@ do
 			git cat-file commit $SHA1_2 &&
 			test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 				git fetch ../testrepo/.git $SHA1_3 2>err &&
-			test_i18ngrep "remote error:.*not our ref.*$SHA1_3\$" err
+			# ideally we would insist this be on a "remote error:"
+			# line to make sure an ERR packet was sent. But
+			# checking that is racy, because the client may see the
+			# pipe close while they are still writing their "done"
+			# line. So check only that it appears in stderr at all,
+			# which will generally pick up the copy that
+			# upload-pack sends to stderr. This is a hack, because
+			# in the real world the upload-pack stderr would often
+			# not be shown to the client at all (e.g., over git://
+			# or over an ssh channel to a non-vanilla server). So
+			# this is papering over a real racy bug that users
+			# might see in the wild, but this is the best we can do
+			# for now to make our tests robust.
+			test_i18ngrep "not our ref.*$SHA1_3\$" err
 		)
 	'
 done

-Peff
