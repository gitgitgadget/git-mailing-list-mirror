Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B6C20C32
	for <e@80x24.org>; Fri,  8 Dec 2017 09:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbdLHJgT (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 04:36:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:51886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753141AbdLHJeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 04:34:36 -0500
Received: (qmail 30989 invoked by uid 109); 8 Dec 2017 09:34:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 09:34:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30337 invoked by uid 111); 8 Dec 2017 09:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 04:34:57 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 04:34:34 -0500
Date:   Fri, 8 Dec 2017 04:34:34 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
Message-ID: <20171208093434.GD26199@sigill.intra.peff.net>
References: <20171208002447.20261-1-sbeller@google.com>
 <20171208002447.20261-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208002447.20261-2-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 04:24:47PM -0800, Stefan Beller wrote:

> Sometimes users are given a hash of an object and they want to
> identify it further (ex.: Use verify-pack to find the largest blobs,
> but what are these? or [1])
> 
> One might be tempted to extend git-describe to also work with blobs,
> such that `git describe <blob-id>` gives a description as
> '<commit-ish>:<path>'.  This was implemented at [2]; as seen by the sheer
> number of responses (>110), it turns out this is tricky to get right.
> The hard part to get right is picking the correct 'commit-ish' as that
> could be the commit that (re-)introduced the blob or the blob that
> removed the blob; the blob could exist in different branches.

Neat. I didn't follow the original thread very closely, but I think this
is a good idea (and is definitely something I've simulated manually with
"git log --raw | grep" before).

Bear with me while I pontificate for a moment.

We do something similar at GitHub to report on too-large objects
during a push (we identify the object during index-pack, but then want
to hand back a human-readable pathname).

We do it with a patch to "rev-list", so that you can use the normal
traversal options to limit the set of visited commits. Which effectively
makes it "traverse and find a place where this object is referenced, and
then tell me the path at which you found it (or tell me if it was not
referenced at all)".

That sidesteps the "describe" problem, because now it is the user's
responsibility to tell you which commits to look in. :)

But the rev-list solution only finds _a_ commit that contains the
object, and which likely has nothing to do with the object at all. Your
solution here finds the introduction and removal of the object, which
are interesting for a wider variety of searches.

So I wondered if this could replace my rev-list patch (which I've been
meaning to upstream for a while). But I think the answer is "no", there
is room for both features. What you're finding here is much more
specific and useful data, but it's also much more expensive to generate.
For my uses cases, it was enough to ask "show me a plausible path
quickly" or even "is this object reachable" (which you can answer out of
bitmaps!).

> Junio hinted at a different approach of solving this problem, which this
> patch implements. Teach the diff machinery another flag for restricting
> the information to what is shown. For example:
> 
>   $ ./git log --oneline --blobfind=v2.0.0:Makefile
>   b2feb64309 Revert the whole "ask curl-config" topic for now
>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"
> 
> we observe that the Makefile as shipped with 2.0 was introduced in
> v1.9.2-471-g47fbfded53 and replaced in v2.0.0-rc1-5-gb2feb64309 by
> a different blob.

So I like this very much as an addition to Git's toolbox. But does it
really need to be limited to blobs? We should be able to ask for trees
(both root trees and sub-trees), too. That's going to be less common, I
think, but I have definitely done

  git log --raw -t --pretty=raw --no-abbrev |
  less +/$tree_sha1

to debug things (corrupted repos, funny merges, etc).

You could even do it for submodule commits. Which demonstrates that this
feature does not even need to actually have a resolvable object; you're
just looking for the textual sha1.

You do your filtering on the diff queue, which I think will have the
entries you need if "-t" is specified (and should always have submodule
commits, I think). So you'd just need to relax the incoming object
check, like:

diff --git a/diff.c b/diff.c
index e4571df3bf..0007bb0a09 100644
--- a/diff.c
+++ b/diff.c
@@ -4490,8 +4490,12 @@ static int parse_blobfind_opt(struct diff_options *opt, const char *arg)
 {
 	struct object_id oid;
 
-	if (get_oid_blob(arg, &oid) || sha1_object_info(oid.hash, NULL) != OBJ_BLOB)
-		return error("object '%s' is not a blob", arg);
+	/*
+	 * We don't even need to have the object, and 40-hex sha1s will
+	 * just resolve here.
+	 */
+	if (get_oid_blob(arg, &oid))
+		return error("unable to resolve '%s'", arg);
 
 	if (!opt->blobfind)
 		opt->blobfind = xcalloc(1, sizeof(*opt->blobfind));

At which point:

  ./git log --oneline -t --blobfind=v2.0.0:Documentation

just works (the results are kind of interesting, too; you see that tree
"go away" in a lot of different commits because many independent
branches touched the directory).

Also interesting:

  ./git log --oneline --blobfind=HEAD:sha1collisiondetection

Well, the output for this particular case isn't that interesting. But it
shows that we can find submodules, too.

-Peff
