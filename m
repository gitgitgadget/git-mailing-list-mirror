Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C671E20281
	for <e@80x24.org>; Tue, 31 Oct 2017 01:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbdJaBto (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 21:49:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753247AbdJaBtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 21:49:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4B7BA671B;
        Mon, 30 Oct 2017 21:49:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uYcUqOocb3asO/I5LM8gLLMXtAs=; b=NO08Zd
        UGsJlfbnSyEzJLXbtHo/3IuYZ3fgk/rBJ1wP2zrqZBZ+hB8YHKHH/fi2e+SO8/TK
        ajQElCX1wg78nLgNdIOJS8N7TtwTS++2q/S9ChfaieQxV5LSZw2eFjTN5K9145yv
        0BEMYyq0McTb9Od3NTBQSouHxC4XJeV5avGLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GknsrJG5PJaTcJ2FQ/+Mtji6/tXMXE3v
        WNrUsfnqWbZRcv0nCLSUcLxoCLBWCQ0lBC9QXQ/GBz+s5NAxRZ+HI2zciVpzS3Xi
        DfiLDm2quexy78MIvZRrdH7A4ILd3EguBhqBAcVvotaKMrcgC7ritti1prmObkBZ
        4JGWeJldiLw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEBCCA6718;
        Mon, 30 Oct 2017 21:49:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18269A6717;
        Mon, 30 Oct 2017 21:49:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org, t.gummerer@gmail.com, l.s.r@web.de,
        jsorianopastor@gmail.com, peff@peff.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache entry order to speed index loading
References: <20171018142725.10948-1-benpeart@microsoft.com>
        <20171024144544.7544-1-benpeart@microsoft.com>
        <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
Date:   Tue, 31 Oct 2017 10:49:33 +0900
In-Reply-To: <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com> (Ben Peart's
        message of "Mon, 30 Oct 2017 08:48:48 -0400")
Message-ID: <xmqq8tfs3x3m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF3A3AB0-BDDD-11E7-9A76-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Any updates or thoughts on this one?  While the patch has become quite
> trivial, it does results in a savings of 5%-15% in index load time.
>
> I thought the compromise of having this test only run when DEBUG is
> defined should limit it to developer builds (hopefully everyone
> developing on git is running DEBUG builds :)).  Since the test is
> trying to detect buggy code when writing the index, I thought that was
> the right time to test/catch any issues.

This check is more about catching a possible breakage (and a
malicious repository) early before we go too far into the operation.
I do not think this check is about debugging the implementation of
Git.  How would it be useful to turn it on in DEBUG build?

While I do think pursuing any runtime improvements better than a
couple of percents is worth it, I do not think the approach taken by
this iteration makes much sense; the previous one that at least
allowed fsck to catch breakage may have been already too leaky to
catch real issues (i.e. when you are asked to visit and look at an
unknown repository, you wouldn't start your session with "git fsck"
to protect yourself), and this round makes it much worse.

Besides, I see no -DDEBUG from "grep -e '-D[A-Z]*DEBUG' Makefile".
If this check were about allowing us easier time debugging the
binary (which I do not think it is), this probably should be
'#ifndef NDEBUG' instead.
