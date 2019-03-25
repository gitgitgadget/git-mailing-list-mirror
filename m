Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E158920248
	for <e@80x24.org>; Mon, 25 Mar 2019 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfCYRDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 13:03:12 -0400
Received: from avasout02.plus.net ([212.159.14.17]:50544 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYRDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 13:03:12 -0400
Received: from [10.0.2.15] ([80.189.70.228])
        by smtp with ESMTPA
        id 8T09h93PI2SW58T0AhN0Bi; Mon, 25 Mar 2019 17:03:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NtavjPVJ c=1 sm=1 tr=0
 a=5/rI1lTgw+ttA0Fwm4j1LQ==:117 a=5/rI1lTgw+ttA0Fwm4j1LQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8
 a=bfiFwDrY3TCLbFR5jv4A:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] commit-graph: fix sparse 'NULL pointer' warning
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <1908832c-8dd0-377e-917b-acb33b00273c@ramsayjones.plus.com>
 <871s2vcgb1.fsf@evledraar.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <755f0706-9738-fc10-23a3-e1797c6925dd@ramsayjones.plus.com>
Date:   Mon, 25 Mar 2019 17:03:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <871s2vcgb1.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBqmQvRyeHY3JqVbf90sp4dEawkk5j2OZuOWxtne4QuLU2jFf9bMQky7CRhIGSGxW3Xzo9AXhlBYi6/f8jHH4fAVY8UoB2e1lNugI8oIAO1nDIZc6LuW
 wJM8eaDtyXcKx5WscqQk1/44V7o86LrF1Xjgc4+F0ljY75q/pzs3jsURV4mdZtXeTkX3zosg3seL+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/03/2019 12:02, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Mar 23 2019, Ramsay Jones wrote:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Ævar,
>>
>> If you need to re-roll your 'ab/commit-graph-fixes' branch, could you
>> please squash this into the relevant patch (commit aeb244adbc
>> ("commit-graph: don't early exit(1) on e.g. \"git status\"", 2019-02-21).
> 
> Thanks. Will squash & re-submit. It's still just in "pu". Is there a
> compiler that warns about it? Didn't on clang/gcc, but then again it's
> just-as-valid-C & just a style issue, so compilers don't care...

This is a 'sparse' warning (see subject line). :-D

I run the 'sparse' Makefile target on each branch and save to
a file, sp-out, nsp-out and psp-out, then diff from branch to
branch. So, currently, the diff between the 'next' and 'pu'
branches look like:

  $ diff nsp-out psp-out
  25a26
  > commit-graph.c:103:24: warning: Using plain integer as NULL pointer
  123a125
  >     SP promisor-remote.c
  188a191
  > upload-pack.c:1167:56: warning: Using plain integer as NULL pointer
  289d291
  <     SP builtin/rebase--interactive.c
  $ 

Alternatively, I can simply run 'sparse' over a single file:

  $ make commit-graph.sp
      SP commit-graph.c
  commit-graph.c:103:24: warning: Using plain integer as NULL pointer
  $ 

Of course, you need to have 'sparse' installed ... ;-)

> 
>> This same commit (aeb244adbc) also removes the last call, outside of the
>> commit-graph.c file, to the function load_commit_graph_one(). So, this
>> function is now a file-local symbol and could be marked 'static'.
>>
>> Also, the function verify_commit_graph_lite(), introduced in commit
>> d8acf37ff7 ("commit-graph: fix segfault on e.g. \"git status\"",
>> 2019-02-21), currently has no external callers. This function is also
>> a file-local symbol and could be marked 'static', unless you have plans
>> for future external calls?
> 
> Fixing these too. Just missed them. Thanks.

And these resulted from running my static-check.pl script.

ATB,
Ramsay Jones

