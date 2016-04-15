From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/21] t/test-lib-functions.sh: generalize test_cmp_rev
Date: Fri, 15 Apr 2016 13:00:13 -0700
Message-ID: <xmqqd1pqbq2a.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-4-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:00:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9un-0005V0-3R
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbcDOUAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:00:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752653AbcDOUAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:00:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8DF2132A3;
	Fri, 15 Apr 2016 16:00:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uzToXnKJ5IrLtV1FJ1oX8WdJ2uI=; b=mOEBm7
	4bXeBD4pGCxfNMyVeMuSvFFsO8kWnvn1myea9cyar9+o+wpPCeL8WTc6o1hFVupv
	f37fYbEnF0MiJtOn3Yqb996UJt/p3Z9G+yky84X4exlFup6uZYOhCp/PpWyAUE9g
	gYPY0gvU8JdeR17UgFh+UfIDh2yJLTl0ySSHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ufoz9MZtc75u2fW4xOalQ7scYuncElLg
	pkTXLj/q1SVcYOuMRkfrKProTsZ2keirmzApXGwdcgGfOh1Kimhl4AGRb2vxjN67
	PJn+fAIlxCvyDUYQ37OnsfedNYr/2QodbV4HPkzi+1gl2VDwU35GPFNaZ26Ob0kN
	hcafb1TyFjU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A13DF132A2;
	Fri, 15 Apr 2016 16:00:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B8FD1329F;
	Fri, 15 Apr 2016 16:00:14 -0400 (EDT)
In-Reply-To: <1460294354-7031-4-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:18:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB74DD78-0344-11E6-A9E2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291650>

Stephan Beyer <s-beyer@gmx.net> writes:

> test_cmp_rev() took exactly two parameters, the expected revision
> and the revision to test. This commit generalizes this function
> such that it takes any number of at least two revisions: the
> expected one and a list of actual ones. The function returns true
> if and only if at least one actual revision coincides with the
> expected revision.

There may be cases where you want to find the expected one among
various things you actually have (which is what the above talks
about; it is like "list-what-I-actually-got | grep what-i-want"),
but an equally useful use case would be "I would get only one
outcome from test, I anticipate one of these things, all of which is
OK, but I cannot dictate which one of them should come out" (it is
like "list-what-I-can-accept | grep what-I-actually-got").

I am not enthused by the new test that implements the "match one
against multi" check only in one way among these possible two to
squat on a very generic name, test_cmp_rev.

The above _may_ appear a non-issue until you realize one thing that
is there to help those who debug the tests, which is ...

> While at it, the side effect of generating two (temporary) files
> is removed.

That is not strictly a side effect.  test_cmp allows you to see what
was expected and what you actually had when the test failed (we
always compare expect with actual and not the other way around, so
that "diff -u expect actual" would show how the actual behaviour
diverted from our expectation in a natural way).

Something with the semantics of these two:

	test_revs_have_expected () {
        	expect=$1
		shift
		git rev-parse "$@" | grep -e "$expect" >/dev/null && return
		echo >&2 "The expected '$1' is not found in:"
                printf >&2 " '%s'\n", "$@"
                return 1
	}

	test_rev_among_expected () {
		actual=$1
                shift
		git rev-parse "$@" | grep -e "$actual" >/dev/null && return
		echo >&2 "'$1' is not among expected ones:"
                printf >&2 " '%s'\n", "$@"
                return 1
	}

might be more appropriate.

>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  t/test-lib-functions.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8d99eb3..8caf59c 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -711,11 +711,17 @@ test_must_be_empty () {
>  	fi
>  }
>  
> -# Tests that its two parameters refer to the same revision
> +# Tests that the first parameter refers to the same revision
> +# of at least one other parameter
>  test_cmp_rev () {
> -	git rev-parse --verify "$1" >expect.rev &&
> -	git rev-parse --verify "$2" >actual.rev &&
> -	test_cmp expect.rev actual.rev
> +	hash1="$(git rev-parse --verify "$1")" || return
> +	shift
> +	for rev
> +	do
> +		hash2="$(git rev-parse --verify "$rev")" || return
> +		test "$hash1" = "$hash2" && return 0
> +	done
> +	return 1
>  }
>  
>  # Print a sequence of numbers or letters in increasing order.  This is
