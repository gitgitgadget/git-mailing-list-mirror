Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8595B2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdKUXRm (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:17:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:36970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751290AbdKUXRl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:17:41 -0500
Received: (qmail 5661 invoked by uid 109); 21 Nov 2017 23:17:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Nov 2017 23:17:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28708 invoked by uid 111); 21 Nov 2017 23:17:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 21 Nov 2017 18:17:57 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Nov 2017 18:17:39 -0500
Date:   Tue, 21 Nov 2017 18:17:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
Message-ID: <20171121231739.GB21197@sigill>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
 <xmqqwp2ki4x8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp2ki4x8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 02:20:19PM +0900, Junio C Hamano wrote:

> After queuing this series to an earlier part of 'pu' and resolving a
> conflict with jh/fsck-promisors topic, I ended up with a code that
> rejects 0{40} a lot earlier, before we try to see if a pack entry
> for 0{40} exists, even though the patch that is queued on this topic
> is more conservative (i.e. the above one).
> 
> Perhaps we would want to use the alternate version that declares the
> 0{40} is a sentinel that signals that there is no such object in
> this topic---that would give us a consistent semantics without
> having to adjust jh/fsck-promisors when it becomes ready to be
> merged.

I think we could adjust the patches without too much effort. That said,
I am very on-the-fence about whether to just declare the null sha1 as
"not a real object" and automatically return from the lookup without
doing any work. But if you agree that it's not likely to hurt anything,
it's IMHO a lot easier to reason about.

Here's a re-roll of patch 5 that behaves this way (the patch should be
unsurprising, but I've updated the commit message to match).

I did notice one other thing: the function looks up replace objects, so
we have both the original and the replaced sha1 available. My earlier
patch used the original sha1, but this one uses the replaced value.
I'm not sure if that's sane or not. It lets the fast-path kick in if you
point a replace ref at 0{40}. And it lets you point refs/replace/0{40}
to something else. I doubt that's useful, but it could perhaps be for
debugging, etc.

In most cases, of course, it wouldn't matter (since pointing to or from
the null sha1 is vaguely crazy in the first place).

-- >8 --
Subject: [PATCH v2 5/5] sha1_file: fast-path null sha1 as a missing object

In theory nobody should ever ask the low-level object code
for a null sha1. It's used as a sentinel for "no such
object" in lots of places, so leaking through to this level
is a sign that the higher-level code is not being careful
about its error-checking.  In practice, though, quite a few
code paths seem to rely on the null sha1 lookup failing as a
way to quietly propagate non-existence (e.g., by feeding it
to lookup_commit_reference_gently(), which then returns
NULL).

When this happens, we do two inefficient things:

  1. We actually search for the null sha1 in packs and in
     the loose object directory.

  2. When we fail to find it, we re-scan the pack directory
     in case a simultaneous repack happened to move it from
     loose to packed. This can be very expensive if you have
     a large number of packs.

Only the second one actually causes noticeable performance
problems, so we could treat them independently. But for the
sake of simplicity (both of code and of reasoning about it),
it makes sense to just declare that the null sha1 cannot be
a real on-disk object, and looking it up will always return
"no such object".

There's no real loss of functionality to do so Its use as a
sentinel value means that anybody who is unlucky enough to
hit the 2^-160th chance of generating an object with that
sha1 is already going to find the object largely unusable.

In an ideal world, we'd simply fix all of the callers to
notice the null sha1 and avoid passing it to us. But a
simple experiment to catch this with a BUG() shows that
there are a large number of code paths that do so.

So in the meantime, let's fix the performance problem by
taking a fast exit from the object lookup when we see a null
sha1. p5551 shows off the improvement (when a fetched ref is
new, the "old" sha1 is 0{40}, which ends up being passed for
fast-forward checks, the status table abbreviations, etc):

  Test            HEAD^             HEAD
  --------------------------------------------------------
  5551.4: fetch   5.51(5.03+0.48)   0.17(0.10+0.06) -96.9%

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 8a7c6b7eba..ae4b71f445 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1152,6 +1152,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 				    lookup_replace_object(sha1) :
 				    sha1;
 
+	if (is_null_sha1(real))
+		return -1;
+
 	if (!oi)
 		oi = &blank_oi;
 
-- 
2.15.0.578.g35b419775f

