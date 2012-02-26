From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] submodules: Use relative paths to gitdir and work
 tree
Date: Sun, 26 Feb 2012 20:58:42 +0100
Message-ID: <4F4A8EF2.3020901@web.de>
References: <4F32F252.7050105@web.de> <4F4A6DFA.5080709@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 26 20:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1kF9-0003Q7-5C
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 20:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab2BZT6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 14:58:46 -0500
Received: from fmmailgate06.web.de ([217.72.192.247]:35388 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab2BZT6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 14:58:45 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate06.web.de (Postfix) with ESMTP id 3C21BD05B5E
	for <git@vger.kernel.org>; Sun, 26 Feb 2012 20:58:44 +0100 (CET)
Received: from [192.168.178.48] ([91.3.204.203]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M9Xfb-1S9Boz2BGp-00C8YM; Sun, 26 Feb 2012 20:58:43
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F4A6DFA.5080709@kdbg.org>
X-Provags-ID: V02:K0:yVBoPtIvXmP0dRBGSmZdm+gAWQ8kFag6j+JhHEkC/5D
 w8qw1RBaKeIc2TYWWy1tFy6rl8Bx+n+zQ/S921c+Kn47R2H7oY
 2jl1OA0hJ2rsB5GsAMs1bErtsv8YTVr84CisOWRJIdUlBITNEt
 nASoUPl7AHiWZlVnQDQnuKLluBHc0XjoccK/GHCUhy1S0WLQ7O
 0Wbq2YdRXFOgEcY/qiqFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191573>

Am 26.02.2012 18:38, schrieb Johannes Sixt:
> Am 08.02.2012 23:08, schrieb Jens Lehmann:
>> This patch series replaces all absolute paths pointing from submodule work
>> trees to its gitdir and back with relative paths as discussed in $gmane/187785.
>>
>> The motivation is to make superprojects movable again. They lost this ability
>> with the move of the git directory of submodules into the .git/modules directory
>> of the superproject. While fixing that a bug which would hit when moving the
>> submodule inside the superproject was also fixed.
>>
>> Jens Lehmann (2):
>>   submodules: always use a relative path to gitdir
>>   submodules: always use a relative path from gitdir to work tree
> 
> This series, with the tip at e3307adaba in Junio's repo causes major
> headaches on Windows.
>
> First, a check for an absolute path must be extended to take
> Windows-style paths into account.

Okay, but that check is not part of my series (it was introduced by 501770e1
"Move git-dir for submodules", which is in Git since 1.7.8), so that looks
like it would need to be fixed for msysgit even without my patches, right?

But I'm not so happy about the two code paths there anyway, so I prepared a
patch to replace them with a single code path based upon the paths computed
in the last patch of this series. Please see the always-use-relative-gitdir
branch in my github repo https://github.com/jlehmann/git-submod-enhancements

> Second, the a's and b's are filled with different forms of absolute
> paths (/c/there vs. c:/there), and as a consequence the subsequent loops
> do not find a suitable relative path.
> 
> The below is a minimal hack that passes all t/*submod* tests, but it
> works only on Windows, where the pwd utility has an option -W that
> prints a Windows style absolute path.
> 
> How would you have this solved? One option would be to introduce a function
> 
>   pwd() { builtin pwd -W "$@"; }
> 
> in git-sh-setup conditionally on Windows (but that would affect other
> shell scripts, too).

I suspect other shell scripts might be less affected when non-Windows
paths are forced (at least when they aren't developed under Windows
only). What about something like this:

  pwd() { builtin pwd -W "$@" | sed -e 's,^\([a-z]\):/,/\1/,'; }

> Any other ideas?
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3463d6d..f37745e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -139,8 +139,8 @@ module_clone()
>  	gitdir="$gitdir/modules/$path"
>
>  	case $gitdir in
> -	/*)
> -		a="$(cd_to_toplevel && pwd)/"
> +	/* | [a-z]:/*)
> +		a="$(cd_to_toplevel && pwd -W)/"
>  		b=$gitdir
>  		while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
>  		do

Hmm, here the path which starts with "c:/" is returned by the "git
rev-parse --git-dir" which is used to initialize the $gitdir variable
a few lines up.

> @@ -170,8 +170,8 @@ module_clone()
>
>  	echo "gitdir: $rel_gitdir" >"$path/.git"
>
> -	a=$(cd "$gitdir" && pwd)
> -	b=$(cd "$path" && pwd)
> +	a=$(cd "$gitdir" && pwd -W)
> +	b=$(cd "$path" && pwd -W)
>  	while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
>  	do
>  		a=${a#*/} b=${b#*/};

I don't understand why you need this. Does "pwd" sometimes return a
path starting with "c:/" and sometimes "/c/" depending on what form
you use when you cd into that directory? If not, does the following
help you on windows? (If that is the case, you might need the pwd
redefinition too to make that work)

-----------------8<--------------------
diff --git a/git-submodule.sh b/git-submodule.sh
index 5deabf6..5bb8109 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -134,7 +134,7 @@ module_clone()
        test -n "$name" || name="$path"
        base_path=$(dirname "$path")

-       gitdir=$(git rev-parse --git-dir)
+       gitdir=$(git rev-parse --git-dir | sed -e 's,^\([a-z]\):/,/\1/,')
        gitdir_base="$gitdir/modules/$base_path"
        gitdir="$gitdir/modules/$path"
