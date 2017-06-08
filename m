Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16E01FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdFHA75 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:59:57 -0400
Received: from avasout08.plus.net ([212.159.14.20]:51478 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdFHA74 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:59:56 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id W0zu1v0011keHif010zv3b; Thu, 08 Jun 2017 01:59:55 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=H8XXGom_YRwkIMVfF5cA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20170603221335.3038-1-avarab@gmail.com>
 <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
 <xmqqefuzurj5.fsf@gitster.mtv.corp.google.com>
 <20170607102448.bpgxce4kduzxf7a2@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3ae7243b-93f9-d7ba-0e3f-d0b3388d57ac@ramsayjones.plus.com>
Date:   Thu, 8 Jun 2017 01:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170607102448.bpgxce4kduzxf7a2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/06/17 11:24, Jeff King wrote:
> On Mon, Jun 05, 2017 at 10:55:42AM +0900, Junio C Hamano wrote:
> 
> If you use "prove", it already records this information, and it can
> print it with "--timer".

Yes I have

    DEFAULT_TEST_TARGET=prove
    GIT_PROVE_OPTS='--timer'

in my config.mak and run the test: 'make test >test-out 2>&1'.

> I don't use that myself, though. What's much more interesting (but which
> I haven't found a way to get prove to do out-of-the-box) is to show the
> longest tests after the fact.

So, I have a perl script that can give me that info, like so:

On Linux, (current master branch), the ten slowest tests:

$ ./test-times.pl -n 10 test-out
   1   22.269s   t9001-send-email.sh
   2   15.222s   t7063-status-untracked-cache.sh
   3   10.965s   t9500-gitweb-standalone-no-errors.sh
   4    9.978s   t3404-rebase-interactive.sh
   5    9.270s   t3421-rebase-topology-linear.sh
   6    8.099s   t0027-auto-crlf.sh
   7    6.056s   t7112-reset-submodule.sh
   8    5.937s   t7610-mergetool.sh
   9    5.711s   t5572-pull-submodule.sh
  10    5.229s   t6030-bisect-porcelain.sh
$ 

... and those taking 10s or more:

$ ./test-times.pl -t 10 test-out
   1   22.269s   t9001-send-email.sh
   2   15.222s   t7063-status-untracked-cache.sh
   3   10.965s   t9500-gitweb-standalone-no-errors.sh
$ 

However, on cygwin (v2.13.0 test output file), the ten slowest:

$ ./test-times.pl -n 10 test-out
   1  385.057s   t3404-rebase-interactive.sh
   2  339.694s   t3421-rebase-topology-linear.sh
   3  224.854s   t7610-mergetool.sh
   4  211.230s   t6030-bisect-porcelain.sh
   5  180.297s   t3425-rebase-topology-merges.sh
   6  179.446s   t3903-stash.sh
   7  177.600s   t9001-send-email.sh
   8  175.278s   t5572-pull-submodule.sh
   9  160.422s   t2013-checkout-submodule.sh
  10  158.615s   t1013-read-tree-submodule.sh
$ 

... and (some of) those taking 10s or more:

$ ./test-times.pl -t 10 test-out
   1  385.057s   t3404-rebase-interactive.sh
   2  339.694s   t3421-rebase-topology-linear.sh
   3  224.854s   t7610-mergetool.sh
   4  211.230s   t6030-bisect-porcelain.sh

...

 175   10.389s   t4300-merge-tree.sh
 176   10.324s   t4213-log-tabexpand.sh
 177   10.143s   t3034-merge-recursive-rename-options.sh
 178   10.108s   t1410-reflog.sh
$ 

[On linux a complete run is about 400s and on cygwin about 3hours!]

ATB,
Ramsay Jones

