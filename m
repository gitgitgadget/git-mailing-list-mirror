Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3245D1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 23:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965574AbdGTXLQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 19:11:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55523 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755017AbdGTXLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 19:11:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D91FE7FA07;
        Thu, 20 Jul 2017 19:11:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SMAOshaDvLHnK6bCmLeUrcdpJI4=; b=ALJCJV
        4Cf8HfacJpFUDp62uX+vV7fwHKbXqpRm8ugR/UHWBvcz06e4cHqEnG/WMjtzEk3y
        w4VcS+7Z5PqfQi6FKsTZC8Zlk0cf1YEU94AZ9LZ57CmmXU97VYLjzgth1GkDjhVk
        jIGyIMEtBxnk4tYT8vvxxLj2SBwkAsQgUGc1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bOWIGwm8orxzmxsMNHtS/TFL17zV4ieX
        SRFPHY0YOGWSR+AzJUO8AsdC+grx5kbOQwiH4Opzy2kDNlRMV6xX1P2uutFJxgxP
        +npqgmLw7uLDqR4NamsuLn7gSW80P19WMHiBeUOri1968nluEBPK4J+h+5aM4bx3
        ApRuSfPUg0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0C2C7FA05;
        Thu, 20 Jul 2017 19:11:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B2F17FA04;
        Thu, 20 Jul 2017 19:11:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate from the lockfile
References: <cover.1497534157.git.mhagger@alum.mit.edu>
        <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
Date:   Thu, 20 Jul 2017 16:11:12 -0700
In-Reply-To: <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Thu, 15 Jun 2017 16:47:26 +0200")
Message-ID: <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA19E6B2-6DA0-11E7-8732-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> We will want to be able to hold the lockfile for `packed-refs` even
> after we have activated the new values. So use a separate tempfile,
> `packed-refs.new`, as a place to stage the new contents of the
> `packed-refs` file. For now this is all done within
> `commit_packed_refs()`, but that will change shortly.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

The layout created by "contrib/workdir/git-new-workdir" will be
broken by this line of change.  "git worktree" is supposed to know
that refs/packed-refs is a shared thing and lives in common-dir,
so it shouldn't be affected.

Do we care about the ancient layout that used symlinks to emulate
the more modern worktree one?
