Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7531F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 18:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdCBSqX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 13:46:23 -0500
Received: from siwi.pair.com ([209.68.5.199]:50126 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbdCBSqS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 13:46:18 -0500
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3702F845D4;
        Thu,  2 Mar 2017 13:37:28 -0500 (EST)
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
 <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
 <alpine.DEB.2.20.1703012334400.3767@virtualbox>
 <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
 <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net>
 <CACsJy8D3h1KAaKi_Esc98za3LqXaB=YeW0Yu+VAV9UnX5vmttg@mail.gmail.com>
 <alpine.DEB.2.20.1703021539330.3767@virtualbox>
 <CA+55aFzscLaviJac-SB65WFYViY=wyAF3EWOnhHSuzSuFLdPTA@mail.gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <85221b97-759f-b7a9-1256-21515d163cbf@jeffhostetler.com>
Date:   Thu, 2 Mar 2017 13:37:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFzscLaviJac-SB65WFYViY=wyAF3EWOnhHSuzSuFLdPTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/2/2017 11:35 AM, Linus Torvalds wrote:
> On Thu, Mar 2, 2017 at 6:45 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> It would probably make sense to switch the index integrity check away from
>> SHA-1 because we really only care about detecting bit flips there, and we
>> have no need for the computational overhead of using a full-blown
>> cryptographic hash for that purpose.
> Which index do you actually see as being a problem, btw? The main file
> index (.git/index) or the pack-file indexes?
>
> We definitely don't need the checking version of sha1 for either of
> those, but as Jeff already did the math, at least the pack-file index
> is almost negligible, because the pack-file operations that update it
> end up doing SHA1 over the objects - and the object SHA1 calculations
> are much bigger.
>
> And I don't think we even check the pack-file index hashes except on fsck.
>
> Now, if your _file_ index is 300-400MB (and I do think we check the
> SHA fingerprint on that even on just reading it - verify_hdr() in
> do_read_index()), then that's going to be a somewhat noticeable hit on
> every normal "git diff" etc.

Yes, the .git/index is 450MB with ~3.1M entries.  verify_hdr() is called 
each time
we read it into memory.

We have been testing a patch in GfW to run the verification in a 
separate thread
while the main thread parses (and mallocs) the cache_entries.  This does 
help
offset the time.
         https://github.com/git-for-windows/git/pull/978/files

> But I'd have expected the stat() calls of all the files listed by that
> index to be the _much_ bigger problem in that case. Or do you just
> turn those off with assume-unchanged?
>
> Yeah, those stat calls are threaded when preloading, but even so..

Yes, the stat() calls are more significant percentage of the time (and 
having
core.fscache and core.preloadindex help that greatly), but the total 
time for a command
is just that -- the total -- so using the philosophy of "every little 
bit helps", the faster
routines help us here.

> Anyway, the file index SHA1 checking could probably just be disabled
> entirely (with a config flag). It's a corruption check that simply
> isn't that important. So if that's your main SHA1 issue, that would be
> easy to fix.

Yes, in the GVFS effort, we disabled the verification with a config 
setting and haven't
had any incidents.


> Everything else - like pack-file generation etc for a big clone() may
> end up using a ton of SHA1 too, but the SHA1 costs all scale with the
> other costs that drown them out (ie zlib, network, etc).
>
> I'd love to see a profile if you have one.
>
>                        Linus

