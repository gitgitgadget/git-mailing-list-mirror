From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/2] git-sh-setup: define workaround wrappers before they
 are used
Date: Thu, 17 May 2012 23:36:01 +0100
Message-ID: <4FB57D51.7050402@ramsay1.demon.co.uk>
References: <4FB09FF2.70309@viscovery.net> <1337191208-21110-1-git-send-email-gitster@pobox.com> <1337191208-21110-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Steven Penny <svnpenn@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 18 01:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV9w6-0006UO-V4
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 01:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762434Ab2EQXQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 19:16:42 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:46191 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755845Ab2EQXQl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 19:16:41 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SV9vv-0004Wr-fY; Thu, 17 May 2012 23:16:39 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1337191208-21110-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197931>

Junio C Hamano wrote:
> Recently we tweaked this scriptlet to let mingw port redefine "pwd" to
> always return Windows-style path, but the code to do so came after the
> first use of "pwd" to set up $GIT_DIR shell variable.
> 
> Move the block to define these workaround wrappers, so that everything
> everything that executes when the scriptlet is dot-sourced uses the
> replacements.
> 
> Noticed-by: Ramsay Jones
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-sh-setup.sh | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 7b3ae75..770a86e 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -218,27 +218,8 @@ clear_local_git_env() {
>  	unset $(git rev-parse --local-env-vars)
>  }
>  
> -# Make sure we are in a valid repository of a vintage we understand,
> -# if we require to be in a git repository.
> -if test -z "$NONGIT_OK"
> -then
> -	GIT_DIR=$(git rev-parse --git-dir) || exit
> -	if [ -z "$SUBDIRECTORY_OK" ]
> -	then
> -		test -z "$(git rev-parse --show-cdup)" || {
> -			exit=$?
> -			echo >&2 "You need to run this command from the toplevel of the working tree."
> -			exit $exit
> -		}
> -	fi
> -	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
> -		echo >&2 "Unable to determine absolute path of git directory"
> -		exit 1
> -	}
> -	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
> -fi
>  
> -# Fix some commands on Windows
> +# Platform specific tweaks to work around some commands
>  case $(uname -s) in
>  *MINGW*)
>  	# Windows has its own (incompatible) sort and find
> @@ -269,3 +250,23 @@ case $(uname -s) in
>  		return 1
>  	}
>  esac
> +
> +# Make sure we are in a valid repository of a vintage we understand,
> +# if we require to be in a git repository.
> +if test -z "$NONGIT_OK"
> +then
> +	GIT_DIR=$(git rev-parse --git-dir) || exit
> +	if [ -z "$SUBDIRECTORY_OK" ]
> +	then
> +		test -z "$(git rev-parse --show-cdup)" || {
> +			exit=$?
> +			echo >&2 "You need to run this command from the toplevel of the working tree."
> +			exit $exit
> +		}
> +	fi
> +	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
> +		echo >&2 "Unable to determine absolute path of git directory"
> +		exit 1
> +	}
> +	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
> +fi

Thanks for doing this. (I would have got around to it, honest! However, it does
solve a minor problem for me, since I kinda promised not to post anymore MinGW
specific patches. :-D ).

I have not done a full test on this patch; I have only run the following tests
on MinGW and cygwin:

    $ git grep -l -e 'git *submodule' -- t
    t/t5526-fetch-submodules.sh
    t/t6008-rev-list-submodule.sh
    t/t7003-filter-branch.sh
    t/t7400-submodule-basic.sh
    t/t7401-submodule-summary.sh
    t/t7403-submodule-sync.sh
    t/t7405-submodule-merge.sh
    t/t7406-submodule-update.sh
    t/t7407-submodule-foreach.sh
    t/t7408-submodule-reference.sh
    t/t7506-status-submodule.sh
    t/t7610-mergetool.sh
    t/t9300-fast-import.sh
    t/t9350-fast-export.sh

(On MinGW i have to use a "GIT_TEST_CMP='diff -ub'" prefix, otherwise there are
some failures caused by "lf/crlf line ending" problems).

All of these tests pass. I don't anticipate any problems (especially on cygwin,
since it is essentially a noop there), but I have not done a complete test.

I probably won't get to it soon, so I'm hoping somebody can beat me to it!

ATB,
Ramsay Jones
