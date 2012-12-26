From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: treat numerical arguments as shorthand for
 stash@{n}
Date: Tue, 25 Dec 2012 18:08:05 -0800
Message-ID: <7v623pr2ey.fsf@alter.siamese.dyndns.org>
References: <1356482314-29044-1-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Wed Dec 26 03:08:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TngQ6-0000Gh-2G
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 03:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab2LZCIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2012 21:08:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab2LZCII (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2012 21:08:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA1A0ABC5;
	Tue, 25 Dec 2012 21:08:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+IRPDhoXosE+Gu7AO0JWNrWpdgE=; b=NAZZQB
	tFqUkJtAkEa8qiwWLvljzom9kCXP0/LqEfLkC8s7kV7D8oth4r13LmuZSmdZKjxJ
	xBqNbzQPp4dXZvZW5bLOlDmFfc3lgRUdkYWMiveETs8DlbnFGiOfe+RdClGrMRO8
	fAY7lEQ/i41puKfkCvDnkyUo6/EP0Um6monks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X9xy0NA2TVIX4gX2NnDttzLG8L6G8tbM
	xDjkQTu9cp21Y0noNrhdPphrAQM1mv8D4pZ/TKWoAvSy3HhArXa2KYndUP5dKRiC
	ORKNzA+qr9AmmuaRsA0ykefCsz1XjPZ5vr+Se4hC66tJvATxGzO5Ji0jmPx2Nmkj
	gLam+oOSiLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8475ABC4;
	Tue, 25 Dec 2012 21:08:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECEEDABC1; Tue, 25 Dec 2012
 21:08:06 -0500 (EST)
In-Reply-To: <1356482314-29044-1-git-send-email-peter@pcc.me.uk> (Peter
 Collingbourne's message of "Tue, 25 Dec 2012 16:38:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16BFFAF0-4F01-11E2-B0AE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212126>

Peter Collingbourne <peter@pcc.me.uk> writes:

> This patch causes git-stash to treat any argument consisting of
> between one and three numerical digits as if it were of the form
> `stash@{<n>}`, where `<n>` is the argument supplied.

Inperative mood.

>
> This is a significant usability improvement for people dealing with
> multiple stashes, as it avoids redundantly typing 'stash@{' ... '}'
> (which involves shifted characters on most keyboards) in the very
> common case that the stash was created using git-stash.

Be less subjective by dropping "significant"; do not shove the
judgement down the throat of reviewers.

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 711ffe1..8ffcc97 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -40,6 +40,10 @@ the usual reflog syntax (e.g. `stash@{0}` is the most recently
>  created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
>  is also possible).
>  
> +Any argument supplied to this command consisting of between one
> +and three numerical digits is treated as if it were of the
> +form `stash@{<n>}`, where `<n>` is the argument supplied.

Why up to 999, not 99 or 9999?

How about doing it this way instead:

	if commit=$(git rev-parse --verify --quiet $arg^0)
	then
		: that is a commit-ish, even though it is 0123
	elif test "$arg" = 0 || expr "$arg" : '[1-9][0-9]*$' >/dev/null &&
	     commit=$(git rev-parse --verify --quiet "stash@{$arg}^0")
	then
		: $arg is decimal integer and stash@{$arg} is a commit-ish
	else
        	BAD
	fi

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 5dfbda7..5467acf 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -38,7 +38,7 @@ test_expect_success 'parents of stash' '
>  '
>  
>  test_expect_success 'applying bogus stash does nothing' '
> -	test_must_fail git stash apply stash@{1} &&
> +	test_must_fail git stash apply 1 &&

If you are _adding_ a feature, do not remove tests for existing one;
otherwise you will risk masking a breakage you may be introducing to
an existing feature.  Add tests to check that (1) your new feature
works when it should, and (2) your new feature does *not* kick in
when it should not.  For example, if you only accept up to 3-digit
decimal integer, make sure feeding 0000 (or something that is *not*
3-digit decimal integer) does not trigger your new feature.

>  	echo 1 >expect &&
>  	test_cmp expect file
>  '
> @@ -113,7 +113,7 @@ test_expect_success 'drop middle stash' '
>  	git stash &&
>  	echo 9 > file &&
>  	git stash &&
> -	git stash drop stash@{1} &&
> +	git stash drop 1 &&

Likewise throughout the patch.
