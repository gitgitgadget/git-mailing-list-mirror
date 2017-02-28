Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138DD202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 23:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdB1XOr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 28 Feb 2017 18:14:47 -0500
Received: from fester.cwi.nl ([192.16.191.27]:33018 "EHLO fester.cwi.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751992AbdB1XOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 18:14:45 -0500
X-Greylist: delayed 1329 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Feb 2017 18:14:45 EST
Received: from fester.cwi.nl (fester.cwi.nl [192.16.191.27])
        by fester.cwi.nl (8.14.4/8.12.3) with ESMTP id v1SMp0ao018646;
        Tue, 28 Feb 2017 23:51:00 +0100
Received: from [192.168.4.56] (541FB48C.cm-5-8c.dynamic.ziggo.nl [84.31.180.140])
        (authenticated bits=0)
        by fester.cwi.nl (8.14.4/8.12.3) with ESMTP id v1SMox9N018631
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 28 Feb 2017 23:51:00 +0100
Subject: Re: SHA1 collisions found
To:     Dan Shumow <danshu@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
 <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
 <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
 <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com>
 <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>
 <CY1PR0301MB21078DDCA8C679983D22821FC4560@CY1PR0301MB2107.namprd03.prod.outlook.com>
Cc:     Jeff King <peff@peff.net>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
From:   Marc Stevens <marc.stevens@cwi.nl>
Message-ID: <259cc328-13f7-2d2d-c86f-8b4fc7da8e34@cwi.nl>
Date:   Tue, 28 Feb 2017 23:50:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CY1PR0301MB21078DDCA8C679983D22821FC4560@CY1PR0301MB2107.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can also keep me in this thread, so we can help or answer any
further questions,
but I also appreciate the feedback on our project.

Like Dan Shumow said, our main focus on the library has been correctness
and then performance.
The entire files ubc_check.c and ubc_check.h are generated based on
cryptanalytic data,
in particular a list of 32 disturbance vectors and their unavoidable
attack conditions,
see https://github.com/cr-marcstevens/sha1collisiondetection-tools.

sha1.c and sha1.h were coded to work for any such generated ubc_check.c
and ubc_check.h.
That means that indeed we might have some superfluous code, once used
for testing, or for generality,
but nothing that should noticeably impact runtime performance.

Because we only have 32 disturbance vectors to check, we have DVMASKSIZE
equal to 1 and maski always 0.
In the more general case when we add disturbance vectors this will not
remain the case.

Of course for dedicated code this can be simplified, and some parts
could be further optimized.

Regarding the recompression functions, the ones needed are given in the
sha1_dvs table,
but also via preprocessor defines that are used to actually only store
needed internal states:
#define DOSTORESTATE58
#define DOSTORESTATE65
For each disturbance vector there is a window of which states you can
start the recompression from,
we've optimized it so there are only 2 unique starting points (58,65)
instead of 32.
These defines should be easy to use to remove superfluous compiled
recompression functions.

Note that as each disturbance vector has its own unique message differences
(leading to different values for ctx->m2), our code does not loop over
just 2 items.
It loops over 32 distinct computations which have either of the 2
starting points.

Finally, thanks for taking a close look at our code,
this helps bringing the library in better shape also for other software
projects.

Best regards,
Marc Stevens

On 2/28/2017 10:22 PM, Dan Shumow wrote:
> [Responses inline]
>
> No need to keep me "bcc'd" (though thanks for the consideration) -- I'm happy to ignore anything I don't want to be pulled into ;-)
>
> Here's a rollup of what needs to be done based on the discussion below:
>
> 1) Remove extraneous exports from sha1.h
> 2) Remove "safe mode" support.
> 3) Remove sha1_compression_W if it is not needed by the performance improvements.
> 4) Evaluate logic around storing states and generating recompression states.  Remove defines that bloat code footprint.
>
> Thanks,
> Dan
>
>
> -----Original Message-----
> From: linus971@gmail.com [mailto:linus971@gmail.com] On Behalf Of Linus Torvalds
> Sent: Tuesday, February 28, 2017 11:34 AM
> To: Junio C Hamano <gitster@pobox.com>
> Cc: Jeff King <peff@peff.net>; Joey Hess <id@joeyh.name>; Git Mailing List <git@vger.kernel.org>
> Subject: Re: SHA1 collisions found
>
> On Tue, Feb 28, 2017 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> In a way similar to 8415558f55 ("sha1dc: avoid c99 
>> declaration-after-statement", 2017-02-24), we would want this on top.
> There's a few other simplifications that could be done:
>
>  (1) make the symbols static that aren't used.
>
>      The sha1.h header ends up declaring several things that shouldn't have been exported.
>
>      I suspect the code may have had some debug mode that got stripped out from it before making it public (or that was never there, and was just something the generating code could add).
>
> [danshu] Yes, this is reasonable.  The emphasis of the code, heretofore, had been the illustration of our unavoidable bit condition performance improvement to counter cryptanalysis.  I'm happy to remove the unused stuff from the public header.
>
>  (2) get rid of the "safe mode" support.
>
>      That one is meant for non-checking replacements where it generates a *different* hash for input with the collision fingerpring, but that's pointless for the git use when we abort on a collision fingerprint.
>
> [danshu] Yes, I agree that if you aren't using this it can be taken out.  I believe Marc has some use cases / potentially consumers of this algorithm in mind.  We can move it into separate header/source files for anyone who wants to use it.
>
> I think the first one will show that the sha1_compression() function isn't actually used, and with the removal of safe-mode I think
> sha1_compression_W() also is unused.
>
> [danshu]  Some of the performance experiments that I've looked at involve putting the sha1_compression_W(...) back in.  Though, that doesn't look like it's helping.  If it is unused after the performance improvements, we'll take it out, or move it into its own file.
>
> Finally, only states 58 and 65 (out of all 80 states) are actually used, and from what I can tell, the 'maski' value is always 0, so the looping over 80 state masks is really just a loop over two.
>
> [danshu]  So, while looking at performance optimizations, I specifically looked at how much removing storing the intermediate states helps -- And I found that it doesn't seem to make a difference for performance.  My cursory hypothesis is because nothing is waiting on those writes to memory, the code moves on quickly.  That said, it is a bunch of code that is essentially doing nothing and removing that is worthwhile.  Though, partially what we're seeing here is that, as you point out below, we're working with generated code that we want to be general.  Specifically, right now, we're checking only disturbance vectors that we know can be used to efficiently attack the compression function.  It may be the case that further cryptanalysis uncovers more.  We want to have a general enough approach that we can add scanning for new disturbance vectors if they're found later.  Over specializing the code makes that more difficult, as currently the algorithm is data driven, and we don't need to write new code, but rather just add more data to check.  One other note -- the "maski" field of the  dv_info_t struct is not an index to check the state, but rather an index into the mask generated by the ubc check code, so that doesn't pertain to looping over the states.  More on this below.  
>
> The file has code top *generate* all the 80 sha1_recompression_step() functions, and I don't think the compiler is smart enough to notice that only two of them matter.
>
> [danshu] That's a good observation -- We should clean up the unused recompression steps, especially because that will generate a ton of object code.  We should add some logic to only compile the functions that are used.
>
> And because 'maski' is always zero, thisL
>
>    ubc_dv_mask[sha1_dvs[i].maski]
>
> code looks like it might as well just use ubc_dv_mask[0] - in fact the ubc_dv_mask[] "array" really is just a single-entry array anyway:
>
>    #define DVMASKSIZE 1
>
> [danshu]  The idea here is that we are currently checking 32 disturbance vectors with our bit mask.  We're checking 32 DVs, because we have 32 bits of mask that we can use.  The DVs are ordered by their probability of leading to an attack (which is directly correlated to the complexity of finding a collision.)  Several of those DVs correspond to very low probability / high cost attacks, which we wouldn't expect to see in practice.  We just have the space to check, so why not?  However, improvements in cryptanalysis may make those attacks cheaper, in which case, we would potentially want to add more DVs to check, in which case we would expand the number of DVs and the mask.
>
> so that code has a few oddities in it. It's generated code, which is probably why.
>
> [danshu]  Accurate, we're also just trying to be general enough that we can easily add more DVs later if need be.  I don't know how likely that is, certainly the DVs that we're checking now are based on solid conjectures and rigorous analysis of the problem.  Though we don't want to rule out that there will be subsequent cryptanalytic developments later.  Marc can comment more here.
>
> Basically, some of it could be improved. In particular, the "generate code for 80 different recompression cases, but only ever use two of them" really looks like it would blow up the code generation footprint a lot.
>
> I'm adding Marc Stevens and Dan Shumow to this email (bcc'd, so that they don't get dragged into any unrelated email threads) in case they want to comment.
>
> I'm wondering if they perhaps have a cleaned-up version somewhere, or maybe they can tell me that I'm just full of sh*t and missed something.
>
> [danshu]  Naw man, it looks pretty good, modulo a little bit of understandable confusion over 'maski' -- No fake news or alternative facts here ;-)
>
>                     Linus


