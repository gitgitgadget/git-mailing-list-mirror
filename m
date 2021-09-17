Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC85C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF36124B
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbhIQTpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:45:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63979 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbhIQTpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:45:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0ABF61580D3;
        Fri, 17 Sep 2021 15:44:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SI+v3VXdPg7y
        cEW5XpV0KafViqEvdahEsPmDO1NgdPQ=; b=lVm6bq8yqrIaU6jnOqsDoYTEtXjD
        x8dpjqPp87+WffoQLxx0QfGmj6A+Z8v0b84pH5VLOhbgcdJsnB6v8GOhxAhZbLil
        rHAu20yRjirh0XGiH1fo7eqG+YZfvgePEQ2zQyllSHXJZNZ/E0lmdFjgV4cYsZu+
        XbEEptAJHR0MG2E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0384F1580D2;
        Fri, 17 Sep 2021 15:44:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6456C1580D0;
        Fri, 17 Sep 2021 15:43:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kurt von Laven <kurt.von.laven@gmail.com>, git@vger.kernel.org
Subject: Re: Don't Call commit-msg Hooks With Empty Commit Messages
References: <CAO-Ogzs7vCtfgjZqp+cg1ERiu3bSwZM47arHJyyTrEqAQ=ZLcw@mail.gmail.com>
        <xmqqlf3vilnb.fsf@gitster.g> <874kajdmsh.fsf@evledraar.gmail.com>
Date:   Fri, 17 Sep 2021 12:43:57 -0700
In-Reply-To: <874kajdmsh.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 17 Sep 2021 21:27:13 +0200")
Message-ID: <xmqqmtobgf7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 99A9327C-17EF-11EC-81AF-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'd think we'd want to call it on an empty message, e.g. maybe someone
> depends on that with empty message =3D auto-generate a message for me.

I tend to agree with you that, especially if we are to keep the
"commit-msg hook is allowed to change the message, even though it is
a job for other hooks", we should invoke it even on an empty file.

> But for those that don't, doesn't the default behavior of "git commit"
> catch this in either case, i.e. it wouldn't let it pass without
> --allow-empty-message.
>
> I understood this report as the hook taking the empty message (e.g. the
> user using it as a shorthand to abort), and their hook "helpfully"
> inserting some "default" message or template.

My understanding largely overlaps with yours but with some
differences.

They do not fall into either of the two camps.  Their hook does futz
with the message indiscriminately and adds some boilerplate material
blindly, even to an empty file.

The complaint is "the message is otherwise without any substance,
but because the hook blindly added some boilerplate material into
the empty original, it appears to be non-empty and fails to trigger
the --no-allow-empty-message machinery."



