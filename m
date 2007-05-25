From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 13:24:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251157450.4648@racer.site>
References: <11800866643203-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 14:25:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrYr7-0005x3-K0
	for gcvg-git@gmane.org; Fri, 25 May 2007 14:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXEYMZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 08:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXEYMZD
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 08:25:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:42116 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751115AbXEYMZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 08:25:01 -0400
Received: (qmail invoked by alias); 25 May 2007 12:24:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 25 May 2007 14:24:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2OwAPdgL285nPSEpS6iJAWbeeRFhyhra+fPF3Gs
	ahZDvKTVjMT+tI
X-X-Sender: gene099@racer.site
In-Reply-To: <11800866643203-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48364>

Hi,

On Fri, 25 May 2007, Lars Hjemli wrote:

> There is currently no way to override the mappings in the .gitmodules 
> file, except by manually creating the subproject repository.

I think that is okay. We can add that easily at a later stage, and the 
script is much easier without that logic.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt

Looks good here, I checked with asciidoc.

> diff --git a/git-submodule.sh b/git-submodule.sh
> new file mode 100755
> index 0000000..c4a1cc3
> --- /dev/null
> +++ b/git-submodule.sh
> @@ -0,0 +1,163 @@
> +#!/bin/sh
> +#
> +# git-submodule.sh: init, update or list git submodules
> +#
> +# Copyright (c) 2007 Lars Hjemli
> +
> +USAGE='[-i | --init | -u | --update] [-q | --quiet] [--cached] <path>...'
> +. git-sh-setup
> +require_work_tree
> +
> +init=
> +update=
> +quiet=
> +cached=
> +
> +#
> +# print stuff on stdout unless -q was specified
> +#
> +say()
> +{
> +	if test -z "$quiet"
> +	then
> +		echo -e "$@"
> +	fi
> +}
> +
> +#
> +# Find all (requested) submodules, run clone + checkout on missing paths
> +#
> +# $@ = requested paths (default to all)
> +#
> +modules_init()
> +{
> +	git ls-files --stage -- $@ | grep -e '^160000 ' |

Any reason you read in the stage? It does not seem that you use it.

> +	while read mode sha1 stage path
> +	do
> +		test -d "$path/.git" && continue
> +
> +		if test -d "$path"
> +		then
> +			rmdir "$path" 2>/dev/null ||
> +			die "Directory '$path' exist, but not as a submodule"
> +		fi
> +
> +		test -e "$path" &&
> +		die "A file already exist at path '$path'"
> +
> +		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)

I like that command ;-)

> +		test -z "$url" &&
> +		die "No url found for submodule '$path' in .gitmodules"
> +
> +		git-clone "$url" "$path" ||
> +		die "Clone of submodule '$path' failed"
> +
> +		$(cd "$path" && git-checkout -q "$sha1") ||
> +		die "Checkout of submodule '$path' failed"
> +
> +		say "Submodule '$path' initialized"
> +	done
> +}
> +
> +#
> +# Checkout correct revision of each initialized submodule
> +#
> +# $@ = requested paths (default to all)
> +#
> +modules_update()
> +{
> +	git ls-files --stage -- $@ | grep -e '^160000 ' |

Same here.

> +	while read mode sha1 stage path
> +	do
> +		if ! test -d "$path/.git"
> +		then
> +			say "Submodule '$path' not initialized"
> +			continue;
> +		fi
> +		subsha1=$(cd "$path" && git-rev-parse --verify HEAD) ||

Maybe it would be a better idea to use "git --git-dir="$path" rev-parse 
..."? Just in case somebody calls this with GIT_DIR overridden...

Or, unset GIT_DIR explicitely.

> +		die "Unable to find current revision of submodule '$path'"
> +
> +		if test "$subsha1" != "$sha1"
> +		then
> +			$(cd "$path" && git-fetch && git-checkout -q "$sha1") ||

This will make a detached HEAD, right? Do you want that? (I am not really 
interested in submodules myself, so I haven't thought about it, and I 
haven't followed that monster discussion.)

> +			die "Unable to checkout revision $sha1 of submodule '$path'"
> +
> +			say "Submodule '$path' reset to revision $sha1"

I'd rather not say "reset", since this has a different meaning in Git, but 
rather "set to revision $sha1".

> +		fi
> +	done
> +}
> +
> +#
> +# List all registered submodules, prefixed with:
> +#  - submodule not initialized
> +#  + different version checked out
> +#
> +# If --cached was specified the revision in the index will be printed
> +# instead of the currently checked out revision.
> +#
> +# $@ = requested paths (default to all)
> +#
> +modules_list()
> +{
> +	git ls-files --stage -- $@ | grep -e '^160000 ' |
> +	while read mode sha1 stage path
> +	do
> +		if ! test -d "$path/.git"
> +		then
> +			say "-$sha1 $path"
> +			continue;
> +		fi
> +		revname=$(cd "$path" && git-describe $sha1)
> +		if git diff-files --quiet -- "$path"
> +		then
> +			say " $sha1 $path\t($revname)"
> +		else
> +			if test -z "$cached"
> +			then
> +				sha1=$(cd "$path" && git-rev-parse --verify HEAD)
> +				revname=$(cd "$path" && git-describe $sha1)
> +			fi
> +			say "+$sha1 $path\t($revname)"
> +		fi
> +	done
> +}
> +
> +
> +while case "$#" in 0) break ;; esac
> +do
> +	case "$1" in
> +	-i|--init)
> +		init=1
> +		;;
> +	-u|--update)
> +		update=1
> +		;;
> +	-q|--quiet)
> +		quiet=1
> +		;;
> +	--cached)
> +		cached=1
> +		;;
> +	--)
> +		break
> +		;;
> +	-*)
> +		usage
> +		;;
> +	*)
> +		break
> +		;;
> +	esac
> +	shift
> +done
> +
> +
> +if test "$init" = "1"
> +then
> +	modules_init $@
> +elif test "$update" = "1"
> +then
> +	modules_update $@
> +else
> +	modules_list $@
> +fi

I'll let Junio comment on that command line parsing...

All in all, I like it: it is short, to the point, and it should do the job 
(maybe with a few enhancements like "--update" without arguments means 
_all_ submodules).

Ciao,
Dscho
