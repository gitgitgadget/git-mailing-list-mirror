From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into
 porcelain.
Date: Tue, 02 Aug 2011 16:01:28 -0700
Message-ID: <7voc07ct9z.fsf@alter.siamese.dyndns.org>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
 <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 01:01:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNxx-0006E0-6d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 01:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab1HBXBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 19:01:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912Ab1HBXBb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 19:01:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63FBE37C4;
	Tue,  2 Aug 2011 19:01:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pKg/LidFJ9nfAuNk4QXkn1E4n+E=; b=fHtmDp
	6HWQDdjnHLH7Pgd8idHTU5+TpLpekwyt/6c7J++MhljbgdkEpv84mrlsBnmDv8K7
	Rm77s2Rl8loiHeCEeJGvAt7rKSBlQC8q5bWXH16pEqTwwOTm670TUvaKT+OFROPu
	8SmmPHddIGzYt5IHnxWvDt9izNZzW2Awsuh9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nen2dQUNHyPEFDX/l8IcoUY20Xw7pZig
	5ZI4dMtmi1PdPHk6Zc6yasZbfFpav7KJPhBMYKoRPiGlDRO6ygLIumVGaAaAAEGZ
	xxbwRiDKz+2/SFF+UJNBJdrQ4jhYAotlSNC1ZnABxHJnqdsIUGI1Z1uYlG0zbaua
	y7cihj1EBlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5968637C2;
	Tue,  2 Aug 2011 19:01:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B22E237BE; Tue,  2 Aug 2011
 19:01:29 -0400 (EDT)
In-Reply-To: <1312323362-20096-6-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Wed, 3 Aug 2011 08:15:59 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B974964-BD5B-11E0-8C32-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178530>

Jon Seymour <jon.seymour@gmail.com> writes:

> +	BISECT_MODE=
>  	while [ $# -gt 0 ]; do
>  	    arg="$1"
>  	    case "$arg" in
> @@ -76,6 +79,11 @@ bisect_start() {
>  		shift
>  		break
>  		;;
> +	    --no-checkout)
> +		BISECT_MODE=--no-checkout;
> +		shift ;;
> +	    --*)
> +		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
>  	    *)
>  		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
>  		    test $has_double_dash -eq 1 &&
> @@ -107,7 +115,11 @@ bisect_start() {
>  	then
>  		# Reset to the rev from where we started.
>  		start_head=$(cat "$GIT_DIR/BISECT_START")
> -		git checkout "$start_head" -- || exit
> +		if test "$BISECT_MODE" = "--no-checkout"; then
> +		    git update-ref --no-deref HEAD "$start_head"
> +		else
> +		    git checkout "$start_head" --
> +		fi

Just a minor worry but I would not be surprised if somebody's "test"
implementation barfs upon:

	test "--no-checkout" = "--no-checkout"

mistaking the string with a dash at the beginning as an option unknown to
it. That is why we often have "z$variable" in our comparison, like so:

	if test "z$BISECT_MODE" = "z--no-checkout"
        then
        	git update-ref --no-deref BISECT_HEAD "$start_head"
	else
        	git checkout "$start_head" --
	fi

> -	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
> +	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES"
> +	echo "$BISECT_MODE" > "$GIT_DIR/BISECT_MODE" &&

&&?
