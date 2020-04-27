Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10663C54EEB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB61A20728
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uMGhlT+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgD0SoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:44:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64471 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgD0SoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 14:44:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF3085B998;
        Mon, 27 Apr 2020 14:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cDXg1WENF0Y1ab6RCdIjvQ8EXrU=; b=uMGhlT
        +OuBlHuCMz3Zb0psHdpM8jYEgFTpKqyboKSORwtTyxyu7eo6lxromis83YajysoA
        MrlSCRiLL8oDToxUY1YmLGTWMvlnETcHpeGJBjScGf54yqfkpw9PlntimaCSgsEX
        /rlDdPYmXwmHOHR2ykSsqp+4PzvJ1g1TtIJUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xW9cRZcxqp06+dfTXwziijcNJnX0n8+6
        Iyv3nBth8DNxz9IMk7z9p6X+UiumIrhuNt372K2HXeNEcs3GRekIpAXP4sBRTlQw
        N3iCkXuz+kyxHNhpvspTOSU3D9NGRLjkgj4hEHnQUmnKs1HraN/O2jsVQ8tPjg3x
        /l76OCjbiss=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 911785B996;
        Mon, 27 Apr 2020 14:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC0725B994;
        Mon, 27 Apr 2020 14:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v5] credential: fix matching URLs with multiple levels in path
References: <20200421225837.GB3515235@coredump.intra.peff.net>
        <20200427011809.2494377-1-sandals@crustytoothpaste.net>
Date:   Mon, 27 Apr 2020 11:44:06 -0700
In-Reply-To: <20200427011809.2494377-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 27 Apr 2020 01:18:08 +0000")
Message-ID: <xmqqblnc93bd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13BB4506-88B7-11EA-A5E0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I talked to Carlo off-list because he was concerned about the potential
> security implications of the patch, and as part of that discussion he
> suggested an additional test for our UTF-8 handling.  Since adding some
> additional tests for that case seemed like a good idea, I squashed in a
> patch of his to handle that case.
>
> That's the only change between v4 and v5.

With the polarity flip of the option done in v4, the resulting code
is quite easy to follow.  Thanks, will queue.
