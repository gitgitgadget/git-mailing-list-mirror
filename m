Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F3720193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942481AbcJ0W5A (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:57:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57595 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935281AbcJ0W47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:56:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56D044A5BC;
        Thu, 27 Oct 2016 18:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pddxPZietegy5D7tu9Swk13dBl0=; b=hZl/hy
        2VmYdk2ZDK7Yywttv0Gv6oVPnucSemOW+TPzexcCb+pw/TrWgXnLj6aVdz6cVJGh
        LgaNOIVtcSsUFCljz9hef2/U+FilMH2seqKOOkNqDQxMwKbVsfI1W8YefenB/Dgm
        5WHPMEfcx2pyzYBtIC86Whe2rLr/X6W0sdMec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dcOgMPxVpQGSx2eCuuosP83tX4SGtv2Y
        BcXLRM4RGKADCeziqfJM4V39C2wLy+i3wd3NKbUsShhOrpqFIG8+1dZrd2c4WpMs
        CEoRYaXgJ2J6rYHQd5Ke2oJvGkCHDrHFjhFNN9wvubEzukQgiveNuQI77zIk9oWn
        XBnA+s2GKK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EF6B4A5BB;
        Thu, 27 Oct 2016 18:56:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6EF64A5B9;
        Thu, 27 Oct 2016 18:56:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
        <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
        <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
        <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
Date:   Thu, 27 Oct 2016 15:56:55 -0700
In-Reply-To: <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 27 Oct 2016 15:38:59 -0700")
Message-ID: <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9C0529E-9C98-11E6-824C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Note that you can *not* do the same thing with O_NOATIME, since the
> whole point of O_NOATIME is that it changes the behavior of the open
> itself (unlike O_CLOEXEC which changes _later_ behavior, and can
> always be replaced by FD_CLOEXEC fnclt modulo races that are
> immaterial for git)

A tangent.  

I also thought O_NOATIME shouldn't be an effective fcntl(2) thing,
for the reasons you stated above, when I was studying the area
because of the discussion on these patches.  I was surprised to see
that http://man7.org/linux/man-pages/man2/fcntl.2.html contradicts
by saying F_SETFL can take O_NOATIME.  

Perhaps it deserves a bugreport?


