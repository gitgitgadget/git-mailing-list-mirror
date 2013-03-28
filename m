From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/5] merge/pull: verify GPG signatures of commits
 being merged
Date: Thu, 28 Mar 2013 15:33:37 -0700
Message-ID: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
References: <7vli9bue40.fsf@alter.siamese.dyndns.org>
 <cover.1364295502.git.jaseg@physik-pool.tu-berlin.de>
 <5151810A.1010203@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Thu Mar 28 23:34:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLOb-0005uS-F9
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 23:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab3C1Wdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 18:33:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab3C1Wdk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 18:33:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06FFDE405;
	Thu, 28 Mar 2013 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=g8rn4+1aCzgRXXA+k00FEsMas
	98=; b=kU5CbgP0ekrCvnxsm+/0NUuDP0mxOFqRjlxzo2ar5MIsHMkzzB1AWMdI9
	a/2Wer3VoJHg3NgRJBS2LtHUWIeBeym+8awBFeeMGVLp6m5bo2YAD43YxWhLs0FB
	cqM9qrwBcwrMnrqRNepO65Ne8b6nW7a4aBBWY/3RAs2X/BSqH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=bQxC1akzySEibEd9ZtO
	N837Cn57eJgD7EobruWySwtgP6SXbCm4wCuF/Dm5IL9RWKvKMqEvqFJ7VoImsOor
	0eBIGuceoOSdZ05+VVNYbwCdPGpigDUFzWg+2p7E56PzoTvdr1ZG/qxMqmmeMMNt
	kCzfxOqSsj6HkFmPuSk0cfrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF8AFE404;
	Thu, 28 Mar 2013 22:33:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65F1AE401; Thu, 28 Mar 2013
 22:33:39 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8982501C-97F7-11E2-A389-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219474>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> When --verify-signatures is specified on the command-line of git-merg=
e
> or git-pull, check whether the commits being merged have good gpg
> signatures and abort the merge in case they do not. This allows e.g.
> auto-deployment from untrusted repo hosts.
>
> Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
> ---
> ...
> +	if (verify_signatures) {
> +		/* Verify the commit signatures */
> +		for (p =3D remoteheads; p; p =3D p->next) {
> +			struct commit *commit =3D p->item;
> +			struct signature signature;
> +			signature.check_result =3D 0;

Even though you may happen to know all other fields are output only,
it is a good practice to clear it with

			memset(&signature, 0, sizeof(signature);

By the way, I think this variable and type should be called more
like "signature_check" or something with "check" in its name, not
"signature".  After all it is _not_ a signature itself.

> +			check_commit_signature(commit, &signature);
> +
> +			char hex[41];

builtin/merge.c: In function 'cmd_merge':
builtin/merge.c:1247: error: ISO C90 forbids mixed declarations and cod=
e

> +
> +test_expect_success GPG 'merge unsigned commit with verification' '
> +	test_must_fail git merge --ff-only --verify-signatures side-unsigne=
d 2> mergeerror &&

No SP between redirection and the target filename.

> +	grep "does not have a GPG signature" mergeerror

Do we plan to make this message localized?  If so I think you would
need to do this with test_i18ngrep.

> +'
> +
> +test_expect_success GPG 'merge commit with bad signature with verifi=
cation' '
> +	test_must_fail git merge --ff-only --verify-signatures $(cat forged=
=2Ecommit) 2> mergeerror &&
> +	grep "has a bad GPG signature" mergeerror
> +'
> +
> +test_expect_success GPG 'merge signed commit with verification' '
> +	git merge -v --ff-only --verify-signatures side-signed > mergeoutpu=
t &&
> +	grep "has a good GPG signature" mergeoutput
> +'

Hmph.

So the caller needs to check both the standard output and the
standard error to get the whole picture?  Is there a reason why we
are not sending everything to the standard output consistently?

> +test_expect_success GPG 'merge commit with bad signature without ver=
ification' '
> +	git merge $(cat forged.commit)
> +'

Good to see that negative case where the new feature should _not_
trigger is properly tested.

> +
> +test_done
