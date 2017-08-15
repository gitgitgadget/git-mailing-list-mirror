Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B2A208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbdHOTCd (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:02:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751576AbdHOTCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:02:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79E569BFDF;
        Tue, 15 Aug 2017 15:02:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2jSSHXTHXV0P/UuxICoxlaqcNkQ=; b=qDHCUZ
        5syb54A7Ghe3zHsMkqdJ1jgVPaxmgrLFoiPiRqNO0pXM51KoHaKMn8NDBxFhlt4A
        TU1qGSEh3LeZ7BO7fCI7bDA1l5egrkm9rl026IOMkvuvE0Z1seosgrkDTxoYuU+S
        1eGpJHw85ZQILTHRv4t8a02OQG864wLXHW3NA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YTid11DnueNG5pkU8rlrnddxtA2ikuFT
        GlzroH8l/hhPiE9wogxqms+fGV2cazuLPQXfJiXw9MdlhjO4hWzhSPCg4O3150Iw
        OzI4Re1MJKpTxEVi97+lbHYIOwX4/ADsWMSreOkYFg+J7cfce/HE60DEpI1uu3Ns
        2K12BCGZe60=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 718739BFDD;
        Tue, 15 Aug 2017 15:02:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D99BB9BFDC;
        Tue, 15 Aug 2017 15:02:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/5] sha1_file: fix hardcoded size in null_sha1
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <a21088f049390828cdee957f88503e8466e1d34e.1502796628.git.patryk.obara@gmail.com>
        <xmqq1socsnay.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaCA29j6ON4KSsB=EH8FPfZGE56hVGSAAepcPiH952v6g@mail.gmail.com>
Date:   Tue, 15 Aug 2017 12:02:29 -0700
In-Reply-To: <CAGZ79kaCA29j6ON4KSsB=EH8FPfZGE56hVGSAAepcPiH952v6g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 15 Aug 2017 11:29:55 -0700")
Message-ID: <xmqqbmngr6wq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49D4F4F4-81EC-11E7-B689-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Once we have 2 hash functions usable in a local Git installation,
> this would be wasteful for the smaller hash function (and the
> related grafts).
>
> I think Jonathan once envisioned an 'optimized' version as a
> second step, maybe this is a good time to discuss how we'd
> get the right size for e.g. allocating memory, as _MAX_ seems
> to be not the correct solution long term?

MAX is inevitable only if we envision that we have to handle objects
named using two or more hashing schemes at the same time, with the
same binary and during the same run inside a single process.

Using MAX may be nicer even if we use only one hashing scheme at a
time, though.
