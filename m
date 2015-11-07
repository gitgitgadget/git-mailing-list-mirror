From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sat, 7 Nov 2015 21:21:11 +0000
Message-ID: <563E6B47.5000807@ramsayjones.plus.com>
References: <563DEA71.1080808@dinwoodie.org>
 <20151107184527.GA4483@sigill.intra.peff.net>
 <20151107192029.GW14466@dinwoodie.org>
 <1446930165.16957.9.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 07 22:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvAvP-00050N-AB
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 22:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbbKGVVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 16:21:22 -0500
Received: from avasout01.plus.net ([84.93.230.227]:52590 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbbKGVVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 16:21:21 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout01 with smtp
	id elMJ1r0012GQ2gJ01lMK3Y; Sat, 07 Nov 2015 21:21:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MbeRwMLf c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=tlGd1AaCrvFmyQjEw_cA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1446930165.16957.9.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281024>



On 07/11/15 21:02, Dennis Kaarsemaker wrote:
> On za, 2015-11-07 at 19:20 +0000, Adam Dinwoodie wrote:
>> On Sat, Nov 07, 2015 at 01:45:27PM -0500, Jeff King wrote:
>>> On Sat, Nov 07, 2015 at 12:11:29PM +0000, Adam Dinwoodie wrote:
>>>
>>>> Specifically, I'm seeing t5813 subtests 9-13 and 15-19 failing.
>>>> This happens
>>>> with a clean build straight from the Git source tree (git clean 
>>>> -dfx && make
>>>> configure && ./configure && make && cd t && ./t5813-proto-disable
>>>> -ssh.sh) as
>>>> well as builds using the Cygwin packaging paraphernalia.
>>>
>>> What does the output of "./t5813-proto-disable-ssh.sh -v -i" show?
>>>
>>> It seems strange that it would fail only on Cygwin; this code
>>> doesn't
>>> really use any platform-dependent features. It's also weird that it
>>> fails _only_ for ssh, and _only_ on the tests that are using
>>> "ssh://"
>>> URLs are not "host:path" syntax.
>>
>> Ah!  I thought I'd checked that already, but looking at the output
>> now I
>> can see what's going wrong.  Cutting down to the relevant error:
>>
>>     ssh: remote git-upload-pack '//home/Adam/vcs/Cygwin-Git/git-2.6.2
>> -1.x86_64/build/t/trash directory.t5813-proto-disable
>> -ssh/remote/repo.git' fatal: '//home/Adam/vcs/Cygwin-Git/git-2.6.2
>> -1.x86_64/build/t/trash directory.t5813-proto-disable
>> -ssh/remote/repo.git' does not appear to be a git repository
>>
>> Note the '//' at the start of the path -- on most *nix systems '//'
>> is
>> effectively identical to '/'.  On Cygwin, however, '//' is used to
>> access Windows UNC paths: what Windows calls "\\server\share", Cygwin
>> calls "//server/share".  If you replace the '//' with '/' you get the
>> locatoin of the repository; but here Cygwin is looking for the
>> repository in a share called "Adam" on a network server called
>> "home"...
>>
>> I suspect the correct fix here is to fix whatever's causing Git to
>> generate a path with that '//'.  If nobody else gets to it soon
>> (probably on the order of a week before I'll get the chance), I'll go
>> code diving and submit a patch.
>>
>>> I tried building on Linux with the Cygwin build knobs found in
>>> config.mak.uname, but I couldn't get it to fail. I also wondered if
>>> the
>>> test was doing something with the shell that might not be portable,
>>> but
>>> I don't see anything interesting.
>>
>> If I recall correctly, the correct interpretation of '//' isn't
>> defined
>> in POSIX, so whatever's causing that path to be generated is the bit
>> that's not fully portable.  It looks as though t5813 throwing this up
>> is
>> just a coincidence rather than it being particularly related to the
>> function those tests are actually testing.
> 
> Looks like lib-proto-disable.sh's fake SSH doesn't strip double leading
> /'es from the path. Try this patch:
> 
> diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable
> -ssh.sh
> index ad877d7..a954ead 100755
> --- a/t/t5813-proto-disable-ssh.sh
> +++ b/t/t5813-proto-disable-ssh.sh
> @@ -14,7 +14,7 @@ test_expect_success 'setup repository to clone' '
>  '
>  
>  test_proto "host:path" ssh "remote:repo.git"
> -test_proto "ssh://" ssh "ssh://remote/$PWD/remote/repo.git"
> -test_proto "git+ssh://" ssh "git+ssh://remote/$PWD/remote/repo.git"
> +test_proto "ssh://" ssh "ssh://remote$PWD/remote/repo.git"
> +test_proto "git+ssh://" ssh "git+ssh://remote$PWD/remote/repo.git"

Heh, this looks familiar ... see, for example, commit 3a81f33c5. ;-)

ATB,
Ramsay Jones
