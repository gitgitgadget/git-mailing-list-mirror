Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E98DC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DAA208C3
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ajfqiN1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgCCS3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:29:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57162 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgCCS3V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 13:29:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48A6FC606E;
        Tue,  3 Mar 2020 13:29:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w+bO/yWNugKVL+vdmnnptUUf1tI=; b=ajfqiN
        1cepwbOFlay0hwLUYzbrVUCZzfqUitO316827Tbr3naDY2Yaesq/RtxSLEM4nlbu
        85P33VCspQeV4yZTIlSuLumIEskjBecbpzHYrDYo4921kddkOjHdVu9gMHrTs9ht
        DRd5jic+TX5+vZ4WS7kIiSjy5HixjZPndJ5Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Du/Vh880nu5A9vbyDW+HqBJK3AIP3v7j
        zXerf5lRJFChvpyrOCSr9/q+dJc/KAI/xfDSd5PshiKFhDFXBhYDl9jIWayevw0p
        MlVk0iAt+i1wJm9uM+ZgRrJLlxbHF2BBJOyQ6CY/mjSUJX06ekCSAB/oY+1IqLOU
        fVCBxdLt8WA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40865C606D;
        Tue,  3 Mar 2020 13:29:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66D7AC606C;
        Tue,  3 Mar 2020 13:29:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] remote.c: fix handling of %(push:remoteref)
References: <20200302133217.GA1176622@coredump.intra.peff.net>
        <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
        <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
        <20200303162906.xadbaeaq4nurqsem@feanor>
Date:   Tue, 03 Mar 2020 10:29:14 -0800
In-Reply-To: <20200303162906.xadbaeaq4nurqsem@feanor> (Damien Robert's message
        of "Tue, 3 Mar 2020 17:29:06 +0100")
Message-ID: <xmqqpndt8f7p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E39E23BC-5D7C-11EA-AE2E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

>> +	case PUSH_DEFAULT_MATCHING:
>> +	case PUSH_DEFAULT_CURRENT:
>> +		return branch->refname;
>
> Here I follow the logic of branch_get_push1, but the case of
> push.default=matching is not quite correct, because we never check
> that we have a matching remote branch. On the other hand we cannot check
> this until we contact the remote, so I don't know how we could get around
> that.

Quite honestly, I do not think that is a problem that needs to be
solved; there is no workable definition.

