Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A487C4332F
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiI3SOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiI3SOP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:14:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B0921829
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:13:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 595E01BD500;
        Fri, 30 Sep 2022 14:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uriMxq/75/U1
        bUGluR35vFdXd/5uk9o9CZvsEyKF4Rg=; b=WvpTPxTFqZz9QdzfbZiR73D916w8
        3zoafIqRf4qsV8fxHf6IVk801Y1cUlW51b30brwQMCVSHNfl6awiN7nlLpzAaDzZ
        n227Ilv9bmvOopzZAUdP6RQTJQv/hU9qn0O8fG4KKglZlm2noVdQnO6TG4oZ2VJP
        fr0KLlLFKvP4GOQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5344A1BD4FF;
        Fri, 30 Sep 2022 14:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 303441BD4FC;
        Fri, 30 Sep 2022 14:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: do not fail a no-op --edit-desc
References: <xmqqczbftina.fsf@gitster.g> <xmqq8rm1mz1d.fsf@gitster.g>
        <220930.86v8p5updv.gmgdl@evledraar.gmail.com>
        <xmqq7d1klrua.fsf@gitster.g>
        <220930.861qrsvj12.gmgdl@evledraar.gmail.com>
Date:   Fri, 30 Sep 2022 11:13:40 -0700
In-Reply-To: <220930.861qrsvj12.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 30 Sep 2022 19:58:03 +0200")
Message-ID: <xmqqill4k9wr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9CE53CDA-40EB-11ED-8D96-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Ah, OK, so in short, _gently() is still unusable to use for that.  I
>> guess it means that the approach taken by v1 would be a better
>> solution, then.
>
> As you noted it's got a TOCTOU instead, so we might wipe away good
> config entirely.

I do not think that is the case.

What you have in mind is probably something entirely different.  If
you open two windows, start "edit description" in both, write a
description in one of them, then write a different description in
another, depending on the order you save the buffer and cause the
"git branch --edit-desc" that invoked the editor to use the edited
result, the description written in the editor that was later closed
will win, instead of telling you "you started from state X and you
want to update to state Y, but in the meantime somebody else made it
state Z, so I won't overwrite it with state Y".  But that has always
been with us, IIUC.

The only "funny" thing the change makes it do is leave the good
config as-is, if the user starts without an existing branch
description and exits with an empty edit buffer, instead of removing
the description written in the other window in the meantime.  That
is quite far from wiping away good config entirely.

