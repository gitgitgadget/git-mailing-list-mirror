Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A76CD5BCD
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 15:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjISPNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjISPNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 11:13:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ACBC6
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 08:13:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35DD62C534;
        Tue, 19 Sep 2023 11:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Kbj6h0hmyVDGH1qzSP47q0Ut9vvj4WO+A8/yUv
        UoN+0=; b=DEAXB0MHvwswoKTlXwYPAcPLsqt1IFfz6mK5GCo3QcBqu+Cv5FKH2D
        +AIwsuryURsDdYW0/siWv3HHMCxE/z6LGrIjhNHAWx60Qy4clz+GtmYWa042asIB
        UkAPbydsvG/DBUccdXtEeVqrvjMXM+x5qjJ+syAxfosGul61eANfs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E3AA2C533;
        Tue, 19 Sep 2023 11:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B2382C532;
        Tue, 19 Sep 2023 11:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v3] revision: add `--ignore-missing-links` user option
In-Reply-To: <CAOLa=ZQdtdpu3KMMpvgr16A19xtjtOXG=HAtNrLKv97-D=Cd+g@mail.gmail.com>
        (Karthik Nayak's message of "Tue, 19 Sep 2023 10:45:37 +0200")
References: <20230912155820.136111-1-karthik.188@gmail.com>
        <20230915083415.263187-1-knayak@gitlab.com>
        <xmqqfs3fe08e.fsf@gitster.g>
        <CAOLa=ZQ9ZRmYe5b6R9ZTTpDCzb2L0UmxkeBujb2kOMSeFuwJGA@mail.gmail.com>
        <xmqqv8c7mq4o.fsf@gitster.g>
        <CAOLa=ZQdtdpu3KMMpvgr16A19xtjtOXG=HAtNrLKv97-D=Cd+g@mail.gmail.com>
Date:   Tue, 19 Sep 2023 08:13:39 -0700
Message-ID: <xmqqfs3ai4bg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DDA70E2-56FF-11EE-ABAF-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> If I remove the hardcoding, it would mean that
> `--ignore-missing-links` would skip missing commits but for
> non-commits objects, the user would have to pass
> `--missing=allow-any` else rev-list would still error out with a
> missing object error.
>
> Don't you think this would be confusing for the user?  I'm happy
> to send a revised version removing this hardcoding if you still
> think otherwise :)

Yes.  This is an example of flexibility and ergonomics at odds, and
for a low-level plumbing like rev-list, I would prefer not to limit
the flexibility unnecessarily.

I do not care about the ability to pass allow-any here.  But when
you traverse a range A..B with the --ignore-missing-links option,
the reporting mechanism based on the --boundary cannot tell which
ones are at the usual "traversal boundaries" and which ones are ones
beyond the broken links, can it?  If you allowed the users to pass
'print', then those reported with '?' prefix would be the missing
ones.  The ones that are reported with '-' prefix may still be
mixture of the two kinds, but you can now subtract one set from the
other set to see which ones are true boundaries and which ones are
missing.  The hardcoded "we do not let __ma() logic to kick in"
makes it impossible, which is what I find disturbing.

Thanks.




