Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B5C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiEIQFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiEIQFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:05:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4810F6
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:01:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69D2B180068;
        Mon,  9 May 2022 12:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sO8Coh5bvPHcMZi0TgoWnew0XudPMveBs+mBwf
        E1dr4=; b=oYDp469f6dv3QKpADSmx2lANb5XxXXn9MeZ0+xweQelty4Z7y9+JbQ
        oqZXWfBhI/HoEFhwuAeK4OQBMFekngixavXFDhl8U2h3UwPAdUo7eVgjb+yH30Eo
        6VzBz/MD6qgSRl/em1VQteoR6QVY/I8WJP8urRwC/LuUobCQcgrIs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61463180067;
        Mon,  9 May 2022 12:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3582A180066;
        Mon,  9 May 2022 12:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, git@vger.kernel.org, bagasdotme@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220503065442.95699-1-carenas@gmail.com>
        <20220503065442.95699-2-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
        <xmqqlevfesnu.fsf@gitster.g>
        <4314bf6d-d76c-bc5b-a7f9-e59c7c181c7c@gmail.com>
Date:   Mon, 09 May 2022 09:01:12 -0700
In-Reply-To: <4314bf6d-d76c-bc5b-a7f9-e59c7c181c7c@gmail.com> (Phillip Wood's
        message of "Mon, 9 May 2022 09:21:25 +0100")
Message-ID: <xmqq35hig0fr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 400CD992-CFB1-11EC-BBB2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> That way we can avoid having to run "chown" while preparing for the
>> test fixture, and running "git status" under root, but I am not sure
>> if we want our shipped production binaries to have these "pretend"
>> knobs.
>
> Lets ask ourselves "How could an attacker use these knobs to
> facilitate an attack?". They need to either (a) set these variables in
> the user's environment themselves or (b) persuade the user to set
> them.

I actually was not worried about the scenario where an attacker
fools potential victims, who are more privileged than the attacker,
into doing stupid things to hurt themselves.  I mentioned that the
existing knob for testing, "pretend that euid and st_uid are
different", because it tightens the check (even if you are trying
the code with your own directory, euid==st.st_uid check would not
give you an access and you are forced to rely on the safe.directory
cofniguration allowing you in), not loosens it, and it felt much
less risky than "pretend we are root" or "pretend the directory is
owned by root", which just felt much riskier things to allow people
to have us pretend.

But I was totally wrong ;-)  No matter what a unprivileged attacker
does with these knobs, the actual access will be done by a process
run by the attacker, and the actual security at the filesystem level
still kicks in to prevent the attacker from doing anything that the
attacker cannot normally do.  So the only qualm about the proliferation
of these GIT_TEST_* environment variable checks in the production code
is that it makes the logic ugly with more code.

Thanks.

