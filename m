Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641F51FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 14:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdJKOwS (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 10:52:18 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:19342 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdJKOwR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 10:52:17 -0400
Received: from [84.188.151.28] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e2IMn-0006Hc-Rt; Wed, 11 Oct 2017 16:52:13 +0200
Date:   Wed, 11 Oct 2017 16:52:12 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
Message-ID: <20171011145212.GA85076@book.hvoigt.net>
References: <20171006222544.GA26642@sandbox>
 <20171006223234.GC26642@sandbox>
 <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
 <20171010130335.GB75189@book.hvoigt.net>
 <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 11:39:21AM -0700, Stefan Beller wrote:
> So you propose to make git-add behave like "git submodule add"
> (i.e. also add the .gitmodules entry for name/path/URL), which I
> like from a submodule perspective.

Well more like: clone and add will behave like "git submodule add" but
basically yes.

> However other users of gitlinks might be confused[1], which is why
> I refrained from "making every gitlink into a submodule". Specifically
> the more powerful a submodule operation is (the more fluff adds),
> the harder it should be for people to mis-use it.
> 
> [1] https://github.com/git-series/git-series/blob/master/INTERNALS.md
>      "git-series uses gitlinks to store pointer to commits in its own repo."

But would those users use

    git add

to add a gitlink? From the description in that file I read that it
points to commits in its own repository. Will there also be files
checked out like submodules at that location?

Otherwise I would propose that 'git add' could detect whether a gitlink
is a submodule by trying to read its git configuration. If we do not
find that we simply do not do anything.

> > If everyone agrees that submodules are the default way of handling
> > repositories insided repositories, IMO, 'git add' should also alter
> > .gitmodules by default. We could provide a switch to avoid doing that.
> 
> I wonder if that switch should be default-on (i.e. not treat a gitlink as
> a submodule initially, behavior as-is, and then eventually we will
> die() on unconfigured repos, expecting the user to make the decision)
> 
> > An intermediate solution would be to warn
> 
> That is already implemented by Peff.

Ah ok, thanks I suspected so when I realized that this discussion was
older.

> > but in the long run my goal
> > for submodules is and always was: Make them behave as close to files as
> > possible. And why should a 'git add submodule' not magically do
> > everything it can to make submodules just work? I can look into a patch
> > for that if people agree here...
> 
> I'd love to see this implemented. I cc'd Josh (the author of git-series), who
> may disagree with this, or has some good input how to go forward without
> breaking git-series.

Yeah, lets see if, as described above, that actually would break
git-series.

> > Regarding handling of gitlinks with or without .gitmodules:
> >
> > Currently we are actually in some intermediate state:
> >
> >  * If there is no .gitmodules file: No submodule processing on any
> >    gitlinks (AFAIK)
> 
> AFAIK this is true.
> 
> >  * If there is a .gitmodules files with some submodule configured: Do
> >    recursive fetch and push as far as possible on gitlinks.
> 
> * If submodule.recurse is set, then we also treat submodules like files
>   for checkout, reset, read-tree.

To clarify: If submodule.recurse is set but there is no .gitmodules file
we do submodule processing for the above commands?

> > So I am not sure whether there are actually many users (knowingly)
> > using a mix of some submodules configured and some not and then relying
> > on the submodule infrastructure.
> >
> > I would rather expect two sorts of users:
> >
> >   1. Those that do use .gitmodules
> 
> Those want to reap all benefits of good submodules.
> 
> >
> >   2. Those that do *not* use .gitmodules
> 
> As said above, we don't know if those users are
> "holding submodules wrong" or are using gitlinks for
> magic tricks (unrelated to submodules).

I did not want to say that they are "holding submodules wrong" but
rather that if they do not use .gitmodules they do that knowingly and
thus consistently not use .gitmodules for any gitlink.

> > Users that do not use any .gitmodules file will currently (AFAIK) not
> > get any submodule handling. So the question is are there really many
> > "mixed users"? My guess would be no.
> 
> I hope that there are few (if any) users of these mixed setups.

That sounds promising.

> > Because without those using this mixed we could switch to saying: "You
> > need to have a .gitmodules file for submodule handling" without much
> > fallout from breaking users use cases.
> 
> That seems reasonable to me, actually.

Nice.

> > Maybe we can test this out somehow? My patch series would be ready in
> > that case, just had to drop the first patch and adjust the commit
> > message of this one.
> 
> I wonder how we would test this, though? Do you have any idea
> (even vague) how we'd accomplish such a measurement?
> I fear we'll have to go this way blindly.

One idea would be to expose this somewhere to a limited amount of users.
I remember Jonathan was suggesting, back when Jens was working on the
recursive checkout, that he could add the series to the debian package
and see what happens. Or we could use Junios next branch? Something like
that. If we get complaints we know the assumption was wrong and we need
a fallback.

Cheers Heiko
