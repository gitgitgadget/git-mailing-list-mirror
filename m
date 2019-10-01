Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84FF1F4BE
	for <e@80x24.org>; Tue,  1 Oct 2019 13:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbfJANbR (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 09:31:17 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55347 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJANbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 09:31:17 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 872B24000D;
        Tue,  1 Oct 2019 13:31:14 +0000 (UTC)
Date:   Tue, 1 Oct 2019 19:01:12 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
Message-ID: <20191001133112.3qh4aeoctkoz2wxy@yadavpratyush.com>
References: <pull.361.git.gitgitgadget@gmail.com>
 <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com>
 <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com>
 <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
 <20190927130539.52oir56byuedqmm3@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1909301139460.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909301139460.46@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/19 11:42AM, Johannes Schindelin wrote:
> On Fri, 27 Sep 2019, Pratyush Yadav wrote:
> > On 27/09/19 08:10AM, Bert Wesarg wrote:
> > > On Fri, Sep 27, 2019 at 12:40 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > > gitdir is used in a lot of places, and I think all those would 
> > > > also
> > > > benefit from using --git-path. So I think it is a better idea to move
> > > > this to the procedure gitdir. It would have to be refactored to take any
> > > > number of arguments, instead of the two it takes here.
> 
> The `gitdir` function is called 13 times during startup alone, and who
> knows how many more times later.
> 
> So I am quite convinced that the original intention was to save on
> spawning processes left and right.
> 
> But since you are the Git GUI maintainer, and this was your suggestion,
> I made it so.

Yes, I am the maintainer, but I am not an all-knowing, all-seeing 
entity. Your, and every other contributors, suggestions are very 
valuable. And my suggestions aren't gospel. I would hate to see someone 
send in a patch they weren't sure was the best thing to do just because 
I suggested it. Please feel free to object my suggestions.

In this case, I didn't expect gitdir to be called this many times.

While I don't notice much of a performance difference on my system 
(Linux), a quick measurement tells me that the time spent in gitdir is 
about 16 ms. In contrast, the same measurement without the v2 patch 
gives out 0 ms (IOW, very fast). 16 ms sounds a bit much for something 
so simple. It might not be the same for everyone else. AFAIK, spawning a 
process is much slower on Windows.

So now I'm not so sure my suggestion was a good one. My original aim was 
to be sure everything was correct, and no incorrect directories were 
being used. But the current solution comes at a performance hit.

> > > We could either maintain a blacklist, for what we cache the result
> > > too, or always call "git rev-parse --git-dir".
> > >
> > > This blacklist would need to be in sync with the one in Git's
> > > path.c::adjust_git_path() than.

Bert's suggestion seems like a decent compromise. We run `git rev-parse 
--git-path` for the paths in the blacklist, and for the rest we use the 
cached value. This does run the risk of getting out of sync with 
git.git's list, but it might be better than spawing a process every 
time, and is very likely better than just doing it for hooks.

Thoughts?

-- 
Regards,
Pratyush Yadav
