Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D331FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756537AbcLPVn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:43:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:57795 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755661AbcLPVn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:43:26 -0500
Received: (qmail 10833 invoked by uid 109); 16 Dec 2016 21:43:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 21:43:25 +0000
Received: (qmail 14920 invoked by uid 111); 16 Dec 2016 21:44:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 16:44:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 16:43:22 -0500
Date:   Fri, 16 Dec 2016 16:43:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
Message-ID: <20161216214322.xibllaw2iibhc5nv@sigill.intra.peff.net>
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
 <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
 <20161216013728.in2dazshtarrnnq3@sigill.intra.peff.net>
 <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
 <xmqqd1gru5fw.fsf@gitster.mtv.corp.google.com>
 <xmqq7f6zu55k.fsf@gitster.mtv.corp.google.com>
 <xmqq37hnu50y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37hnu50y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 10:01:49AM -0800, Junio C Hamano wrote:

> >> I think 2/3 is a good change to ensure we get a reasonable error for
> >> "index-pack --stdin", and 3/3 is a very good cleanup.  Both of them
> >> of course are enabled by 1/3.
> >>
> >> We still fail "nongit git index-pack tmp.pack" with a BUG: though.
> >
> > Wait.  
> >
> > This only happens with a stalled-and-to-be-discarded topic on 'pu'.
> > Please don't waste time digging it (yet).
> 
> Don't wait ;-).  My mistake.  We can see t5300 broken with this
> change and b1ef400eec ("setup_git_env: avoid blind fall-back to
> ".git"", 2016-10-20) without anything else.  We still need to
> address it.

Ah, I only checked that it did not do anything terrible like write into
".git". But it looks like it still looks at the git_dir value as part of
the collision check.

Here's a patch, on top of the rest of the series.

-- >8 --
Subject: [PATCH] index-pack: skip collision check when not in repository

You can run "git index-pack path/to/foo.pack" outside of a
repository to generate an index file, or just to verify the
contents. There's no point in doing a collision check, since
we obviously do not have any objects to collide with.

The current code will blindly look in .git/objects based on
the result of setup_git_env(). That effectively gives us the
right answer (since we won't find any objects), but it's a
waste of time, and it conflicts with our desire to
eventually get rid of the "fallback to .git" behavior of
setup_git_env().

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't do a test, as this doesn't really have any user-visible
behavior change. I guess technically if you had a non-repo with
".git/objects/12/3456..." in it we would erroneously read it, but that's
kind of bizarre. The interesting test is that when merged with
jk/no-looking-at-dotgit-outside-repo-final, the test in t5300 doesn't
die.

 builtin/index-pack.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d450a6ada2..f4b87c6c9f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -787,13 +787,15 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			const unsigned char *sha1)
 {
 	void *new_data = NULL;
-	int collision_test_needed;
+	int collision_test_needed = 0;
 
 	assert(data || obj_entry);
 
-	read_lock();
-	collision_test_needed = has_sha1_file_with_flags(sha1, HAS_SHA1_QUICK);
-	read_unlock();
+	if (startup_info->have_repository) {
+		read_lock();
+		collision_test_needed = has_sha1_file_with_flags(sha1, HAS_SHA1_QUICK);
+		read_unlock();
+	}
 
 	if (collision_test_needed && !data) {
 		read_lock();
-- 
2.11.0.348.g960a0b554

