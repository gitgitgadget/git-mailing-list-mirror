Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F000CC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF47B208CE
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFFU5H1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKUFCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:02:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58608 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfKUFCu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 00:02:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6DE12E811;
        Thu, 21 Nov 2019 00:02:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PkBE6JFjQjw4
        jpH4mZYxze1SJI0=; b=JFFU5H1DLRyQ9RpncR3IFAk3vXwoq2xdkuEmWulOPcdj
        9Qb0wMVl5fE73kRH2HAmrxBJEY5rz9NC5GH/r9oj0w7essBSJaX9m1wpX2uaiOCz
        6/JNfZ4lqv3USAXfrMT4K2WtEjpmG6n5SvfrjT3hIemDPaYtjWV9pxUadOmaIw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Lfpdo6
        qBQUx0prOFPaSYK/KvzRnwseLJgyYqyvOdTOD9g3je7N4jXf6ziL46B+ovNTIbOM
        mW1XGVhrM+FFwW3+wd8akdSSJ2jNbhhnpn+YSwav4hiR09ZD8D28XiYaC+dj0YGA
        R5Z15EuPNEqQRqYAYglJms+2e0LKz6dZqnyBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DE472E80F;
        Thu, 21 Nov 2019 00:02:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0825B2E80E;
        Thu, 21 Nov 2019 00:02:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/8] builtin/config: extract `handle_value_regex()` from `get_value()`
References: <cover.1573670565.git.martin.agren@gmail.com>
        <c4bcb32299291549d82c0544937a647c5000ad64.1573670565.git.martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 14:02:47 +0900
In-Reply-To: <c4bcb32299291549d82c0544937a647c5000ad64.1573670565.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 13 Nov 2019 19:55:02
 +0100")
Message-ID: <xmqq4kyxakjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29F18B2C-0C1C-11EA-8063-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> This is a self-contained and fairly large chunk of code which will soon
> gain a few more lines. Prepare by extracting it into a separate
> function.
>
> This whole chunk is wrapped in "if (regex_)" -- rewrite it into an earl=
y
> return path in the new helper function to reduce indentation.

It is not clear if regexp were cleared to NULL when !regex_ in the
original code, so if that were the case, this refactoring is a
worthy clean-up from that point of view, too.

>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  I copy the "xmalloc(sizeof(regex_t))" anti-pattern verbatim. We will
>  lose it in the next patch.

It also spreads the use of file-scope global variables like
do_not_match and regexp, which also is existing anti-pattern that we
may want to fix by enclosing them in a struct and pass a pointer to
it around the callchain.  We can clean it up later.

