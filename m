Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F4F1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391634AbeIVFac (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:30:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:55728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725756AbeIVFab (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:30:31 -0400
Received: (qmail 8100 invoked by uid 109); 21 Sep 2018 23:39:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 23:39:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9889 invoked by uid 111); 21 Sep 2018 23:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 19:39:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 19:39:21 -0400
Date:   Fri, 21 Sep 2018 19:39:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Gniazdowski <psprint@zdharma.org>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Very simple popen() code request, ground-shaking functionality
 openned by it
Message-ID: <20180921233921.GA3323@sigill.intra.peff.net>
References: <315083291.15466.1537536854535@privateemail.com>
 <20180921222454.GD11177@sigill.intra.peff.net>
 <87musajun7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87musajun7.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 01:30:36AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> This will allow users to free their creativity and provide probably
> >> dozens of custom Git progress bars.
> >
> > I don't personally feel that the existing progress bar is that bad, but
> > if anybody wants to pursue this, I think the most sensible path is:
> 
> I don't think it's bad either, but one thing that's really neat about
> Sebastian's suggestion is that it's using some UTF-8 terminal ASCII art
> to render an actual progress bar.

Yeah. I don't care myself, but I'm not opposed to somebody trying to
spruce up the in-code bar, as long we can still handle the lowest common
denominator cleanly (and remember that includes passing progress bars
back over the remote sideband).

> >   1. Add a trace_key for sending machine-readable progress output to a
> >      descriptor or file. E.g., via setting GIT_TRACE_PROGRESS=2 in the
> >      environment.
> >
> >   2. Teach the trace code to open a command for piping, so that you
> >      could do something like GIT_TRACE_PROGRESS='|mygauge'.
> >
> > That would make your use case work, and I think many other use cases
> > would benefit from both of those features independently.
> 
> Yup, that's all sensible, and would be great both for this and other
> stuff if we wanted true extensibility for this sort of thing.
> 
> I'll just add that a 3rd thing that would also make sense would be to
> add a feature to configure the value of these GIT_TRACE_*=* variables
> via the .gitconfig, that's been suggested before (too lazy to dig up a
> ML archive reference), and would make this as easy to configure as
> Sebastian's suggestion.

Heh, I almost included that in my original mail, but didn't want to get
into the tangle of secondary concerns. But since you mention it... :)

One thing to watch out is that (2) and (3) combined may mean executing
arbitrary code specified in the .git/config of an untrusted repository.
This is already the case for many commands, but we've specifically tried
to avoid it with git-upload-pack, making it safe to "git fetch" out of
an untrusted repository. It's almost certain that you'd be able to
trigger trace code from it.

There are a number of solutions floating around. We already have some
upload-pack config which is smart enough to realize when its source is
in-repo and handle it appropriately, and we've talked on the list about
having some "I don't trust this repo" environment variable that would
make Git operate in a more restricted way. I don't think we need to hash
out the solution here, but I just want to mention that it's a thing that
would have to dealt with before adding those two features.

(Actually, I guess you could argue that even reading existing trace
specs out of config is potentially dangerous, since you can append to
arbitrary files).

-Peff
