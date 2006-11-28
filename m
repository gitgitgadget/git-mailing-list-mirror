X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 16:02:11 -0500
Message-ID: <20061128210211.GI28337@spearce.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281029.11918.andyparkins@gmail.com> <ekh45n$rfc$1@sea.gmane.org> <200611281335.38728.andyparkins@gmail.com> <456C94E2.6010708@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 21:02:41 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <456C94E2.6010708@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32577>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpA5s-0004Hp-6q for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755518AbWK1VCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbWK1VCQ
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:02:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:24769 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1755518AbWK1VCP
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:02:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GpA5c-0001Mg-HL; Tue, 28 Nov 2006 16:02:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8BB3B20FB7F; Tue, 28 Nov 2006 16:02:11 -0500 (EST)
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> wrote:
> Andy Parkins wrote:
> >Unfortunately, during development, you've switched libsubmodule1 to 
> >branch "development", but supermodule isn't tracking libsubmodule1/HEAD 
> >it's tracking libsubmodule1/master.  Your supermodule commit doesn't 
> >capture a snapshot of the tree you're using.
> >  
>
> Or maybe not a merge, but worse, you'd *replace* the 
> previously committed master with what's in your dev branch.

Right, you would be replacing the prior branch of that submodule with
the new submodule branch.

I think the safety valve you are looking for here is two things:

  * don't automatically update the submodule's HEAD into the
    supermodule's index.

  * make sure the submodule's HEAD is a fast-forward of the
    supermodule's index, with a --force option to force it
	anyway.

Otherwise the developer just has to know what he/she is doing.
Today you can put stuff that isn't ready for prime-time into a
repository on the wrong branch just by applying the wrong patch,
or cherry-picking the wrong commit, etc...  the user can (and
will) make mistakes.  But they can also easily recover from them
by rewinding history and redoing it.

> On a related note, it would be great from a usability point of view if 
> there were a way to say "I always want to be on the same branch in all 
> submodules and the supermodule."

That's not really an issue.

A branch doesn't exist just because you checked-out the branch, or
because you created it.  A branch exists because there were two or
more commits (B and C) which use the same parent (A) and two or more
of those commits survive, e.g. they have refs which point to them
(directly or indirectly) or they were merged into another commit
which itself survives.

Therefore if the supermodule is on the "development branch" the
submodules are also immediately on the same branch, because their
HEADs are derived from whatever is stored in the supermodule's tree.
And that tree is derived from whatever "development branch" means.

Really what you want/need is a special head in the submodule
which acts as the "branch that corresponds to the supermodule".
This probably should just be a naked SHA1 stored in HEAD, which
is committable only because a supermodule exists in a higher level
directory.

The fact that the submodule project has branches *at all* is
totally irrelevant once you start to speak about that submodule
within the supermodule, as its the supermodule which determines
the branch of the submodule.

> But I think the Perforce-style 
> "compose a single workspace out of different bits of a larger project" 
> model is hugely useful

That's a mess.

You start to get into weird cases where the directory structure
expected by the build process is no longer intact, because the user
has sliced it apart in weird ways.  And there's no single version
which corresponds to that workspace as (if I recall correctly)
you can pick different tags or branches at will.  I believe that
ClearCase has the same bug.

You also can't version that now spliced workspace, aside from taking
the configuration file and putting that under version control too.

However I think the proposal on the table will support that to some
degree, in that you can take any version of any repository and embed
it at any directory of any other repository.  This means you can
for example embed the Linux kernel, glibc and gcc projects into
a larger "embedded device" repository, but you cannot alter the
structure of any of those three projects without making your own
locally developed branch of them.  Which is actually the correct
thing to do as any subslicing of a repository is exactly that:
a locally developed branch of that repository.

-- 
