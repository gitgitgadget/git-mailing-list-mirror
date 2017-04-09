Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7E61FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 20:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdDIUhN (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 16:37:13 -0400
Received: from 5.itsy.de ([188.40.84.14]:46181 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbdDIUhL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 16:37:11 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 5D69F64942
        for <git@vger.kernel.org>; Sun,  9 Apr 2017 22:37:09 +0200 (CEST)
Subject: Re: [PATCH 0/2] test: Detect *lots* of bugs by adding non-alnum to
 trash dir names
References: <20170409191117.25175-1-avarab@gmail.com>
To:     git@vger.kernel.org
From:   Joachim Durchholz <jo@durchholz.org>
Message-ID: <2893d697-735f-537c-241d-910139f2c281@durchholz.org>
Date:   Sun, 9 Apr 2017 22:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170409191117.25175-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.04.2017 um 21:11 schrieb Ævar Arnfjörð Bjarmason:
> This series changes the test library so that we interpolate the result
> of:
>
>     perl -e 'print join q[], grep { /[^[:alnum:]]/ and !m<[./]> } map chr, 0x01..0x7f'
>
> Into the trash directory name we generate. Doing this makes 30% of the
> test suite fail.

Wow.
I know that I tend to bring out weird errors in systems, but this is 
much deeper than I could have ever expected.

You might want to additionally test directory names like "asdf" and 
'asdf' - some shell might try to be smart about such names and 
automatically unquote them. This would probably mean running the test 
suite multiple times, which some people find offensive (myself included).

There's also high-bit characters that might cause oddness. 0x80 and 0xff 
look like interesting edge cases to me.
Note that just appending these bytes is going to cause failures with 
filesystems that expect UTF-8 file names, you'd want to use a Unicode 
code point that gets encoded using a 0x80 resp. 0xff byte (I suspect 
0xff is actually not a valid UTF-8 encoding at all but I'd have to 
double-check that).

Is git supposed to run fine under Windows, or under Linux with an ntfs 
filesystem driver?
If yes, then I'd expect this patch to cause the other 70% of tests to 
crash, because NTFS forbids several non-alnum printable characters, 
among them <=>\
