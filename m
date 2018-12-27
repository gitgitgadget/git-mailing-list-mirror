Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5603A211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 19:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeL0Tzb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 14:55:31 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:16993 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbeL0Tzb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 14:55:31 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43QgYW5vv6z5tl9;
        Thu, 27 Dec 2018 20:55:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 291E92091;
        Thu, 27 Dec 2018 20:55:27 +0100 (CET)
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
 <93f0a854-9b8d-500c-b015-59c50ecdb0f3@kdbg.org>
 <20181227164353.GC423984@genre.crustytoothpaste.net>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <435b6870-379c-7183-da99-35aec5cf1137@kdbg.org>
Date:   Thu, 27 Dec 2018 20:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181227164353.GC423984@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.12.18 um 17:43 schrieb brian m. carlson:
> On Thu, Dec 27, 2018 at 11:06:17AM +0100, Johannes Sixt wrote:
>> It worries me that theoretical correctness is regarded higher than existing
>> practice. I do not care a lot what some RFC tells what programs should do if
>> the majority of the software does something different and that behavior has
>> been proven useful in practice.
> 
> The majority of OSes produce the behavior I document here, and they are
> the majority of systems on the Internet. Windows is the outlier here,
> although a significant one. It is a common user of UTF-16 and its
> variants, but so are Java and JavaScript, and they're present on a lot
> of devices. Swallowing the U+FEFF would break compatibility with those
> systems.
> 
> The issue that Windows users are seeing is that libiconv always produces
> big-endian data for UTF-16, and they always want little-endian. glibc
> produces native-endian data, which is what Windows users want. Git for
> Windows could patch libiconv to do that (and that is the simple,
> five-minute solution to this problem), but we'd still want to warn
> people that they're relying on unspecified behavior, hence this series.
> 
> I would even be willing to patch Git for Windows's libiconv if somebody
> could point me to the repo (although I obviously cannot test it, not
> being a Windows user). I feel strongly, though, that fixing this is
> outside of the scope of Git proper, and it's not a thing we should be
> handling here.

Please appologize that I leave the majority of what you said uncommented 
as I am not deep in the matter and don't have a firm understanding of 
all the issues. I'll just trust what you said is sound.

Just one thing: Please do the count by *users* (or existing files or 
number of charactes exchanged or something similar); do not just count 
OSs; I mean, Windows is *not* the outlier if it handles 90% of the 
UTF-16 data in the world. (I'm just making up numbers here, but I think 
you get the point.)

>> My understanding is that there is no such thing as a "byte order marker". It
>> just so happens that when the first character in some UTF-16 text file
>> begins with a ZWNBSP, then it is possible to derive the endianness of the
>> file automatically. Other then that, that very first code point U+FEFF *is
>> part of the data* and must not be removed when the data is reencoded. If Git
>> does something different, it is bogus, IMO.
> 
> You've got part of this. For UTF-16LE and UTF-16BE, a U+FEFF is part of
> the text, as would a second one be if we had two at the beginning of a
> UTF-16 or UTF-8 sequence. If someone produces UTF-16LE and places a
> U+FEFF at the beginning of it, when we encode to UTF-8, we emit only one
> U+FEFF, which has the wrong semantics.
> 
> To be correct here and accept a U+FEFF, we'd need to check for a U+FEFF
> at the beginning of a UTF-16LE or UTF-16BE sequence and ensure we encode
> an extra U+FEFF at the beginning of the UTF-8 data (one for BOM and one
> for the text) and then strip it off when we decode. That's kind of ugly,
> and since iconv doesn't do that itself, we'd have to.

But why do you add another U+FEFF on the way to UTF-8? There is one in 
the incoming UTF-16 data, and only *that* one must be converted. If 
there is no U+FEFF in the UTF-16 data, the should not be one in UTF-8, 
either. Puzzled...

-- Hannes
