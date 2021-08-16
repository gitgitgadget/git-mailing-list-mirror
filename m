Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B1C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FCB60F41
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhHPSzF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 Aug 2021 14:55:05 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21415 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhHPSzF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:55:05 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17GIsJRI078631
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Aug 2021 14:54:19 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com> <YRaYnDR6RlgJRr/P@coredump.intra.peff.net> <01b401d792c9$c083e4b0$418bae10$@nexbridge.com> <YRqv30kTZqW9nMN0@coredump.intra.peff.net>
In-Reply-To: <YRqv30kTZqW9nMN0@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Date:   Mon, 16 Aug 2021 14:54:14 -0400
Message-ID: <01b901d792d0$1e993950$5bcbabf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMBTs001OO8pWyP/FbVHKiIK4dspwGtgrwqAm7jwVgCqaHe1ajsz0ag
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 16, 2021 2:35 PM, Jeff King wrote:
>On Mon, Aug 16, 2021 at 02:08:38PM -0400, Randall S. Becker wrote:
>
>> On August 13, 2021 12:07 PM, Jeff King wrote:
>> >On Fri, Aug 13, 2021 at 10:22:19AM -0400, Randall S. Becker wrote:
>> >
>> >> >Just a report that t0301.9 hung again on 2.32.0-rc1 on the NonStop
>> >> >ia64 platform, and t5563.8 hung on the x86 platform. These did not
>> >
>> >We don't seem to have a t5563. Do you mean t5562?
>> Yes.
>
>I've seen issues with t5562.8, as well. It doesn't _fail_, but I occasionally notice that it takes a very long time to complete. If I instrument
>the test suite like this:
>
>diff --git a/t/test-lib.sh b/t/test-lib.sh index abcfbed6d6..45e6062e3a 100644
>--- a/t/test-lib.sh
>+++ b/t/test-lib.sh
>@@ -989,10 +989,18 @@ test_run_ () {
> 		trace=$trace_tmp
> 	fi
>
>+	start=$(date +%s)
> 	setup_malloc_check
> 	test_eval_ "$1"
> 	eval_ret=$?
> 	teardown_malloc_check
>+	end=$(date +%s)
>+
>+	len=$((end - start))
>+	if test $len -gt 5; then
>+		echo >&2 "took $len seconds to finish; failing"
>+		eval_ret=1
>+	fi
>
> 	if test -z "$immediate" || test $eval_ret = 0 ||
> 	   test -n "$expecting_failure" && test "$test_cleanup" != ":"
>
>And then run:
>
>  ./t5562-http-backend-content-length.sh --stress
>
>I get many successful completions, but eventually one fails t5562.8
>with:
>
>  took 60 seconds to finish; failing
>
>That 60 seconds is the timeout from t5562/invoke-with-content-length.
>
>So one, are you sure it's hanging forever, and not just for 60 seconds?

Absolutely sure. 48 hours because I forgot to check.

>And two, it is quite obvious there's some racing here. I'm not sure if this is indicative of a problem in the test suite, or in http-backend
>itself (in which case it could be affecting real users).

How can I help track this down?

>> This looks strange. There is no signal 34 defined by the platform.
>>
>> test_must_fail: died by signal 34: git send-email --from=Example
>> <nobody@example.com> --to=nobody@example.com
>> --smtp-server=/home/git/git/t/trash
>> directory.t9001-send-email/fake.sendmail --transfer-encoding=8bit
>> 0001-Second.patch longline.patch not ok 33 - reject long lines [...]
>
>On my system 34 is SIGRTMIN, so I agree that seems unlikely. Keep in mind, though, that we are getting the exit code from the shell, so
>we interpret codes between 129 and 192 as 128+signo, which is the shell's convention.
>
>If the program actually called exit(162), we'd see that as "signal 34".  Likewise for exit(-94), since the result is cast to unsigned.
>
>Now why send-email would do that, I have no idea. The expected error from this test (the "... is longer than 998" message) should come
>from calling perl's "die", which usually exits with code 255. You can double check with:
>
>  perl -e 'die "foo"'
>  echo $?
>
>but I'd be surprised if it varies between systems (and also I expect other tests sometimes call die, too).
>
>Beyond that, I expect your best bet is to instrument send-email itself to print more information about how it's exiting here (or possibly use
>your platform's equivalent of strace, if it has one).

We're getting exit code 255, not 162 in this test. t9001 is the only test where this is happening. The only other test that occasionally hangs is t0301, but not any consistency on which subtest although 6 or 8 is more often than not the offender. Interestingly, perl is not in ${prefix}. It comes from /usr/bin/perl (5.26.3), but PERL_PATH is specified explicitly in config.mak.uname as /usr/bin/perl, so:

use lib (split(/:/, $ENV{GITPERLLIB} || '/usr/local-ssl1.1/share/perl5'));

may or may not be an issue. There is another quirk on the platform. The first output message to stdout determines the encoding. If wchar is used first, and then something else uses char for output, the program behaves strangely - and output disappears randomly; the reverse is also true - and this does apply across a fork. Sadly, my perl is not expert level.

