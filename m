Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983E22036B
	for <e@80x24.org>; Wed,  4 Oct 2017 01:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdJDBoR (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 21:44:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60773 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751171AbdJDBoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 21:44:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 924529E749;
        Tue,  3 Oct 2017 21:44:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hPAzBCHRqA/99KqkihakNHoFLMs=; b=w05CaF
        Yjgc8WNSoA/xVYABBBKQmtNlHyJmYqd/Q2nfPcwYARE2IiE507jJCPVfPYBC0AVS
        88vKcZU7Ta/J0lHpPL4Dq/iV4y4pPsNGsVsWrpUhtmjSYYJdlAGfcF7f2GAWnbhl
        P+IrkFMfuLRDTBt7QlG7u6XZEpATxmqhnnNa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mBPCjoJQdXwZXRrzIV8YbxPixTVEAOHT
        VSEW9umG9itCFdpwa+B3wKwsQwhFI2r9hZNs81b9ID9EBCD3t5XPNHV9C3Y/vx72
        Cc1v4PrNKeiP0RPQuKS/RVmyxd4n6R9Y/PJs+38FZBd6pvUlT6ZuhlIyfdR5nAoW
        MkVTJSTtsT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 890EA9E747;
        Tue,  3 Oct 2017 21:44:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED38C9E746;
        Tue,  3 Oct 2017 21:44:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function transition
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
        <20170928044320.GA84719@aiede.mtv.corp.google.com>
Date:   Wed, 04 Oct 2017 10:44:13 +0900
In-Reply-To: <20170928044320.GA84719@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 27 Sep 2017 21:43:21 -0700")
Message-ID: <xmqqefqjheky.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87444F30-A8A5-11E7-89A7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> +Alternatives considered
> +-----------------------
> +Upgrading everyone working on a particular project on a flag day
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
> +Using hash functions in parallel
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...

Good that we are not doing these ;-)

> +Lazily populated translation table
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Some of the work of building the translation table could be deferred to
> +push time, but that would significantly complicate and slow down pushes.
> +Calculating the sha1-name at object creation time at the same time it is
> +being streamed to disk and having its newhash-name calculated should be
> +an acceptable cost.

And the version described in the body of the document hopefully
would be simpler.  It certainly would be, when SHA-1 content and
NewHash content are the same (i.e. blob).

THanks.
