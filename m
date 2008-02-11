From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-submodule - Follow top-level remote on
 init/update/clone
Date: Mon, 11 Feb 2008 22:09:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802112152050.3870@racer.site>
References: <1202576245-284-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOgqX-0001wE-11
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651AbYBKWJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 17:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757588AbYBKWJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:09:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:56061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757136AbYBKWJN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 17:09:13 -0500
Received: (qmail invoked by alias); 11 Feb 2008 22:09:11 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 11 Feb 2008 23:09:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zTqNHUl5zFhgPAaW/rrKAEYLkcfOrj8rwTzbm5D
	CbaFzx9fm6d7Ku
X-X-Sender: gene099@racer.site
In-Reply-To: <1202576245-284-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73594>

Hi,

On Sat, 9 Feb 2008, Mark Levedahl wrote:

> This change allows the remote used for relative submodules (those defined
> using a url that is relative to their parent) to be defined by explicit
> definition on the command line or through the top-level project's
> branch.<name>.remote configuration.  This override is applied *only* to
> submodules defined using a url relative to the top-level project's url,
> under the assumption that such modules are logically part of the same
> project and managed as a unit.

That makes sense.

> @@ -40,11 +42,13 @@ get_repo_base() {
>  # Resolve relative url by appending to parent's url
>  resolve_relative_url ()
>  {
> -	branch="$(git symbolic-ref HEAD 2>/dev/null)"
> -	remote="$(git config branch.${branch#refs/heads/}.remote)"
> -	remote="${remote:-origin}"
> -	remoteurl="$(git config remote.$remote.url)" ||
> -		die "remote ($remote) does not have a url in .git/config"

I did not really look at this code before, but does that not mean that 
git-submodule does already what you want?

Because usually, you clone the superproject from the URL that you actually 
want to use, and in that case, the initial branch's default remote will 
have exactly that URL.

So I have to admit that I do not see the reason why you remove that code, 
replace it with another (that I think does the same), and claim that you 
introduce that behaviour.

Your patch seems to change only one thing: you can specify "-r <remote>" 
with "git submodule add/init/update" -- except for some peculiarity; see 
below.

> @@ -107,7 +112,7 @@ module_clone()
>  	test -e "$path" &&
>  	die "A file already exist at path '$path'"
>  
> -	git-clone -n "$url" "$path" ||
> +	git-clone -n -o "$remote" "$url" "$path" ||
>  	die "Clone of '$url' into submodule path '$path' failed"
>  }
>  

If you do _that_, you will _force_ the submodule to have no "origin" 
remote.  As discussed _at length_, this is not what you should do.  The 
only reason to use "-o <other-nick-name>" is if you plan _not_ to use the 
same URL for the default remote.

IOW I do not like this hunk _at_ _all_.  Because I get the impression that 
I really wasted my time explaining the same issue over and over and over 
again.

> @@ -156,13 +169,16 @@ cmd_add()
>  	case "$repo" in
>  	./*|../*)
>  		# dereference source url relative to parent's url
> -		realrepo="$(resolve_relative_url $repo)" ;;
> +		realremote=${remote:-$(get_default_remote)}
> +		realrepo=$(resolve_relative_url $repo) || exit 1
> +		;;

Why do you need the "realremote" here?  Why is "$remote" not enough?

> @@ -235,7 +259,7 @@ cmd_init()
>  		# Possibly a url relative to parent
>  		case "$url" in
>  		./*|../*)
> -			url="$(resolve_relative_url "$url")"
> +			url=$(resolve_relative_url "$url") || exit 1

Yes for the "|| exit 1".  No for the removal of the quotes: keep in mind: 
you are possibly getting a url from the _config_, which is supposed to be 
user-editable.

> @@ -274,6 +308,7 @@ cmd_update()
>  		shift
>  	done
>  
> +	remote=${remote:-$(get_default_remote)}

You have this paradigm so often, but AFAICS you only use it for the call 
to module_clone.  Why not let module_clone figure it out, if $remote is 
empty?

> @@ -298,9 +333,24 @@ cmd_update()
>  			die "Unable to find current revision in submodule path '$path'"

>  		fi
>  
> +		baseurl="$(GIT_CONFIG=.gitmodules git config submodule."$name".url)"
> +		case "$baseurl" in
> +		./*|../*)
> +			fetch_remote=$remote
> +			absurl=$(resolve_relative_url $baseurl) || exit 1
> +			(unset GIT_DIR ; cd "$path" && git config remote."$fetch_remote".url > /dev/null) ||
> +			(
> +				unset GIT_DIR; cd "$path" && git remote add "$fetch_remote" "$absurl"
> +			) || die "Unable to define remote '$fetch_remote' in submodule path '$path'"
> +			;;
> +		*)
> +			fetch_remote=
> +			;;
> +		esac
> +
>  		if test "$subsha1" != "$sha1"
>  		then
> -			(unset GIT_DIR; cd "$path" && git-fetch &&
> +			(unset GIT_DIR; cd "$path" && git-fetch $fetch_remote &&

Wasn't the whole _point_ of having a two-stage init/update that you could 
_change_ the remote in the config?

Now you override those settings if .gitmodules says that the path is 
relative?  Shouldn't you respect the setting in the config (which the user 
can change freely), rather than .gitmodules (which the user cannot change 
without either committing it or having a permanently dirty working 
directory)?

Ciao,
Dscho
