Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C37C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A99620643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J13E9J2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLWSCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:02:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54915 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLWSCf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:02:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26922295A8;
        Mon, 23 Dec 2019 13:02:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HZaChtUFVHPcCngCsMszYcPAgeI=; b=J13E9J
        2ryiByrh90f2y4BSRk18KpuQw6zN1i9BageEbsYH1YCesu5ATZL2BX4f3geg0vGJ
        e4KzDRh3LxWFDIw+NutbDgsXd0etfC5pqxAHqZUA4P1Z1mPOnEGQUlS9hBEQNTxv
        Dv6SVUQodwFzvBWsCogjlKN/vcWgYgWnq7Go4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pICmuQuipMVGQuLY1B85g5WbIMwdr49e
        fKIHZaAEUSmxMXHM4GZM0MZwoieTLa07x8wHznaD91T3iNjKCCSm8gNFtIS3trH0
        nmNk+cek+nhypsQfsNxvRexv5++xKdtke7uECXFas83leLJO3sdtUiVMIuTMoPNT
        qdjkRN7UNu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D059295A5;
        Mon, 23 Dec 2019 13:02:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76E5E295A3;
        Mon, 23 Dec 2019 13:02:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Arnaud Bertrand <xda@abalgo.com>
Cc:     git@vger.kernel.org
Subject: Re: Mismatch meaning between git-diff and git-log for the .. (double dot notation) and ... (triple dot notation)
References: <CAEW0o+gYqWT5u-Tf8aDoMgXaf36Mb-XOApLNs4D+GMVLvsOjxg@mail.gmail.com>
Date:   Mon, 23 Dec 2019 10:02:31 -0800
In-Reply-To: <CAEW0o+gYqWT5u-Tf8aDoMgXaf36Mb-XOApLNs4D+GMVLvsOjxg@mail.gmail.com>
        (Arnaud Bertrand's message of "Mon, 23 Dec 2019 13:51:12 +0100")
Message-ID: <xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64459CCC-25AE-11EA-B749-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please unlearn dot-dot and three-dots when using "git diff", which
is not about ranges but about comparing two endpoints.  If we were
reinventing Git today from scratch, we would make "git diff A..B" an
error.  You can consider it a bug that the command accepts a range
notation, but this will not change any time soon without a large
fight to find and fix uses of the syntax in scripts by longtime Git
users have written over the years.

Allowing dot-dot on the command line of "git diff", instead of
diagnosing them as errors and dying, was a stupid mistake we (well,
mostly Linus, but I am willing to take the blame too) made due to
laziness when we reused the machinery, which we invented to parse
the command line of "log" family of commands to specify ranges, to
parse the command line of "diff", which accidentally ended up
allowing the syntax for ranges where it shouldn't be allowed.

And worse yet, since there was only dot-dot and three-dots came much
later, "git diff A..B" ended up comparing the endpoints A and B,
because there didn't even A...B notation exist.

This is not limited to you but any user of modern Git is better off
to pretend "git diff A..B" does not exist; please unlearn dot-dot
and three-dots when using "git diff" and you'd be happier.
