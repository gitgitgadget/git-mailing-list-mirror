Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8A1208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdHRWR7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:17:59 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:39248 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752573AbdHRWR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:17:58 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dipaU-0000HX-KX; Sat, 19 Aug 2017 07:17:54 +0900
Date:   Sat, 19 Aug 2017 07:17:54 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Revision resolution for remote-helpers?
Message-ID: <20170818221754.3rbh35aewj5xnu4z@glandium.org>
References: <20170818064208.plkppke7efpucuwm@glandium.org>
 <20170818220637.GN13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818220637.GN13924@aiede.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 03:06:37PM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Mike Hommey wrote:
> 
> > My thought is that a string like <helper>::<revision> could be used
> > wherever a committish is expected. That would call some helper
> > and request to resolve revision, and the helper would provide a git
> > commit as a response.
> 
> I like this idea.
> 
> > The reason for the <helper>:: prefix is that it matches the <helper>::
> > prefix used for remote helpers.
> >
> > Now, there are a few caveats:
> > - <revision>, for e.g. svn, pretty much would depend on the remote.
> >   OTOH, in mercurial, it doesn't. I think it would be fair for the
> >   helper to have to deal with making what appears after :: relevant
> >   to find the right revision, by possibly including a remote name.
> > - msys likes to completely fuck up command lines when they contain ::.
> >   For remote helpers, the alternative that works is
> >   <helper>://<host>/etc.
> 
> Hm --- is there a bug already open about this (e.g. in the Git for
> Windows project or in msys) where I can read more?

It's entirely an msys problem. Msys has weird rules to translate between
unix paths and windows paths on the command line, and botches everything
as a consequence. That's by "design".

http://www.mingw.org/wiki/Posix_path_conversion

(Particularly, see the last two entries)

That only happens when calling native Windows programs from a msys
shell.

> > Which leads me to think some "virtual" ref namespace could be a solution
> > to the problem. So instead of <helper>::, the prefix would be <helper>/.
> > For e.g. svn, svn/$remote/$rev would be a natural way to specify the
> > revision for a given remote. For mercurial, hg/$sha1.
> 
> I see.  My naive assumption would be that a string like r12345 would be
> the most natural way for a user to want to specify a Subversion
> revision, but you're right that those only have meaning scoped to a
> particular server.  That makes the svn/ prefix more tolerable.
> 
> > Potentially, this could be a sort of pluggable ref stores, which could
> > be used for extensions such as the currently discussed reftable.
> >
> > On the opposite end of the problem, I'm also thinking about git log
> > --decorate=<helper> displaying the mercurial revisions where branch
> > decorations would normally go.
> >
> > I have no patch to show for it. Those are ideas that I first want to
> > discuss before implementing anything.
> 
> One additional thought: unlike refs, these are not necessarily
> enumerable (and I wouldn't expect "git show-ref" to show them) and
> they do not affect "git prune"'s reachability computation.
> 
> So internally I don't think refs is the right concept to map these to.
> I think the right layer is revision syntax handling (revision.c).

Makes sense.

Mike
