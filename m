Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A811F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfEPBqW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:22 -0400
Received: from thyrsus.com ([71.162.243.5]:59568 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfEPA2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:28:32 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id A3CB84703049; Wed, 15 May 2019 20:28:31 -0400 (EDT)
Date:   Wed, 15 May 2019 20:28:31 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190516002831.GC124956@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com>:
> What problem are you trying to solve where commit date is important?

I don't know what Jason's are.  I know what mine are.

A. Portable commit identifiers

1. When I in-migrate a repository from (say) Subversion with
reposurgeon, I want to be able to patch change comments so that (say)
r2367 becomes a unique reference to its corresponding commit. I do
not want the kludge of appending a relic SVN-ID header to be *required*,
though some customers may choose that. Requirung that is an orthogonality
violation.

2. Because I think in decadal timescales about infrastructure, I want
my commit references to be in a format that won't break when the history
is forward-migrated to the *next* VCS. That pretty much eliminates any
from of opaque hash. (Git itself will have a weaker version of this problem
when you change hash formats.)

3. Accordingly, I invented action stamps. This is an action stamp:
<esr@thyrsus.com!2019-05-15T20:01:15Z>. One reason I want timestamp
uniqueness is for action-stamp uniqueness.

B. Unique canonical form of import-stream representation.

Reposurgeon is a very complex piece of software with subtle failure
modes.  I have a strong need to be able to regression-test its
operation.  Right now there are important cases in which I can't do
that because (a) the order in which it writes commits and (b) how it
colors branches, are both phase-of-moon dependent.  That is, the
algorithms may be deterministic but they're not documented and seem to
be dependent on variables that are hidden from me.

Before import streams can have a canonical output order without hidden
variables (e.g. depending only on visible metadata) in practice, that
needs to be possible in principle. I've thought about this a lot and
not only are unique commit timestamps the most natural way to make
it possible, they're the only way conistent with the reality that
commit comments may be altered for various good reasons during
repository translation.

> P.S. All of my (overly strong) opinions on using commit date are made
> more valid when you realize anyone can set GIT_COMMITTER_DATE to get
> an arbitrary commit date.

In the way I would write things, you can *request* that date, but in
case of a collision you might actually get one a few microseconds off
that preserves its order relationship with your other commits.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


