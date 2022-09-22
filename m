Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39BAECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIVT1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIVT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:27:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354F106F74
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:27:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BEC91BBC31;
        Thu, 22 Sep 2022 15:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=byjL7+vNIwq2evXzXI9Sm9AO2c6cEgq0hz9+9s
        H3BJ0=; b=J6s4Kj2cR8I2XoYL+zRSgakrEoSFjGaZ8RlAnMAPmXQoOwlpvGUsuW
        VUg7xWOnaXudwhFO7cuF7w7yFvhuAKRkpaUy9V/YF+FAGrIOvi72777PuAmRCK2f
        UalXKvtnxG49BTgSI70ei1OVU8tR3lJeImKI/uRvz4XFHR8F46rRc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 138331BBC30;
        Thu, 22 Sep 2022 15:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A2491BBC2E;
        Thu, 22 Sep 2022 15:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] fsck: free tree buffers after walking unreachable
 objects
References: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
        <Yyw031PqCyYlEqCX@coredump.intra.peff.net>
        <xmqqa66rz20q.fsf@gitster.g>
        <YyywSdrWO61Kza0e@coredump.intra.peff.net>
Date:   Thu, 22 Sep 2022 12:27:33 -0700
In-Reply-To: <YyywSdrWO61Kza0e@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 22 Sep 2022 14:58:17 -0400")
Message-ID: <xmqq5yhfyztm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C5E7CA8-3AAC-11ED-9D97-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think it is true that this is the final time we'd look at these
> objects. But I don't think it would be a disaster if somebody did. The
> free_tree_buffer() function clears the "parsed" flag on the struct. 

Ah, that is perfectly fine, then.  Thanks.

> As a side note, IMHO having tree->buffer at all is a mistake, because it
> leads to exactly this kind of confusion about when the buffer should be
> discarded. We'd be better off having all callers parse directly into a
> local buffer, and then clean up when they're done.

Yeah, tree-walk.c users woud use tree_desc structure anyway, and
instead of having a moving pointer that points into a separate thing
(i.e. tree->buffer), it could have its own copy of the "whole buffer"
that can be used to free when it is done iterating over entries.

> .... But that's obviously a much bigger change.

Yup.

Thanks.
