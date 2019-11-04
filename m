Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609161F454
	for <e@80x24.org>; Mon,  4 Nov 2019 03:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKDDzR (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 22:55:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61362 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfKDDzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 22:55:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3803383E3;
        Sun,  3 Nov 2019 22:55:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ciHf7mj35UZJthCYMmcBibr9MoQ=; b=U6NknQ
        BdNAmQ3U41py7Le20iPTBpAWbxTGTFwgFFx9M+o1nPb3QzlZ45ux3AEVPEgW7GIA
        6sovqZGoiVeepL3CDSWqbjR4MuD4T1rRlfP6050U9eZDD3qvh5qKbtTtBPB86r1Q
        6yR/vgZivgTn6o0NFoJEv7GgAjYD+B5vvZkBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e3bVGQdPcFs15j0KFxYdOQMH8rLDxWOU
        gTGzD9B+VjX5PD0mnNvv2X1TgcQkUydD9g6CBVDgoqktZko2/vo4EXtmP+zkqXv6
        6I2Tr0Mih6dV8EsCbOYxR4g+M+yh0zZXitoUuFTtxSTXo2fFqaNiIa4sDOPFnjMv
        sTjO99IAZoQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBC38383E2;
        Sun,  3 Nov 2019 22:55:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 210D6383E1;
        Sun,  3 Nov 2019 22:55:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Davide Berardi <berardi.dav@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
References: <20191101002432.GA49846@carpenter.lan>
        <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet>
        <20191101193558.GA1169@sigill.intra.peff.net>
        <xmqqh83m1t3c.fsf@gitster-ct.c.googlers.com>
        <20191103181657.GA89185@carpenter.lan>
Date:   Mon, 04 Nov 2019 12:55:09 +0900
In-Reply-To: <20191103181657.GA89185@carpenter.lan> (Davide Berardi's message
        of "Sun, 3 Nov 2019 19:16:57 +0100")
Message-ID: <xmqq36f41ejm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E639D6CC-FEB6-11E9-AA44-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Davide Berardi <berardi.dav@gmail.com> writes:

> The problem with the proposed approach was that the code was
> incompatible with some tests (specifically the tests which specifies an
> empty .git directory would fail and fallback to the unborn master
> branch).
>
> The lookup commit have two error-paths:
>
> 1. the commit cannot be found;
> 2. the commit is found and cannot be casted to a commit (whoops!).
>
> so, I've returned the second condition using an auxiliary variable and
> declaring a new lookup_commit function keeping compatibility with the
> old one.

It's more like three, I think.

  1a. The given object name is a sentinel, "no such object", value.

  1b. The given object name is meant to name a real object, but
      there is no object with such a name in the repository.

  2.  The given object name names an existing object, but it does
      not peel to a commit.

Traditionally, we had only lookup_commit() and died on any of the
above.  Later, we added the _gently() variant for callers that want
to use a commit and also want to handle an error case where the
object name they are handed by their callers does not peel to a
commit.

In the "unborn repository, empty .git" case, are you getting a
random object name, or null_oid (aka case 1a. above)?  If that is
the case, then your solution to introduce another variant of
lookup_commit() that takes *err parameter is a wrong approach would
not differenciate between 1a. and 1b., which would not help, as I
suspect that we still do want to treat 1b. as an error.

Wouldn't it be cleaner to catch 1a. upfront, e.g.

	if (our)
		tip = &our->old_oid;
	else if (remote)
		tip = &remote->old_oid;
	else
		return NULL;

	if (is_null_oid(tip))
        	return NULL;

	tip_commit = lookup_commit_reference_gently(the_repository, tip, 1);
	if (!tip_commit) {
		warning(...);
		create_symref(...);
		return NULL;
	}

I am not offhand sure if the places we return NULL upfront want to
also create HEAD symref, or that is something automatically happens
for us in the downstream of this function, though.

Thanks.
