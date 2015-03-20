From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: test &&-chain lint (was: [PATCH 1/5] t5312: test object deletion
 code paths in a corrupted repository)
Date: Fri, 20 Mar 2015 03:18:23 -0400
Message-ID: <CAPig+cQ29Ab7-2RWB6HXUk=oikhpF=1J7qnLcw6kqvTR7p_tow@mail.gmail.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
	<CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
	<20150320013217.GA15302@peff.net>
	<CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
	<20150320020851.GC15302@peff.net>
	<20150320022532.GA5502@peff.net>
	<20150320051051.GA30803@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 08:18:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYrCQ-00073q-5Q
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 08:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbCTHS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 03:18:26 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34497 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbbCTHSY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 03:18:24 -0400
Received: by yhch68 with SMTP id h68so36088810yhc.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kI3LhIijIwqnzVar1X1ierXnFOWqXEOzsdooTEf7858=;
        b=nyfduOHZF6L59YXkBe626A2xpRgaMf81lcdtgI6ypQiurS67FZptBPmgIU8embCf4j
         ampkbvKntEjzPH8C8d+VTxccs0ys13M5fkGi+DE4EWlPNtTdkYjJ1pg5Efrjx1cn0Bi1
         B/3Wrl8LfNt9Pyl+Tk1lYZ/zOiz97Ftlh0OWbi5ejbdlSDlm7/Cw1k5BHysB5MSCwdfe
         xQ1gy7kOWHX1advaTLV5LLDuFgLGzrOIof8ae9AJfbRceDYMPISYSpeKfkCRqyP2nR08
         jR0rXwuWsulf5CjQCU51IL/8rSF/RHmeHQAlmB/v/j6OgLXRbZhSuk+pOxIG7y2eTqLN
         tn/A==
X-Received: by 10.236.105.210 with SMTP id k58mr80906082yhg.52.1426835903709;
 Fri, 20 Mar 2015 00:18:23 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Fri, 20 Mar 2015 00:18:23 -0700 (PDT)
In-Reply-To: <20150320051051.GA30803@peff.net>
X-Google-Sender-Auth: c_hlTB1NjryNhRS5dg_LFxKiBWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265867>

On Fri, Mar 20, 2015 at 1:10 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2015 at 10:25:32PM -0400, Jeff King wrote:
>> > diff --git a/t/test-lib.sh b/t/test-lib.sh
>> > index c096778..02a03d5 100644
>> > --- a/t/test-lib.sh
>> > +++ b/t/test-lib.sh
>> > @@ -524,6 +524,21 @@ test_eval_ () {
>> >  test_run_ () {
>> > +   if test -n "$GIT_TEST_CHAIN_LINT"; then
>> > +           # 117 is unlikely to match the exit code of
>> > +           # another part of the chain
>> > +           test_eval_ "(exit 117) && $1"
>> > +           if test "$?" != 117; then
>> > +                   # all bets are off for continuing with other tests;
>> > +                   # we expected none of the rest of the test commands to
>> > +                   # run, but at least some did. Who knows what weird
>> > +                   # state we're in? Just bail, and the user can diagnose
>> > +                   # by running in --verbose mode
>> > +                   error "bug in the test script: broken &&-chain"
>> > +           fi
>> > +   fi

Clever (Jonathan's too); much nicer than trying to special case only here-doc.

>> > This turns up an appalling number of failures, but AFAICT they are all
>> > "real" in the sense that the &&-chains are broken. In some cases these
>> > are real, but in others the tests are of an older style where they did
>> > not expect some early commands to fail (and we would catch their bogus
>> > output if they did). E.g., in the patch below, I think the first one is
>> > a real potential bug, and the other two are mostly noise. I do not mind
>> > setting a rule and fixing all of them, though.
>
> FWIW, I have spent about a few hours wading through the errors, and am
> about 75% done. There are definitely some broken chains that were
> causing test results to be ignored (as opposed to just minor setup steps
> that we would not expect to fail). In most cases, the tests do passed. I
> have a few that I still need to examine more closely, but there may be
> some where there are actual test failures (but it's possible that I just
> screwed it up while fixing the &&-chaining).
>
> I hope to post something tonight, but I wanted to drop a note on the off
> chance that you were actively looking at it at the same time.

Thanks for working on this. It looks like this technique should be a
valuable addition to test-lint. (I had intended, but haven't yet found
time to dig into it, so I'm happy to hear of your progress.)
