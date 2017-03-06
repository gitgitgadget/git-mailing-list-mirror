Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8AF1FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 06:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbdCFG44 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 01:56:56 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:5272 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752703AbdCFGyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 01:54:53 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.105])
        by bsmtp2.bon.at (Postfix) with ESMTPS id 3vc9Vw0vJNz5vCx
        for <git@vger.kernel.org>; Mon,  6 Mar 2017 07:54:00 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3vc9Sq2KGtz5tlR;
        Mon,  6 Mar 2017 07:52:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6584D376;
        Mon,  6 Mar 2017 07:52:10 +0100 (CET)
Subject: Re: [PATCH] pull: do not segfault when HEAD refers to missing object
 file
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Andr=c3=a9_Laszlo?= <andre@laszlo.nu>
References: <20170305234222.4590-1-andre@laszlo.nu>
 <20170305235222.vxia7jw2n5uj2h2e@genre.crustytoothpaste.net>
 <20170306035152.c7bh5jiqrfncyudl@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <6726b36d-6f50-d258-12e3-8b7b56159631@kdbg.org>
Date:   Mon, 6 Mar 2017 07:52:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170306035152.c7bh5jiqrfncyudl@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.2017 um 04:51 schrieb Jeff King:
> On Sun, Mar 05, 2017 at 11:52:22PM +0000, brian m. carlson wrote:
>
>> On Mon, Mar 06, 2017 at 12:42:22AM +0100, André Laszlo wrote:
>>> +test_expect_success 'git pull --rebase with corrupt HEAD does not segfault' '
>>> +	mkdir corrupted &&
>>> +	(cd corrupted &&

We usally indent this like so:

	(
		cd corrupted &&
		echo one >file &&
		git add file &&
...
	) &&

>>> +	git init &&
>>> +	echo one >file && git add file &&
>>> +	git commit -m one &&
>>> +	REV=$(git rev-parse HEAD) &&
>>> +	rm -f .git/objects/${REV:0:2}/${REV:2} &&
>>
>> I think this is a bashism.  On dash, I get the following:
>>
>>   genre ok % dash -c 'foo=abcdefg; echo ${foo:0:2}; echo ${foo:2}'
>>   dash: 1: Bad substitution
>
> Yeah, it is. You can do it easily with 'sed', of course, but if you want
> to avoid the extra process and do it in pure shell, it's more like:
>
>   last38=${REV#??}
>   first2=${REV%$last38}
>   rm -f .git/objects/$first2/$last38

Is it "HEAD points to non-existent object" or ".git/HEAD contains junk"? 
In both cases there are simpler solutions than to remove an object. For 
example, `echo "$_x40" >.git/HEAD` or `echo "this is junk" >.git/HEAD`?

-- Hannes

