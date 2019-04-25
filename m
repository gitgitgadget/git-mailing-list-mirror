Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E371F453
	for <e@80x24.org>; Thu, 25 Apr 2019 00:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfDYAzU (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 20:55:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61046 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfDYAzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 20:55:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86D446949B;
        Wed, 24 Apr 2019 20:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4CY5X6d/Cg85327G9Hk80WXDLp4=; b=C4RcBs
        1MIpZlAEBa5rk89lySUfalC+PJgrmZ996Eo4dHBZvlRs1SX1TMzWmXSMJxoaacji
        80N813fZd6xUBZeoffRZEfjP4DC6ZXum56RucX1pEBFl0pfi42Xqb48rabTDDeKC
        DOAukHX2/2TZel5h2TmD/P1Tien/XE0aIaIxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U+WNciTZRkrrGONAWWOqhOCTpUwk+pKQ
        wHheMuGtEpkpkchqjGXSs/WAKB1NcShtDP6JnKwWcu+i6wPLsdyxNhomBt8TcOkG
        giQY5rFI3Pb+7fUDPKVpDlaXnFNkoz/ku74rxm2dJDBpjWAz1/ZGrq/DPRzjwO1N
        yZmdXIrdhtg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F1F26949A;
        Wed, 24 Apr 2019 20:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFBF269499;
        Wed, 24 Apr 2019 20:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple hooks
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
        <20190424004948.728326-2-sandals@crustytoothpaste.net>
        <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
        <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org>
Date:   Thu, 25 Apr 2019 09:55:13 +0900
In-Reply-To: <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org> (Johannes Sixt's
        message of "Wed, 24 Apr 2019 20:48:32 +0200")
Message-ID: <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9EDCD2A-66F4-11E9-9B21-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Furthermore, basing a decision on whether a file is executable won't
> work on Windows as intended. So, it is better to aim for an existence check.

That is a good point.

So it may be OK for "do we have a single hook script for this hook
name?" to say "no" when the path exists but not executable on
POSIXPERM systems, but it is better to say "yes" for consistency
across platforms (I think that is one of the reasons why we use
.sample suffix these days).

And for the same reason, for the purpose of deciding "because we do
not have a single hook script, let's peek into .d directory
ourselves", mere presence of the file with that name, regardless of
the executable bit, should signal that we should not handle the .d
directory.

IOW, you think access(X_OK) should be more like access(F_OK)?

