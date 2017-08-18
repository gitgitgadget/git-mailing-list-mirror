Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADC3208D0
	for <e@80x24.org>; Fri, 18 Aug 2017 07:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbdHRHoa (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 03:44:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62743 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750808AbdHRHo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 03:44:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E20E7A57AC;
        Fri, 18 Aug 2017 03:44:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6cWrjLRca/TZXt4/7GoWp7VZMe8=; b=Gx+pCT
        PNr9qF5QsPyYXLjWp0sjx8bMKAJI7/98uWB70tDeOyJNe0a389AN3uurNL/l7XIF
        PnSKbS6ufV9va6w2rjvEWrFoIPotiHgCUW/fJhBc9f2E8E7rRHQJEAThytauRTk5
        dCRCEcI3QqRztDrwg3jZODNscm/ndwUSAUWVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WUAB4uOXdMpoCWmnLuYA/FqNrpP589L7
        xpJu5eKP13FJfeq7+MASPA/uW6VFkJ0CuUxe9WznzvwY7NWFCd4OgeKSMSm1GCH4
        mdkYrgbKbjaTktmVDMfSZbEXB3WGA/vV0xMovqL7kf8Iy46DsK15YUf7ZHF/z8m4
        1rafo+tTDx4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6C1CA57AB;
        Fri, 18 Aug 2017 03:44:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E8F6A57A9;
        Fri, 18 Aug 2017 03:44:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] commit: rewrite read_graft_line
References: <cover.1503020338.git.patryk.obara@gmail.com>
        <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
        <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net>
Date:   Fri, 18 Aug 2017 00:44:26 -0700
In-Reply-To: <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 18 Aug 2017 02:43:36 -0400")
Message-ID: <xmqqziaxcobp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FBC8030-83E9-11E7-BF35-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So we're probably fine. The two parsing passes are right next to each
> other and are sufficiently simple and strict that we don't have to
> worry about them diverging.

If I were doing the two-pass thing, I'd probably write a for loop
that runs exactly twice, where the first iteration parses into a
single throw-away oid struct only to count, and the second iteration
parses the same input into the allocated array of oid struct.  That
way, you do not have to worry about two phrases going out of sync.
