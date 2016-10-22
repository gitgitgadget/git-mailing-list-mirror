Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8000F20229
	for <e@80x24.org>; Sat, 22 Oct 2016 04:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbcJVEpL (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 00:45:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:32786 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbcJVEpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 00:45:10 -0400
Received: (qmail 11933 invoked by uid 109); 22 Oct 2016 04:45:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 04:45:09 +0000
Received: (qmail 9383 invoked by uid 111); 22 Oct 2016 04:45:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 00:45:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2016 00:45:06 -0400
Date:   Sat, 22 Oct 2016 00:45:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: [PATCH 4/3] test-lib: bail out when "-v" used under "prove"
Message-ID: <20161022044506.vba6g2q25yxa2air@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net>
 <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
 <CA+P7+xozpk2-WZUYtaKmCazG3Owzpa3bsDejyUuGj0YEQnJWJg@mail.gmail.com>
 <20161021153534.mjed3sqhxjelxzwx@sigill.intra.peff.net>
 <CA+P7+xrix3UZDEE1swG_=jBLwWHA04KoYikWBBMNx7aa=Hevmw@mail.gmail.com>
 <20161021154840.pdmb5c3gjharsrxe@sigill.intra.peff.net>
 <CA+P7+xp8TDL59tQgCpmMDJ-BspA1CF6YsnuGMXas1bx_X0qJoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xp8TDL59tQgCpmMDJ-BspA1CF6YsnuGMXas1bx_X0qJoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 09:15:28AM -0700, Jacob Keller wrote:

> >> > For $HARNESS_ACTIVE with _just_ "--verbose", I don't think it would be a
> >> > good idea to activate it. We should either silently ignore --verbose
> >> > then, or complain and die.
> >>
> >> We should probably do that to make sure people realize what might
> >> happen. I read your series and it has a good explanation of the
> >> possible alternatives. I like the approach you chose.
> >
> > Thanks. Do you want to make a patch on top of my series?
> 
> I am not sure I will find time to do it today, so it wouldn't be for a
> few more days.

I thought I'd just knock this out in 5 minutes before I forgot about it.
But as with so many things, getting it right proved slightly harder than
I thought. But I did learn about TAP's "Bail out!" directive. And
apparently you can pass it back arbitrary YAML (!). And the "--verbose"
output really is violating the spec, and they claim that Test::Harness
will eventually be tightened to complain (though that was in 2007, and
it still hasn't happened, so...).

Anyway. Here is the patch I came up with (on top of the others).

-- >8 --
Subject: test-lib: bail out when "-v" used under "prove"

When there is a TAP harness consuming the output of our test
scripts, the "--verbose" breaks the output by mingling
test command output with TAP. Because the TAP::Harness
module used by "prove" is fairly lenient, this _usually_
works, but it violates the spec, and things get very
confusing if the commands happen to output a line that looks
like TAP (e.g., the word "ok" on its own line).

Let's detect this situation and complain. Just calling
error() isn't great, though; prove will tell us that the
script failed, but the message doesn't make it through to
the user. Instead, we can use the special TAP signal "Bail
out!". This not only shows the message to the user, but
instructs the harness to stop running the tests entirely.
This is exactly what we want here, as the problem is in the
command-line options, and every test script would produce
the same error.

The result looks like this (the first "Bailout called" line
is in red if prove uses color on your terminal):

 $ make GIT_TEST_OPTS='--verbose --tee'
 rm -f -r 'test-results'
 *** prove ***
 Bailout called.  Further testing stopped:  verbose mode forbidden under TAP harness; try --verbose-log
 FAILED--Further testing stopped: verbose mode forbidden under TAP harness; try --verbose-log
 Makefile:39: recipe for target 'prove' failed
 make: *** [prove] Error 255

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 85946ec40d..b859db61ac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -321,6 +321,16 @@ say () {
 	say_color info "$*"
 }
 
+if test -n "$HARNESS_ACTIVE"
+then
+	if test "$verbose" = t || test -n "$verbose_only"
+	then
+		printf 'Bail out! %s\n' \
+		 'verbose mode forbidden under TAP harness; try --verbose-log'
+		exit 1
+	fi
+fi
+
 test "${test_description}" != "" ||
 error "Test script did not set test_description."
 
-- 
2.10.1.776.ge0e381e

