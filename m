Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2B120958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbdCWUQw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:16:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56314 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753644AbdCWUQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:16:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B68467C1F;
        Thu, 23 Mar 2017 16:16:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1v6uqCufxQ7qVFEeOatcUt93/J8=; b=toG9uz
        G+RHs4fdfT0PQC7Sl9+n6fF2cckEEoGwrHz4URAU46T6pfTCpOGtudyD5b5M+qsb
        opOWpiOyAJNX6yf8oyMw8P3KrXc39hLK2676Qs5T5mfbnCRRWPm8hn8bNDFUMt18
        BcZIApecz44g1o1ZyM0gTXK8UHasWx/O0Qo2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CRe9rvizTk1KFLUlLpquHOpbD3+77EDM
        wSZso2F+xr0AYSi6+G8cPVOCh900cxZnLAZ6hvLDaZpmhuXP0rMn2OqCIJbjT4Up
        TQiQq68J0jpip+7VguWdg7oCz45S6n925TJDFp7mbug0dhlKZ9Xp1ZHiirJJaihE
        ggXTfIDe+/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64B3D67C1E;
        Thu, 23 Mar 2017 16:16:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAAD167C1D;
        Thu, 23 Mar 2017 16:16:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
References: <20170322065612.18797-1-larsxschneider@gmail.com>
Date:   Thu, 23 Mar 2017 13:16:48 -0700
In-Reply-To: <20170322065612.18797-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Wed, 22 Mar 2017 07:56:12 +0100")
Message-ID: <xmqqbmsrbvf3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5AB6B4A-1005-11E7-84C4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Things, that would need to be done:
> * Someone with write access to https://travis-ci.org/git/git would need
>   to add the secret token as "GFW_CI_TOKEN" variable in the TravisCI
>   repository setting [1]. Afterwards the build should just work.

As coordinating the timing of when this happens with the timing when
merging this topic to 'pu' happens is an unnecessary cognitive
burden, can you make a small change to this part:

> +      script:
> +        - >
> +          test "$TRAVIS_REPO_SLUG" != "git/git" ||

Add
	test -z "$GFW_CI_TOKEN" ||

here, so that the sript is not run while "Someone with write access"
hasn't got around to doing it. 

> +          ci/run-windows-build.sh $GFW_CI_TOKEN $TRAVIS_BRANCH $(git rev-parse HEAD)

It would still be a good idea to dq all these $VARIABLE and
$(COMMAND OUTPUT) references, as the script expects three
parameters.

> + ...
> +[ $# -eq 3 ] || (echo "Unexpected number of parameters" && exit 1)

Thanks.
