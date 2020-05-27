Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE2C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 20:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AF3207BC
	for <git@archiver.kernel.org>; Wed, 27 May 2020 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qtXa1OSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgE0Ulu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 16:41:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55852 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgE0Ulu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 16:41:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3285CCBD46;
        Wed, 27 May 2020 16:41:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r/ihGSlQ6oJW50H10NIvfMVIp8E=; b=qtXa1O
        SI0ykIQq1OKoGM7qE6ZjVTCkq6zgzrUaJ/e9raqLdzyAbF3EnoKVCO8CyhRjEQJU
        Di3AsYtg91PeV0qlXazD0emIy6VxL4hhJh2VQdlOC42910KdVZUFZvLt29lXFrCO
        19I3w5vIWGUcxZh5iPKN4eO4G96aEFwbkNsa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yDc0294o9CQboScZiihZ8OMC+YM7qWLG
        jqsGrR3FDVk2cMgbBEFGDca8Fp4kVGHzABLKxHOHixTqVFK8zel1pcTTH0roSQAl
        +9nInZ3TzH5Ntpi0XaSFIn158KSuXmlICSlwIbILVYu+DcEx91qdlLt7nQcmMzAh
        P1E5cmVCGBc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A6B5CBD45;
        Wed, 27 May 2020 16:41:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B71BCBD44;
        Wed, 27 May 2020 16:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/12] upload-pack: use 'struct upload_pack_data' thoroughly, part 2
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
        <20200527164742.23067-1-chriscool@tuxfamily.org>
        <20200527185700.GJ4020820@coredump.intra.peff.net>
Date:   Wed, 27 May 2020 13:41:42 -0700
In-Reply-To: <20200527185700.GJ4020820@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 27 May 2020 14:57:00 -0400")
Message-ID: <xmqqblm9kt4p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79ECA080-A05A-11EA-AEBB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One thing I think we _could_ do is to switch v2 to only reading the
> config once, instead of once per request. And then all of those config
> values could remain where they are, as they wouldn't need to be cleared
> or reset. But I doubt the cost of parsing config per-request is
> noticeable in practice, so I'm happy with it either way.

Yeah, I agree that that would not be an optimization for
performance, but the value of doing it primarily lies in
gaining the conceptual clarity in the resulting code.

Thanks, both.
