From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7510: Skip all if GPG isn't installed
Date: Wed, 25 Jun 2014 14:16:55 -0700
Message-ID: <xmqqfvis8zaw.fsf@gitster.dls.corp.google.com>
References: <1403585536-32185-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:17:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzuZ2-0002oq-DT
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 23:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbaFYVRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 17:17:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51115 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbaFYVRC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 17:17:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EAAF21B92;
	Wed, 25 Jun 2014 17:16:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6c6TecMhrAZD1IdjyRzmXKADeiQ=; b=JCXsJm
	jkRm6FxvHnXqMguptCKAy9rUO92pS4tac1CE3cT2xJiMrCr6m/dYUW63qvvDoAdb
	w3Rh94JAi+JK5n2XyGuyB/3ctND9yX3VDaL4dw7Nxqmm4vg7OQEjm4ZMd3XZWTJ3
	zkc/iVa9HBK0vZ1G6J+o6RIJYwX660e02moDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HsichF+HyBfZ/2gkTPhQ+Dw9L5GIpNbo
	xjS6pLd0+Vju3fo55BJtUUjWjvcRioweCHwitHBJn+VEZPmUx72Uqq8LumabSeHG
	VrfAkwc8V7+RHI0cEkP9ne9NIWjina20iva7O5V/1g2YAC1XQlbZwvbifmVjdHyB
	bs/u6ZJMqX4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 108F521B91;
	Wed, 25 Jun 2014 17:16:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4385921B86;
	Wed, 25 Jun 2014 17:16:50 -0400 (EDT)
In-Reply-To: <1403585536-32185-1-git-send-email-brian@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Tue, 24 Jun 2014 00:52:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 05CA179C-FCAE-11E3-AB7E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252461>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> Since the setup requires the GPG prerequisite, it doesn't make much
> sense to try and run any tests without it.  So rather than using a
> prereq on each individual test and possibly forgetting it on new ones
> (as just happened), skip the entire file if GPG isn't found.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---

I think by "just happend" you mean aa4b78d4 (pretty: avoid reading
past end-of-string with "%G", 2014-06-16), which adds one that is
not protected (Cc'ed peff).

As there are a few additional test pieces to this file in flight
that come from another topic (which by the way protects them with
the prerequiste), I'd rather fix it up with the necessary GPG
prerequisite, at least for now, instead of doing it this way.

After the dust settles, we should definitely consider taking the
approach of this patch to simplify everything, but not now.

Another thing we may want to take into account is that we would also
want to make sure that builds of Git without GPG installed still
behave sensibly (with some definition of sensible) when faced with
GPG signatures in existing commit objects and tag objects.  I do not
think we currently test that combination at all, but we may want to
introduce a new directory t/t7510/ to hold store pre-existing commit
objects in the loose form (or in the textual form, suitable for
fast-import) and use them to populate the test repository in the
set-up step.  And new test pieces that do not require GPG (or those
that do require that GPG is *not* installed) would make sure that
various commands like "show --show-signature", "verify-commit" would
say "I cannot verify them" but still do what they are asked to do in
a sensible way (e.g. "show --show-signature" may not be able to show
the signature obviously but still will give you the header, the log
message and the patch; "verify-commit" should fail because it cannot
verify).  If that will happen in this same script, then skipping all
by requiring GPG upfront may not be a good change, but it is likely
that we would want a NOGPG prerequisite for "No GPG installed" case
and have a separate test script, in which case, this will just skip
all without GPG, and the other new one will just skip all without
NOGPG.  We'll see.


>  t/t7510-signed-commit.sh | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 9810242..414f9d1 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -4,7 +4,13 @@ test_description='signed commit tests'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-gpg.sh"
>  
> -test_expect_success GPG 'create signed commits' '
> +if ! test_have_prereq GPG
> +then
> +	skip_all='skipping signed commit tests; gpg not available'
> +	test_done
> +fi
> +
> +test_expect_success 'create signed commits' '
>  	test_when_finished "test_unconfig commit.gpgsign" &&
>  
>  	echo 1 >file && git add file &&
> @@ -48,7 +54,7 @@ test_expect_success GPG 'create signed commits' '
>  	git tag eighth-signed-alt
>  '
>  
> -test_expect_success GPG 'show signatures' '
> +test_expect_success 'show signatures' '
>  	(
>  		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
>  		do
> @@ -79,7 +85,7 @@ test_expect_success GPG 'show signatures' '
>  	)
>  '
>  
> -test_expect_success GPG 'detect fudged signature' '
> +test_expect_success 'detect fudged signature' '
>  	git cat-file commit seventh-signed >raw &&
>  
>  	sed -e "s/seventh/7th forged/" raw >forged1 &&
> @@ -89,7 +95,7 @@ test_expect_success GPG 'detect fudged signature' '
>  	! grep "Good signature from" actual1
>  '
>  
> -test_expect_success GPG 'detect fudged signature with NUL' '
> +test_expect_success 'detect fudged signature with NUL' '
>  	git cat-file commit seventh-signed >raw &&
>  	cat raw >forged2 &&
>  	echo Qwik | tr "Q" "\000" >>forged2 &&
> @@ -99,7 +105,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
>  	! grep "Good signature from" actual2
>  '
>  
> -test_expect_success GPG 'amending already signed commit' '
> +test_expect_success 'amending already signed commit' '
>  	git checkout fourth-signed^0 &&
>  	git commit --amend -S --no-edit &&
>  	git show -s --show-signature HEAD >actual &&
> @@ -107,7 +113,7 @@ test_expect_success GPG 'amending already signed commit' '
>  	! grep "BAD signature from" actual
>  '
>  
> -test_expect_success GPG 'show good signature with custom format' '
> +test_expect_success 'show good signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	G
>  	13B6F51ECDDE430D
> @@ -117,7 +123,7 @@ test_expect_success GPG 'show good signature with custom format' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success GPG 'show bad signature with custom format' '
> +test_expect_success 'show bad signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	B
>  	13B6F51ECDDE430D
> @@ -127,7 +133,7 @@ test_expect_success GPG 'show bad signature with custom format' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success GPG 'show unknown signature with custom format' '
> +test_expect_success 'show unknown signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	U
>  	61092E85B7227189
> @@ -137,7 +143,7 @@ test_expect_success GPG 'show unknown signature with custom format' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success GPG 'show lack of signature with custom format' '
> +test_expect_success 'show lack of signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	N
