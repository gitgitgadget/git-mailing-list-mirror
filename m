Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A15208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 18:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdHRS3Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 14:29:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58646 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750971AbdHRS3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 14:29:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C24896A3B;
        Fri, 18 Aug 2017 14:29:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1poIPxu9zmgozinrYneUkMoJiWs=; b=kPFTWI
        t5zdSJ5qnq+XkKXJjlx1MPV+pOOsXbq2zbrM/c2DNOzE9MqEI5U4Gv/aGh2c5Y4a
        9sGfXJW/BYs6ISF2v3ISQKJ4aF+WR2HtBijn0nsURZ0LHkTDYxhMCA7RbItJbsPG
        iKKDTGhNMv0wILcwtv7mJM9jFq7ZoKuPZAR2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U3/IviNe0Jh9EgmGhji+oaGEqO/kHJlF
        U80p6Nx3sxUuPtgl0BItEtXWVyCZm/TxAfKEUWzTi9l3e5AugPfAf3IXopcdl3ej
        WugZa0vY7ZiuFKD+Aeb9INFRk/jihp5AKdir+zjtD6I0Toe0GpiCa388i20O9dIG
        DvH+k07jqoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2710F96A39;
        Fri, 18 Aug 2017 14:29:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 859D796A37;
        Fri, 18 Aug 2017 14:29:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] commit: rewrite read_graft_line
References: <cover.1503020338.git.patryk.obara@gmail.com>
        <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
        <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net>
        <xmqqziaxcobp.fsf@gitster.mtv.corp.google.com>
        <CAJfL8+SHSAhgrMY6ONVHLMWEHcT0mhm4oKMmq6D=89SErDKiMA@mail.gmail.com>
        <xmqqd17sddvz.fsf@gitster.mtv.corp.google.com>
        <CAJfL8+Tkb1KOn6bTGd8QPwr3=GgxKNZbp9OD_RmNeN4w-Os-iw@mail.gmail.com>
Date:   Fri, 18 Aug 2017 11:29:22 -0700
In-Reply-To: <CAJfL8+Tkb1KOn6bTGd8QPwr3=GgxKNZbp9OD_RmNeN4w-Os-iw@mail.gmail.com>
        (Patryk Obara's message of "Fri, 18 Aug 2017 19:05:56 +0200")
Message-ID: <xmqqtw14bugt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28862BCA-8443-11E7-9914-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Ah! I presumed two separate loops, one throwing away oids and second
> one actually filling a table - this makes more sense. I was just about
> to send v4, but will rewrite the last patch and we'll see how it looks
> like.

Yeah, it is understandable if you missed my "a loop that runs
exactly twice", as that pattern, while we do use it in a few places
in our codebase, is of limited applicability in general---the cost
of discarded computation in the first pass need to be low enough for
the improved maintainability to make sense.
