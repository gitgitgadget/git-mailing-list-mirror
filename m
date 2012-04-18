From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule.sh: Don't use $path variable in eval_gettext
 string
Date: Wed, 18 Apr 2012 13:05:45 +0200
Message-ID: <4F8EA009.5080405@web.de>
References: <4F8DAFDA.1020108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, bwalton@artsci.utoronto.ca,
	Johannes Sixt <j6t@kdbg.org>, avarab@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKSiv-0000rV-QV
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 13:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab2DRLGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 07:06:53 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:59385 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab2DRLGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 07:06:52 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate05.web.de (Postfix) with ESMTP id 56CF16DC2E47
	for <git@vger.kernel.org>; Wed, 18 Apr 2012 13:05:50 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.175.87]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MUnqm-1Sm1cV42pw-00YDB6; Wed, 18 Apr 2012 13:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F8DAFDA.1020108@ramsay1.demon.co.uk>
X-Provags-ID: V02:K0:vy5yA1ysVCu05nQI9c3RE42zcURt3kiCrDjihHgPSRj
 JoBfP9SpPWEKzfkCajUxJGw1zT1KqHxlubtWJlMtajDDMAdw8F
 mX7sFcyaTBvCX5BtRS8gOrbQ0W7eA3vt8Lf4Jk2Hu2dTebCO6F
 2I8SGw1olFfg230B1UCKSAfnh7Do3oa810kLq9Ez8Tad+X6o5H
 5NntrEaRnl8M9QcM2hMag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195857>

Am 17.04.2012 20:00, schrieb Ramsay Jones:
> 
> The eval_gettext (and eval_gettextln) i18n shell functions call
> git-sh-i18n--envsubst to process the variable references in the
> string parameter. Unfortunately, environment variables are case
> insensitive on windows, which leads to failure on cygwin when
> eval_gettext exports $path.
> 
> Commit df599e9 (Windows: teach getenv to do a case-sensitive search,
> 06-06-2011) attempts to solve this problem on MinGW by overriding
> the system getenv() function to allow git-sh-i18n--envsubst to read
> $path rather than $PATH from the environment. However, this commit
> does not address cygwin at all and, furthermore, does not fix all
> problems on MinGW.
> 
> In particular, when executing test #38 in t7400-submodule-basic.sh,
> an 'git-sh-i18n-envsubst.exe - Unable To Locate Component' dialog
> pops up saying that the application "failed to start because
> libiconv2.dll was not found." After studying the voluminous trace
> output from the process monitor, it is clear that the system is
> attempting to use $path, rather than $PATH, to search for the DLL
> file. (Note that, after dismissing the dialog, the test passes
> anyway!)
> 
> As an alternative, we finesse the problem by renaming the $path
> variable to $sm_path (submodule path). This fixes the problem on
> MinGW along with all test failures on cygwin (t7400.{7,32,34},
> t7406.3 and t7407.{2,6}). We note that the foreach subcommand
> provides $path to user scripts (ie it is part of the API), so we
> can't simply rename it to $sm_path.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

To me it makes sense to rename the problematic $path variable to
get rid of this problem.

>  git-submodule.sh |  161 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 82 insertions(+), 79 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3d94a14..64a70d6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -101,11 +101,12 @@ module_list()
>  module_name()
>  {
>  	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
> +	sm_path="$1"
>  	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>  	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
>  		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
>  	test -z "$name" &&
> -	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
> +	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$sm_path'")"
>  	echo "$name"
>  }

And as an extra this part fixes the bug that the die won't print the
submodule path in case of an error as to do that it would have had
to use $1 here ;-)
