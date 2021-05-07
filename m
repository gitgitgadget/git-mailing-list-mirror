Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F30CC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA35613E3
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhEGEuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:50:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51475 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGEuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:50:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D2BB12E442;
        Fri,  7 May 2021 00:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IhNjzA3X9jIR5rU5TjmSUsZv5kIFS1YvF1YHH9
        3ssww=; b=Wn01jfHVFWZn8vDb9wLTMpv3lYN1NXrTsIUkiU/OHgpgEbT5KYgs+L
        c5AKJQI4+Vpd6UrkwKJ7V8tvN9xaunYgy3egtGF6sMHo7Zxk+Xae9XJItMLz4sWm
        twrBWJBPWoHLTJmmQfloMg2Q/4PCwfxz8l6zuJ5kTNWIU3KqgjucM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A01812E441;
        Fri,  7 May 2021 00:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42E9D12E440;
        Fri,  7 May 2021 00:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
        <xmqqfsz01vc2.fsf@gitster.g>
        <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
        <xmqqk0oczao3.fsf@gitster.g>
        <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
        <xmqqtungxg4y.fsf@gitster.g>
        <CAOLTT8TQXAh9vu21d5rvaHe=+eqtFU8MCVhorfGmqYRohDThUg@mail.gmail.com>
        <xmqq8s4ry2ye.fsf@gitster.g>
        <CAOLTT8QWadP9ovrUC_7m86dKh1PsawUyZ=msK5tx1utTpuCXMQ@mail.gmail.com>
Date:   Fri, 07 May 2021 13:49:47 +0900
In-Reply-To: <CAOLTT8QWadP9ovrUC_7m86dKh1PsawUyZ=msK5tx1utTpuCXMQ@mail.gmail.com>
        (ZheNing Hu's message of "Fri, 7 May 2021 12:32:25 +0800")
Message-ID: <xmqq5yzvw3kk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7578BEE-AEEF-11EB-9E04-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> But I am afraid that the cost we paid for string matching here is too high,

If that is truly the concern (I do not know without measuring),
perhaps we should add a member next to the union to say which one of
the union members is valid, so that you can say

    if (atom->atom_type == ATOM_TYPE_REMOTE_REF &&
        atom->u.remote_ref.push)

(introduce an enum and define ATOM_TYPE_* after the member in the
union).

That would help futureproofing the code even further, as a new
synonym of "push" introduced laster [*] would not invalidate the check you are
adding there.


[Footnote]

* remote_ref_atom_parser() in the future may begin like so:

-	if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))
+	if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:") ||
+           !strcmp(atom->name, "a-synonym-for-push"))
		atom->u.remote_ref.push = 1;

