From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 9/9] pull: add the --gpg-sign option.
Date: Mon, 03 Feb 2014 12:31:47 -0800
Message-ID: <xmqqd2j4djkc.fsf@gitster.dls.corp.google.com>
References: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
	<1391221086-1044384-10-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAQBU-0003mX-WE
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbaBCUbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:31:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbaBCUbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 15:31:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A3E869355;
	Mon,  3 Feb 2014 15:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0FpE4N2b79e+uq3dYxJb4GB33HI=; b=A4s+DE
	lbJ78jGzixQ7YfBeuVbol01rHcVqUgMtvJb8BmtaPFKIb1Nvu2rS1ZcNwc9ItE4n
	NfgiP3vDLs96wKjeVgxV49sU9NZU5zrHULg0TuJSZIWSTDDmM5HGN3aHZJ4R32fA
	X9j9FCFlzs2znGCIjZ1ThRaifXceiU3AcX9TI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGimllobrf3Ei+cEgdwIbyQSkcH8OCX5
	FmOcjMa43tIM9/BtO7iRHYFVPlwYggbm3ShBzHt9v2IFanE0vgCczmAmCC0XJwFE
	IgHD6fwLRDZ3mq5MaH1L9iSkLI15MePkV0XiTXz/NUmWvE/Ric4RiwLOxacFcKAY
	FOYBp6x8jAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8422E69353;
	Mon,  3 Feb 2014 15:31:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAD4369350;
	Mon,  3 Feb 2014 15:31:50 -0500 (EST)
In-Reply-To: <1391221086-1044384-10-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 1 Feb 2014 02:18:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36194F6E-8D12-11E3-A02F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241475>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> git merge already allows us to sign commits, and git rebase has recently
> learned how to do so as well.  Teach git pull to parse the -S/--gpg-sign
> option and pass this along to merge or rebase, as appropriate.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-pull.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 0a5aa2c..3b2ea9e 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -138,6 +138,15 @@ do
>  	--no-verify-signatures)
>  		verify_signatures=--no-verify-signatures
>  		;;
> +	--gpg-sign|-S)
> +		gpg_sign_args=-S
> +		;;
> +	--gpg-sign=*)
> +		gpg_sign_args="$(git rev-parse --sq-quote "-S${1#--gpg-sign=}")"
> +		;;
> +	-S*)
> +		gpg_sign_args="-S${1#-S}"
> +		;;

Interesting.  Remove -S from the beginning and then prefix that with -S?

Also, --gpg-sign='"b m c" <s@c.n>' and -S'"b m c" <s@c.n>' from the
command line of this program would result in $gpg_sign_args that are
differently quoted.  Both of them cannot be correct at the same time.


>  	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
>  		dry_run=--dry-run
>  		;;
> @@ -305,11 +314,13 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>  case "$rebase" in
>  true)
>  	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
> +	eval="$eval $gpg_sign_args"
>  	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
>  	;;
>  *)
>  	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
> -	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
> +	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
> +	eval="$eval $gpg_sign_args"
>  	eval="$eval \"\$merge_name\" HEAD $merge_head"
>  	;;
>  esac
