From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] checkout(-index): do not checkout i-t-a entries
Date: Mon, 28 Dec 2015 11:56:45 -0800
Message-ID: <xmqq7fjyl536.fsf@gitster.mtv.corp.google.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
	<1451181092-26054-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 20:56:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDduX-0001tI-ID
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 20:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbbL1T4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2015 14:56:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752134AbbL1T4s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2015 14:56:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AB6237C63;
	Mon, 28 Dec 2015 14:56:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h6X+tFutp+r2
	BM0qAJe/DcpNuw8=; b=ZcYYpclRPmq2Cg92OnW3ZkYVrjQvBmZojaaE85FO/pog
	rNrXe7XPHzCYyrF2TAE7/57gJL74W7j+UHZst3f+yCojVewwM3lTK5A/vAykDkVq
	Rpxi5PUkx4gAwi8b3PnS86ysQMtEK/6Y9bZM2SGtcjdePhGVGqirSvxtL3+JgiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XJxFts
	wBAY1gJoEgLvb+2WL+8t4OE5DBcgxKXWgj622ICL/aVefM9Ey7pRG750YKDLYEzR
	dBLccg8U39lygzoVAbmo/6YTCNTnwSEjaz3Y6XKDEDjYVK1uFZ1+fkxNv2e75Jyb
	i242oWi6+Jz9x1t6NJWSm9eKTdN12+h8Q6M+k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4254F37C62;
	Mon, 28 Dec 2015 14:56:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A558137C60;
	Mon, 28 Dec 2015 14:56:46 -0500 (EST)
In-Reply-To: <1451181092-26054-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 27
 Dec 2015 08:51:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 203B7B56-AD9D-11E5-9952-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283045>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 9ca2da1..d9fe8f4 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -48,6 +48,7 @@ static int checkout_file(const char *name, const ch=
ar *prefix)
>  	int pos =3D cache_name_pos(name, namelen);
>  	int has_same_name =3D 0;
>  	int did_checkout =3D 0;
> +	int has_intent_to_add =3D 0;
>  	int errs =3D 0;
> =20
>  	if (pos < 0)
> @@ -56,8 +57,11 @@ static int checkout_file(const char *name, const c=
har *prefix)
>  	while (pos < active_nr) {
>  		struct cache_entry *ce =3D active_cache[pos];
>  		if (ce_namelen(ce) !=3D namelen ||
> -		    memcmp(ce->name, name, namelen))
> +		    memcmp(ce->name, name, namelen)) {
> +			if (ce_intent_to_add(ce))
> +				has_intent_to_add =3D 1;
>  			break;
> +		}
>  		has_same_name =3D 1;
>  		pos++;
>  		if (ce_stage(ce) !=3D checkout_stage

Sorry, but I cannot see what this hunk is trying to do.

Earlier, 'pos' is set to where the 'name' would be inserted (or
would replace, if there is an existing entry with the same name).
We iterate over the index starting from that 'pos' until we see a
different name (i.e. the length is different, or the name does not
match) and then break out, because that entry is not something we
want to muck with, because the entry here you are checking with
ce_intent_to_add() is an entry that is entirely unrelated to the
path you are checking out.

So you do not check it out, just as before, which is correct, but
then this 'has_intent_to_add' flag is used to say something
nonsensical below ...

> @@ -77,7 +81,9 @@ static int checkout_file(const char *name, const ch=
ar *prefix)
> =20
>  	if (!state.quiet) {
>  		fprintf(stderr, "git checkout-index: %s ", name);
> -		if (!has_same_name)
> +		if (has_intent_to_add)
> +			fprintf(stderr, "is not yet in the cache");

=2E.. the reason why you are here does not have anything to do with the
entry that happened to come after the path you wanted to check out
was marked with the I-T-A bit.  The reason why you are here is
because 'did_checkout' was unset, which in turn was because there
wasn't a path that match 'name' you are checking out in the index,
with or without the I-T-A bit.

    $ rm .git/index
    $ >file
    $ git add -N file
    $ git checkout-index fild

would hit this codepath, I think, and the code would give a message
that says "fild is not yet in the cache", which may be technically
correct but it is the same as !has_same_name's "fild is not in the
cache".

Probably the I-T-A check must go after the code decides that 'ce' is
an entry for the 'name' the caller asked us to check out (and of
course we shouldn't check it out in that case).

> @@ -99,6 +105,8 @@ static void checkout_all(const char *prefix, int p=
refix_length)
>  		if (ce_stage(ce) !=3D checkout_stage
>  		    && (CHECKOUT_ALL !=3D checkout_stage || !ce_stage(ce)))
>  			continue;
> +		if (ce_intent_to_add(ce))
> +			continue;

This one is probably correct, I didn't check the context to fully
see if it is valid, though.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3e141fc..ac37d92 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -328,12 +328,15 @@ static int checkout_paths(const struct checkout=
_opts *opts,
>  	if (opts->merge)
>  		unmerge_marked_index(&the_index);
> =20
> -	/* Any unmerged paths? */
>  	for (pos =3D 0; pos < active_nr; pos++) {
> -		const struct cache_entry *ce =3D active_cache[pos];
> +		struct cache_entry *ce =3D active_cache[pos];
>  		if (ce->ce_flags & CE_MATCHED) {
> -			if (!ce_stage(ce))
> +			if (!ce_stage(ce)) {
> +				if (ce_intent_to_add(ce))
> +					ce->ce_flags &=3D ~CE_MATCHED;
>  				continue;
> +			}
> +			/* Unmerged paths */
>  			if (opts->force) {
>  				warning(_("path '%s' is unmerged"), ce->name);
>  			} else if (opts->writeout_stage) {

This loop has become dual-purpose; it is drops CE_MATCHED bit from
cache entries with the I-T-A bit, and it continues to handle errors
for an attempt to checkout unmerged paths.

    $ rm .git/index
    $ >file
    $ git add -N file
    $ git checkout file

would hit this codepath, and it will force-skip "file".

There is a small source of confusion for new people here, though.

    $ git checkout filo

would complain that there is no 'filo'.  But

    $ git checkout file

would silently turn itself into a no-op.  Don't we want to at least
give some indication that we are not checking out "file" because its
contents do not yet exist in the index, or something?

> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 96c8755..52e9f7f 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -111,5 +111,39 @@ test_expect_success 'apply:check_preimage() not =
creating empty file' '
>  	)
>  '
> =20
> +test_expect_success 'checkout ignores i-t-a' '
> +	git init checkout &&
> +	(
> +		cd checkout &&
> +		echo data >file &&
> +		git add -N file &&
> +		git checkout -- file &&
> +		echo data >expected &&
> +		test_cmp expected file
> +	)
> +'
> +
> +test_expect_success 'checkout-index ignores i-t-a' '
> +	(
> +		cd checkout &&
> +		git checkout-index file &&
> +		echo data >expected &&
> +		test_cmp expected file
> +	)
> +'
> +
> +test_expect_success 'checkout-index --all ignores i-t-a' '
> +	(
> +		cd checkout &&
> +		echo data >anotherfile &&
> +		git add anotherfile &&
> +		rm anotherfile &&
> +		git checkout-index --all &&
> +		echo data >expected &&
> +		test_cmp expected file &&
> +		test_cmp expected anotherfile
> +	)
> +'
> +
>  test_done
