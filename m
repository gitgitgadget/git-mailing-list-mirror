Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E232EC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbiEXWRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiEXWRC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:17:02 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8D18357
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:16:58 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B16F12C26B;
        Tue, 24 May 2022 18:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ozv5is3Qhcwf
        hr8T0/jQu/MqXQTg4KQVRYxtRnHk8t4=; b=QHeNH594Kkwd+FEQAyABNQQV73O+
        DAFasa3sr+vLdbX/qPwUV6Rbmpbodl54IBz5sIzdu9OVvKRNoqo5xH42fQNc3IYO
        KTKjeFWattQwOza4UBio7ClIeDUz3m2gNEq9NZFmqR1JijpiWmxULU117BfzYBJ4
        DEiJyF8f22j9F3I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00E8912C26A;
        Tue, 24 May 2022 18:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7174E12C269;
        Tue, 24 May 2022 18:16:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
        <xmqqleuqj1gy.fsf@gitster.g>
        <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan>
Date:   Tue, 24 May 2022 15:16:56 -0700
In-Reply-To: <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan> ("Carlo
 Marcelo
        Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 24 May 2022 13:16:39
 -0700")
Message-ID: <xmqqwneaeftz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39A96A70-DBAF-11EC-9594-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> My guess is that there is a curl version somewhere that is patched to u=
se
> threads more extensible than upstream and where this code is stil neede=
d.
> I think it is also safe to assume (like you did) that this is a 16 year=
 bug
> that was already fixed and reverting that code would be an alternative =
too.

Sorry, but this does not make any sense to me.

It wasn't like we were working around somebody else's bug 16 years
ago.  Reverting the bugfix we made 16 years ago will make the issue
fixed 16 years ago to reappear.

Also, even if your version of curl library uses multi-threading
internally, it cannot magically make _our_ calls into curl library
to be multi-threaded, letting a control flow that came from
run_active_slot() down to another recursive invocation of
run_active_slot() to spin there calling curl_multi_perform()
repeatedly, while returning the control to the outer
run_active_slot() at the same time.  So "a curl version somewhere
that is patched" does not sound like a plausible explanation,
either.
