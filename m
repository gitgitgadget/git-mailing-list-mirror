Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89385C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC092100A
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbhAYTHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:07:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62495 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbhAYTGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:06:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A05EB108A5E;
        Mon, 25 Jan 2021 14:05:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5ykBQUVTPViS
        HDIhRFuYhjF3MsQ=; b=bjRDVb5s97QNuU4cJ1ks3juC/ALBDKRvmTsK0o7uErnb
        2sh491Dd6FSAIuQNyLD3n31BRX4cxaxI4QObUkzap8exxqhPyNYnGvwQOqDlfg3e
        1fbTw2MYxO6JBkChi9JnRWZdZHPLk5jCcOsTLRsQ/XiYpldc5WHczes/90vRkPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SGD+al
        SKxdF0iXOQwpEwT5mi+A8sUGFCferY27HEuX5yBo8HVkp4NbB+v8E+Jui0inBmJ8
        s3ziE+hdlisKTyfAawQO21mw79CREsbtqCwNT+9SeZ1FSNv2FYs28gf5PvwE3r38
        14m0x25ShdAOY6MRk0la+tdPQ+kVvP0PDRjWs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 861E7108A5B;
        Mon, 25 Jan 2021 14:05:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB0FA108A58;
        Mon, 25 Jan 2021 14:05:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 1/3] ls_files.c: bugfix for --deleted and --modified
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
        <8b02367a359e62d7721b9078ac8393a467d83724.1611485667.git.gitgitgadget@gmail.com>
        <xmqqo8heyoti.fsf@gitster.c.googlers.com>
        <CAOLTT8QgDeWmcX7y3QmQ7jyunziw4qn==L3BiJ81weMZtq8Obw@mail.gmail.com>
Date:   Mon, 25 Jan 2021 11:05:36 -0800
In-Reply-To: <CAOLTT8QgDeWmcX7y3QmQ7jyunziw4qn==L3BiJ81weMZtq8Obw@mail.gmail.com>
        (=?utf-8?B?IuiDoeWTsuWugSIncw==?= message of "Mon, 25 Jan 2021 14:05:06
 +0800")
Message-ID: <xmqqtur4ygzj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4FD9E6B8-5F40-11EB-89C4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:

> OK,I didn=E2=80=99t notice any formatting changes before.
>
> Am I free from this patch now?I should probably
> look for other issues.

I think we are pretty much done with it.  Thanks for working on the
topic so patiently.

