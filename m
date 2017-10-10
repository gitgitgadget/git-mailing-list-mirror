Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379D22036B
	for <e@80x24.org>; Tue, 10 Oct 2017 13:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdJJNDl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 09:03:41 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.98]:31479 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbdJJNDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 09:03:40 -0400
Received: from [84.141.117.173] (helo=book.hvoigt.net)
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e1uC9-00019C-3J; Tue, 10 Oct 2017 15:03:37 +0200
Date:   Tue, 10 Oct 2017 15:03:35 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
Message-ID: <20171010130335.GB75189@book.hvoigt.net>
References: <20171006222544.GA26642@sandbox>
 <20171006223234.GC26642@sandbox>
 <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Oct 09, 2017 at 11:20:51AM -0700, Stefan Beller wrote:
> On Fri, Oct 6, 2017 at 3:32 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > NOTE: The argument in this message is not correct, see description in
> > cover letter.
> >
> > The setup of the repositories in this test is using gitlinks without the
> > .gitmodules infrastructure. It is however testing convenience features
> > like --recurse-submodules=on-demand. These features are already not
> > supported by fetch without a .gitmodules file. This leads us to the
> > conclusion that it is not really used here as well.
> >
> > Let's use the usual submodule commands to setup the repository in a
> > typical way. This also has the advantage that we are testing with a
> > repository structure that is more similar to one we could expect on a
> > users setup.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> >
> > As mentioned in the cover letter. This seems to be the only test that
> > ensures that we stay compatible with setups without .gitmodules. Maybe
> > we should add/revive some?
> 
> An interesting discussion covering this topic is found at
> https://public-inbox.org/git/20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net/

Thanks for that pointer. So in that discussion Junio said that the
recursive operations should succeed if we have everything necessary at
hand. I kind of agree because why should we limit usage when not
necessary. On the other hand we want git to be easy to use. And that
example from Peff is perfect as a demonstration of a incosistency we
currently have:

git clone git://some.where.git/submodule.git
git add submodule

is an operation I remember, I did, when first getting in contact with
submodules (many years back), since that is one intuitive way. And the
thing is: It works, kind of... Only later I discovered that one actually
needs to us a special submodule command to get everything approriately
setup to work together with others.

If everyone agrees that submodules are the default way of handling
repositories insided repositories, IMO, 'git add' should also alter
.gitmodules by default. We could provide a switch to avoid doing that.

An intermediate solution would be to warn but in the long run my goal
for submodules is and always was: Make them behave as close to files as
possible. And why should a 'git add submodule' not magically do
everything it can to make submodules just work? I can look into a patch
for that if people agree here...

Regarding handling of gitlinks with or without .gitmodules:

Currently we are actually in some intermediate state:

 * If there is no .gitmodules file: No submodule processing on any
   gitlinks (AFAIK)
 * If there is a .gitmodules files with some submodule configured: Do
   recursive fetch and push as far as possible on gitlinks.

So I am not sure whether there are actually many users (knowingly)
using a mix of some submodules configured and some not and then relying
on the submodule infrastructure.

I would rather expect two sorts of users:

  1. Those that do use .gitmodules

  2. Those that do *not* use .gitmodules

Users that do not use any .gitmodules file will currently (AFAIK) not
get any submodule handling. So the question is are there really many
"mixed users"? My guess would be no.
Because without those using this mixed we could switch to saying: "You
need to have a .gitmodules file for submodule handling" without much
fallout from breaking users use cases.

Maybe we can test this out somehow? My patch series would be ready in
that case, just had to drop the first patch and adjust the commit
message of this one.

Cheers Heiko
