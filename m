From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 2/4] guilt-guard: Assign guards to patches in series
Date: Mon, 30 Jul 2007 00:06:10 -0400
Message-ID: <20070730040610.GD22017@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <11856954181497-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 06:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMWh-00014v-0C
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 06:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXG3EGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 00:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbXG3EGX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 00:06:23 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45879 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbXG3EGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 00:06:22 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6U46AwS026536;
	Mon, 30 Jul 2007 00:06:10 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6U46AXB026534;
	Mon, 30 Jul 2007 00:06:10 -0400
Content-Disposition: inline
In-Reply-To: <11856954181497-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54180>

On Sun, Jul 29, 2007 at 12:50:16AM -0700, Eric Lesh wrote:
> guilt-guard will assign guards to a patch.  They work so that:
> 
>     * Patches with no guards are always pushed.
> 
>     * Patches with positive guards (i.e. +foo) are pushed *only if* the
>       guard is selected.
> 
>     * Patches with negative guards (i.e. -foo) are pushed *unless* the
>       guard is selected.
> 
> Signed-off-by: Eric Lesh <eclesh@ucla.edu>
> ---
>  Documentation/guilt-guards.txt |   40 +++++++++++++++++++++++++
>  guilt                          |   58 ++++++++++++++++++++++++++++++++++++
>  guilt-guards                   |   63 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 161 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/guilt-guards.txt
>  create mode 100755 guilt-guards
> 
> diff --git a/Documentation/guilt-guards.txt b/Documentation/guilt-guards.txt
> new file mode 100644
> index 0000000..f5ac537
> --- /dev/null
> +++ b/Documentation/guilt-guards.txt
> @@ -0,0 +1,40 @@
> +guilt-guards(1)
> +===============
> +
> +NAME
> +----
> +guilt-guards - Assign guards to patches
> +
> +SYNOPSIS
> +--------
> +include::usage-guilt-guards.txt[]
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
> index 774909e..b2767ea 100755
> --- a/guilt
> +++ b/guilt
> @@ -182,6 +182,64 @@ get_series()
>  	grep -ve '^[[:space:]]*\(#.*\)*$' < "$series" | sed -e 's/[[:space:]]*#.*$//'
>  }
>  
> +get_guarded_series()
> +{
> +	get_series | while read p
> +	do
> +		[ -z `check_guards $p` ] && echo "$p"

Having check_guards return 0 or 1 makes things cleaner:

check_guards "$p" && echo "$p"

> +	done
> +}
> +
> +# usage: check_guards <patch>
> +# Returns t if the patch should be skipped
> +check_guards()
> +{
> +        get_guards "$1" | while read guard
> +        do
> +                pos=`echo $guard | grep -e "^+"`
> +                guard=`echo $guard | sed -e 's/[+-]//'`
> +                if [ $pos ]; then
> +                        # Push +guard *only if* guard selected
> +                        push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
> +                        [ $push -ne 0 ] && echo t

			   [ $push -ne 0 ] && return 1

> +                else
> +                        # Push -guard *unless* guard selected
> +                        push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
> +                        [ $push -eq 0 ] && echo t

ditto

> +                fi
> +        done

	return 0
> +}
> +
> +# usage: get_guards <patch>
> +get_guards()
> +{
> +	grep -e "^$1[[:space:]]*#" < "$series" | sed -e "s/^$1 //" -e 's/#[^+-]*//g'
> +}
> +
> +# usage: set_guards <patch> <guards>

I'd try to make it clearer that multiple guards can be specified.

> +set_guards()
> +{
> +	p="$1"
> +	shift
> +	for x in "$@"; do
> +		if [ -z $(echo "$x" | grep -e "^[+-]") ]; then

Is that the only restriction on the guard name?

> +			echo "'$x' is not a valid guard name"
> +		else
> +			sed -i -e "s/^\($p[[:space:]]*.*\)$/\1 #$x/" "$series"
> +		fi
> +	done
> +}
> +
> +# usage: unset_guards <patch> <guards>

ditto.

> +unset_guards()
> +{
> +        p="$1"
> +        shift
> +        for x in "$@"; do
> +            sed -i -e "/^$p[[:space:]]/s/ #$x//" "$series"
> +        done
> +}
> +
>  # usage: do_make_header <hash>
>  do_make_header()
>  {
> diff --git a/guilt-guards b/guilt-guards
> new file mode 100755
> index 0000000..71df4f8
> --- /dev/null
> +++ b/guilt-guards
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +#
> +# Copyright (c) Eric Lesh, 2007
> +#
> +
> +USAGE="[-l|--list] [-n|--none] [<patchname>] [+<guard>] [-<guard>]"

Since -l and -n are mutually exclusive, shouldn't it be something like:

[-l|--list|-n|--none|[<patchname>] [(+|-)guard...]]

> +. guilt
> +
> +print_guards()
> +{
> +	guards=`get_guards "$1"`
> +	echo "$1: $guards"
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
> +		;;
> +	1)
> +		if [ -z $(echo $1 | grep -e '^[+-]') ]; then
> +			if [ -z $(get_series | grep -e "^$1\$") ]; then
> +				die "Patch $1 does not exist"
> +			else
> +				print_guards "$1"
> +			fi
> +		else
> +			p=`get_top`
> +			unset_guards "$p" `get_guards "$p"`
> +			set_guards "$p" "$1"
> +		fi
> +		;;
> +	*)
> +		if [ -z $(echo $1 | grep -e '^[+-]') ]; then
> +			if [ -z $(get_series | grep -e "^$1\$") ]; then
> +				die "Patch $1 does not exist"
> +			else
> +				patch="$1"
> +			fi
> +			shift
> +		else
> +			patch=`get_top`
> +		fi
> +		unset_guards "$patch" `get_guards "$patch"`
> +		set_guards "$patch" "$@"
> +		;;
> +esac
> -- 
> 1.5.2

-- 
Note 96.3% of all statistics are fiction.
