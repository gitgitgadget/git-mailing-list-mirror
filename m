From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Tue, 31 Jul 2007 00:05:10 -0400
Message-ID: <20070731040510.GD12918@filer.fsl.cs.sunysb.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu> <1185851481271-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Tue Jul 31 06:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFiz4-0002WI-1V
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 06:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbXGaEFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 00:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbXGaEFS
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 00:05:18 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:42243 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbXGaEFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 00:05:16 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6V45Afq014485;
	Tue, 31 Jul 2007 00:05:10 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6V45AoU014483;
	Tue, 31 Jul 2007 00:05:10 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <1185851481271-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54317>

On Mon, Jul 30, 2007 at 08:11:18PM -0700, Eric Lesh wrote:
...
> diff --git a/Documentation/guilt-guard.txt b/Documentation/guilt-guard.txt
> new file mode 100644
> index 0000000..6290bf7
> --- /dev/null
> +++ b/Documentation/guilt-guard.txt
> @@ -0,0 +1,40 @@
> +guilt-guard(1)
> +===============

Extra = ;)

> +
> +NAME
> +----
> +guilt-guard - Assign guards to patches
> +
> +SYNOPSIS
> +--------
> +include::usage-guilt-guard.txt[]
> +
> +DESCRIPTION
> +-----------
> +Assign guards to the specified patch, or to the patch on top of the
> +stack if no patch is given on the command line.
> +
> +An unguarded patch is always pushed.
> +
> +A positive guard begins with a +. A patch with a positive guard is
> +pushed *only if* the guard is selected.
> +
> +A negative guard begins with a -. A patch with a negative guard is
> +always pushed, *unless* the guard is selected.
> +
> +OPTIONS
> +-------
> +-l|--list::
> +        List all patches and their guards
> +-n|--none::
> +        Remove all guards from a patch

I generally try to keep an empty line between the options. I don't think it
affects rendering, but just for consistency.

> +
> +Author
> +------
> +Written by Eric Lesh <eclesh@ucla.edu>
> +
> +Documentation
> +-------------
> +Documentation by Eric Lesh <eclesh@ucla.edu>
> +
> +include::footer.txt[]
> diff --git a/guilt b/guilt
> index 700c167..6af590c 100755
> --- a/guilt
> +++ b/guilt
> @@ -187,6 +187,72 @@ get_series()
>  		" $series
>  }
>  
> +get_guarded_series()
> +{
> +	get_series | while read p
> +	do
> +		check_guards "$p" && echo "$p"
> +	done
> +}
> +
> +# usage: check_guards <patch>
> +# Returns 0 if the patch should be pushed
> +check_guards()
> +{
> +	get_guards "$1" | while read guard
> +	do
> +		pos=`printf %s $guard | grep -e "^+"`
> +		guard=`printf %s $guard | sed -e 's/^[+-]//'`
> +		if [ "$pos" ]; then
> +			# Push +guard *only if* guard selected
> +			push=`grep -e "^$guard\$" "$guards_file" >/dev/null 2>/dev/null; echo $?`
> +			[ $push -ne 0 ] && return 1

			grep -e "^$guard\$" "$guards_file" >/dev/null 2>/dev/null
			[ $? -ne 0 ] && return 1

Much cleaner looking :) Or even:

			grep -e ....... || return 1

> +		else
> +			# Push -guard *unless* guard selected
> +			push=`grep -e "^$guard\$" "$guards_file" >/dev/null 2>/dev/null; echo $?`
> +			[ $push -eq 0 ] && return 1

Ditto.

> +		fi
> +		return 0
> +	done
> +	return $?

I'd throw in a small comment above the outter return to make sure no one
tries to clean things up and remove it.

> +}
> +
> +# usage: get_guards <patch>
> +get_guards()
> +{
> +	sed -n -e "\,^$1[[:space:]]*#, {
> +		s,^$1[[:space:]]*,,
> +		s,#[^+-]*,,g
> +
> +		p
> +		}
> +		" $series

Three things...

1) I generally preserve the sed script indentation

