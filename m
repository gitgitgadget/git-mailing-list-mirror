Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2D8207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 01:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935265AbcI3B3G (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 21:29:06 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:59022 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932838AbcI3B3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 21:29:05 -0400
X-Greylist: delayed 1909 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Sep 2016 21:29:03 EDT
Received: from glandium by zenigata with local (Exim 4.87)
        (envelope-from <mh@glandium.org>)
        id 1bpm7y-00041d-8Z; Fri, 30 Sep 2016 09:56:38 +0900
Date:   Fri, 30 Sep 2016 09:56:38 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160930005638.almd66ralshknoxa@glandium.org>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
 <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <CA+55aFx9Utm9yDZceks+5q9c8ydc2QMYshWwJ0G0GHWWLwSsXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx9Utm9yDZceks+5q9c8ydc2QMYshWwJ0G0GHWWLwSsXQ@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20160910 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 12:06:23PM -0700, Linus Torvalds wrote:
> On Thu, Sep 29, 2016 at 11:55 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > For the kernel, just the *math* right now actually gives 12
> > characters. For current git it actually seems to say that 8 is the
> > correct number. For small projects, you'll still see 7.
> 
> Sorry, the git number is 9, not 8. The reason is that git has roughly
> 212k objects, and 9 hex digits gets expected collisions at about 256k
> objects.
> 
> So the logic means that we'll see 7 hex digits for projects with less
> than 16k objects, 8 hex digits if there are less than 64k objects, and
> 9 hex digits for projects like git that currently have fewer than 256k
> objects.
> 
> But git itself might not be *that* far from going to 10 hex digits
> with my patch.
> 
> The kernel uses 12 he digits because the collision math says that's
> the right thing for a project with between 4M and 16M objects (with
> the kernel being at 5M).

OTOH, how often does one refer to trees or blobs with abbreviated sha1s?
Most of the time, you'd use abbreviated sha1s for commits. And the number
of commits in git and the kernel repositories are much lower than the
number of overall objects.

rev-list --all --count on the git repo gives me 46790. On the kernel, it
gives 618078.

Now, the interesting thing is looking at the *actual* collisions in
those spaces.

At 9 digits, there's only one commit collision in the kernel repo:
  45f014c5264f5e68ef0e51b36f4ef5ede3d18397
  45f014c52eef022873b19d6a20eb0ec9668f2b09

And two commit collisions at 8 digits in the git repo:
  1536dd9c1df0b7167b139f6666080cc4774ef63f
  1536dd9c61b5582cf079999057cb715dd6dc6620

  2e6e3e82ee36b3e1bec1db8db24817270080424e
  2e6e3e829f3759823d70e7af511bc04cd05ad0af

At 7 digits, there are 5 actual commit collisions in the git repo and
718 in the kernel repo only one of those collisions involve more than 2
commits.

Mike
