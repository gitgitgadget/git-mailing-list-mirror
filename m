Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D20202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbdCHRYu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:24:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752998AbdCHRYt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:24:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF7A86AF7C;
        Wed,  8 Mar 2017 12:24:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CryF9DhdiAbVgaqbxLp/CaTPKro=; b=FgWcJV
        LGJ2NywVFe5gwmvHFy368H9mksnMp9cWsvUc71mjMZTUH6bdmVzgbtBKmDodAYp9
        lptqJ3JN7AVY7H+0UJ+cuMmLdwHURwzzjoqJi03c/1jXAChgMyXYXKl8WkHN13GE
        AHWSYHhr3SQcQEJILl/sxwVlRmTLC3DAdWXa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DPh3UrS0AJljrSJ5eE/C5NnlYhK34UMD
        sRyfwXp7FJlG3/opp0AOIZ9Ji0/BLYD/gRYOfm/YEhonQUybV8CgE87hifhYHjOH
        gGGwk1ItwJDXbqY4AOOiZZTEYOOl4m0fweAwF2fN8UuC8vPhH0vXQUrJcc+okxmS
        vba+oapuu34=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D72816AF7B;
        Wed,  8 Mar 2017 12:24:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 368336AF7A;
        Wed,  8 Mar 2017 12:24:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
        <alpine.DEB.2.20.1703072345530.3767@virtualbox>
        <alpine.DEB.2.20.1703080104580.3767@virtualbox>
        <xmqqh9344hq6.fsf@gitster.mtv.corp.google.com>
        <xmqqa88w4bbp.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703081304130.3767@virtualbox>
Date:   Wed, 08 Mar 2017 09:24:46 -0800
In-Reply-To: <alpine.DEB.2.20.1703081304130.3767@virtualbox> (Johannes
        Schindelin's message of "Wed, 8 Mar 2017 16:34:14 +0100 (CET)")
Message-ID: <xmqqpohr3cm9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20C166F6-0424-11E7-A283-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Rather than a heavy-handed reversal, I would really prefer to perform a
> diligent audit of all real_pathdup() callers and adjust them
> appropriately.
>
> Turns out that the canonicalize_ceiling_entry() caller is *the only one*
> handling NULL correctly. All other callers need to be changed.

The observation matches what I saw.  

I would have added a patch that introduces real_pathdup_gently()
that returns NULL and made real_pathdup() die as before immediately
on top of the Brandon's series (which would ensure that any branch
that would want to use real_pathdup() would get the dying version by
default) and flipped selected callers to call the gently() version
in that patch, but what you posted is a lot more apprporiate for a
regression fix.  By changing the function signature, the patch
ensures that it covers all the callsites.

Among the two-and-half regressions known to us post 2.12 so far,
this one probably needs to go into a maintenance release without
waiting for the other one-and-half, I think.

Thanks.
