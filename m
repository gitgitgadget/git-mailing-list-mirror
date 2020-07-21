Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8B6C433E5
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E99020717
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DbtsCsjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgGUUny (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:43:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55194 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGUUny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 16:43:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6514FEAE3F;
        Tue, 21 Jul 2020 16:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjzkfUd6TqEwMlj519s/KMOl1kk=; b=DbtsCs
        jVGGXDCxU9pIFAFdpySYad7PJmBq8yIcJKFFLDFhxHxbcpdszhOTTn7H9UN80Q3M
        J44ONYXJxLGM2QL+9d4AqSqG1qVl9sVZ8wbUfgRUmj1C1n9gwiCQjX9WAcw5yGpQ
        8wH/qj8rQt4vT1SrpEpIy817D5Tn3DVBcxBp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CyEk5okC3JDSl6a6FcYhJyCTgtNmXlno
        Ba+sIH8UqLDW8gquQivVm6dq+CM7rkia8c+PCg+QdQmvEN9KCdc+I1EX0BuSLFel
        nyAsdzMzCNPQUFZQwHuoYIjtp69o2pGrA40weVvPiyPeW6pk+xxEEbRiRY3g2sus
        Oqq/7ANW5EY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D9A5EAE3E;
        Tue, 21 Jul 2020 16:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A321EEAE3D;
        Tue, 21 Jul 2020 16:43:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Alireza <rezaxm@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Request for adding a "clean" merge strategy for a double-commit merge to deal with conflicts separately
References: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
        <CABPp-BE2R3eUU7WD1Ovkn_OfVH6fc42DnXs5CuBTkMUcQsnCdQ@mail.gmail.com>
Date:   Tue, 21 Jul 2020 13:43:47 -0700
In-Reply-To: <CABPp-BE2R3eUU7WD1Ovkn_OfVH6fc42DnXs5CuBTkMUcQsnCdQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 21 Jul 2020 10:08:47 -0700")
Message-ID: <xmqqlfjc7g58.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E17B3A6E-CB92-11EA-B16D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I disagree that they are "lost".  Rather, git doesn't make them very
> easy to access: git log -p won't show you any output for a merge by
> default, and the only options that exist (-c, -cc) don't do what you
> need to see how conflicts were resolved.

With "sometimes" sprinkled into appropriate places, you are 110%
right.

