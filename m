From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Mon, 19 Feb 2007 02:07:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1171838852534-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 02:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIx0H-0005lF-UY
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 02:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbXBSBHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 20:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbXBSBHi
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 20:07:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:43756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752639AbXBSBHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 20:07:38 -0500
Received: (qmail invoked by alias); 19 Feb 2007 01:07:36 -0000
X-Provags-ID: V01U2FsdGVkX1/EustRF17EojKu7fkfaP3u4O5/RZruWogWkGnhhK
	FqiQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1171838852534-git-send-email-mdl123@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40088>

Hi,

Sorry to be such a PITA, but I really, really think that it is wrong to 
make a tar dependency here. You said your cygwin has problems with binary 
files. Could you please try this:

	$ echo -ne '\x1a\x1b\x15\x10\0abc' | cat | wc

If it returns anything else than "<tab>0<tab>1<tab>8", then your setup 
works differently from mine. I fit returns what I expect it to, then we 
can use cat directly and do not have to move the tar bloat around (it is 
inherently block based, so it wastes a lot of space, and it also stores 
other things we'll never use, like permissions for all files).

On Sun, 18 Feb 2007, Mark Levedahl wrote:

> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
> old mode 100755
> new mode 100644

This is unintended, right?

> diff --git a/git-bundle.sh b/git-bundle.sh
> new file mode 100755
> index 0000000..19ac137
> --- /dev/null
> +++ b/git-bundle.sh
> @@ -0,0 +1,174 @@
> +#!/bin/sh
> +# Basic handler for bundle files to connect repositories via sneakernet.
> +# Invocation must include action.
> +# This function can create a bundle or provide information on an existing bundle
> +# supporting git-fetch, git-pull, and git-ls-remote
> +
> +USAGE='[--create bundle <git-rev-list args>] |
> +[--verify|--list-heads|--unbundle bundle] <--tar tarspec>
> +     where bundle is the name of the bundle file.'

We seem to prefer another (more consistent?) way to describe things: If 
the argument is not an option, we embrace it with "<>", for example:

	<bundle>

if it is an optional option, we put it in "[]", for example:

	[--tar <tarfile>]

and if one of several mutual exclusive options has to be passed, we put it 
in "()" delimited with "|". Also, we put no explanation in the output of 
"-h", since you should read the man page if you don't know what the 
options mean. So, it is

	git-bundle ( --create <bundle> [<rev-list-args>...] |
		 --verify | --list-heads | --unbundle <bundle> )
		[--tar <tarspec>]

> +verify() {

This function is nicely done, AFAICT!

> +list_heads() {
> +	if test -z "$*" ; then
> +		$TAR -xf "$bfile" -O references 2>/dev/null || exit 1
> +	else
> +		($TAR -xf "$bfile" -O references 2>/dev/null || exit 1) |

AFAICT this will not work as expected: "()" opens a subshell, and "exit 1" 
will only exit that subshell. Correct me if I'm wrong.

> +		while read sha1 ref ; do
> +			for arg in $* ; do
> +				if test "${ref%$arg}" != "$ref" ; then
> +					echo "$sha1 $ref"
> +					break
> +				fi
> +			done
> +		done
> +	fi
> +}

The complexity here is unnecessarily high (O(N*M)), but I guess we cannot 
do better in shell. Maybe constructing a regexp from the args, and piping 
the output from tar through a grep would help here. Dunno. Maybe it 
doesn't matter much in reality, anyway.

> +SUBDIRECTORY_OK=1
> +. git-sh-setup

We tend to write this part at the very top of a git script.

> +while test -n "$1" ; do
> +    case $1 in
> +        --create|--list-heads|--unbundle|--verify)
> +            action=${1#--}
> +            shift
> +            bfile=$1

This can contain spaces (you are working on Windows, right? Windows users 
_love_ spaces in their filenames).

> +            test -z "$bfile" && die "$action requires filename";;
> +        --tar=*)
> +            TAR=${1##--tar=};;
> +        --tar)
> +			shift
> +            TAR=$1;;
> +        *)
> +            args="$args $1";;

I know you want to mix the --tar option with the rev-list options (which I 
still find totally confusing, and unnecessary at best), but you _have_ to 
quote "$1" in the args=... part, then. Even refs can contain spaces these 
days.

> +# what tar to use, prefer gtar, then tar.
> +if test -z "$TAR" ; then
> +    GTAR=$(which gtar 2>/dev/null)

Somebody on this list said that "which" should not be relied upon IIRC. I 
forgot why, but I obey that hint.

> +    gitrevargs=$(git-rev-parse --symbolic --revs-only $args) || exit 1

Here, you rely again on the refs not containing spaces.

> +    # git-rev-list cannot determine edge objects if a date restriction is
> +    # given...  we do things a slow way if max-age or min-age are given

Might make sense to teach max-age about boundary commits instead...

> +            prereqs=$(git-rev-list --objects-edge $fullrevargs | sed -ne 's/^-//p');;

Since you are not interested in non-commits at all, why not use 
"--boundary" instead?

> +    # create refs and pack
> +    tmp="$GIT_DIR/bundle_tmp$$"

Should we really rely on $GIT_DIR being writable? For unbundling, yes, but 
for bundling? Given the great confusion with git-status trying to write 
into $GIT_DIR, and people _demanding_ that it does not do so, I recommend 
against that.

In the following part, refnames must not contain spaces again:

> +	(for p in $prereqs ; do
> +		git-rev-list --pretty=one --max-count=1 $p
> +	done) > "$prerequisites" &&
> +    git-show-ref $refs > "$references" &&
> +    git-rev-list --objects $fullrevargs | cut -b-40 |
> +        git pack-objects --all-progress --stdout > "$pack" &&

pack-objects can take rev-list arguments itself these days, using "--revs" 
and being piped the rev-list arguments.

> +verify)
> +    verify && echo "$bfile is ok";;
> +
> +list-heads)
> +    list_heads $args;;

I like this abstraction (defining a function, and calling that). Why don't 
you do it with all commands?

Rest looks fine.

Given the problems you had with "cat" on Cygwin, and the quoting stuff, I 
think it might make sense to make this a builtin right away, before the 
script stage (which is meant to speed things up, not slow them down).

Ciao,
Dscho
