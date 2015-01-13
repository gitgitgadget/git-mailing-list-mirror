From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Tue, 13 Jan 2015 23:33:08 +0100
Message-ID: <54B59D24.7030508@kdbg.org>
References: <54B5579B.4080607@kdbg.org> <20150113214733.GA16582@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:33:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBA1Y-0001Pk-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 23:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbbAMWdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 17:33:15 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:36147 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752384AbbAMWdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 17:33:12 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kMRPx69Gzz5tlC;
	Tue, 13 Jan 2015 23:33:09 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E9D2919F8CC;
	Tue, 13 Jan 2015 23:33:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20150113214733.GA16582@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262357>

Am 13.01.2015 um 22:47 schrieb Jeff King:
> On Tue, Jan 13, 2015 at 06:36:27PM +0100, Johannes Sixt wrote:
> 
>> For some unknown reason, the dd on my Windows box segfaults every now
>> and than, but since recently, it does so much more often than it used
>> to, which makes running the test suite burdensome.
>>
>> Get rid of four invocations of dd and use test-genrandom instead.
> 
> There are a dozen other uses of dd in the test suite. Do they all need
> to go?

Yes, at best.

>> The new code does change some properties of the generated files:
>>
>>  - They are a bit smaller.
>>  - They are not sparse anymore.
>>  - They do not compress well anymore.
> 
> This is unfortunate, as it means other platforms will be slower. I
> measured a best-of-five on running t1050 going from 0.780s to 1.750s.
> That's on an SSD. Doing it on a RAM disk the numbers are 0.600s and
> 1.394s. Better, but not great.

Certainly you run the test suite a *LOT* more often than I do, so
theoretically, your (and everybody else's) lost time does add up to
more than the 5 minutes that I need to take care of the failing test
scripts until each test case happens to succeed at least once. So...

BTW, is it the incompressibility where the time is lost or lack of
sparseness of the files? How does the timing change with this patch on
top?

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f653121..9cf4e0e 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -9,10 +9,10 @@ test_expect_success setup '
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
 	git config --global core.bigfilethreshold 200k &&
-	test-genrandom seed1 2000000 >large1 &&
+	printf "\0%2000000s" X >large1 &&
 	cp large1 large2 &&
 	cp large1 large3 &&
-	test-genrandom seed2 2500000 >huge &&
+	printf "\0%2500000s" Y >huge &&
 	GIT_ALLOC_LIMIT=1500k &&
 	export GIT_ALLOC_LIMIT
 '
