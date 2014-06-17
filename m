From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 02/14] submodules: Add the lib-submodule-update.sh test
 library
Date: Tue, 17 Jun 2014 22:46:50 +0200
Message-ID: <53A0A93A.9050305@web.de>
References: <539DD029.4030506@web.de> <539DD09A.7010200@web.de>	<xmqqwqcgo4gc.fsf@gitster.dls.corp.google.com>	<53A07BCE.5010100@web.de> <xmqqwqcfl6jh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 22:47:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx0He-0006Hw-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 22:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbaFQUrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 16:47:06 -0400
Received: from mout.web.de ([212.227.17.12]:58052 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933428AbaFQUrE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 16:47:04 -0400
Received: from [192.168.178.41] ([84.132.188.209]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M57Vi-1WnbKX1o0U-00zFb5; Tue, 17 Jun 2014 22:46:51
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqwqcfl6jh.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:/PL/smWDQV1hwz61frwYMnQeApDwTmFtsQCfIxE8ZQqk3nkzmD4
 n5QrSQGJfoBN3MiYeDpL5PQsyD1aTvfIowTKxn0T1BANnIkD5qNmGTbUT+X80mCY9pZuR2t
 UL78C40dYU1EQzyWL54xRuXSKkSWmpx0bPqY7LoIDhYSVJ/+bBpRQt0u26ucKzwqSuXqBVL
 VgF9cRPz+VSHNVct11F8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251949>

Am 17.06.2014 20:44, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 17.06.2014 00:49, schrieb Junio C Hamano:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>> +		GIT_WORK_TREE=. git config --unset core.worktree
>>>
>>> Hmph.  What does GIT_WORK_TREE=. alone without GIT_DIR=<somewhere>
>>> do?  It's not like it is a workaround for "git config" that complains
>>> when you do not have a working tree, right?  Puzzled...
>>
>> It is, it overrides the core.worktree config that would stop us
>> from unsetting the core.worktree config with this error message:
>>
>>   fatal: Could not chdir to '../../../sub1': No such file or directory
>>
>> (We use the same pattern in git-submodule.sh and some other tests)
> 
> Is this a work-around for a bug in "git config"?  Or is this an
> expected failure and it is unusual and not realistic outside of test
> setup to want to unset core.worktree?  I am inclined to think it is
> the latter, but I dunno.

I didn't think deeply about that, but when I first encountered
this behavior it felt a bit strange that config does a chdir into
the work tree. I somehow expected it only to access the config
file in GIT_DIR and not the work tree, but I didn't care enough
to investigate further after I found this solution.

>>>> +		sha1=$(git ls-tree HEAD "sub1" 2>/dev/null | grep 160000 | tr '\t' ' ' | cut -d ' ' -f3) &&
>>>
>>> Why discard the standard error stream?
>>
>> Because we sometimes reset to commits where "sub1" isn't present:
>>
>>   fatal: Path 'sub1' does not exist in 'HEAD'
> 
> Huh?  We shouldn't.
> 
> 	$ git ls-tree HEAD no-such; echo $?
>         0

You are correct, it looks like I used rev-parse instead of
ls-files when producing that error.

> It discards errors that may happen in other situations, too---is
> that something we do not have to worry about?

I'll look deeper into that tomorrow. After all in some tests
"sub1" will be a file and not a submodule, and then we should
not try to populate it ...

>>>> +# Test that the given submodule at path "$1" contains the content according
>>>> +# to the submodule commit recorded in the superproject's commit "$2"
>>>> +test_submodule_content () {
>>>> +	if test $# != 2
>>>> +	then
>>>> +		echo "test_submodule_content needs two arguments"
>>>> +		return 1
>>>> +	fi &&
>>>> +	submodule="$1" &&
>>>> +	commit="$2" &&
>>>> +	test -d "$submodule"/ &&
>>>> +	if ! test -f "$submodule"/.git && ! test -d "$submodule"/.git
>>>
>>> I wonder if we can get away with a single "test -e" (we do not
>>> expect us to be creating device nodes or fifos there, do we?).
>>
>> But a symbolic link maybe?
> 
> Symlinks should pose no problems, ...

Oh, I forgot to add a smiley there, I haven't been serious about
that statement. I don't care too deeply about it but feel a bit
more confident with the two explicit tests. Do you want me to
change them to a single "test -e"?
