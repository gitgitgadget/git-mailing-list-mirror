From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 15:28:11 +0100
Message-ID: <550C2E7B.3030203@drmicha.warpmail.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 15:28:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYxuP-0000QJ-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 15:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbbCTO2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 10:28:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33155 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751479AbbCTO2O (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 10:28:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 18C0920AA6
	for <git@vger.kernel.org>; Fri, 20 Mar 2015 10:28:11 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 20 Mar 2015 10:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	 s=mesmtp; bh=WYZevMw1BPBpinBgp5vdZfR8/Mg=; b=cnkqRfqdza4fiwSqPr
	CC3lNSTlXwhWUcsb/k2hgFXaRewmXFuQaARodBCyhdDYD46C1j/CIsl0dhMZTyPF
	E2IKMz4Urw8iUzd29uWDfcQWX+PmgMnt5lUuTMwpkwmenKiCgqfDDtu5Ay0VH/lP
	DlN9j3z/Lfkz7VhrUaYPARs6s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=WYZevMw1BPBpinBgp5vdZf
	R8/Mg=; b=ME0mYJ8Ss/92QicydaTJctFXdZGFVt394C2G2QwFVFTC8dmEJ9WLyY
	J0xY0R87jglVM6E+87LOkshk5TcbQ8J1N5LOG58/IXnMTN2qLU53SKvu3AU2OxUt
	h9Wh/d/2dx+Q3lwgWIlx1lnlK/BUMN9E7BeTRkwc21UXKx9iy66/k=
X-Sasl-enc: vNe9r+3RnxLPPuJCRKeaKsTn03RZNCBVK3M6kpQBrGA8 1426861693
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CD898680102;
	Fri, 20 Mar 2015 10:28:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265905>

Jeff King venit, vidit, dixit 20.03.2015 11:04:
> This is a cleanup of the &&-chain lint I posted earlier:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/265613/focus=265859
> 
> I don't know who came up with the idea for it originally, but the
> concept certainly was floating in the back of my mind from Jonathan's
> earlier version that is referenced in that thread.
> 
> The general idea is to detect &&-chain breakage that can lead to our
> tests yielding false success. The first patch implements and discusses
> the lint-check itself, which is quite simple. The bulk of the work was
> fixing all of the issues in the existing tests. :)
> 
> That didn't all need to happen immediately. I mainly wanted to start on
> it to answer two questions:
> 
>   1. Are &&-chain breakages actually preventing us from seeing any test
>      failures? Or is it mostly just pedantry, and we miss out only on
>      knowing whether "cat >expect <<-\EOF" failed (which presumably it
>      never does).
> 
>   2. How bad are the false positives? Both how common, and how bad to
>      work around.
> 
> But after a few hours, I reached a zen state and just kept going. So at
> the end of this series, the whole test suite is --chain-lint clean
> (modulo any tests that are skipped on my platform). We could even switch
> the checks on by default at the end of the series, but I didn't do that
> here. I think it would be sane to run them all the time, though; in the
> normal success case, they don't add any forks (the shell just runs
> "(exit) && ...", and realizes that the whole thing is one big &&-chain).
> I couldn't measure any time difference running the suite with and
> without it.
> 
> Anyway, to answer the questions: Yes, there were definitely tests whose
> values were being thrown away, and we would not have noticed if they
> failed. The good news is that all of them did pass once we started
> checking their results. Hooray.
> 
> There were a number of false positives, though as a percentage of the
> test suite, probably not many (it's just that we have quite a lot of
> tests).  Most of them were in rather old tests, and IMHO the fixes I did
> actually improved the readability of the result. So overall I think this
> is a very positive change; I doubt it will get in people's way very
> often, and I look forward to having one less thing to worry about
> handling manually in review. The biggest downside is that I may have
> automated Eric Sunshine out of a job. :)
> 
> The patches are:
> 
>   [01/25]: t/test-lib: introduce --chain-lint option
>   [02/25]: t: fix severe &&-chain breakage
>   [03/25]: t: fix moderate &&-chain breakage
>   [04/25]: t: fix trivial &&-chain breakage
>   [05/25]: t: assume test_cmp produces verbose output
>   [06/25]: t: use verbose instead of hand-rolled errors
>   [07/25]: t: use test_must_fail instead of hand-rolled blocks
>   [08/25]: t: fix &&-chaining issues around setup which might fail
>   [09/25]: t: use test_might_fail for diff and grep
>   [10/25]: t: use test_expect_code instead of hand-rolled comparison
>   [11/25]: t: wrap complicated expect_code users in a block
>   [12/25]: t: avoid using ":" for comments
>   [13/25]: t3600: fix &&-chain breakage for setup commands
>   [14/25]: t7201: fix &&-chain breakage
>   [15/25]: t9502: fix &&-chain breakage
>   [16/25]: t6030: use modern test_* helpers
>   [17/25]: t0020: use modern test_* helpers
>   [18/25]: t1301: use modern test_* helpers
>   [19/25]: t6034: use modern test_* helpers
>   [20/25]: t4117: use modern test_* helpers
>   [21/25]: t9001: use test_when_finished
>   [22/25]: t0050: appease --chain-lint
>   [23/25]: t7004: fix embedded single-quotes
>   [24/25]: t0005: fix broken &&-chains
>   [25/25]: t4104: drop hand-rolled error reporting
> 
> It's a lot of patches, and a few of them are long. I tried to group
> them by functionality rather than file (though as you can see, some of
> the tests were unique enough snowflakes that it made sense to discuss
> their issues separately). I'm hoping it should be an easy review, if
> not a short one.
> 
> I'll spare you the full per-file diffstat, but the total is a very
> satisfying:
> 
>    84 files changed, 397 insertions(+), 647 deletions(-)
> 
> That's a lot of changes in a lot of hunks, but most of them are in files
> that haven't been touched in a while. The series merges cleanly with
> "pu", so I don't think I've stepped on anyone's topics in flight.
> 
> -Peff

Nice series! In fact, it's a great place to learn many of the test suite
features that we have nowadays.

With 1/25 only, I get 163 dubious or failed on current next.
With 1/25 and only chain-lint without running the actual test loads, I
get 213.

So, just as Jeff explained, we don't want a "chain-lint-only mode"
because it does not give correct results.

I reviewed the first 15 and they all look good.
I skimmed through the rest and it appears good to (though this is no
review).

You run without git svn tests, obviously... I'll follow up with two
patches for those.

Michael
