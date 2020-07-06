Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC7EC433DF
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 22:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2489920723
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 22:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rg/hV1W2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGFWkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:40:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54875 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGFWkz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 18:40:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B043566B2A;
        Mon,  6 Jul 2020 18:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SV7Tk+CfedORShvdDSFvYxDWkI4=; b=Rg/hV1
        W2ayrpUNI4fFSjqyaUZ5Ym385Q+P3NlVDBfjTRC/savnghMYHpmvuYK/7a3Pk8qA
        6NlAm+GXm7n9sqosTEAxw1nBQx6gFi3UjNBFhYZlPW2c1UWT6aXLm4v5pi2Np72w
        LfmUFkcIBtXuosP4l51miFWk3gwDMgtl75QZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DS8DqJh2mPb1nvtJ6KI9yF0he+VnXKbd
        FS4DnO4QJ1eURmnK7q/Ev+9qDaOP56PKlHj4dT1IhMWHAvMU780D9CXWCx1mPeKT
        Q7oc0CLiP3EyED5S1nTnhP9lFgU+7pHmESVoR2fxuSpy44iIcDr7l2qQamEX7kkK
        3PEzdoZovOk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0D8166B28;
        Mon,  6 Jul 2020 18:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2232066B27;
        Mon,  6 Jul 2020 18:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Wijen <ben@wijen.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] git clone: don't clone into non-empty directory
References: <CAPig+cS6XnUK9MQL68_yoR9Gve4_itmawsd_0-yJr3S5=3-zPQ@mail.gmail.com>
        <20200702081335.16786-2-ben@wijen.net>
Date:   Mon, 06 Jul 2020 15:40:51 -0700
In-Reply-To: <20200702081335.16786-2-ben@wijen.net> (Ben Wijen's message of
        "Thu, 2 Jul 2020 10:13:35 +0200")
Message-ID: <xmqqv9j08dxo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF01D0AC-BFD9-11EA-98E3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Wijen <ben@wijen.net> writes:

> When using git clone with --separate-git-dir realgitdir and
> realgitdir already exists, it's content is destroyed.
>
> So, make sure we don't clone into an existing non-empty directory.

This came from d45420c1 (clone: do not clean up directories we
didn't create, 2018-01-02), where we claimed

    Because we know that the only directory we'll write into is
    an empty one, we can handle this case by just passing the
    KEEP_TOPLEVEL flag to our recursive delete (if we could
    write into populated directories, we'd have to keep track of
    what we wrote and what we did not, which would be much
    harder).

The assumed use case is that somebody created an empty directory for
our use in a grandparent directory where we have no write permission
and gave it to us, and we want to do a "git clone" into it while
keeping that directory alive.  But we didn't make sure the directory
was not empty ourselves---we just assumed it to be empty.

And the originally envisioned use case does not have anything to do
with the use of --separate-git-dir at all.  So from that point of
view, this change does not break the originally envisioned use case,
so this probably is not regressing any existing and valid use case
that may not involve "--separate-git-dir", but I'd rather see that
the commit message explain these things to its readers to justify
itself.

Thanks.

