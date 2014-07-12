From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Sat, 12 Jul 2014 20:23:18 +0200
Message-ID: <53C17D16.80106@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de>	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>	<53BCDDE2.1080301@web.de> <53BD87B3.8050901@web.de>	<xmqqmwci9vn1.fsf@gitster.dls.corp.google.com> <xmqqsim96ine.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 20:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X61xM-0008Jo-HX
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 20:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaGLSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 14:23:28 -0400
Received: from mout.web.de ([212.227.15.3]:60640 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbaGLSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 14:23:28 -0400
Received: from [192.168.178.41] ([79.193.71.94]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MMnD5-1XDyZJ0nUN-008Z2M; Sat, 12 Jul 2014 20:23:22
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqsim96ine.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:bNEkFScbq0WIT4msuGbtGvcQwWq0n/nYE06QtDuf2SwSZ/lE/8i
 7k30OFBx9cCOU437KsUbjZUDMp6GpigA+bFCHaBFupH0ysAhSDKyCNzpfyN4k3u+DSvqtNo
 XwMIcTrfaxf5XzVpJoHkiQNKlofvSbRtklRcrkbzpltzVNGbMM4L8NMRiXaHCsiPG4Ax9oj
 hrKMzKBwyyY3hL+yY5fSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253397>

Am 10.07.2014 22:52, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> I agree, but this case is special. The test asserts that nobody
>>> added, modified or removed *anything* inside the .git directory.
>>> The reason for problem we are seeing here is that I have to
>>> remove the core.worktree setting when moving the git directory
>>> from .git/modules into the submodule work tree.
>>
>> Hmph.  Comparing the files with core.worktree removed sounds like a
>> workaround that knows too much about the implementation detail of
>> what is being tested.  I am just wondering if core.worktree will
>> stay forever be the only thing that is special, or there may come
>> other things (perhaps as a fallout of integrating things like Duy's
>> multiple-worktree stuff).
>>
>> But perhaps we cannot do better than this.
> 
> One thing we should be able to do (and must do) better is to
> validate that core.worktree in the relocated config file actually
> points at the right place.  Unsetting before comparing may let us
> compare the relocated one in .git/modules/$1/config with the one
> that is embedded in the working tree (hence no .git/config), but the
> way your "how about this?" patch does, we wouldn't catch a possible
> breakage to the relocation code to point core.worktree to a bogus
> location, I'm afraid.

Indeed.

> Perhaps squashing this to 7e8e5af9 instead?

Yes please, this is much better than my first attempt.

>  t/lib-submodule-update.sh | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index e441b98..fc1da84 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -110,18 +110,23 @@ replace_gitfile_with_git_dir () {
>  }
>  
>  # Test that the .git directory in the submodule is unchanged (except for the
> -# core.worktree setting, which we temporarily restore). Call this function
> -# before test_submodule_content as the latter might write the index file
> -# leading to false positive index differences.
> +# core.worktree setting, which appears only in $GIT_DIR/modules/$1/config).
> +# Call this function before test_submodule_content as the latter might
> +# write the index file leading to false positive index differences.
>  test_git_directory_is_unchanged () {
>  	(
> -		cd "$1" &&
> -		git config core.worktree "../../../$1"
> +		cd ".git/modules/$1" &&
> +		# does core.worktree point at the right place?
> +		test "$(git config core.worktree)" = "../../../$1" &&
> +		# remove it temporarily before comparing, as
> +		# "$1/.git/config" lacks it...
> +		git config --unset core.worktree
>  	) &&
>  	diff -r ".git/modules/$1" "$1/.git" &&
>  	(
> -		cd "$1" &&
> -		GIT_WORK_TREE=. git config --unset core.worktree
> +		# ... and then restore.
> +		cd ".git/modules/$1" &&
> +		git config core.worktree "../../../$1"
>  	)
>  }
>  
> 
