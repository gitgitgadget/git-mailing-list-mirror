Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7438020248
	for <e@80x24.org>; Fri,  5 Apr 2019 17:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfDERvU (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 13:51:20 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:35468 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbfDERvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 13:51:20 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44bS6Y4jLFz5tlC;
        Fri,  5 Apr 2019 19:51:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C86992AA9;
        Fri,  5 Apr 2019 19:51:16 +0200 (CEST)
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
 <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1904051653360.41@tvgsbejvaqbjf.bet>
 <20190405172536.GA11212@dev-l>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <34af9bf5-4031-63ed-c34b-9f2c7ff76c51@kdbg.org>
Date:   Fri, 5 Apr 2019 19:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405172536.GA11212@dev-l>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.19 um 19:25 schrieb Denton Liu:
> On Fri, Apr 05, 2019 at 04:55:37PM +0200, Johannes Schindelin wrote:
>> On Mon, 1 Apr 2019, Denton Liu wrote:
>>> +test_rebase() {
>>> +	expected="$1" &&
>>> +	shift &&
>>> +	test_expect_success "git rebase $@" "
>>> +		git checkout master &&
>>> +		git reset --hard E &&
>>> +		git checkout side &&
>>> +		git reset --hard G &&
>>> +		git rebase $@ &&
>>
>> I think we need this patch, to make the macOS build happy:
> 
> Thanks for digging into this, both.
> 
> Out of curiosity, t3432 is written similarly:
> 
> 	test_rebase_same_head() {
> 		status="$1" &&
> 		shift &&
> 		test_expect_$status "git rebase $@ with $changes is no-op" "
> 			oldhead=\$(git rev-parse HEAD) &&
> 			test_when_finished 'git reset --hard \$oldhead' &&
> 			git rebase $@ &&
> 			newhead=\$(git rev-parse HEAD) &&
> 			test_cmp_rev \$oldhead \$newhead
> 		"
> 	}

Using $@ in these expansions is wrong. You do not want to forward an
argument list, but you want to construct a command line. $* is correct
here. Then you can remove the single-quotes at the invocation, like so:

	test_rebase_same_head success
	test_rebase_same_head success --onto B B

Function test_rebase() could be done in the same way, but the first
argument, expected, still needs quotes at the call site, of course.

-- Hannes
