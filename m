Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D142092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750720AbdAVWzW (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:55:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55082 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750704AbdAVWzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:55:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F7EC62510;
        Sun, 22 Jan 2017 17:55:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6a/eIILGynACzjsAlNs2nsSOM7A=; b=vhaZZ2
        +B52AGb54wP0GcSiz5XJRWuKThooT14BpSTKhTyEoxANbVYS8Sc4uxawZui9pFrk
        VlKejsYT/x2pIiI9eXRnXvFiPjpJ+NsPy6n3r371kfzfy48Oc1Rg3BhbGnHDxqFs
        MdGTBuK/n6tVE5djlFoBfrKKyMzT94Q9NtXhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uCe7qtQ/SPpxjosHMedPdz+Otp5F09Es
        h7bHHcH70nPuIwyQYEuY+ywnCz7wCmriqb5nekEt4Ra7utqZMAmitpHOA0TVdf/G
        tnNw3vXvdtpW39Er0BFQk0xh1LptV7+9c/KOvPT1FlVxuVinci1SNgxic6rbmnB7
        iH29QYpA3g4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4808E6250E;
        Sun, 22 Jan 2017 17:55:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABB566250D;
        Sun, 22 Jan 2017 17:55:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <git@thecybershadow.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] show-ref: Optimize show_ref a bit
References: <20170121010821.25046-1-git@thecybershadow.net>
        <20170121010821.25046-4-git@thecybershadow.net>
        <xmqqa8aivhik.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 22 Jan 2017 14:55:18 -0800
In-Reply-To: <xmqqa8aivhik.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 22 Jan 2017 14:47:47 -0800")
Message-ID: <xmqq60l6vh61.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9362AD4-E0F5-11E6-BFE7-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Having to do this change probably is an indication that the division
> of labour between show_ref() and show_one() up to this step needs to
> be rethought.
>
> Conceptually, "git show-ref" works in two ways:
>
>  * When in --verify mode, the end user gives which refnames to
>    consider showing.
>
>  * Otherwise the end user gives pattern and the command infers which
>    refnames to consider showing using the pattern.
>
> And for the refnames that are considered for showing, we may do
> various things, like -d to deref and --quiet to be silent.  We want
> this actual "output" step to be the same between two modes of
> operation.

... also "error out if the named object did not exist" can be part
of this, which means ...

> So a better division of labour would be:
>
>  * Make show_ref() about "using pattern, enumerate what refs to
>    show" and call show_one().
>
>  * Update show_one() and teach _it_ to handle quiet and deref_tags.

... "if (!has_sha1_file(oid->hash)) die()" in show_ref() would
probably want to be part of this update.
