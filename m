From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] difftool: support repositories with .git-files
Date: Tue, 25 Feb 2014 20:34:30 +0000
Message-ID: <530CFE56.6040807@web.de>
References: <1393211555-50270-1-git-send-email-davvid@gmail.com>	<xmqqr46s9yzx.fsf@gitster.dls.corp.google.com>	<530BB548.3050603@web.de> <xmqq1tyr6pfw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?R8Oh?= =?UTF-8?B?Ym9yIExpcHTDoWs=?= 
	<gabor.liptak@gmail.com>, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 21:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIOiJ-00039C-Lz
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 21:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbaBYUeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Feb 2014 15:34:46 -0500
Received: from mout.web.de ([212.227.17.11]:58455 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbaBYUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 15:34:44 -0500
Received: from [192.168.1.102] ([90.174.2.76]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0LrYLd-1XEiV13NAz-013Kt1 for <git@vger.kernel.org>; Tue,
 25 Feb 2014 21:34:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqq1tyr6pfw.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:YPBEnKDNr8+zyWqUYiunwU6eCVx3nIoz3PAB3cp4XMQUenKtB14
 4dlCStC/8PG+L4nmjuC1mg6f6K6jng6DitlT/anDCQ89wfjfbCKN6Z82KaPPArL+tGmRYZj
 SbuCw+c48NehXRMgPjRW79hBeFO5hXDH3mWgL9aJGxmpaGL+oK7uFVnzVm2X8bhCZwyP+Ec
 Rstd5zZy+KoZnNihtF4/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242681>

Am 25.02.2014 18:02, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
>> Am 24.02.2014 17:55, schrieb Junio C Hamano:
>>> David Aguilar <davvid@gmail.com> writes:
>>>
>>>> Modern versions of "git submodule" use .git-files to setup the
>>>> submodule directory.  When run in a "git submodule"-created
>>>> repository "git difftool --dir-diff" dies with the following
>>>> error:
>>>>
>>>> 	$ git difftool -d HEAD~
>>>> 	fatal: This operation must be run in a work tree
>>>> 	diff --raw --no-abbrev -z HEAD~: command returned error: 128
>>>>
>>>> core.worktree is relative to the .git directory but the logic
>>>> in find_worktree() does not account for it.
>>>>
>>>> Use `git rev-parse --show-toplevel` to find the worktree so that
>>>> the dir-diff feature works inside a submodule.
>>>>
>>>> Reported-by: G=C3=A1bor Lipt=C3=A1k <gabor.liptak@gmail.com>
>>>> Helped-by: Jens Lehmann <jens.lehmann@web.de>
>>>> Helped-by: John Keeping <john@keeping.me.uk>
>>>> Signed-off-by: David Aguilar <davvid@gmail.com>
>>>> ---
>>>
>>> Looks good; thanks.
>>
>>
>> FWIW:
>> Tested-by: Jens Lehmann <jens.lehmann@web.de>
>>
>> What about squashing this in to detect any future regressions?
>>
>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>> index 2418528..d86ad68 100755
>> --- a/t/t7800-difftool.sh
>> +++ b/t/t7800-difftool.sh
>> @@ -434,4 +434,12 @@ test_expect_success PERL 'difftool --no-symlink=
s detects conflict ' '
>>  	)
>>  '
>>
>> +test_expect_success PERL 'difftool properly honours gitlink and cor=
e.worktree' '
>> +	git submodule add ./. submod/ule &&
>> +	(
>> +		cd submod/ule &&
>> +		git difftool --tool=3Decho  --dir-diff --cached
>=20
> In the context of this fix, finishing with 0 exit status may be all
> we care about, but do we also care about things like in what
> directory the tool is invoked in, what arguments and extra
> environment settings (if any) it is given, and stuff like that?

Sure. But I just intended to test the fix (and the test can easily
be extended by people who know more about difftool than I do).

> In fact, the "echo" in the above is very misleading.  The test
> relies on the fact that immediately after the submod/ule is cloned,
> "diff --cached" does not have to call any tool backend---if you
> modify some tracked file in its working tree and dropped --cached
> on the command line, the command will fail with "Huh?  I do not know
> what 'echo' diff/merge backend is", no?

Right, using echo was not the best choice here. I used it to avoid
the dependency to meld in the example of the OP (maybe using "true"
as tool would have indicated that the tool is not important here,
but looking into this again a simple "git difftool --dir-diff"
without any further arguments also shows that the fix is working).

Aas mentioned above, I'm not familiar with difftool and just wanted
to share an easy way to test the fix. But I do not care too deeply
about this test, so feel free to ignore it.
