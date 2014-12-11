From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] create gpg homedir on the fly and skip RFC1991 tests for gnupg 2.1
Date: Thu, 11 Dec 2014 14:41:31 -0800
Message-ID: <xmqqr3w5dd2c.fsf@gitster.dls.corp.google.com>
References: <1418303772-7909-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:41:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzCQW-0005tk-3z
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 23:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933631AbaLKWlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 17:41:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933541AbaLKWle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 17:41:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2147B254A4;
	Thu, 11 Dec 2014 17:41:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AwAQMoh0YEEExBNx238mAzJMxg8=; b=FoVAEo
	Ikq04cZIFM9JwKPhLjQfDQ/4RF+pMO/VOMRtWiCyWSoTvUzAhTuI3PI8dtaZw1V6
	6xFaYaRF3S60LUxcI223BZ0+a2vp77VyACGTsqVwxUHZSQpYnUomASo5J0WlxlhZ
	R5hN3+yjXTtBzr4N0RIfwgQkR+4YVsJaIH+pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFQtVFNXKwcyUIpZilmW+PJwFTElLDvA
	/vX6hlp687nkqquD8vZ8Y18Q58P4AozuixBfVXj5thb1hhl84FdKfMPxuAZXxdC2
	wCXECO+DYsqU9bBn/DZDbg9Q/rmdm9EWFDrzV6+8VSoKYvB3vDMJisdGpk/F6Vpn
	Mpcz851ymVI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18430254A3;
	Thu, 11 Dec 2014 17:41:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 891D6254A2;
	Thu, 11 Dec 2014 17:41:32 -0500 (EST)
In-Reply-To: <1418303772-7909-1-git-send-email-mail@eworm.de> (Christian
	Hesse's message of "Thu, 11 Dec 2014 14:16:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DAE0E232-8186-11E4-BA35-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261299>

Christian Hesse <mail@eworm.de> writes:

> GnuPG 2.1 homedir looks different, so just creat it on the fly by
> importing needed private and public keys and ownertrust.
> This solves an issue with gnupg 2.1 running interactive pinentry when
> old secret key is present.
>
> Additionally GnuPG 2.1 does not longer support RFC1991, so skip these
> tests.
> ---

Needs a sign-off.

Are older GPG implementations still happy with this new way to
initialize their gpghome?  

>  t/lib-gpg.sh          |  13 ++++++++++---
>  t/lib-gpg/ownertrust  |   4 ++++
>  t/lib-gpg/random_seed | Bin 600 -> 0 bytes
>  t/lib-gpg/trustdb.gpg | Bin 1360 -> 0 bytes
>  t/t7004-tag.sh        |  14 +++++++-------
>  5 files changed, 21 insertions(+), 10 deletions(-)
>  create mode 100644 t/lib-gpg/ownertrust
>  delete mode 100644 t/lib-gpg/random_seed
>  delete mode 100644 t/lib-gpg/trustdb.gpg

Do these trust files need to be shipped?  In other words, would it
be insufficient to just import private-public keyrings?  I know we
have been shipping trustdb.gpg, and I do not think it is a problem
to ship export-ownertrust output, but as long as we are cleaning
things up to make us compatible with both older and newer GPG,
I thought I'd ask ;-)

> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index cd2baef..17c45ad 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -16,12 +16,19 @@ else
>  		# Type DSA and Elgamal, size 2048 bits, no expiration date.
>  		# Name and email: C O Mitter <committer@example.com>
>  		# No password given, to enable non-interactive operation.
> -		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
> -		chmod 0700 gpghome
> -		chmod 0600 gpghome/*
> +		mkdir ./gpghome
> +		chmod 0700 ./gpghome
>  		GNUPGHOME="$(pwd)/gpghome"
>  		export GNUPGHOME
> +		gpg --homedir "${GNUPGHOME}" --import \
> +			"$TEST_DIRECTORY"/lib-gpg/pubring.gpg \
> +			"$TEST_DIRECTORY"/lib-gpg/secring.gpg
> +		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
> +			"$TEST_DIRECTORY"/lib-gpg/ownertrust
>  		test_set_prereq GPG
> +		if [ -e "${GNUPGHOME}"/pubring.kbx ]; then
> +			test_set_prereq GNUPG21
> +		fi

Instead of !GNUPG21 prerequisite, how about using a RFC1991
prerequisite, which is satisfied by older GPG but not by the ones
that lack support?  That is,

	...
        test_set_prereq GPG
	if ! test "${GNUPGHOME}"/pubring.kbx
        then
		test_set_prereq GPG_RFC1991
	fi

or something.  That way, we do not have to be in a funny situation
where we say a version of GPG satisfies GNUPG21 prereq but it in
fact is GPG version 4.3 in the future.

Thanks.
