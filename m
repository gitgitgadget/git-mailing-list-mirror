From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RESEND] git-submodule: provide easy way of adding new submodules
Date: Sat, 23 Jun 2007 12:58:03 -0700
Message-ID: <7v8xaa4f5g.fsf@assigned-by-dhcp.pobox.com>
References: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jun 23 21:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2BkR-0006cb-M9
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 21:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbXFWT6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 15:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbXFWT6I
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 15:58:08 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46201 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbXFWT6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 15:58:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623195804.MHPM1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Jun 2007 15:58:04 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id F7y41X0041kojtg0000000; Sat, 23 Jun 2007 15:58:04 -0400
In-Reply-To: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Thu, 21 Jun 2007 11:53:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50748>

Sven Verdoolaege <skimo@kotnet.org> writes:

>  COMMANDS
>  --------
> +add::
> +	Add the given repository as a submodule at the given path
> +	to the changeset to be committed next.  In particular, the
> +	repository is cloned at the specified path, added to the
> +	changeset and registered in .gitmodules.   If no path is
> +	specified, the path is deduced from the repository specification.
> +

Somehow "git submodule add $URL $my_subdirectory" feels
unnatural, although it certainly is simpler to write the command
usage string.  Wouldn't a commit on the maintenance branch of
cgit.git want to say "Add the 'maint' branch of git.git as my
submodule", for example?

The alternatives I can come up with do not feel right either, though.

	git submodule $my_subdirectory $URL [$branch]
	git submodule $URL [--branch $branch] $my_subdirectory

Hmmm...

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 89a3885..3df7121 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1,13 +1,14 @@
>  #!/bin/sh
>  #
> -# git-submodules.sh: init, update or list git submodules
> +# git-submodules.sh: add, init, update or list git submodules
>  #
>  # Copyright (c) 2007 Lars Hjemli
>  
> -USAGE='[--quiet] [--cached] [status|init|update] [--] [<path>...]'
> +USAGE='[--quiet] [--cached] [add <repo>|status|init|update] [--] [<path>...]'

Can a single repo added at more than one path with this syntax?
I do not see that in the code, but this implies such.

>  . git-sh-setup
>  require_work_tree
>  
> +add=
>  init=
>  update=
>  status=
> @@ -25,6 +26,17 @@ say()
>  	fi
>  }
>  
> +get_repo_base() {
> +	(
> +		cd "`/bin/pwd`" &&
> +		cd "$1" || cd "$1.git" &&
> +		{
> +			cd .git
> +			pwd
> +		}
> +	) 2>/dev/null
> +}
> +

I've seen this code before elsewhere.  We do not need to
refactor right now with this patch, but please mark this copy
with something like:

	# NEEDSWORK: identical function exists in get_repo_base
        # in clone.sh
	get_repo_base () {
        	...

as a reminder.

> @@ -66,6 +78,44 @@ module_clone()
>  }
>  
>  #
> +# Add a new submodule to the working tree, .gitmodules and the index
> +#
> +# $@ = repo [path]
> +#
> +module_add()
> +{
> +	repo=$1
> +	path=$2
> +
> +	# Turn the source into an absolute path if
> +	# it is local
> +	if base=$(get_repo_base "$repo"); then
> +		repo="$base"
> +	fi
> +
> +	# Guess path from repo if not specified or strip trailing slashes
> +	if test -z "$path"; then
> +		path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
> +	else
> +		path=$(echo "$path" | sed -e 's|/*$||')
> +	fi
> +
> +	test -e "$path" &&
> +	die "'$path' already exists"
> +
> +	module_clone "$path" "$repo" || exit

 - module_clone catches the "$path already exists" case; but the
   test is done differently.  One particular case of "an empty
   directory exists" is allowed there, but you are dying early
   to forbid it.  Is that warranted?  My gut feeling is that
   they should share the same check, iow, don't check yourself
   but have module_clone take care of the error case.

 - If $path does not exist in the worktree (because it hasn't
   been checked out), but does exist in the index, what should
   happen?  Should it be flagged as an error (in module_clone,
   not here)?
