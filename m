Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23DD52055E
	for <e@80x24.org>; Fri,  3 Nov 2017 13:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756249AbdKCNoL (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 09:44:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59194 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756012AbdKCNoK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 09:44:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7159A0598;
        Fri,  3 Nov 2017 09:44:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=euPXSrZdyUT/03DMpmDLOC4hnJ0=; b=inxuyl
        YgTn86pJuhHxxfTYAJ4UO5sFtUHmLQuZ9s1larC7uKMhhOK+rH5gyC/zBtdpeaaH
        qnPJ3oGDNL69bM8blC8SH3rUXcUjJ++eAUdUVUTY6YtEcwyeYnLA6xwNgb4ttmSz
        wbJsy0FtkECKgatOlvtpAnkk5LYnfRgjYjFyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Si7OVhLrBeyTGxwCt4S1T/1HBQchZfpu
        SidcvkwTyFkWZNLvgEvA4zST9sKFZDZclrz6A4sVGzU0ABws8lcWZYMjKklOOcUb
        0IaUyRRudioBRUghK2UaYZ02LHdWkXGK+CiXF72Gh3BRJ2o59hwGnFyjfP6WUz1c
        mZa2lTZQD9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE9D7A0597;
        Fri,  3 Nov 2017 09:44:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 423D8A0596;
        Fri,  3 Nov 2017 09:44:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
        <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
        <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
        <20171103103248.4p45r4klojk5cf2g@ruderich.org>
Date:   Fri, 03 Nov 2017 22:44:08 +0900
In-Reply-To: <20171103103248.4p45r4klojk5cf2g@ruderich.org> (Simon Ruderich's
        message of "Fri, 3 Nov 2017 11:32:48 +0100")
Message-ID: <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1176DDEE-C09D-11E7-90FB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> I tried looking into this by adding a new write_file_buf_gently()
> (or maybe renaming write_file_buf to write_file_buf_or_die) and
> using it from write_file_buf() but I don't know the proper way to
> handle the error-case in write_file_buf(). Just calling
> die("write_file_buf") feels ugly, as the real error was already
> printed on screen by error_errno() and I didn't find any function
> to just exit without writing a message (which still respects
> die_routine). Suggestions welcome.

How about *not* printing the error at the place where you notice the
error, and instead return an error code to the caller to be noticed
which dies with an error message?
