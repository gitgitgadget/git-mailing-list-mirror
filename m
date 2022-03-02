Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB076C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiCBTT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbiCBTTY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:19:24 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AAE2AC76
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:18:36 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BA5611CCE9;
        Wed,  2 Mar 2022 14:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ni/8sVs74mmlmH6IHZaWmXlbNsjwW+smiLlUEx
        5v1Nw=; b=DI/bU2VQE6ScwfIcDfwWUE3PE0xI/XNI1xREIXi5GHmsq36tvyoFQr
        pGwroFDp/LR4o+i72LUYmGaW9Clu1Wbbvsx4xxKbVZtCsufDdVU6sWL1BJaSdwHV
        KmqQl0mYweco7IkjJOFulHPcmw9LWVmYYt72b2wnnX4VPXBBveaJU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71CE811CCE8;
        Wed,  2 Mar 2022 14:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D450E11CCE7;
        Wed,  2 Mar 2022 14:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v3 1/3] gpg-interface/gpgsm: fix for v2.3
References: <20220224100628.612789-1-fs@gigacodes.de>
        <20220302090250.590450-1-fs@gigacodes.de>
Date:   Wed, 02 Mar 2022 11:18:33 -0800
In-Reply-To: <20220302090250.590450-1-fs@gigacodes.de> (Fabian Stelzer's
        message of "Wed, 2 Mar 2022 10:02:48 +0100")
Message-ID: <xmqqh78gkvsm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E227486-9A5D-11EC-A773-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Checking if signing was successful will now accept '[GNUPG]:
> SIG_CREATED' on any beginning of a line. Not just explictly the second
> one anymore.

"the second or subsequent one", I would think, but the code change
looks correct anyway.

> Switch to gpg's `--with-colons` output format to make
> parsing more robust.  This avoids issues where the
> human-readable output from gpg commands changes.

Does this refer only to how parsing in tests is done?

> Adjust error messages checking in tests for v2.3 specific output changes.

Does this refer only to the change to 4202 where "failed to find
the" and the colon after "certificate" are made optional, so that
the regexp can read messages from both pre- and post-2.3 versions?

> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 3e7ee1386a..6bc083ca77 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
>  		--passphrase-fd 0 --pinentry-mode loopback \
>  		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>  
> -	gpgsm --homedir "${GNUPGHOME}" -K |
> -	grep fingerprint: |
> -	cut -d" " -f4 |
> -	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
> +	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
> +	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
> +		>"${GNUPGHOME}/trustlist.txt" &&

The old iteration had (fpr|fingerprint) which appeared as if it were
catering to both pre- and post-2.3 versions, but "with colons", all
versions we care about would say "fpr" and that is the reason why we
no longer have such an alternative here?  Just checking my
understanding.

> -	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&

This removal is because...?  I do not recall seeing the explanation
in the proposed log message.

>  	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
>  	       -u committer@example.com -o /dev/null --sign -
>  '
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 55fac64446..d599bf4b11 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -2037,7 +2037,7 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
>  	git merge --no-ff -m msg signed_tag_x509_nokey &&
>  	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
>  	grep "^|\\\  merged tag" actual &&
> -	grep "^| | gpgsm: certificate not found" actual
> +	grep -Ei "^| | gpgsm:( failed to find the)? certificate:? not found" actual
>  '

OK.  It might be easier to read if we give two expressions
separately and say "we can take either of these", i.e.

	# the former is from pre-2.3, the latter is from 2.3 and later
	grep -e "^| | gpgsm: certificate not found" \
	     -e "^| | gpgsm: failed to find the certificate: not found" \
	     actual

Thanks for working on this update.
