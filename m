Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A011F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdARV5W (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:57:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55417 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751634AbdARV5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:57:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21FBA6186D;
        Wed, 18 Jan 2017 16:56:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LrxYVLOAMFUmQOhq2cbXc5E2M0A=; b=K5Fj9u
        uzkftghP7u09UBmqHj92cr5b5e1lxoRLxXFf0QDlLBhXIU3lM5uW+jeN6I067TbB
        +rNlZFySXLh83XOWHRI1YMMg7RWpZRK1Y1bu/Gkf559qRBBB93Sz/BPNLIcvRnyQ
        vPfDowp8rAtF4fvFZjcXGNqG4qAEbEDmuJIfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NiDN0BshRpFoG1J8wzGKoR3OLvc9xARl
        P5qNpM9yCfdOghWAfJclSlHG7PsXaKZ0IelTDYT2PGlL8wpfrkiyJGAgYTLakQ9/
        TXTr9/EuIR5QugfkNJXzyhoBz2mM3jGn4m6Y1FHa+ChTW891gM8TtOw60zV2hmmJ
        SKgo8nZZIfo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AC0F6186C;
        Wed, 18 Jan 2017 16:56:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7949A6186B;
        Wed, 18 Jan 2017 16:56:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/5] name-rev: add support to exclude refs by pattern match
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
        <20170118000930.5431-4-jacob.e.keller@intel.com>
        <xmqqtw8w86xc.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xo4-45je995LLoyh-LbGTTf3EZUVW-UV+Dd=Wg0EGRvVA@mail.gmail.com>
Date:   Wed, 18 Jan 2017 13:56:39 -0800
In-Reply-To: <CA+P7+xo4-45je995LLoyh-LbGTTf3EZUVW-UV+Dd=Wg0EGRvVA@mail.gmail.com>
        (Jacob Keller's message of "Wed, 18 Jan 2017 13:13:30 -0800")
Message-ID: <xmqqy3y82fs8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDF37FBE-DDC8-11E6-90BF-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Yes this makes sense. I'm still looking at whether the alternative
> implementation suggested based on the git-log style would make more
> sense or not, but if we keep this as is, the added text you gave is
> important.

I actually think it is a red-herring that "git log" honors "orders";
it does, but that is not a result of carefully considering the
desired behaviour.  It instead is a historical wart that came from
the fact that "--branches" and friends uses for_each_glob_ref_in()
that takes the top-level hierarchy paths like "refs/heads/" and the
implementation of "--exclude" piggybacked into the function in a
lazy way.  

If exclusion were done independently (e.g. in a way similar to what
you did in this series using subpath match), we wouldn't have had
the "the user must give exclude patterns first that would affect the
next inclusion pattern, at which point the exclude patterns are
cleared and the user needs to start over", which is an end-user
experience that is clunky.

