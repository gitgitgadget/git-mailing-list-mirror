Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976B920A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbdJAORW (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:17:22 -0400
Received: from ikke.info ([178.21.113.177]:60986 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdJAORV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:17:21 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id EB5044403C1; Sun,  1 Oct 2017 16:17:19 +0200 (CEST)
Date:   Sun, 1 Oct 2017 16:17:19 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: will git rebase has side effect
Message-ID: <20171001141719.GB20406@alpha.vpn.ikke.info>
References: <CAJYFCiNj22McSaKcCVMDVgah5cAqHYHja_b2jj6VAaAA=zSM1g@mail.gmail.com>
 <20171001134155.GA20406@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171001134155.GA20406@alpha.vpn.ikke.info>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forgot to cc the mailing list.

On Sun, Oct 01, 2017 at 09:23:23PM +0800, Yubin Ruan wrote:
> Suppose that I have such a history of commit locally:
> 
> A --> B --> C --> D
> 
> If I then add a few more commits locally
> 
> A --> B --> C --> D --> E --> F --> G
> 
> And then I do a rebase and squash F and G into one single commit H.
> What side effect will this rebase have? How will this affect "git push
> origin master"?
> 
> Yubin

Hello Yubin,

So the situation is this:

            [origin/master]
                  |
A --> B --> C --> D --> E --> F --> G
                                    |
                                 [master] 

Then you squash (F' is the result of squashing F and G):

            [origin/master]
                  |
A --> B --> C --> D --> E --> F'
                              |
                           [master] 

When you want to push now, it's just as if you just created just two
commits in the first place, and you can just push normally (assuming no
one else has pushed in the mean time.

The situation is different when you have pushed already:

                              [origin/master]
                                    |
A --> B --> C --> D --> E --> F --> G
                                    |
                                 [master] 

Then after you squash, the history would look as follows:

                              [origin/master]
                                    |
A --> B --> C --> D --> E --> F --> G
                         \
                          --> F'
                              |
                           [master] 

This sitation would look to git like you created F', and someone else
had pushed F and G. It will reject the push, saying you would need to
merge these changes first (but you don't want this, because you are
merging the same changes together).

To solve this, you can use git push --force-with-lease=master origin,
which will force the push, overwriting the history the remote already
had.

Hope this helps, Kevin.

nb. --force-with-lease is a safer version of just (-f|--force), because
it will prevent you from overwriting history you don't have locally, for
example when someone else did push already.


