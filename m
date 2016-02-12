From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Fri, 12 Feb 2016 22:40:48 +0100
Message-ID: <20160212224048.Horde.IpOeDKLAMM4a11F2xyIeY4M@webmail.informatik.kit.edu>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, tr@thomasrast.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:41:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aULSv-0008J3-74
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 22:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbcBLVlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 16:41:21 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59570 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbcBLVlU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 16:41:20 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aULSk-0002Bu-Vk; Fri, 12 Feb 2016 22:41:15 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aULSK-0001tW-OX; Fri, 12 Feb 2016 22:40:48 +0100
Received: from x590d742f.dyn.telefonica.de (x590d742f.dyn.telefonica.de
 [89.13.116.47]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 12 Feb 2016 22:40:48 +0100
In-Reply-To: <xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1455313275.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286078>


Quoting Junio C Hamano <gitster@pobox.com>:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Feb 04, 2016 at 11:34:59AM +0100, Sebastian Schuberth wrote:
>>
>>> This avoids output like
>>>
>>>     warning: ignoring broken ref refs/remotes/origin/HEAD
>>>
>>> while completing branch names.
>>
>> Hmm. I feel like this case (HEAD points to a branch, then `fetch
>> --prune` deletes it) came up recently and we discussed quieting that
>> warning. But now I cannot seem to find it.
>>
>> Anyway, I this is a reasonable workaround. Errors from bash completion
>> scripts are almost always going to be useless and get in the way of
>> reading your own prompt.
>
> I think that is absolutely the right stance to take, but then I
> wonder if it is a sensible execution to sprinkle 2>/dev/null
> everywhere.
>
> For example, couldn't we do something like this instead?
>
> This is just for illustration and does not remove all 2>/dev/null
> and replace them with a single redirection that covers the entire
> shell function body, but something along this line smells a lot more
> pleasant.  I dunno.

Please no :)

First, we don't have to redirect stderr of every completion function,
it's sufficient to do so only for the two "main" entry point functions
__git_main() and __gitk_main().

But:

  * It would swallow even those errors that we are interested in,
    e.g. (note the missing quotes around $foo):

       $ func () { if [ $foo = y ] ; then echo "foo is y" ; fi ; }
       $ foo=
       $ func 2>/dev/null
       $ func
       bash: [: =: unary operator expected

    Something like this should not happen, it's a bug in the
    completion script that should be fixed, and we should get a bug
    report.

  * I often find myself tracing/debugging the completion script
    through stderr by scattering

       echo >&2 "foo: '$foo'"

    and the like all over the place.  If completion functions' stderr
    were redirected, then I would have to disable that redirection
    first to be able do this kind of poor man's tracing.

  * I have a WIP patch series that deals with errors from git
    commands.
    It's a mixed bag of __gitdir()-related cleanups, fixes and
    optimizations, which factors out all git executions into a
    __git() wrapper function and redirects stderr only in that
    function, thereby eliminating most of the 2>/dev/null
    redirections in the completion script.
    It still needs some work to iron out a wrinkle or two around
    corner cases, though.



>  contrib/completion/git-completion.bash | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash  
> b/contrib/completion/git-completion.bash
> index ba4137d..637c42d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -47,14 +47,14 @@ __gitdir ()
>  		elif [ -d .git ]; then
>  			echo .git
>  		else
> -			git rev-parse --git-dir 2>/dev/null
> +			git rev-parse --git-dir
>  		fi
>  	elif [ -d "$1/.git" ]; then
>  		echo "$1/.git"
>  	else
>  		echo "$1"
>  	fi
> -}
> +} 2>/dev/null
>
>  # The following function is based on code from:
>  #
> @@ -320,7 +320,7 @@ __git_heads ()
>  			refs/heads
>  		return
>  	fi
> -}
> +} 2>/dev/null
>
>  __git_tags ()
>  {
> @@ -330,7 +330,7 @@ __git_tags ()
>  			refs/tags
>  		return
>  	fi
> -}
> +} 2>/dev/null
>
>  # __git_refs accepts 0, 1 (to pass to __gitdir), or 2 arguments
>  # presence of 2nd argument means use the guess heuristic employed
> @@ -389,7 +389,7 @@ __git_refs ()
>  			"refs/remotes/$dir/" 2>/dev/null | sed -e "s#^$dir/##"
>  		;;
>  	esac
> -}
> +} 2>/dev/null
>
>  # __git_refs2 requires 1 argument (to pass to __git_refs)
>  __git_refs2 ()
