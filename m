From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute
 url logic to module_clone
Date: Mon, 21 Apr 2008 23:10:38 -0700
Message-ID: <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:11:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoBjE-0006GK-CW
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbYDVGKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbYDVGKt
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:10:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbYDVGKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:10:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A95DE1150;
	Tue, 22 Apr 2008 02:10:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D7565114E; Tue, 22 Apr 2008 02:10:41 -0400 (EDT)
In-Reply-To: <1208355577-8734-3-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Wed, 16 Apr 2008 22:19:32 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80063>

Ping Yin <pkufranky@gmail.com> writes:

> Extract function absolute_url to remove code redundance and inconsistence in
> cmd_init and cmd_add when resolving relative url/path to absolute one.
>
> Also move resolving absolute url logic from cmd_add to module_clone which
> results in a litte behaviour change: cmd_update originally doesn't
> resolve absolute url but now it will.

Hmmm.  Somehow I find this unreadable and hard to parse.

> This behaviour change breaks t7400 which uses relative url './.subrepo'.
> However, this test originally doesn't mean to test relative url with './',
> so fix the url as '.subrepo'.

Isn't ".subrepo" a relative URL that says "subdirectory of the current
one, whose name is .subrepo", exactly the same way as "./.subrepo" is?
Shouldn't they behave the same?

If the test found they do not behave the same, perhaps the new code is
broken in some way and isn't "fixing" the test simply hiding a bug?

I dunno...

> +# Resolve relative url/path to absolute one
> +absolute_url () {
> +	case "$1" in
> +	./*|../*)
> +		# dereference source url relative to parent's url
> +		url="$(resolve_relative_url $1)" ;;
> +	*)
> +		# Turn the source into an absolute path if it is local
> +		url=$(get_repo_base "$1") ||
> +		url=$1
> +		;;
> +	esac
> +	echo "$url"
> +}
> +
>  #
>  # Map submodule path to submodule name
>  #
> @@ -112,7 +127,7 @@ module_info() {
>  module_clone()
>  {
>  	path=$1
> -	url=$2
> +	url=$(absolute_url "$2")
>  
>  	# If there already is a directory at the submodule path,
>  	# expect it to be empty (since that is the default checkout

Why does this call-site matter?  The URL is given to "git-clone" which I
think does handle the relative URL just fine???

> @@ -195,21 +210,7 @@ cmd_add()
>  			die "'$path' already exists and is not a valid git repo"
>  		fi
>  	else
> -		case "$repo" in
> -		./*|../*)
> -			# dereference source url relative to parent's url
> -			realrepo="$(resolve_relative_url $repo)" ;;
> -		*)
> -			# Turn the source into an absolute path if
> -			# it is local
> -			if base=$(get_repo_base "$repo"); then
> -				repo="$base"
> -			fi
> -			realrepo=$repo
> -			;;
> -		esac
> -
> -		module_clone "$path" "$realrepo" || exit
> +		module_clone "$path" "$repo" || exit
>  		(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
>  		die "Unable to checkout submodule '$path'"
>  	fi

Ok.

> @@ -262,13 +263,7 @@ cmd_init()
>  		test -z "$url" &&
>  		die "No url found for submodule path '$path' in .gitmodules"
>  
> -		# Possibly a url relative to parent
> -		case "$url" in
> -		./*|../*)
> -			url="$(resolve_relative_url "$url")"
> -			;;
> -		esac
> -
> +		url=$(absolute_url "$url")
>  		git config submodule."$name".url "$url" ||
>  		die "Failed to register url for submodule path '$path'"

Ok.
