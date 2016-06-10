From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 2/3] completion: add __git_get_option_value helper
Date: Fri, 10 Jun 2016 15:10:20 +0200
Message-ID: <20160610151020.Horde.AfAwgXgKC_jSSpyr60T85sW@webmail.informatik.kit.edu>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
 <20160603183426.13140-1-thomas.braun@virtuell-zuhause.de>
 <20160603183426.13140-3-thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Fri Jun 10 15:10:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBMD9-0000ww-A3
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 15:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbcFJNKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 09:10:50 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:55240 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932248AbcFJNKd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 09:10:33 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1bBMCj-0001Qo-2i; Fri, 10 Jun 2016 15:10:29 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1bBMCa-00045o-Ao; Fri, 10 Jun 2016 15:10:20 +0200
Received: from x4db0041d.dyn.telefonica.de (x4db0041d.dyn.telefonica.de
 [77.176.4.29]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 10 Jun 2016 15:10:20 +0200
In-Reply-To: <20160603183426.13140-3-thomas.braun@virtuell-zuhause.de>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1465564229.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297003>


Hallo Thomas,

I saw v5 hit my mailbox while writing this.  I glanced it over and it
seems my comments here apply to that version as well.

Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:

> This function allows to search the commmand line and config
> files for an option, long and short, with mandatory value.
>
> The function would return e.g. for the command line
> "git status -uno --untracked-files=3Dall" the result
> "all" regardless of the config option.

Wow, regarding my earlier remark about bonus points: I didn't realize
that there were so many bonus point to give away :)

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
> contrib/completion/git-completion.bash | 44 =20
> ++++++++++++++++++++++++++++++++++
> 1 file changed, 44 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash =20
> b/contrib/completion/git-completion.bash
> index addea89..4bd17aa 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -803,6 +803,50 @@ __git_find_on_cmdline ()
> 	done
> }
>
> +# Echo the value of an option set on the command line or config
> +#
> +# $1: short option name
> +# $2: long option name including =3D

I'm not sure about requiring the '=3D', the function could just append
it as necessary.  More on this below.

> +# $3: list of possible values
> +# $4: config string (optional)

I don't understand why the list of possible values is necessary.

This function will be called when the caller wants to take different
actions based on different values, so the caller will process the
function's output with a case statement or an if-else chain, both of
which would be perfectly capable to ignore whatever invalid value the
user might have specified.  Therefore, I think this function doesn't
need the list of possible values, it should just return whatever value
it found after the option.

> +# example:
> +# result=3D"$(__git_get_option_value "-d" "--do-something=3D"\
> +#     "yes no" "core.doSomething")"
> +#
> +# result is then either empty (no option set) or "yes" or "no"
> +#
> +# __git_get_option_value requires 3 arguments
> +__git_get_option_value ()
> +{
> +	local c short_opt long_opt val
> +	local result=3D values config_key word
> +
> +	short_opt=3D"$1"
> +	long_opt=3D"$2"
> +	values=3D"$3"
> +	config_key=3D"$4"

These can be assigned when the variables are declared, saving a couple
of lines.

> +	((c =3D $cword - 1))
> +	while [ $c -ge 0 ]; do

Searching from the end of the command line, so even if someone were to
do a 'git status -uall -unormal -uno <TAB>', this would still do the
right thing.  Good!

However ;)
Just for fun imagine following:

       $ >-uno
       $ git status -- -uno <TAB>

'git status' treats that '-uno' after the doubledash as a filename,
but this function interprets it as an option, and on the subsequent
TAB the completion script won't list untracked files.

I'm tempted to say that this is such a pathological corner case that
it doesn't worth worrying about.

> +		word=3D"${words[c]}"
> +		for val in $values; do

Without the possible values argument this inner loop could go away.

> +			if [ "$short_opt$val" =3D "$word" ]
> +			|| [ "$long_opt$val"  =3D "$word" ]; then
> +				result=3D"$val"
> +				break 2

You could just 'echo "$val"' or rather ${word#$short_opt} and return
here ...

> +			fi
> +		done
> +		((c--))
> +	done
> +
> +	if [ -n "$config_key" ] && [ -z "$result" ]; then

=2E.. and that would make the second condition unnecessary here ...

> +		result=3D"$(git --git-dir=3D"$(__gitdir)" config "$config_key")"

=2E.. and this could just be a simple 'git config' execution, without
command substitution ...

> +	fi
> +
> +	echo "$result"

=2E.. and this echo could go away as well.

> +}
> +
> __git_has_doubledash ()
> {
> 	local c=3D1
> --
> 2.8.3.windows.1


However, I'm not sure we need or want this helper function _at the
moment_.  Yes, in general helper functions are good, and in this case
it makes _git_status() easier to follow, but it has some drawbacks,
too:

   - It has a single callsite: the upcoming _git_status().  No other
     existing case springs to mind where it could be used, i.e. where
     different values of an option would require different actions from
     the completion script.  Maybe we'll have one in the future, maybe
     not.

   - This function works only with the "stuck" form of options, i.e.
     '--opt=3Dval' or '-oval', which is mostly sufficient in this case,
     because 'git status' understands only this form.  However, it
     doesn't work with "unstuck" options, i.e. '--opt val' or '-o val'.
     In many cases git supports only this "unstuck" form, and there are
     many cases where it supports both for a given option.  We can't kn=
ow
     which form a future callsite might need, but requiring the '=3D' a=
s
     part of the long option seems to paint us into a corner.

   - I wrote "mostly sufficient" above, because 'git status' does accep=
t
     a valueless '-u|--untracked-files' option, too, e.g.:

       $ git config status.showUntrackedFiles no
       $ git status --untracked-files

     lists untracked files, therefore the completion script should list
     them as well.  Your function can't cope with this case, and I'm no=
t
     sure how it and its caller could differentiate between the presenc=
e
     of such a valueless option and no option at all.  Perhaps with an
     additional optional function parameter holding the default value
     that should be echo-ed when a valueless option is encountered.

If this function were not a function but its logic were embedded into
_git_status(), then we wouldn't have to spend any effort _now_ to come
up with a proper calling convention that can cope with stuck vs.
unstuck vs. both forms of options and with valueless options.  We would
deal with all that and the necessary refactorization when (or if ever)
there's a second potential callsite.  Embedding into _git_status()
would give you more freedom to deal with the valueless '-u' option,
too.  If embedded, some of my in-code comments wouldn't apply anymore,
of course.

I'm in favor of crossing the bridge when we get there.


G=C3=A1bor
