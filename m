Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F112021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933520AbcKORGj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:06:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:43444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbcKORGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:06:37 -0500
Received: (qmail 26017 invoked by uid 109); 15 Nov 2016 17:06:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 17:06:36 +0000
Received: (qmail 11880 invoked by uid 111); 15 Nov 2016 17:07:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 12:07:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2016 12:06:34 -0500
Date:   Tue, 15 Nov 2016 12:06:34 -0500
From:   Jeff King <peff@peff.net>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: Protecting old temporary objects being reused from concurrent
 "git gc"?
Message-ID: <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
References: <1479219194.2406.73.camel@mattmccutchen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1479219194.2406.73.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 09:13:14AM -0500, Matt McCutchen wrote:

> I want to change this to something that won't leave an inconsistent
> state if interrupted.  I've written code for this kind of thing before
> that sets GIT_INDEX_FILE and uses a temporary index file and "git
> write-tree".  But I realized that if "git gc" runs concurrently, the
> generated tree could be deleted before it is used and the tool would
> fail.  If I had a need to run "git commit-tree", it seems like I might
> even end up with a commit object with a broken reference to a tree.
>  "git gc" normally doesn't delete objects that were created in the last
> 2 weeks, but if an identical tree was added to the object database more
> than 2 weeks ago by another operation and is unreferenced, it could be
> reused without updating its mtime and it could still get deleted.

Modern versions of git do two things to help with this:

 - any object which is referenced by a "recent" object (within the 2
   weeks) is also considered recent. So if you create a new commit
   object that points to a tree, even before you reference the commit
   that tree is protected

 - when an object write is optimized out because we already have the
   object, git will update the mtime on the file (loose object or
   packfile) to freshen it

This isn't perfect, though. You can decide to reference an existing
object just as it is being deleted. And the pruning process itself is
not atomic (and it's tricky to make it so, just because of what we're
promised by the filesystem).

> Is there a recommended way to avoid this kind of problem in add-on
> tools?  (I searched the Git documentation and the web for information
> about races with "git gc" and didn't find anything useful.)  If not, it
> seems to be a significant design flaw in "git gc", even if the problem
> is extremely rare in practice.  I wonder if some of the built-in
> commands may have the same problem, though I haven't tried to test
> them.  If this is confirmed to be a known problem affecting built-in
> commands, then at least I won't feel bad about introducing the
> same problem into add-on tools. :/

If you have long-running data (like, a temporary index file that might
literally sit around for days or weeks) I think that is a potential
problem. And the solution is probably to use refs in some way to point
to your objects. If you're worried about a short-term operation where
somebody happens to run git-gc concurrently, I agree it's a possible
problem, but I suspect something you can ignore in practice.

For the most part, a lot of the client-side git tools assume that one
operation is happening at a time in the repository. And I think that
largely holds for a developer working on a single clone, and things just
work in practice.

Auto-gc makes that a little sketchier, but historically does not seem to
have really caused problems in practice.

For a busy multi-user server, I recommend turning off auto-gc entirely,
and repacking manually with "-k" to be on the safe side.

-Peff
