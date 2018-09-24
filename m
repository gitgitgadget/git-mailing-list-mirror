Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BA31F453
	for <e@80x24.org>; Mon, 24 Sep 2018 03:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeIXJPU (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 05:15:20 -0400
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:45075 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIXJPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 05:15:19 -0400
Received: from fed1rmimpo209.cox.net ([68.230.241.160])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180924031518.KJEQ4101.fed1rmfepo101.cox.net@fed1rmimpo209.cox.net>
          for <git@vger.kernel.org>; Sun, 23 Sep 2018 23:15:18 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo209.cox.net with cox
        id fFFG1y00g59yGBo01FFHSz; Sun, 23 Sep 2018 23:15:17 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090201.5BA856C6.0039,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=UKxp4xXy c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=tDrJsivbDvydaWdw5SQA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 58FDF29A0075;
        Sun, 23 Sep 2018 20:15:16 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/4] wt-status.c: Set the committable flag in the collect phase.
Date:   Sun, 23 Sep 2018 20:15:16 -0700
Message-ID: <2295579.U4Xb9QnJqG@thunderbird>
Organization: Personal
References: <20180906005329.11277-1-ischis2@cox.net> <xmqqworxufuv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, September 7, 2018 3:31:55 PM MST Junio C Hamano wrote:
> For example, I noticed that both of the old
> callsites of wt_status_get_state() have free() of a few fiedls in
> the structure, and I kept the code as close to the original, but I
> suspect they should not be freed there in the functions in the
> "print" phase, but rather the caller of the "collect" and "print"
> should be made responsible for deciding when to dispose the entire
> wt_status (and wt_status_state as part of it).  This illustration
> patch does not address that kind of details (yet).

I followed the call tree back to original callers run_status() and 
cmd_status() in commit.c

This leads to a philosophical question.  We want to move the state information 
out of the print functions because it doesn't seem correct.  For the case in 
question this includes the calls to free() .   By doing this we seem go have 
traded one location that shouldn't be touching the state variables for 
another. 

I can see three solutions and could support any of the three:
1) Move the free calls to run_status() and cmd_status().
2) Move the calls calls to wt_status_print since that is the last function 
from wt_status.c that is called befor the structure goes out of scope in  
run_status() and cmd_status().
3) Add a new wt_collect*() function to free the variables. This would have an 
advantage that the free calls could be grouped in on place and not done in to 
functions.  A second advantage is that the free calls would be located where 
the pointers are initialized.  

Personally I like solutions 1 and 3 over 2.
What do others think?

sps







