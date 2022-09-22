Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B1C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 20:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiIVUNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiIVUNl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 16:13:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFF10E5DB
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 13:13:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AD1A133A07;
        Thu, 22 Sep 2022 16:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BIRLx6w22jEw
        /EmBBHLQ/kvjZUIVz02h/jiG2VyWa2o=; b=RHT3iXq1mE6ga3+vffVcv9k5/87n
        cLiI9k7aeFpEKMtL25rKFQzZqgLp6Ch7GMFskBLWA+tTbGP6A8INEX/le/UdKjhr
        glpvI2qHXd8w6b2cyW9XwLQWsB9wKkFZHoPMdDqzl9P67wh0e43DzfpdHjOIVyEJ
        pp22ZYe+RNwqHvw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E987133A06;
        Thu, 22 Sep 2022 16:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85A9C133A05;
        Thu, 22 Sep 2022 16:13:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git --archive
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
Date:   Thu, 22 Sep 2022 13:13:34 -0700
In-Reply-To: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
        (Richard Scheffenegger's message of "Thu, 22 Sep 2022 08:57:10 +0000")
Message-ID: <xmqqleqbxj4h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 09C23090-3AB3-11ED-8840-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com> writes:

> Unless I=E2=80=99m mistaken, the procedure to create a zip archive read=
s like a recursive collection of all relevant objects, and then writing t=
hem out sequentially, in a single thread.=20
>
> Is this assessment correct?
>
> I was wondering if a highly concurrent fetching phase could be optional=
ly added=E2=80=A6

The details matter here, I think.  Enumerating and slurping down the
contents to be archived out of the repository/object store to the
core can indeed be made parallel, but the end result product being a
zip archive or a tarball, which is fairly a serialized output
format, there is only so much you can hold in core, and it is not
clear what your plan is to do this without filling all the memory.

