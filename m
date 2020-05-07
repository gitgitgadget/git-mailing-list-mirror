Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED753C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 05:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34EB20753
	for <git@archiver.kernel.org>; Thu,  7 May 2020 05:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gX7l34MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGFI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 01:08:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgEGFI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 01:08:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 818F8D396B;
        Thu,  7 May 2020 01:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KRrgUmI4brWoUonuaBh+EDI5Hgg=; b=gX7l34
        MGsWzK3OF3eEIKoWkL7qBg84qg75XIK4LJ0/js8FrHzYkFb7IWcM6aTgkT7lNunm
        Rq8/4dX5afMiLrnZC2MD4J+haF3xLyctn0Pt9y37WCeK9zoCG1D+ZKVuCz83mWEQ
        z1p8NxUIoIT3hR/idnn77GlZXo1FsGOalidrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bua1f0aAhmTEbspIO0b07F5QKtijxa5g
        SINbCo24DVLNgwsT5wsMZCbnbHBPfnMx7rpf+7wXpY/HuEh3qYEK2k6xToJlcTm6
        q8neKjdoe9RvNK8WZDOfFhAMxEVa893KPTxzi2fX7DMHI2YFfwdZY6z1KmWM5Gm1
        srctq5vJpdg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7941AD396A;
        Thu,  7 May 2020 01:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2D0FD3969;
        Thu,  7 May 2020 01:08:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     chrisitan.couder@gmail.com, liu.denton@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
        <20200506181239.GA5683@konoha>
        <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
        <20200507044028.GA5168@konoha>
Date:   Wed, 06 May 2020 22:08:51 -0700
In-Reply-To: <20200507044028.GA5168@konoha> (Shourya Shukla's message of "Thu,
        7 May 2020 10:10:28 +0530")
Message-ID: <xmqqv9l849i4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D828623C-9020-11EA-82EF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> No worries. BTW, should I include the `path == NULL` check in the
> if-statement?

If I were writing this code, I would probably write it like so:

	if (!path || !newurl)
		oops;

Specifically, I would write "!path", not "path == NULL".  I thought
a rule for that is in the CodingGuidelines (I didn't double check,
though).

The comparison on argc is to see if we are even allowed to access
argv[0] and/or argv[1].  In practice, if what main() got from the
outside world in argv[] is passed directly to you, argv[n] would
never be NULL as long as n < argc, but there are a few levels of
callchain between main() and you (i.e. module_set_url()), so not
counting on that would be sensible.
