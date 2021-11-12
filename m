Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA151C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B02E601FF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhKLTfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 14:35:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60673 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhKLTe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 14:34:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A44F116C6BF;
        Fri, 12 Nov 2021 14:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B2Ot9G7rotOV
        KfdaOtZsJ3ve3vpN+LobBnmcfUkivew=; b=mx3t/Z1A/RxSzjbWYJarpnshYVKj
        G25X6oVlnJxPB+HNW2GgMQLUB28lguwKZcbqwCKNXHTLhmB6Uqv9Kyxm4gb+VF2o
        ifV7gPvRKDpg1YX2/LcS3RO0xtyG9+d3eHB1JA6QA4CdMDhL457G+oo81o5mxwtE
        Z0zARyK17eOJQ2Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DA2916C6BE;
        Fri, 12 Nov 2021 14:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0983816C6BD;
        Fri, 12 Nov 2021 14:32:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 8/8] grep: make "extendedRegexp=true" the same as
 "patternType=extended"
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-8.8-cc904d93b26-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 11:32:03 -0800
In-Reply-To: <patch-v2-8.8-cc904d93b26-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:50
        +0100")
Message-ID: <xmqqk0hdqifg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 382FAC2A-43EF-11EC-BA74-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In the preceding commit we changed how a "grep.patternType=3Ddefault"
> set after "grep.extendedRegexp=3Dtrue" would be handled so that the las=
t
> set would win, but a "grep.extendedRegexp=3Dtrue" would only be used if
> "grep.patternType" was set to a value other than "default".

I am getting the feeling that my suspicion about your confusion in
7/8 is right.

The grep.patternType=3Ddefault was merely a backward compatibility
measure for those who were used to grep.extendedRegexp=3Dtrue/false
way of doing things, and "default" never meant to mean "basic".  It
merely was an instruction to "honor the old extendedRegexp variable
for this old timer".  The intention all along was that patternType
was a more flexible single true way to set the type to supersede
extendedRegexp but we couldn't discontinue the support for the
latter all of a sudden, and the "default" was invented as the
transition mechanism, but it ended up as the mechanism to choose
either new (setting patternType to some other value) or old
(patternType is set to default, making the value given to
extendedRegexp is the only thing that matters) world to live in.

If you want to change anything in this area, the right thing to do
is rather to _deprecate_ extendedRegexp and eventually remove
extendedRegexp together with the "default" setting to patternType, I
would think, not to change the semantics of extendedRegexp in any
way.

Thanks.
