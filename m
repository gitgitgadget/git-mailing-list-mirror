Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772EB20288
	for <e@80x24.org>; Fri, 21 Jul 2017 07:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbdGUHOs (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 03:14:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61971 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751709AbdGUHOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 03:14:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DC3B8F7BE;
        Fri, 21 Jul 2017 03:14:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0p8JIuMN54xwmQJG7z0cIiLG0Jg=; b=TNG/qV
        JVzirx/ttGPSjge9k/3oV5FkdzA3dJYYXrCYDcYGcWfks4OqDOfNdO4PlLUOrbLG
        vLvNu1W2Frq7tg5JCP8+dBTif9v3USzQuacNXav1KO6kNZGQk3Tlhtx1/5t2rYlR
        QUvlqczpWx2v3aQZpgtWcjKVLWECPTS2uHJiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j1+f376s9tu4gsAdTePyuEIAjsuCa+Is
        YYbB37dDavvhrptlyCUFRWyTyoBFSx16Q6PRlZfYTavvCi/JQgh6sU96xqvMbEFm
        6FwEA+JivawQUqF6QaK4fH5pNj6CwSYPEAGOvAAmlAQoyD0TxrLsZcxm8SZqXBI5
        i+0a4DVwn/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 959B08F7BD;
        Fri, 21 Jul 2017 03:14:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5FA68F7BB;
        Fri, 21 Jul 2017 03:14:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate from the lockfile
References: <cover.1497534157.git.mhagger@alum.mit.edu>
        <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
        <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
        <20170720233051.GB159617@aiede.mtv.corp.google.com>
        <xmqqpocuib06.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 21 Jul 2017 00:14:44 -0700
In-Reply-To: <xmqqpocuib06.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 20 Jul 2017 23:01:45 -0700")
Message-ID: <xmqqlgnii7mj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4675F310-6DE4-11E7-8073-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The general strategy we take for these atomic update of a file
> entity at $path is to:
>
>  (1) try to create $path.lock exclusively; if we cannot, somebody
>      else holds the lock so fail (or backoff and retry, which
>      amounts to the same thing in the larger picture).
>
>  (2) update $path.lock and close the fd.
>
>  (3) rename $path.lock to $path atomically to unlock.
>
> Would it be sufficent to tweak the above procedure with a new,
> zeroth step?
>
>  (0) see $path is a symlink; if so, readlink it and assign the
>      result to $path.  Then go on to step (1) above.
>
> I do not think such an enhancement would break atomicity guarantee
> we want from the locking.  When updating .git/packed-refs in an
> ancient new-workdir'ed directory, we would end up locking the
> corresponding file in the real repository, which is exactly what we
> want anyway.  As the basic assumption of having a symbolic link in
> the new-workdir'ed directory is that a symlink can stay the same
> forever while the linked target will be updated, I think this would
> be a reasonable short-term "fix".
>
> It would be ideal if we can do this at somewhat a low level, i.e. in
> the lockfile subsystem.

One thing I forgot to mention.  For the above to work safely, we
should think through the possible interaction this may have with the
core.preferSymlinkRefs configuration.  If the above is implemented
naively, an update of a symref (e.g. "HEAD") that points at
something to point at something else would end up taking a lock on
the underlying ref and updating it, which is not what we want at
all.

Perhaps it is about time we stopped supporting the configuration.
We may be able to come up with a solution while keeping it alive,
but dropping it would mean we would have one less thing we need to
worry about.



