Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF86D1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 19:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbcFQTO5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 15:14:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751577AbcFQTO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 15:14:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61AAB23B12;
	Fri, 17 Jun 2016 15:14:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8HrKA+JlSzn/O6EOTAHyB2HAQdk=; b=xvsszg
	QgUFSStjvl0dxI4zB0wM9H4I+P5iD4V3MivVDITBkKWRybqVjbz0iKDpkvdjMQwE
	MiTkbP0x+v8nxmJictPYgEJZLuPVUxHN0ICpXP9yAQsoOOel7wAu4iVgUfhPsRqR
	C2mKNNYN74EZ2fP3x56CnA5/tQIMXJKtSy1u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SJnAx7YFv8MEyW6+qWBi7GUTya5uI00K
	t+ZsOfLOtDp2UAVvLa7TDDkEsMyomZsTtKqCQIrLLB0x1jWwb/6Oi6txq2SkX5mh
	CcJ6fEyK5dV73vK50Ohn8rPC+eiHcQwkixFYQZRjXh5h9I3j3iLgve6GPVVxcOIo
	/h3Fo5Zz2QQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A85723B11;
	Fri, 17 Jun 2016 15:14:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D625B23B0F;
	Fri, 17 Jun 2016 15:14:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCHv2] Documentation/technical: push certificate format
References: <b2557387aeea4b34da4a5b28e87063d1f2c9ff69.1466148698.git.git@drmicha.warpmail.net>
	<358c097f88671847e5003696a65d3a107aa2f59b.1466153557.git.git@drmicha.warpmail.net>
Date:	Fri, 17 Jun 2016 12:14:53 -0700
In-Reply-To: <358c097f88671847e5003696a65d3a107aa2f59b.1466153557.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 17 Jun 2016 10:54:59 +0200")
Message-ID: <xmqq1t3v1vbm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C621D462-34BF-11E6-BF8D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> This is the version describing the current state, not assuming any new
> verify command for blobs.
>
>  Documentation/technical/signature-format.txt | 51 ++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
> index 7afd403..1c21379 100644
> --- a/Documentation/technical/signature-format.txt
> +++ b/Documentation/technical/signature-format.txt
> @@ -184,3 +184,54 @@ Date:   Wed Jun 15 09:13:29 2016 +0000
>      # gpg:          There is no indication that the signature belongs to the owner.
>      # Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
>  ----
> +
> +== Push certificates
> +
> +- created by: `git push --signed`
> +- payload: a push certificate header followed by the push transcript
> +  (see pack-protocol.txt and below)
> +- embedding: append the signature to the push transcript and pass it to receive hooks
> +  via the environment (see below)
> +- example: push of commit `dd1416f` updating `master` on `.` from `d36de3d`,
> +  resulting in push certificate object `d4169b9`:
> +
> +----
> +certificate version 0.1
> +pusher C O Mitter <committer@example.com> 1465983405 +0000
> +pushee .
> +nonce 1465983405-07421dc1515c6f4d76d4
> +
> +d36de3db9b6a83076477254a3186b721a7bfaab7 dd1416f2cd1ec85957a9520a33e9053a133a775d refs/heads/master
> +-----BEGIN PGP SIGNATURE-----
> +Version: GnuPG v1
> +
> +iEYEABECAAYFAldhIa0ACgkQE7b1Hs3eQw2pGwCgmJs98xETSDZb6rooh/X7af3V
> +zWgAn08ctVNga27jRkIdhFNetJy3x8De
> +=WH0m
> +-----END PGP SIGNATURE-----
> +----
> +
> +- verify with: `gpg --verify <(git cat-file -p pushcert | sed -n '/-----BEGIN PGP/,$p') <(git cat-file -p pushcert | sed  '/-----BEGIN PGP/Q')`
> +  (assuming the push certificate is stored in the blob tagged `pushcert`)

And assuming your sed is GNU, assuming your shell is bash.

Let's have a version of this without "verify with", finish that
"generalized way to verify the 'payload followed by detached
signature'" patch, and add a description to use that command here
when it is done.

> +
> +----
> +gpg: Signature made Wed Jun 15 11:36:45 2016 CEST using DSA key ID CDDE430D
> +gpg: Good signature from "C O Mitter <committer@example.com>"
> +----
> +
> +- pre- and post-receive hook input:
> +
> +----
> +d36de3db9b6a83076477254a3186b721a7bfaab7 dd1416f2cd1ec85957a9520a33e9053a133a775d refs/heads/master
> +----
> +
> +- pre- and post-receive hook environment:
> +
> +----
> +GIT_PUSH_CERT_NONCE_STATUS=OK
> +GIT_PUSH_CERT_KEY=13B6F51ECDDE430D
> +GIT_PUSH_CERT=d4169b9a3c2674458f9656796132c145bbc5ba74
> +GIT_PUSH_CERT_STATUS=G
> +GIT_PUSH_CERT_SIGNER=C O Mitter <committer@example.com>
> +GIT_PUSH_CERT_NONCE=1465983405-07421dc1515c6f4d76d4
> +----
