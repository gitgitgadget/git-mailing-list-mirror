From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/6] submodule: Make 'checkout' update_module explicit
Date: Thu, 16 Jan 2014 10:46:36 -0800
Message-ID: <xmqqwqhzzrw3.fsf@gitster.dls.corp.google.com>
References: <20140114224246.GA13271@book.hvoigt.net>
	<43e8f3bfdaffefca9edd7a23574816630690e1e5.1389837412.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 19:46:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3rxn-0002Mu-6k
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 19:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbaAPSqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 13:46:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbaAPSqm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 13:46:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F1F62B9E;
	Thu, 16 Jan 2014 13:46:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DplCOrbwUOTmNa9HKpqzeATbV+o=; b=RjcpdF
	ZQa0w5qS7R6RChTqRc505Rx7IKXIfRO69HTbB8jrFqyxPpQ80cMVmaLTLOWAlCOM
	AT9I0FgVA5T4GkodHRH3QqdYTtc9/kgBzl1UqYT2fmn7JIXw00bHPKjKYOHNA4aM
	DLZtFcvqYwK8HzuXojWfC8y4rfhd48dbqxbCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XwVSnQ7RjFGqSptXL0338A9IX98GRZKM
	UOIxyVA/suxaULaqR22wL2SlLiCmlknflkHUvcP9FWmZrXMkYJAvAzpc3llhgbPs
	1gKSVQfJ3LFwK0ZcOzhoQtxTy9e+3UZudn37okfyLpckOenUOusHusi00tznnKG9
	N4413Nqrf5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E4E262B9C;
	Thu, 16 Jan 2014 13:46:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A19762B9A;
	Thu, 16 Jan 2014 13:46:39 -0500 (EST)
In-Reply-To: <43e8f3bfdaffefca9edd7a23574816630690e1e5.1389837412.git.wking@tremily.us>
	(W. Trevor King's message of "Wed, 15 Jan 2014 20:10:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 88BCD390-7EDE-11E3-91AB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240519>

"W. Trevor King" <wking@tremily.us> writes:

> This avoids the current awkwardness of having either '' or 'checkout'
> for checkout-mode updates, which makes testing for checkout-mode
> updates (or non-checkout-mode updates) easier.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  git-submodule.sh | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5247f78..5e8776c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -803,17 +803,10 @@ cmd_update()
>  			update_module=$update
>  		else
>  			update_module=$(git config submodule."$name".update)
> -			case "$update_module" in
> -			'')
> -				;; # Unset update mode
> -			checkout | rebase | merge | none)
> -				;; # Known update modes
> -			!*)
> -				;; # Custom update command
> -			*)
> -				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
> -				;;
> -			esac
> +			if test -z "$update_module"
> +			then
> +				update_module="checkout"
> +			fi
>  		fi

Is this a good change?

It removes the code to prevent a broken configuration value from
slipping through.  The code used to stop early to give the user a
chance to fix it before actually letting "submodule update" to go
into the time consuming part, e.g. a call to module_clone, but that
code is now lost.

>  		displaypath=$(relative_path "$prefix$sm_path")
> @@ -882,11 +875,16 @@ Maybe you want to use 'update --init'?")"
>  			case ";$cloned_modules;" in
>  			*";$name;"*)
>  				# then there is no local change to integrate
> -				update_module= ;;
> +				update_module=checkout ;;
>  			esac
>  
>  			must_die_on_failure=
>  			case "$update_module" in
> +			checkout)
> +				command="git checkout $subforce -q"
> +				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> +				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> +				;;
>  ...
>  			*)
> -				command="git checkout $subforce -q"
> -				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> -				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> -				;;
> +				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
>  			esac

These two hunks make sense.  It is clear in the updated code that
"checkout" is what is implemented with that "git checkout $subforce
-q", and not any other random update mode.
