Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B660C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365A521841
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OWkqEVTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgEHPgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:36:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51915 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgEHPgn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:36:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AE7ED76F1;
        Fri,  8 May 2020 11:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=poq9UGJXCI9S
        25lvQDgSmFCP868=; b=OWkqEVTSQ6WRcsyrYYE8BdyYKF/QYjEOomZekVDnlCg3
        s7APqI/lfmZIz6/agk806jxo6V1+fo3Up6jBgo9a9YL+ohJxzW25H9VLmpfO7WXE
        eXJOx6Ad4uHbFXxSGOpAQGtfXOFYBIX4nkH2nWGR2qd4DcIgLcsg2QTgaR21Ym4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WImqOP
        YIVTMTEWl3EUs2IF/seACF/IM381/0tQEfWNCu0kCrVYPF9WWyOT/+mFAJVg/ggr
        fvY08KmZEGlN56n/2weIOK54FS5Fyru8tJqsKHsC67bc9C3XPoRWPvTKSW6+wDQW
        2851mDupAuPXm//lmEqfYVDJgL7Npme9jdunY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73296D76F0;
        Fri,  8 May 2020 11:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66AB6D76EE;
        Fri,  8 May 2020 11:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Force Charlie via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Force Charlie <charlieio@outlook.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] Correctly initialize 'installed_handlers'
References: <pull.630.git.1588921514146.gitgitgadget@gmail.com>
        <20200508083340.GA36538@Carlos-MBP>
Date:   Fri, 08 May 2020 08:36:36 -0700
In-Reply-To: <20200508083340.GA36538@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 8 May 2020 01:33:40 -0700")
Message-ID: <xmqqy2q2zbej.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B508B85C-9141-11EA-8A77-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> the way this is handled would seem to indicate otherwise
>
> if (!installed_handlers) {
>                 atexit(remove_tmp_objdir);
>                 sigchain_push_common(remove_tmp_objdir_on_signal);
>                 installed_handlers++;
> }

It is a curious piece of code. =20

The "prepare a file-scope static and do something and increment it
when it is 0" pattern expects the function to be called many times
and do the guarded thing only once.  However, there is this code:

	if (the_tmp_objdir)
		BUG(...);

before we do anything else, and then before that "arrange to clean
up, but do so just once" block, there is

	the_tmp_objdir =3D t;

where t is the pointer to a "struct tmp_objdir" instance.  So one
part of the function expects to be called at most once, while
another part is prepared to be called more than once.

Almost all of this function is attributed to 2564d994 (tmp-objdir:
introduce API for temporary object directories, 2016-10-03), so
let's see if Peff remembers anything about this curiosity.

Thanks.
