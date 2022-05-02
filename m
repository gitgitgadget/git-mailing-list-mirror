Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1405C433FE
	for <git@archiver.kernel.org>; Mon,  2 May 2022 21:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiEBVjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 17:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387730AbiEBVjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 17:39:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9D1163
        for <git@vger.kernel.org>; Mon,  2 May 2022 14:35:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AD86137E88;
        Mon,  2 May 2022 17:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RhSV5eIjxhPX
        +21SHDjB+FCnPB1W5nQCgTGdFJelOwU=; b=nE0fgBf9+6Rp2J9O6AYhzKKuMN8l
        nTsgXl/vnCattFo5kcqo2WjUWiZyjM32r28xeRApauc9nfQL1omHCHdp0RfgINpU
        DFclSL5qilWkUTd5CdoZwoi9T/38QDNiMsWOatn41u6Wb39rEgHKAP6K1ilWB5wd
        dV0j2X7gyXN5rYc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F599137E86;
        Mon,  2 May 2022 17:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6DB0137E85;
        Mon,  2 May 2022 17:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH v3 1/3] t: document regression git safe.directory
 when using sudo
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220502183920.88982-1-carenas@gmail.com>
        <20220502183920.88982-2-carenas@gmail.com>
Date:   Mon, 02 May 2022 14:35:33 -0700
In-Reply-To: <20220502183920.88982-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 2 May 2022 11:39:18 -0700")
Message-ID: <xmqqy1zjwrbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCC2BF0C-CA5F-11EC-AC0F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> +test_lazy_prereq SUDO '
> +	sudo -n id -u >u &&
> +	id -u root >r &&
> +	test_cmp u r &&

OK.  We make sure we can become root with "sudo".

> +	command -v git >u &&
> +	sudo command -v git >r &&
> +	test_cmp u r

While this is not as thorough as the "make sure we see the
environment intact" that I alluded to during the previous review, it
at least makes sure PATH (which our test framework tweaks) is
propagated down to "sudo" environment intact, which should be good
enough to run just "init" and "status".  Keeping things simple is
good.

We may have to exclude this from tests that require specialized
environment like valgrind tests, but that is not of immediate
concern.

Will queue.

> +'
> +
> +test_expect_success SUDO 'setup' '
> +	sudo rm -rf root &&
> +	mkdir -p root/r &&
> +	sudo chown root root &&
> +	(
> +		cd root/r &&
> +		git init
> +	)
> +'
> +
> +test_expect_failure SUDO 'sudo git status as original owner' '
> +	(
> +		cd root/r &&
> +		git status &&
> +		sudo git status
> +	)
> +'
> +
> +# this MUST be always the last test
> +test_expect_success SUDO 'cleanup' '
> +	sudo rm -rf root
> +'
> +
> +test_done
