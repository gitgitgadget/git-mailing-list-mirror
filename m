Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FEFC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378098AbiATWlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:41:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57181 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiATWlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:41:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79AE417C602;
        Thu, 20 Jan 2022 17:41:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mRB9H4GayuLzqR006gyW559sEuyD3lnOVxnlBy
        6OT7U=; b=Ax0w5GWoo44OYfrZkjo+Gz8eAw6Oss7FzeaBtem6EPuMznMqrP8NuS
        1NeQF+FJEmLYDldxelofAoowqnPtCcmN378ZZViQ6We+MSGt40RVrSe2hQTHfB2S
        bu3syYN6ixCE6uSYbOZiJUhxB9CIm648osyeCS6pRBY2GePfijNPE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7301417C601;
        Thu, 20 Jan 2022 17:41:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E15B817C600;
        Thu, 20 Jan 2022 17:41:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH v3 1/9] t5326: demonstrate bitmap corruption after
 permutation
References: <babce7d29a85df0da54cb651433111bc33097a4e.1641320129.git.me@ttaylorr.com>
        <20220120175541.3099054-1-jonathantanmy@google.com>
        <YeneJrzjp160edGG@nand.local>
Date:   Thu, 20 Jan 2022 14:41:47 -0800
In-Reply-To: <YeneJrzjp160edGG@nand.local> (Taylor Blau's message of "Thu, 20
        Jan 2022 17:11:50 -0500")
Message-ID: <xmqq5yqeghck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 276AEEDE-7A42-11EC-A478-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Right. The problem being that it's possible to change the MIDX's
> object order without changing its checksum. Since the .rev file's
> contents encodes the pseudo-pack order, embedding it into the MIDX is
> sufficient to guarantee that the MIDX's checksum changes whenever the
> object order does.

To slightly rephrase,

    The problem being that before the change to embed reverse table in
    MIDX, it was possible to change the object order without changing
    the checksum, but with that change alone, if a rebuilt MIDX has the
    same checksum, it is guaranteed that it records the same objects in
    the same order.

Hence, shuffling between rename(2) and link(2), which was the code
change that is only necessary to force updating the existing MIDX
with newly recreated one because two MIDX with the same checksum
could record objects in different orders, is no longer necessary.

Am I on the same page as you two?
