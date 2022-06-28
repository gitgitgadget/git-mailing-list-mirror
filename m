Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC2AC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 18:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiF1SN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiF1SNE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 14:13:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370DE3A4
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 11:13:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2175197136;
        Tue, 28 Jun 2022 14:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=56N5bcUuQekZ
        CZadgKN2aWDTRcRGCzDG/w5h+Zjfwt0=; b=Xge2KRYTUbJCG0prKf/HT1lM4t0S
        MFx/ashWTFrPF1E0a1m028rtoKFzTHwLYGpfHBDT2w0SFo4d49zuutAeTFPf2O8D
        FYfZvCRgQeykNAbqb3MDYjAoIuT3l9vhU1QLsgvCwSil/vXImJqGYL74YA8Mq+py
        UnEamrGyAd3dxMM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA9B0197134;
        Tue, 28 Jun 2022 14:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E49A197131;
        Tue, 28 Jun 2022 14:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, derrickstolee@github.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        git@jeffhostetler.com
Subject: Re: [PATCH v5 5/5] tr2: avoid to print "interesting" config repeatedly
References: <cover.1656403084.git.dyroneteng@gmail.com>
        <f3b87a33da2a9bd2cd5148fcfe1d55a6281d8b99.1656403084.git.dyroneteng@gmail.com>
        <220628.86o7ydf8gi.gmgdl@evledraar.gmail.com>
Date:   Tue, 28 Jun 2022 11:12:58 -0700
In-Reply-To: <220628.86o7ydf8gi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 28 Jun 2022 11:13:21 +0200")
Message-ID: <xmqqbkuck66t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1116180-F70D-11EC-8455-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Do we care in this case? I really don't know, but perhaps we can declar=
e
> "dedup" using the same facility we're using to wildcard-match keys, and
> either make that optional or the default, e.g.:
>
> 	GIT_TRACE2_CONFIG_PARAMS=3D'*:dedup,core.*:'
>
> I.e. to make it a list of <glob>[:<options>].
>
> Maybe not worth the effort...

I happen to think that the trace output is primarily for machine
consumption (i.e. if you want to make it readable by humans, it is
OK to require them to pre-process).

How does this "duplicate output" come about?  If it is because
end-user configuration files have multiple entries that are either
list-valued or relying on last-one-wins semantics, I suspect that it
is better not to prematurely filter these at the trace generation
side (which by definition is an opration that loses information).

So, to me, it smells that the whole "dedup at the source" thing is
not just not worth the effort but is misguided.
