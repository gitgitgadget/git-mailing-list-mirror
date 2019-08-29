Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839CE1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 21:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfH2VkT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 17:40:19 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52279 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2VkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 17:40:19 -0400
Received: from localhost (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4F396200008;
        Thu, 29 Aug 2019 21:40:16 +0000 (UTC)
Date:   Fri, 30 Aug 2019 03:10:14 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
Message-ID: <20190829214014.vijdotp4g65a5mk3@yadavpratyush.com>
References: <pull.325.git.gitgitgadget@gmail.com>
 <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
 <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
 <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
 <20190829203037.vzxuaxpsghbdc6vl@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829203037.vzxuaxpsghbdc6vl@yadavpratyush.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/08/19 02:00AM, Pratyush Yadav wrote:
> On 29/08/19 04:07PM, Derrick Stolee wrote:
> > On 8/29/2019 2:54 PM, Phillip Wood wrote:
> > > Hi Stolee
> > > 
> > > On 29/08/2019 18:01, Derrick Stolee via GitGitGadget wrote:
> > >> +   
> > >> +    if (argc == 3 && !strcmp(argv[1], "-b")) {
> > >> +        /*
> > >> +         * User ran 'git checkout -b <branch>' and expects
> > > 
> > > What if the user ran 'git checkout -b<branch>'? Then argc == 2.
> > 
> > Good catch. I'm tempted to say "don't do that" to keep this
> > simple. They won't have incorrect results, just slower than
> > the "with space" option.
> > 
> > However, if there is enough interest in correcting the "-b<branch>"
> > case, then I can make another attempt at this.
>  
> You can probably do this with:
> 
>   !strncmp(argv[1], "-b", 2)
> 
> The difference is so little, might as well do it IMO.
 
Actually, that is not correct. I took a quick look before writing this 
and missed the fact that argc == 3 is the bigger problem.

Thinking a little more about this, you can mix other options with 
checkout -b, like --track. You can also specify <start_point>.

Now I don't know enough about this optimization you are doing to know 
whether we need to optimize when these options are given, but at least 
for --track I don't see any reason not to.

So maybe you are better off using something like getopt() (warning: 
getopt modifies the input string so you probably want to duplicate it) 
if you want to support all cases. Though for this simple case you can 
probably get away by just directly scanning the argv list for "-b" 
(using strncmp instead of strcmp to account for "-b<branch-name>)

-- 
Regards,
Pratyush Yadav
