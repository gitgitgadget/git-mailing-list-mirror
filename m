Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A57C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C621206FA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gFrmQ//P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgIAVLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:11:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52256 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgIAVLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 17:11:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D449C8AC1D;
        Tue,  1 Sep 2020 17:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w7GcOn2DboAMR8EwltQnMHiIDew=; b=gFrmQ/
        /PiAToKUMy7uGmq3JfzvF+MswbXnS31/CEisuH6PUcyqi9f9Iws4omANAiyP9UYE
        Z4Muw2GcYZoISukifzLO4QGcwxgQKtbbcqXkI/NQBcpyI5WEaKhDPkR+liRBBV99
        RpH7SUkPhzykJXSODokQGR1nEd3i5mB64x/t8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IBuwT667EqkzDXqTZDjAfBN1QMVBQeYV
        KZDUvk7KIqFc+ik77Fwnc+ujjs63Qv4UXju2dupRscONarxiqUciogihMuxBujTx
        nwuP7iRi0Rsk3Dhy22mttLEOxUAPA1hpmnfESLjb/EOZCzeWBo/vU667RkVnI0fc
        dWMT/Si8Jlw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB65A8AC1C;
        Tue,  1 Sep 2020 17:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F4858AC1B;
        Tue,  1 Sep 2020 17:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/11] merge-index: libify merge_one_path() and merge_all()
References: <20200625121953.16991-1-alban.gruin@gmail.com>
        <20200901105705.6059-1-alban.gruin@gmail.com>
        <20200901105705.6059-4-alban.gruin@gmail.com>
Date:   Tue, 01 Sep 2020 14:11:10 -0700
In-Reply-To: <20200901105705.6059-4-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 1 Sep 2020 12:56:57 +0200")
Message-ID: <xmqqft81cidt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9421EDA-EC97-11EA-A3FA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> The "resolve" and "octopus" merge strategies do not call directly `git
> merge-one-file', they delegate the work to another git command, `git
> merge-index', that will loop over files in the index and call the
> specified command.  Unfortunately, these functions are not part of
> libgit.a, which means that once rewritten, the strategies would still
> have to invoke `merge-one-file' by spawning a new process first.
>
> To avoid this, this moves merge_one_path(), merge_all(), and their
> helpers to merge-strategies.c.  They also take a callback to dictate
> what they should do for each file.  For now, only one launching a new
> process is defined to preserve the behaviour of the builtin version.

... of the "builtin" version?  I thought this series is introducing
a new builtin version?  Puzzled...
