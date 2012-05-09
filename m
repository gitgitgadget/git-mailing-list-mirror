From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH 19/19] bash prompt: alternative git prompt without command
 substitution
Date: Wed, 09 May 2012 20:38:22 +0100
Message-ID: <4FAAC7AE.3020002@pileofstuff.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de> <1336524290-30023-20-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 21:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSCiW-0004T8-L3
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760816Ab2EITi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 15:38:28 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:33142 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752437Ab2EITi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 15:38:27 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120509193824.QPGS10053.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Wed, 9 May 2012 20:38:24 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120509193824.MZXZ10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 9 May 2012 20:38:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <1336524290-30023-20-git-send-email-szeder@ira.uka.de>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=aeW3eDlI0EAA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=z5eh-ceNeBaK14OP6dEA:9 a=QEXdDO2ut3YA:10 a=efSDiHoTNYc9oxhQ:21 a=gbyhD97vA7zhEXx8:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197496>

On 09/05/12 01:44, SZEDER G=C3=A1bor wrote:
> __git_ps1() prints the branch name, status indicators, etc. to stdout=
,
> therefore it has to be included in $PS1 through a command substitutio=
n
> to display that information in the prompt.  The configuration is
> straightforward, but it imposes the overhead of fork()ing a subshell
> for the command substitution.
>=20
> However, bash has the $PROMPT_COMMAND shell variable, which "if set,
> the value is executed as a command prior to issuing each primary
> prompt" (quoted from bash man page).  Its value isn't executed in a
> subshell but in the context of the "main" shell, hence (non-local)
> variables set in invoked shell functions are available when expanding
> $PS1.  We can use this facility to avoid that command substitution fo=
r
> __git_ps1().
>=20
> So split out the meat of __git_ps1() into the new
> __git_prompt_command() function, which stores the branch name & co.
> in the $__git_ps1_string variable.  This function, as its name
> suggests, should be included in $PROMPT_COMMAND, and $__git_ps1_strin=
g
> should in turn be included in $PS1 with a bit of a twist to put the
> parentheses around it:
>=20
>    PROMPT_COMMAND=3D__git_prompt_command

Rather than overwrite any existing PROMPT_COMMAND, it would be better t=
o
do something like:

PROMPT_COMMAND=3D"__git_prompt_command; $PROMPT_COMMAND"

