Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9A7211B5
	for <e@80x24.org>; Sat,  9 Feb 2019 08:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBIIjs (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 03:39:48 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:3567 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfBIIjs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 03:39:48 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43xQTY23T5z5tlD;
        Sat,  9 Feb 2019 09:39:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A77381EA9;
        Sat,  9 Feb 2019 09:39:44 +0100 (CET)
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
To:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
 <20190208180321.GB27673@sigill.intra.peff.net>
 <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
 <20190208193157.GA30952@sigill.intra.peff.net>
 <20190208220714.GG11927@genre.crustytoothpaste.net>
 <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com>
 <20190208223512.GA2135@sigill.intra.peff.net>
 <006601d4c001$2de3a160$89aae420$@nexbridge.com>
 <20190209042456.GB18286@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <38f594ed-0787-aeb5-d34f-2f4775243eb7@kdbg.org>
Date:   Sat, 9 Feb 2019 09:39:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190209042456.GB18286@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.19 um 05:24 schrieb Jeff King:
> On Fri, Feb 08, 2019 at 05:53:53PM -0500, Randall S. Becker wrote:
> 
>>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh index
>>> 92cf8f812c..4afab14431 100644
>>> --- a/t/test-lib-functions.sh
>>> +++ b/t/test-lib-functions.sh
>>> @@ -1302,3 +1302,8 @@ test_set_port () {
>>>  	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
>>>  	eval $var=$port
>>>  }
>>> +
>>> +# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
>>> +gen_zero_bytes () {
>>> +	perl -e 'print "\0" x $ARGV[0]' "$@"
>>> +}
>>
>> This function does work on platform, so it's good.
> 
> Great. Since it sounds like you're preparing some patches to deal with
> /dev/zero elsewhere, do you want to wrap it up in a patch as part of
> that?

Please do not use yes to generate an infinite amount of bytes. Our
implementation of yes() in test-lib.sh generates only 99 lines.

Perhaps do this.

----- 8< -----
Subject: [PATCH] t5318: avoid /dev/zero

Some platforms do not offer /dev/zero. Use printf and tr to generate
a certain amount of NUL bytes.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5318-commit-graph.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 16d10ebce8..04d394274f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -383,7 +383,8 @@ corrupt_graph_and_verify() {
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
-	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
+	printf "%0*d" $(($orig_size - $zero_pos)) 0 | tr 0 '\0' |
+		dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err
-- 
2.20.1.86.gb0de946387
