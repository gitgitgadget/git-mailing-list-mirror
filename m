Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA9920899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbdHWUeW (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:34:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932407AbdHWUeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:34:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C879A96BC;
        Wed, 23 Aug 2017 16:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MFLoRyTIAUoSesEJHpnipjgCz1k=; b=fwryRY
        RWPQwQNOl4wU5VqI3gAYAQaTpb9OI7nQVDvcqQkBw0hYGo00TB3Oono1W71F9Qz8
        1xuphh2sogOtFNMSOrJxc4YHVgw9NPxbBDTd5tKNF0hRrLU5sDffD6YZ955a+p3z
        nreJMHRFV8jMhI0DLjPZLAJ6fo9HoHZOg4uCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rvuth6I+2Q6p3AS+J0Qr3Lc2MQCVPqBk
        f1eauF1L1v5xV+JhDGxv6CX+e+4YriGvEyYf0nYbTvLzBmloHJ6yONqQUsMHFFvJ
        Q+aFhoovNtPujSFlBPt50JD73q/9XTOjqwpf3X6xTCzacwFOYP+7w9c2knnfxIb/
        FQXwW02Vlvc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 229DCA96BB;
        Wed, 23 Aug 2017 16:34:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 793C4A96B9;
        Wed, 23 Aug 2017 16:34:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Should rerere auto-update a merge resolution?
References: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
Date:   Wed, 23 Aug 2017 13:34:19 -0700
In-Reply-To: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
        (Martin Langhoff's message of "Wed, 23 Aug 2017 15:39:04 -0400")
Message-ID: <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 711DF342-8842-11E7-B9CE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Hi List!
>
> Let's say...
>  - git v2.9.4
>  - rerere is enabled.
>  - I merge maint into master, resolve erroneously, commit
>  - I publish my merge in a temp branch, a reviewer points out my mistake
>  - I reset hard, retry the merge, using --no-commit, rerere  applies
> what it knows
>  - I fix things up, then commit
>
> So far so good.
>
> Oops! One of the branches has moved forward in the meantime, so
>
>  - git fetch
>  - git reset --hard master
>  - git merge maint
> ... rerere applies the first (incorrect) resolution...
>
> Am I doing it wrong? {C,Sh}ould rerere have done better?

Between these two steps:

>  - I reset hard, retry the merge, using --no-commit, rerere applies what it knows
>  - I fix things up, then commit

You'd tell rerere to forget what it knows because it is wrong.  Then
after these two (eh, now "three" because there is the "forget"
step), "rerere" notices that an updated resolution needs to be
recorded, so it remembers it.  Later re-resolution will replay the
corrected one, simply because the old incorrect one is forgotten and
replaced by the updated correct one.