>    PS1=3D'[\u@\h \W${__git_ps1_string:+ ($__git_ps1_string)}]\$ '
>=20
> Turn __git_ps1() into a wrapper around __git_prompt_command() such
> that it's functionality remains unaltered, so already configured
> prompts won't break.
>=20
> The whole series speeds up the bash prompt on Windows/MinGW
> immensely, in many cases brings it down to around 10ms on my
> machine while in powersave mode.  Here are some timing results in
> three common scenarios (repeated 10 times, because the after cases
> were too fast to measure a single execution accurately with 'time'):
>=20
> In my home directory, i.e. not in a git repository, before:
>=20
>     /c/Users/szeder
>     $ time for i in {0..9} ; do prompt=3D$(__git_ps1) ; done
>=20
>     real    0m0.952s
>     user    0m0.214s
>     sys     0m0.444s
>=20
>   After:
>=20
>     /c/Users/szeder
>     $ time for i in {0..9} ; do __git_prompt_command ;
>            prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done
>=20
>     real    0m0.718s
>     user    0m0.136s
>     sys     0m0.354s
>=20
>   After, with discovery across filesystems enabled:
>=20
>     /c/Users/szeder
>     $ time for i in {0..9} ; do __git_prompt_command ;
>            prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done
>=20
>     real    0m0.078s
>     user    0m0.016s
>     sys     0m0.062s
>=20
> At the top of a work tree, before:
>=20
>     /c/Users/szeder/repo (master)
>     $ time for i in {0..9} ; do prompt=3D$(__git_ps1) ; done
>=20
>     real    0m2.901s
>     user    0m0.391s
>     sys     0m1.468s
>=20
>   After:
>=20
>     /c/Users/szeder/repo (master)
>     $ time for i in {0..9} ; do __git_prompt_command ;
>            prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done
>=20
>     real    0m0.094s
>     user    0m0.047s
>     sys     0m0.047s
>=20
> In a subdirectory, stash indicator enabled, before:
>=20
>     /c/Users/szeder/repo/subdir (master $)
>     $ time for i in {0..9} ; do prompt=3D$(__git_ps1) ; done
>=20
>     real    0m4.118s
>     user    0m0.468s
>     sys     0m2.056s
>=20
>   After:
>=20
>     /c/Users/szeder/repo/subdir (master $)
>     $ time for i in {0..9} ; do __git_prompt_command ;
>            prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done
>=20
>     real    0m0.858s
>     user    0m0.152s
>     sys     0m0.322s
>=20
>   After, discovery across filesystems enabled:
>=20
>     /c/Users/szeder/repo/subdir (master $)
>     $ time for i in {0..9} ; do __git_prompt_command ;
>            prompt=3D${__git_ps1_string:+ ($__git_ps1_string)} ; done
>=20
>     real    0m0.109s
>     user    0m0.047s
>     sys     0m0.063s
>=20
> Well, that's about 97% improvement.
>=20
> The performance gain on Linux is smaller, the latter case goes down
> from 0.264s to 0.047, but since it was fast enough to begin with I
> won't lengthen this commit message with further timing results on
> Linux.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>=20
> We had some discussions recently about putting user-facing functions =
into
> a separate "namespace".  This patch doesn't take that into account, b=
ut
> once a consensus is reached __git_prompt_command() should be put in t=
hat
> namespace.
>=20
>  contrib/completion/git-completion.bash | 25 +++++++++++++++++++++---=
-
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 5ea19018..1c29f3d0 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -29,6 +29,11 @@
>  #       are currently in a git repository.  The %s token will be
>  #       the name of the current branch.
>  #
> +#       Alternatively, to make the above Bash prompt a bit faster:
> +#               PROMPT_COMMAND=3D__git_prompt_command

As above, I'd recommend a simple documentation change:
PROMPT_COMMAND=3D"__git_prompt_command; $PROMPT_COMMAND"
(to show people how to chain any other prompt commands they have)

> +#               PS1=3D'[\u@\h \W${__git_ps1_string:+ ($__git_ps1_str=
ing)}]\$ '
> +#               GIT_DISCOVERY_ACROSS_FILESYSTEM=3Dtrue
> +#
>  #       In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
>  #       value, unstaged (*) and staged (+) changes will be shown nex=
t
>  #       to the branch name.  You can configure this per-repository
> @@ -258,11 +263,12 @@ __git_ps1_show_upstream ()
>  }
> =20
> =20
> -# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
> -# returns text to add to bash PS1 prompt (includes branch name)
> -__git_ps1 ()
> +# Stores the text to be added to the bash prompt (branch name, statu=
s
> +# indicators, etc.) in the $__git_ps1_string variable.
> +__git_prompt_command ()
>  {
>  	local __git_dir=3D""
> +	__git_ps1_string=3D""
>  	__gitdir >/dev/null
>  	if [ -z "$__git_dir" ]; then
>  		return
> @@ -365,7 +371,18 @@ __git_ps1 ()
>  	fi
> =20
>  	local f=3D"$w$i$s$u"
> -	printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
> +	__git_ps1_string=3D"$c${b##refs/heads/}${f:+ $f}$r$p"
> +}
> +
> +# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
> +# returns text to add to bash PS1 prompt (includes branch name)
> +__git_ps1 ()
> +{
> +	local __git_ps1_string
> +	__git_prompt_command
> +	if [ -n "$__git_ps1_string" ]; then
> +		printf -- "${1:- (%s)}" "$__git_ps1_string"
> +	fi

How hard/appropriate would it be to export individual parts of the
prompt here?  Something like:

__git_ps1_string_dirtystate=3D"$i"
__git_ps1_string_untrackedfiles=3D"$u"

There have been requests in the past to let people individually
colourise different bits of the prompt, which this would make practical=
=2E

>  }
> =20
>  __gitcomp_1 ()
