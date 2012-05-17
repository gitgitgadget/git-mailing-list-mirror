From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Date: Fri, 18 May 2012 00:15:04 +0100
Message-ID: <4FB58678.1050009@ramsay1.demon.co.uk>
References: <4FB09FF2.70309@viscovery.net> <1337191208-21110-1-git-send-email-gitster@pobox.com> <1337191208-21110-3-git-send-email-gitster@pobox.com> <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com> <7vd364c5kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 18 01:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV9wD-0006ZS-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 01:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965828Ab2EQXQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 19:16:47 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:35482 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762456Ab2EQXQq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 19:16:46 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SV9w3-0005x5-cY; Thu, 17 May 2012 23:16:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vd364c5kt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197932>

Junio C Hamano wrote:
> Steven Penny <svnpenn@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>> +*CYGWIN*)
>>> +       pwd () {
>>> +               builtin cygpath -m
>>> +       }
>>> +       ;;
>> Ok I got it!
>>
>> The problem is twofold
>>
>> 1. Ramsay Jones	was right, it needs to be called like
>>
>> 	cygpath -m "$PWD"
>>
>> 2. The Cygwin "pwd" (and quite possibly MinGW "pwd") needs to be defined
>>    **before** it is called
> 
> OK, I missed the first point, it seems.  But you seem to have missed that
> these two problems are more or less independent---that is why I sent two
> patches, not a single ball of wax like the one I am responding to.
> 
> So the replacement for [PATCH 2/2] would now look like this?
> 
> In addition to "applies fine, tested and works" reports from Windows
> stakeholders, I still prefer to have a sign off from you (see
> Documentation/SubmittingPatches).
> 
> Thanks.
> 
> -- >8 --
> From: Steven Penny <svnpenn@gmail.com>
> Date: Wed, 16 May 2012 10:44:49 -0700
> Subject: [PATCH] git-sh-setup: work around Cygwin path handling gotchas
> 
> On Cygwin, tools built for Cygwin can take both Windows-style paths
> (e.g. C:/dir/file.txt or C:\dir\file.txt) and Cygwin-style paths
> (e.g. /cygdrive/c/dir/file.txt), but Windows-native tools can only take
> Windows-style paths.  Because the paths that are relative to $GIT_DIR,
> e.g. the name of the insn sheet file of the "rebase -i" command, are given
> to the programs with $GIT_DIR prefixed, and $GIT_DIR in turn is computed
> by calling "pwd", wrap "pwd" to call "cygpath -m" to give a Windows-style
> path, in a way similar to how mingw does this.
> ---
>  git-sh-setup.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 770a86e..b8e6327 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -241,6 +241,11 @@ case $(uname -s) in
>  		return 1
>  	}
>  	;;
> +*CYGWIN*)
> +	pwd () {
> +		cygpath -m "$PWD"
> +	}
> +	;;
>  *)
>  	is_absolute_path () {
>  		case "$1" in

I guess you won't be shocked to hear that I don't think this patch is
necessary. :-P

However, I can appreciate that some people would rather not have to
create a shell script to wrap their text editor, just to use git.
So I'm certainly not opposed to finding a solution to this problem
that doesn't require the user to do so.

My concerns about this patch include:

    - the additional fork+exec overhead associated with calling cygpath.
      I'm not actually claiming there is any substantial increase; I
      haven't tried it, so I don't know how "hot" the pwd() function is.

    - this is a "big hammer" which will affect much more code that is
      required to fix this problem.

The latter is my main concern. I would rather have the call to cygpath
at the point in the code where the editor is launched. This would reduce
the scope of the change and any side-effects that go with it.

Anyway, I applied this patch tonight to give it a go. The very first test
I tried failed. I've attached the log of the failing test below.
Note that it is attempting to use "ssh" to a "host" that ends in ".../C:".

I haven't investigated yet (I've got to get some sleep).

HTH

ATB,
Ramsay Jones


expecting success:
        (
                cd addtest &&
                git submodule add ../repo relative &&
                test "$(git config -f .gitmodules submodule.relative.url)" = ../
repo &&
                git submodule sync relative &&
                test "$(git config submodule.relative.url)" = "$submodurl/repo"
        )

Cloning into 'relative'...
ssh: /home/ramsay/git/t/trash directory.t7400-submodule-basic/addtest/C: no addr
ess associated with name
fatal: The remote end hung up unexpectedly
Clone of 'C:/cygwin/home/ramsay/git/t/trash directory.t7400-submodule-basic/repo
' into submodule path 'relative' failed
not ok - 41 use superproject as upstream when path is relative and no url is set
 there
#
#               (
#                       cd addtest &&
#                       git submodule add ../repo relative &&
#                       test "$(git config -f .gitmodules submodule.relative.url
)" = ../repo &&
#                       git submodule sync relative &&
#                       test "$(git config submodule.relative.url)" = "$submodur
l/repo"
#               )
#
$
