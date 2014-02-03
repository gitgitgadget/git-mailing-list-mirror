From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 8/9] rebase: add the --gpg-sign option
Date: Mon, 03 Feb 2014 13:42:06 -0800
Message-ID: <xmqqlhxrdgb5.fsf@gitster.dls.corp.google.com>
References: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
	<1391221086-1044384-9-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Feb 03 22:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WARI4-0004GK-BH
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 22:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbaBCVmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 16:42:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbaBCVmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 16:42:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EDED69E36;
	Mon,  3 Feb 2014 16:42:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=21hCBqMxXeH3dzbYrUI9e7oGBeg=; b=o6Ti1c/0OiCnZEUbz/G9
	lCWil425oD0vspk/m2E1+PxL/ecTZqr36kG0sXaGh5tvoMg119kXVpvr8hnDIIdA
	b9ChvTadtf6bsOU7xf/O5zncMtVDV+sdOMTEVyZ50zW3blkriFQs81C47e4RsZ2b
	N6FvSYgULCkxX7nSFULBQHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=W5dYns/Wb20p9Jq2R/EUYBLTFNwlqG0VcVQUUuPBNuniLt
	I39Kzt7/dYoR5SVXCXi+gParCTKMktKf6D9KT+q6c5BmJz9D55urs/sIRbTQ2bsF
	RFXE2UKn0yEfIzaNlQamXyAPYZw6QwTqwNllTMw1DkrjAYOgXK8W8fSGd13aE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E41F69E35;
	Mon,  3 Feb 2014 16:42:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 617D569E30;
	Mon,  3 Feb 2014 16:42:41 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1BACBEFE-8D1C-11E3-9A9D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241479>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 43c19e0..73d32dd 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -181,7 +181,7 @@ exit_with_patch () {
>  	git rev-parse --verify HEAD > "$amend"
>  	warn "You can amend the commit now, with"
>  	warn
> -	warn "	git commit --amend"
> +	warn "	git commit --amend $gpg_sign_opt"
>  	warn
>  	warn "Once you are satisfied with your changes, run"
>  	warn
> @@ -248,7 +248,8 @@ pick_one () {
>  
>  	test -d "$rewritten" &&
>  		pick_one_preserving_merges "$@" && return
> -	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
> +	output eval git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} \
> +			"$strategy_args" $empty_args $ff "$@"

This uses "$gpg_sign_opt" on "eval", which means that the variable's
contents must be properly shell quoted, e.g.

	gpg_sign_opt='-S'\''"brian m. carson" <sandals@c.net>'\'

throughout this script, so that everything between the first
double-quote " and closing ket > is passed as a single parameter
without being broken up.

> @@ -359,7 +360,8 @@ pick_one_preserving_merges () {
>  			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
>  			;;
>  		*)
> -			output eval git cherry-pick "$strategy_args" "$@" ||
> +			output eval git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} \

And this part has the same expectation.  However...

> @@ -470,7 +472,8 @@ do_pick () {
>  			   --no-post-rewrite -n -q -C $1 &&
>  			pick_one -n $1 &&
>  			git commit --allow-empty --allow-empty-message \
> -				   --amend --no-post-rewrite -n -q -C $1 ||
> +				   --amend --no-post-rewrite -n -q -C $1 \
> +				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||

This does not want that "extra level" of quoting.  It would want to
have something like this instead:

	gpg_sign_opt='-S"brian m. carson" <sandals@c.net>'

I am not sure how you are managing these two conflicting needs of
the use sites.

> @@ -497,7 +500,7 @@ do_next () {
>  
>  		mark_action_done
>  		do_pick $sha1 "$rest"
> -		git commit --amend --no-post-rewrite || {
> +		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {

Ditto.

> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index e7d96de..5381857 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -27,7 +27,7 @@ continue_merge () {
>  	cmt=`cat "$state_dir/current"`
>  	if ! git diff-index --quiet --ignore-submodules HEAD --
>  	then
> -		if ! git commit --no-verify -C "$cmt"
> +		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} --no-verify -C "$cmt"

Ditto.

>  		then
>  			echo "Commit failed, please do not call \"git commit\""
>  			echo "directly, but instead do one of the following: "
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 842d7d4..055af1b 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -37,6 +37,7 @@ ignore-date!       passed to 'git am'
>  whitespace=!       passed to 'git apply'
>  ignore-whitespace! passed to 'git apply'
>  C=!                passed to 'git apply'
> +S,gpg-sign?        GPG-sign commits
>   Actions:
>  continue!          continue
>  abort!             abort and check out the original branch
> @@ -85,6 +86,7 @@ preserve_merges=
>  autosquash=
>  keep_empty=
>  test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
> +gpg_sign_opt=
>  
>  read_basic_state () {
>  	test -f "$state_dir/head-name" &&
> @@ -107,6 +109,8 @@ read_basic_state () {
>  		strategy_opts="$(cat "$state_dir"/strategy_opts)"
>  	test -f "$state_dir"/allow_rerere_autoupdate &&
>  		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
> +	test -f "$state_dir"/gpg_sign_opt &&
> +		gpg_sign_opt="$(cat "$state_dir"/gpg_sign_opt)"
>  }
>  
>  write_basic_state () {
> @@ -120,6 +124,7 @@ write_basic_state () {
>  		"$state_dir"/strategy_opts
>  	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
>  		"$state_dir"/allow_rerere_autoupdate
> +	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
>  }
>  
>  output () {
> @@ -324,6 +329,15 @@ do
>  	--rerere-autoupdate|--no-rerere-autoupdate)
>  		allow_rerere_autoupdate="$1"
>  		;;
> +	--gpg-sign)
> +		gpg_sign_opt=-S
> +		;;
> +	--gpg-sign=*)
> +		# Try to quote only the argument, as this will appear in human-readable
> +		# output as well as being passed to commands.
> +		gpg_sign_opt="-S$(git rev-parse --sq-quote "${1#--gpg-sign=}" |
> +			sed 's/^ //')"

Isn't an invocation of sed excessive?

	gpg_sign_opt=$(git rev-parse --sq-quote "${1#--gpg-sign=}") &&
	gpg_sign_opt=-S${gpg_sign_opt# }

if you really need to strip the leading SP, which I do not think is
a necessary thing to do.  It is sufficient to remove the SP before
the variable substitution in the human-readable messages, e.g.

	echo "run this command: git commit$gpg_sign_opt"


> +		;;
>  	--)
>  		shift
>  		break
