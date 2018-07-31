Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACA01F597
	for <e@80x24.org>; Tue, 31 Jul 2018 14:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbeGaPls (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 11:41:48 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33732 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732173AbeGaPls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 11:41:48 -0400
Received: from [192.168.129.6] (x006.home.local [192.168.129.6])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6VE18MC9765002;
        Tue, 31 Jul 2018 14:01:08 GMT
Subject: Re: Is detecting endianness at compile-time unworkable?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net>
 <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
 <87wotdt649.fsf@evledraar.gmail.com>
From:   Michael Felt <aixtools@felt.demon.nl>
Message-ID: <287cdba8-19c1-2fe8-4aff-d0385b38e92c@felt.demon.nl>
Date:   Tue, 31 Jul 2018 16:01:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87wotdt649.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hope a I have a "leap forward"


On 7/30/2018 11:39 AM, Ævar Arnfjörð Bjarmason wrote:
> Perhaps it's worth taking a step back here and thinking about whether
> this whole thing is unworkable. It was hard enough to get this to work
> on the combination of Linux, *BSD and Solaris, but I suspect we'll run
> into increasingly obscure platforms where this is hard or impossible
> (AIX, HP/UX etc.)
While I still cannot say for HP/UX it does seem there is a potential
solution based on the status for _LITTLE_ENDIAN and _BIG_ENDIAN. At
least, gcc on POWER and xlc on POWER provides one or the other - and my
hope is that gcc on other platforms also provides them.

For "other" compilers that do not provide them - a modification to
CFLAGS to define one or the other should make "make" work.

Details (note - I am not a programmer, so by definition at least one of
my "macros" will be wrong :)

AIX and xlc
root@x066:[/]xlc   -qshowmacros -E /dev/null | grep -i endi
1506-297 (S) Unable to open input file null. A file or directory in the
path name does not exist..
#define __HHW_BIG_ENDIAN__ 1
#define __BIG_ENDIAN__ 1
#define __THW_BIG_ENDIAN__ 1
#define _BIG_ENDIAN 1

On SLES12 (le) and xlc
suse12test:~/images/littleEndian/sles # xlc -qshowmacros -dM -E x.c |
grep -i endi
#define _LITTLE_ENDIAN 1
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __LITTLE_ENDIAN__ 1
#define __ORDER_BIG_ENDIAN__ 4321
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __ORDER_PDP_ENDIAN__ 3412
#define __VEC_ELEMENT_REG_ORDER__ __ORDER_LITTLE_ENDIAN__


Based on what I can see on gcc on POWER and xlc on POWER I think an
approach (simplified) can be:

#if undefined(_BIG_ENDIAN) && undef(_LITTLE_ENDIAN)
#error "one of _BIG_ENDIAN or _LITTLE_ENDIAN must be defined. Try adding
the correct value to CFLAGS"
#else defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
#error "Only one of _BIG_ENDIAN and _LITTLE_ENDIAN may be defined, not both"
#endif

And then logic based on the value set.
This should also make cross-compile possible by unsetting an incorrect
default and setting the correct value.

p.s. Is there a setting I need to set somewhere so I receive a copy of
the email sent after it is received by the list. I could send myself a
copy, but I much prefer it comes from the maillist - as verification it
was received.
