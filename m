From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] pull: add the --gpg-sign option.
Date: Mon, 27 Jan 2014 15:31:36 -0800
Message-ID: <xmqqlhy1m27b.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<1390524666-51274-10-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jan 28 00:31:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7vef-0002mb-JL
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 00:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbaA0Xbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 18:31:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbaA0Xbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 18:31:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 466E967072;
	Mon, 27 Jan 2014 18:31:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6rxJSI32kqRLMlKDvqi8S4vq/EE=; b=LUKXje
	jBn1o76q6F7D4/DIk0vljcsdHSih2awha+HUbFevTyctWjGBhDJom6+JQTEe64SO
	+68UqcqbhRV8XKrF/OwPcPPxRl2HZPXsGSJnq1+Jnrj6L/gBPri+kljgqAH5/j7l
	CMhNPR0Yr6Bhuti+4PEAlNrzO5qggPfGslxgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h94Q/jYxVUcUzWRDFbaLdri026CmYXjI
	ED0Z1PRTQxvT97UUOvEUNRtlvEEFkGqekfb57QVvF1l4uSU9HovlQ8BgwmmyKGuB
	J8uTjaPcF5jXZQBvcfT9KAgAEC0ngIyNFbBhL3IS6WN1EZVSjpUkrKBSpfUOzom8
	uoC7otJyCQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCE967071;
	Mon, 27 Jan 2014 18:31:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7502567070;
	Mon, 27 Jan 2014 18:31:38 -0500 (EST)
In-Reply-To: <1390524666-51274-10-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Fri, 24 Jan 2014 00:51:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B2E7758-87AB-11E3-88E6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241167>

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
> index 0a5aa2c..4164dac 100755
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
> +		gpg_sign_args="-S${1#--gpg-sign=}"
> +		;;

Here, $1 is taken from the end-user without any extra quoting...

> +	-S*)
> +		gpg_sign_args="-S${1#-S}"
> +		;;
>  	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
>  		dry_run=--dry-run
>  		;;
> @@ -305,11 +314,13 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>  case "$rebase" in
>  true)
>  	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
> +	eval="$eval $gpg_sign_args"

... but here it is used as if it is properly quoted so that later
"eval $eval" will take it as a single argument.

	git pull --gpg-sign='foo bar'

will probably ask the command to use 'foo' as the signer key id,
with 'bar' as an extra, unknown token on the command line of the
underlying 'git merge', I suspect.  A "git rev-parse --sq-quote"
in the earlier hunk may be all it takes to fix it.

Thanks.

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
