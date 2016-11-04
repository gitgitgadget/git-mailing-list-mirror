Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BA02022D
	for <e@80x24.org>; Fri,  4 Nov 2016 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757327AbcKDVGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 17:06:22 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57415 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755515AbcKDVGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 17:06:21 -0400
Received: from mfilter41-d.gandi.net (mfilter41-d.gandi.net [217.70.178.173])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 55EA81720B2;
        Fri,  4 Nov 2016 22:06:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter41-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter41-d.gandi.net (mfilter41-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id RyfFnju5x3GC; Fri,  4 Nov 2016 22:06:17 +0100 (CET)
X-Originating-IP: 198.233.217.214
Received: from x (unknown [198.233.217.214])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7E31F17209C;
        Fri,  4 Nov 2016 22:06:16 +0100 (CET)
Date:   Fri, 4 Nov 2016 15:06:13 -0600
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161104210613.5ax523wrc5robs7l@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 10:57:09AM -0700, Junio C Hamano wrote:
> After your talk at LPC2016, I was thinking about your proposal to
> give an option to hide certain parents from "git log" traversal.
> 
> While I do not think we would terribly mind a new feature in the
> core to support third-party additions like "git series" better, I
> think this particular one is a big mistake that we shouldn't take.
[...]
> I think this is backwards.  The root cause of the issue you have
> with "gitk" is because you added something that is *NOT* a parent to
> your commit.  We shouldn't have to add a mechanism to filter
> something that shouldn't have been added there in the first place.
> 
> I am wondering if an alternative approach would work better.
> 
> Imagine we invent a new tree entry type, "gitref", that is similar
> to "gitlink" in that it can record a commit object name in a tree,
> but unlike "gitlink" it does imply reachability.  And you do not add
> phony parents to your commit object.  A tree that has "gitref"s in
> it is about annotating the commits in the same repository (e.g. the
> tree references two commits, "base" and "tip", to point into a slice
> of the main history).  And it is perfectly sensible for such a
> pointer to imply reachability---after all it serves different
> purposes from "gitlink".

I absolutely agree with this, and I'd love to have gitref or similar in
core git.  Given the availability of that mechanism, I'd love to use it
in git-series.  (And in git submodule, as well, for other projects.)

The one critical issue there, though: that would break backward
compatibility with old versions of git.  No old version of git could
push, pull, gc, repack, or otherwise touch a repository that used this
feature.

The advantages of the approach (viewing and manipulating the series with
pure git) seem sufficiently high to make that worth considering, but it
is a significant downside.

> Another alternative that I am negative about (but is probably a
> better hack than how you abused the "parent" link) might be to add a
> new commit object header field that behaves similarly to "parent"
> only in that it implies reachability.  But recording the extra
> parent in commit object was not something you wanted to do in the
> first place (i.e. your series processing is done solely on the
> contents of the tree, and you do not read this extra parent). If you
> need to add an in-tree reference to another commit in your future
> versions of "git series", with either this variant or your original
> implementation, you would end up needing adding more "parent" (or
> pseudo parent) only to preserve reachability.  At that point, I
> think it makes more sense to have entries in the tree to directly
> ensure reachability, if you want these entries to always point at an
> in-tree object.

This would similarly break compatibility with old git, as old git
wouldn't follow those reachability-only links from commits, so it could
throw away the data.

One approach compatible with old git would be to continue adding the
relevant commits as artificial parents, but have a separate commit
metadata field that says which parents to ignore; old git would then do
the right thing, as long as it doesn't rewrite the commit entirely.

That does have the same disadvantages of having to duplicate the
information in both the tree and the parent list, though; it's the same
class of hack, just with improved usability.  I'd much rather use
gitrefs.

> I am afraid that I probably am two steps ahead of myself, because I
> am reasonably sure that it is quite possible that I have overlooked
> something trivially obvious that makes the "gitref" approach
> unworkable.

gitref seems like a good idea to me, as long as we can sort out the
compatibility story.
