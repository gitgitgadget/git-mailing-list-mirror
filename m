Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34EC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3A60F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhHPSfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:35:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48752 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhHPSfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:35:45 -0400
Received: (qmail 22271 invoked by uid 109); 16 Aug 2021 18:35:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 18:35:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17198 invoked by uid 111); 16 Aug 2021 18:35:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 14:35:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 14:35:11 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRqv30kTZqW9nMN0@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
 <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
 <01b401d792c9$c083e4b0$418bae10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01b401d792c9$c083e4b0$418bae10$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 02:08:38PM -0400, Randall S. Becker wrote:

> On August 13, 2021 12:07 PM, Jeff King wrote:
> >On Fri, Aug 13, 2021 at 10:22:19AM -0400, Randall S. Becker wrote:
> >
> >> >Just a report that t0301.9 hung again on 2.32.0-rc1 on the NonStop
> >> >ia64 platform, and t5563.8 hung on the x86 platform. These did not
> >
> >We don't seem to have a t5563. Do you mean t5562?
> Yes.

I've seen issues with t5562.8, as well. It doesn't _fail_, but I
occasionally notice that it takes a very long time to complete. If I
instrument the test suite like this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d6..45e6062e3a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -989,10 +989,18 @@ test_run_ () {
 		trace=$trace_tmp
 	fi
 
+	start=$(date +%s)
 	setup_malloc_check
 	test_eval_ "$1"
 	eval_ret=$?
 	teardown_malloc_check
+	end=$(date +%s)
+
+	len=$((end - start))
+	if test $len -gt 5; then
+		echo >&2 "took $len seconds to finish; failing"
+		eval_ret=1
+	fi
 
 	if test -z "$immediate" || test $eval_ret = 0 ||
 	   test -n "$expecting_failure" && test "$test_cleanup" != ":"

And then run:

  ./t5562-http-backend-content-length.sh --stress

I get many successful completions, but eventually one fails t5562.8
with:

  took 60 seconds to finish; failing

That 60 seconds is the timeout from t5562/invoke-with-content-length.

So one, are you sure it's hanging forever, and not just for 60 seconds?
And two, it is quite obvious there's some racing here. I'm not sure if
this is indicative of a problem in the test suite, or in http-backend
itself (in which case it could be affecting real users).

> This looks strange. There is no signal 34 defined by the platform.
> 
> test_must_fail: died by signal 34: git send-email --from=Example <nobody@example.com> --to=nobody@example.com --smtp-server=/home/git/git/t/trash directory.t9001-send-email/fake.sendmail --transfer-encoding=8bit 0001-Second.patch longline.patch
> not ok 33 - reject long lines
> [...]

On my system 34 is SIGRTMIN, so I agree that seems unlikely. Keep in
mind, though, that we are getting the exit code from the shell, so we
interpret codes between 129 and 192 as 128+signo, which is the shell's
convention.

If the program actually called exit(162), we'd see that as "signal
34".  Likewise for exit(-94), since the result is cast to unsigned.

Now why send-email would do that, I have no idea. The expected error
from this test (the "... is longer than 998" message) should come from
calling perl's "die", which usually exits with code 255. You can double
check with:

  perl -e 'die "foo"'
  echo $?

but I'd be surprised if it varies between systems (and also I expect
other tests sometimes call die, too).

Beyond that, I expect your best bet is to instrument send-email itself
to print more information about how it's exiting here (or possibly use
your platform's equivalent of strace, if it has one).

-Peff
