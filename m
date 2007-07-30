From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 3/4] guilt-select: Select guards to apply when pushing patches
Date: Mon, 30 Jul 2007 00:12:31 -0400
Message-ID: <20070730041231.GE22017@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <11856954182318-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 06:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMch-00023S-0x
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 06:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXG3EMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 00:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbXG3EMo
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 00:12:44 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46130 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbXG3EMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 00:12:43 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6U4CVol026887;
	Mon, 30 Jul 2007 00:12:31 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6U4CVaY026885;
	Mon, 30 Jul 2007 00:12:31 -0400
Content-Disposition: inline
In-Reply-To: <11856954182318-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54182>

On Sun, Jul 29, 2007 at 12:50:17AM -0700, Eric Lesh wrote:
> guilt-select chooses guards that alter which patches will be applied
> with a guilt-push.  The selected guards are stored in
> .git/patches/$branch/guards.
> 
> Signed-off-by: Eric Lesh <eclesh@ucla.edu>
> ---
>  Documentation/guilt-select.txt |   42 ++++++++++++++++++++++++++++++++++++++++
>  guilt                          |    1 +
>  guilt-select                   |   36 ++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/guilt-select.txt
>  create mode 100755 guilt-select
> 
> diff --git a/Documentation/guilt-select.txt b/Documentation/guilt-select.txt
> new file mode 100644
> index 0000000..8e18f26
> --- /dev/null
> +++ b/Documentation/guilt-select.txt

You might want to update the guilt(7) page's description of the patch
directory.

> @@ -0,0 +1,42 @@
> +guilt-select(1)
> +===============
> +
> +NAME
> +----
> +guilt-select - Select guards to apply when pushing patches
> +
> +SYNOPSIS
> +--------
> +include::usage-guilt-select.txt[]
> +
> +DESCRIPTION
> +-----------
> +Select guards to apply when pushing patches.
> +
> +Guards are selected without the + or - prefix.  Patches are applied in
> +the following way:
> +
> +An unguarded patch is always applied.
> +
> +A patch with a positive guard is applied *only* if the guard is
> +selected with guilt-select.
> +
> +A patch with a negative guard is applied *unless* the guard is
> +selected with guilt-select.
> +
> +OPTIONS
> +-------
> +-n|--none::
> +        Remove all selected guards
> +-s|--series::
> +        List all guards listed in the series file
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
> index b2767ea..3882962 100755
> --- a/guilt
> +++ b/guilt
> @@ -641,6 +641,7 @@ fi
>  # very useful files
>  series="$GUILT_DIR/$branch/series"
>  applied="$GUILT_DIR/$branch/status"
> +guards_file="$GUILT_DIR/$branch/guards"
>  
>  # determine an editor to use for anything interactive (fall back to vi)
>  editor="vi"
> diff --git a/guilt-select b/guilt-select
> new file mode 100755
> index 0000000..f237ef0
> --- /dev/null
> +++ b/guilt-select
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +#
> +# Copyright (c) Eric Lesh, 2007
> +#
> +
> +USAGE="[-n|--none] [-s|--series] [<guard>]"
> + . `dirname $0`/guilt
> +
> +if [ $# == 0 ]; then
> +	if [ -s "$guards_file" ]; then
> +		cat "$guards_file"

Later on, for the -s option processing, you sort (presumably to have uniq do
the right thing), should we sort here too to be consitent?

> +	else
> +		echo "No guards applied"

I think outputing this message to stderr might be better; it'll allow for
redirection more easily.

> +	fi
> +	exit 0
> +fi
> +
> +case $1 in
> +	-n|--none)
> +		rm -f "$guards_file"
> +		touch "$guards_file"

Since guilt-init doesn't create the guards file, I'm thinking that this
should be just a rm -f ...

> +		;;
> +	-s|--series)
> +		(get_series | while read patch; do
> +			get_guards "$patch"
> +		done) | sed -e 's/ /\n/g' | sort | uniq
> +		;;
> +	*)
> +		for x in "$@"; do
> +			if [ $(echo $x | grep -e "^[+-]") ]; then
> +				die "'$x' is not a valid guard name"
> +			fi
> +		done
> +		echo "$@" | sed -e 's/ /\n/g' | sort | uniq > "$guards_file"
> +		;;
> +esac
> -- 
> 1.5.2

-- 
The box said "Windows XP or better required". So I installed Linux.