2) I like having the whole script start at col 0, syntax highlighting makes
it readable enough.

3) quote the "$series" in case there's whitespace in the repo path or branch
name


This is what I'd make it look like if I were to write it, but that's me just
nitpicking at this point :)

	sed -n -e "
line 1	{
	line 2

	line 4
}
" "$series"


> +}
> +
> +# usage: set_guards <patch> <guards...>
> +set_guards()
> +{
> +	p="$1"

Again, be careful about namespace polution.

> +	shift
> +	for x in "$@"; do
> +		if [ -z $(printf %s "$x" | grep -e "^[+-]") ]; then

Out of curiosity, why printf and not echo?

> +			echo "'$x' is not a valid guard name"
> +		else
> +			sed -i -e "s,^\($p[[:space:]]*.*\)$,\1 #$x," "$series"

The regexp is in double quotes, so you should escape the $ (EOL), as well as
all the \. Yep, this is shell scripting at its worst.

> +		fi
> +	done
> +}
> +
> +# usage: unset_guards <patch> <guards...>
> +unset_guards()
> +{
> +	p="$1"

Namespace..

> +	shift
> +	for x in "$@"; do
> +		sed -i -e "/^$p[[:space:]]/s/ #$x//" "$series"
> +	done
> +}
> +
>  # usage: do_make_header <hash>
>  do_make_header()
>  {
> diff --git a/guilt-guard b/guilt-guard
> new file mode 100755
> index 0000000..a0cac2e
> --- /dev/null
> +++ b/guilt-guard
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +#
> +# Copyright (c) Eric Lesh, 2007
> +#
> +
> +USAGE="[-l|--list|-n|--none|[<patchname>] [(+|-)<guard>...]]"
> +. `dirname $0`/guilt
> +
> +print_guards()
> +{
> +	guards=`get_guards "$1"`
> +	echo "$1: $guards"

	echo "$1: `get_guards \"$1\"`"

Eliminates assignment & namespace polution :) Not really a problem here as
this is a guilt-guard only function.

> +}
> +
> +if [ "$1" == "-l" ] || [ "$1" == "--list" ]; then
> +	get_series | while read patch; do
> +		print_guards "$patch"
> +	done
> +	exit 0
> +elif [ "$1" == "-n" ] || [ "$1" == "--none" ]; then
> +	patch="$2"
> +	if [ -z "$patch" ]; then
> +		patch=`get_top`
> +	fi
> +	unset_guards "$patch" `get_guards "$patch"`
> +	exit 0
> +fi
> +
> +case $# in
> +	0)
> +		if [ ! -s "$applied" ]; then
> +			die "No patches applied."
> +		fi
> +		print_guards `get_top`

Quote the `get_top` in case the topmost patch has whitespace in it. Yeah,
it's annoying, but safety first :)

> +		;;
> +	1)
> +		if [ -z $(printf %s "$1" | grep -e '^[+-]') ]; then
> +			if [ -z $(get_series | grep -e "^$1\$") ]; then
> +				die "Patch $1 does not exist."
> +			else
> +				print_guards "$1"
> +			fi
> +		else
> +			patch=`get_top`
> +			if [ -z "$patch" ]; then
> +				die "You must specify a patch."
> +			fi
> +			unset_guards "$patch" `get_guards "$patch"`
> +			set_guards "$patch" "$1"
> +		fi
> +		;;
> +	*)
> +		if [ -z $(printf %s "$1" | grep -e '^[+-]') ]; then
> +			if [ -z $(get_series | grep -e "^$1\$") ]; then
> +				die "Patch $1 does not exist."
> +			else
> +				patch="$1"
> +			fi
> +			shift
> +		else
> +			patch=`get_top`
> +			if [ -z "$patch" ]; then
> +				die "You must specify a patch."
> +			fi
> +		fi
> +		unset_guards "$patch" `get_guards "$patch"`
> +		set_guards "$patch" "$@"
> +		;;
> +esac
> -- 
> 1.5.2

Josef 'Jeff' Sipek, falling asleep after a loooong day.

-- 
We have joy, we have fun, we have Linux on a Sun...
