Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FC3C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E561185
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhEFAjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 20:39:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64579 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEFAjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 20:39:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AC6B12F630;
        Wed,  5 May 2021 20:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IZ33ZAytE3HJfg5CXqdQ7xYqAooRZsbpe110wQ
        sQIuA=; b=Ie4+zbQdbqHVvEh9LQazigCuD6MeABeSdzPp2DWXyOZVx9kvt5Tk6F
        spdr8ar5wA3YC8/7gr82FYOV4ZlhDLXzpZtVgbqGDbp3AYcN59UuBuXtd9SmO9p0
        kCJ/KGaOJ3llHYovFkvFcmPl9bXKwynpwBF7ZpzkyyQICrdUooQyw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72F9112F62F;
        Wed,  5 May 2021 20:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EDF712F62E;
        Wed,  5 May 2021 20:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
        <YJCABtAGT7s70jl1@camp.crustytoothpaste.net>
        <xmqqfsz36u0r.fsf@gitster.g>
        <YJEuBqVVa/7x+jrZ@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2105051528030.50@tvgsbejvaqbjf.bet>
Date:   Thu, 06 May 2021 09:38:14 +0900
In-Reply-To: <nycvar.QRO.7.76.6.2105051528030.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 5 May 2021 15:51:14 +0200 (CEST)")
Message-ID: <xmqqeeek3de1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 586DC9FE-AE03-11EB-825A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So _if_ we need that file ID information, I would be very much in favor of
> introducing a proper abstraction, where differentiate between the
> intention (think `get_inode(const char *path)`) from the
> platform-dependent implementation detail (think `lstat()`, `CreateFile()`
> and `GetFileInformationByHandle()`).

I agree in principle.  Essentially, we need to

 (1) examine all calls to lstat(2) we make in our codebase, and find
     out what members of "stat" are really used out of the result
     for each callsite.  This will be different from caller to
     caller (some callers may want only ino, other callers may want
     ino, size, and mtime, etc.), and we would learn that there are
     N patterns.

 (2) write N abstracted helper functions (or a single helper that
     takes const char *path, struct stat *, and an enum to tell
     which one of N patterns this call is about).

 (3) replace each lstat(2) call with one of these N abstract helper
     functions.

get_inode() might be one of these N functions, but what is important
is that the current callers that want ino and something else should
not be penalized by making two separte calls get_inode() and
get_other_things(), which, when done naively, would result in two
lstat(2) calls.



