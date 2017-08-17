Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8C0C208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdHQKWU (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 06:22:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:41524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750988AbdHQKWT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 06:22:19 -0400
Received: (qmail 7306 invoked by uid 109); 17 Aug 2017 10:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 10:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25846 invoked by uid 111); 17 Aug 2017 10:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 06:22:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 06:22:17 -0400
Date:   Thu, 17 Aug 2017 06:22:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717172709.GL93855@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 10:27:09AM -0700, Jonathan Nieder wrote:

> > --- a/t/t1402-check-ref-format.sh
> > +++ b/t/t1402-check-ref-format.sh
> > @@ -161,6 +161,10 @@ test_expect_success 'check-ref-format --branch from subdir' '
> >  	test "$refname" = "$sha1"
> >  '
> >  
> > +test_expect_success 'check-ref-format --branch from non-repo' '
> > +	test_must_fail nongit git check-ref-format --branch @{-1}
> > +'
> > +
> >  valid_ref_normalized() {
> >  	prereq=
> >  	case $1 in
> 
> I don't think it's right.  Today I can do
> 
> 	$ cd /tmp
> 	$ git check-ref-format --branch master
> 	master
> 
> You might wonder why I'd ever do such a thing.  But that's what "git
> check-ref-format --branch" is for --- it is for taking a <branch>
> argument and turning it into a branch name.  For example, if you have
> a script with an $opt_branch variable that defaults to "master", it
> may do
> 
> 	resolved_branch=$(git check-ref-format --branch "$opt_branch")
> 
> even though it is in a mode that not going to have to use
> $resolved_branch and it is not running from a repository.

I'm not sure I buy that. What does "turning it into a branch name" even
mean when you are not in a repository? Clearly @{-1} must fail. And
everything else is just going to output the exact input you provided.
So any script calling "check-ref-format --branch" outside of a repo
would be better off not calling it at all. At best it does nothing, and
at worst it's going to give a confusing error when $opt_branch is
something like "@{-1}".

A more compelling argument along these lines is something like:

  Accepting --branch outside of a repo is pointless, but it's something
  we've historically accepted. To avoid breaking existing scripts (even
  if they are doing something pointless), we'll continue to allow it.

I'm not sure I buy _that_ line of reasoning either, but it at least
makes sense to me (I just think it isn't worth the complexity of trying
to audit the innards of interpret_branch_name()).

-Peff
