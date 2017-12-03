Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C94F20A40
	for <e@80x24.org>; Sun,  3 Dec 2017 06:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbdLCGHL (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 01:07:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61487 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750718AbdLCGHK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 01:07:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 611C1B68F2;
        Sun,  3 Dec 2017 01:07:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tL/s+vCI/WqIw73KO87S++Cql/M=; b=JmDkeJ
        diPsiJdwi0P++Lcc9+lsdCRZTW894nVFLjVerwkgsUWyo74WauDRAsFik2chxqrf
        mdXc/b+JfQPzzqugQQsgCdtREpKTCWLbF2jZPjjgKK8vAMDeR7YMda9FNXwd4LCB
        ZDaot42PAehPc+tU47+1QbP21sD2baSguwc04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DUxXiS0puN7GU+74rkwYpMmHWyRUgKka
        MSQ7JrDnhwO5e1KVDNqxep6WB6gJMCR78iql2F8stU9zWO+sTE20z3F5nl+6WsqC
        f5VbvmBRsMCupkna+ZD4Ls5CTr/uOYHOWzDatT1azXKUCGtNXoQwWRyrpRjINQ80
        2+M9xxEJMgY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 579FAB68F1;
        Sun,  3 Dec 2017 01:07:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD3ADB68F0;
        Sun,  3 Dec 2017 01:07:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171126193813.12531-1-max@max630.net>
        <20171126193813.12531-2-max@max630.net>
        <20171129032214.GB32345@sigill.intra.peff.net>
        <xmqqr2sclj2q.fsf@gitster.mtv.corp.google.com>
        <20171203024958.GA31493@sigill.intra.peff.net>
Date:   Sat, 02 Dec 2017 22:07:08 -0800
In-Reply-To: <20171203024958.GA31493@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 2 Dec 2017 21:49:58 -0500")
Message-ID: <xmqq1skcjqer.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3286AE96-D7F0-11E7-B218-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Eventually our fill() will block trying to get data that is
> not there. On an Apache server, the webserver would know there is
> nothing left to send us and close() the pipe, and we'd get EOF.
> But on IIS, I think the pipe remains open and we'd just block
> indefinitely trying to read().

Ah, yeah, under that scenario, trusting content-length and trying to
read, waiting for input that would never come, will be a problem,
and it would probably want to get documented.

