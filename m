From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 2/4] guilt-guard: Assign guards to patches in series
Date: Mon, 30 Jul 2007 15:28:15 -0400
Message-ID: <20070730192815.GC17253@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <11856954181497-git-send-email-eclesh@ucla.edu> <20070730040610.GD22017@filer.fsl.cs.sunysb.edu> <87k5sics0f.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFawT-00033s-SG
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763076AbXG3TaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758869AbXG3TaG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:30:06 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54052 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763076AbXG3TaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 15:30:04 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6UJSF3V018835;
	Mon, 30 Jul 2007 15:28:15 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6UJSFcU018833;
	Mon, 30 Jul 2007 15:28:15 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <87k5sics0f.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54255>

On Sun, Jul 29, 2007 at 11:41:52PM -0700, Eric Lesh wrote:
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:
> 
> [...]
> 
> >> +get_guarded_series()
> >> +{
> >> +	get_series | while read p
> >> +	do
> >> +		[ -z `check_guards $p` ] && echo "$p"
> >
> > Having check_guards return 0 or 1 makes things cleaner:
> >
> > check_guards "$p" && echo "$p"
> >
> >> +	done
> >> +}
> >> +
> >> +# usage: check_guards <patch>
> >> +# Returns t if the patch should be skipped
> >> +check_guards()
> >> +{
> >> +        get_guards "$1" | while read guard
> >> +        do
> >> +                pos=`echo $guard | grep -e "^+"`
> >> +                guard=`echo $guard | sed -e 's/[+-]//'`
> >> +                if [ $pos ]; then
> >> +                        # Push +guard *only if* guard selected
> >> +                        push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
> >> +                        [ $push -ne 0 ] && echo t
> >
> > 			   [ $push -ne 0 ] && return 1
> >
> 
> This returns from the subshell created by the pipe and the while loop,
> right?

Right, sorry.

> So I'm using:
> 
> check_guards()
> {
> 	get_guards "$1" | while read guard
> 	do
> 		pos=`echo $guard | grep -e "^+"`
> 		guard=`echo $guard | sed -e 's/^[+-]//'`
> 		if [ $pos ]; then
> 			# Push +guard *only if* guard selected
> 			push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
> 			[ $push -ne 0 ] && return 1
> 		else
> 			# Push -guard *unless* guard selected
> 			push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
> 			[ $push -eq 0 ] && return 1
> 		fi
>                 return 0

Beware of whitespace :)

> 	done
> 	return $?
> }
> 
> where 1 means push.
> 
> >> +# usage: get_guards <patch>
> >> +get_guards()
> >> +{
> >> +	grep -e "^$1[[:space:]]*#" < "$series" | sed -e "s/^$1 //" -e 's/#[^+-]*//g'
> >> +}
> 
> Should this also be one sed script instead of a grep + sed?

I'm all for more complex sed/awk scripts to replace lots of forks and pipes.

> >> +
> >> +# usage: set_guards <patch> <guards>
> >
> > I'd try to make it clearer that multiple guards can be specified.
> >
> 
> Done with <guards...> now.
> 
> >> +set_guards()
> >> +{
> >> +	p="$1"
> >> +	shift
> >> +	for x in "$@"; do
> >> +		if [ -z $(echo "$x" | grep -e "^[+-]") ]; then
> >
> > Is that the only restriction on the guard name?
> >
> 
> Yes.  On patches, you put a '+guard' or '-guard'.  When selecting with
> guilt-select, it's just 'guard'.  The + or - just means 'apply when
> selected' or 'apply unless selected'.  You can edit things manually to
> make guards with a space in the name, but the mechanism will work even
> in that case.

I am thinking that it _might_ make sense to have some validate_guard_name
function - I am not sure if it would be used enough to make it useful
instead of just obfuscating the code.

> >> +			echo "'$x' is not a valid guard name"
> >> +		else
> >> +			sed -i -e "s/^\($p[[:space:]]*.*\)$/\1 #$x/" "$series"
> >> +		fi
> >> +	done
> >> +}
> >> +
> >> +# usage: unset_guards <patch> <guards>
> >
> 
> [...]
> 
> The rest I'll do.  Thanks for the review.

Thanks for the patches :)

Jeff.

-- 
The obvious mathematical breakthrough would be development of an easy way to
factor large prime numbers.
		- Bill Gates, The Road Ahead, pg. 265
