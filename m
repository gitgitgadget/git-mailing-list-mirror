From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Mon, 16 Apr 2012 17:43:11 +0200
Message-ID: <4F8C3E0F.2040300@in.waw.pl>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl> <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:43:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJo5L-0006Yz-Me
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab2DPPnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:43:19 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34973 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab2DPPnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:43:18 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SJo5F-0007ca-C9; Mon, 16 Apr 2012 17:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120414122127.GA31220@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195648>

On 04/14/2012 02:21 PM, Clemens Buchacher wrote:
> On Sat, Apr 14, 2012 at 02:13:58PM +0200, Clemens Buchacher wrote:
>>
>> In order to better understand the problem on your side, can you execute
>> this script and tell me what it does for you?
> 
> Oops, this is what I really wanted:
> 
> #!/bin/sh
> 
> mkfifo fd
> yes>fd&
> pid=$!
> {
> 	read line
> 	echo $line
> 	cat<fd&
> }<fd
> sleep 1
> kill $pid
> wait $pid
> rm -f fd

Hi,
many thanks for looking into this. I'm sorry I didn't reply sooner,
but I was away for the weekend.

> And as a consequence, t5570 tests fail for you? I cannot reproduce with
> bash 4.2.24(2). Which git version are you seeing this with?
Yes. Example test output is:

----(on master 146fe8ce2)------------------------------------------------------------------
$ (cd t && GIT_TEST_GIT_DAEMON=t ./t5570*sh)
ok 1 - setup repository
ok 2 - create git-accessible bare repository
not ok - 3 clone git repository
#
#               git clone "$GIT_DAEMON_URL/repo.git" clone &&
#               test_cmp file clone/file
#
not ok - 4 fetch changes via git protocol
#
#               echo content >>file &&
#               git commit -a -m two &&
#               git push public &&
#               (cd clone && git pull) &&
#               test_cmp file clone/file
#
not ok 5 - remote detects correct HEAD # TODO known breakage
ok 6 - prepare pack objects
ok 7 - fetch notices corrupt pack
ok 8 - fetch notices corrupt idx
not ok - 9 clone non-existent
#       test_remote_error    clone nowhere.git 'access denied or repository not exported'
not ok - 10 push disabled
#       test_remote_error    push  repo.git    'access denied or repository not exported'
not ok - 11 read access denied
#       test_remote_error -x fetch repo.git    'access denied or repository not exported'
not ok - 12 not exported
#       test_remote_error -n fetch repo.git    'access denied or repository not exported'
./t5570-git-daemon.sh: 59: kill: No such process

error: git daemon exited with status: 141
-----------------------------------------------------------------------------------------

OK, I run your test scripts and found the problem (test.sh is the first
version, and test2.sh is the second version with 'cat' inside {}). Yikes!
I have /bin/sh symlinked to dash, and dash behaves differently:

% bash -x test2.sh | wc -l
+ mkfifo fd
+ pid=10685
+ yes
+ read line
+ echo y
+ sleep 1
+ cat
+ kill 10685
+ wait 10685
test2.sh: line 13: 10685 Terminated              yes > fd
+ rm -f fd
45400064

% dash -x test2.sh | wc -l
+ mkfifo fd
+ pid=10738
+ read line
+ yes
+ echo y
+ sleep 1
+ kill 10738
test2.sh: 12: kill: No such process

+ wait 10738
+ rm -f fd
^C

It hangs at the end until killed with ^C. This seem to happen fairly reliably
(nineteen times out of twenty or so). This is with dash 0.5.7-3 and 0.5.5.1-7.4
from debian. With bash test2.sh seems to always run successfully.

I also run test.sh for comparison, and dash runs test.sh successfully
every once in a while, and test.sh always fails with bash.

So my patch was totally bogus, it was just probably changing the timing.

Now your patches (on top of next):
'git-daemon wrapper to wait until daemon is ready' fixes the problem, thanks!

(I now see that they are both in pu: pu runs fine too.)

Thanks,
Zbyszek
