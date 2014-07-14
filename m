From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Mon, 14 Jul 2014 20:22:37 +0200
Message-ID: <53C41FED.5080101@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de>	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>	<53BCDDE2.1080301@web.de> <53BD87B3.8050901@web.de>	<xmqqmwci9vn1.fsf@gitster.dls.corp.google.com>	<xmqqsim96ine.fsf@gitster.dls.corp.google.com> <53C17D16.80106@web.de> <xmqq4myk21o8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ku1-0001i7-HI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 20:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbaGNSW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 14:22:58 -0400
Received: from mout.web.de ([212.227.17.12]:53383 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756820AbaGNSWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 14:22:47 -0400
Received: from [192.168.178.41] ([84.132.188.114]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MYvxn-1X3GMK1eSJ-00VgLG; Mon, 14 Jul 2014 20:22:43
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq4myk21o8.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:vwRJ3qGUVdmdRiB2ELpt/DDGY8qu9qMn+NtPYwsmjmJI4A9cCZ1
 imGEDpCYtSgQ7y1f8wA7IZ9JUU7uzTL7jlNuRTo4pNMTL/12/9tNEpZKLqJICWe3VStoPBE
 ORilapF82rk+YDzMXnJKN+LlAzN4f9LmybdCYqA9F6ChnG7Jgfy1Dxhrfc+QJlWTH1odH1i
 jNquU/9isyENWGMvzcSvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253506>

Am 14.07.2014 03:01, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>> Perhaps squashing this to 7e8e5af9 instead?
>>
>> Yes please, this is much better than my first attempt.
> 
> One thing that I found troubling is the ../../../ "three levels up"
> is hardcoded.  Would it be always true for any value of "$1"?  If
> the submodule is bound to the superproject at sub/dir/, not at dir/,
> for example, would it have to change?

Yes. And the code currently also doesn't handle submodules whose
name and path differ.

> I am not saying that we must support artibrary cases, but if there
> is such a limitation in the implementation, people who will use the
> helper in their new tests want it at least documented, I think.

Ah, I didn't think about other tests reusing that and only wrote
this as a local helper. But you're right, it would make sense to
reuse this function instead of coding that again (even though I'd
prefer to extract the generic helpers to t/lib-submodule.sh for
that purpose).

So what about adding "Currently only submodules living in the
root directory of the superproject with the default name (same
as the path) are supported." to the comment above the function?

>>>  t/lib-submodule-update.sh | 19 ++++++++++++-------
>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
>>> index e441b98..fc1da84 100755
>>> --- a/t/lib-submodule-update.sh
>>> +++ b/t/lib-submodule-update.sh
>>> @@ -110,18 +110,23 @@ replace_gitfile_with_git_dir () {
>>>  }
>>>  
>>>  # Test that the .git directory in the submodule is unchanged (except for the
>>> -# core.worktree setting, which we temporarily restore). Call this function
>>> -# before test_submodule_content as the latter might write the index file
>>> -# leading to false positive index differences.
>>> +# core.worktree setting, which appears only in $GIT_DIR/modules/$1/config).
>>> +# Call this function before test_submodule_content as the latter might
>>> +# write the index file leading to false positive index differences.
>>>  test_git_directory_is_unchanged () {
>>>  	(
>>> -		cd "$1" &&
>>> -		git config core.worktree "../../../$1"
>>> +		cd ".git/modules/$1" &&
>>> +		# does core.worktree point at the right place?
>>> +		test "$(git config core.worktree)" = "../../../$1" &&
>>> +		# remove it temporarily before comparing, as
>>> +		# "$1/.git/config" lacks it...
>>> +		git config --unset core.worktree
>>>  	) &&
>>>  	diff -r ".git/modules/$1" "$1/.git" &&
>>>  	(
>>> -		cd "$1" &&
>>> -		GIT_WORK_TREE=. git config --unset core.worktree
>>> +		# ... and then restore.
>>> +		cd ".git/modules/$1" &&
>>> +		git config core.worktree "../../../$1"
>>>  	)
>>>  }
>>>  
>>>
> 
