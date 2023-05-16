Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C9BC77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 22:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEPWaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 18:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPWaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 18:30:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0569D5BBE
        for <git@vger.kernel.org>; Tue, 16 May 2023 15:30:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10AB219E564;
        Tue, 16 May 2023 18:30:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JDXzRWHM7FFbNNKGcfrCsqbqRderwVvplkVP/5
        WF/do=; b=m1VslH8y7jj6p0rtvsiuDO7c4of7/TwImoUwJpLo7/zaqimj6Vx5S1
        oxzRXN7vmlp3E/IoHf9gam7u+dIG0d9h5CEsicSvNj/jKQ43fKlMMUEAhPpjrgEm
        /Q6r9uz8TeVND19oVIc52I2IYfa+ruY+vQ+jp61AazE2cFd+FSv8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03C1119E562;
        Tue, 16 May 2023 18:30:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9C5419E561;
        Tue, 16 May 2023 18:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] common.h: move non-compat specific macros and
 functions from git-compat-util.h
References: <20230516170932.1358685-1-calvinwan@google.com>
        <20230516170932.1358685-4-calvinwan@google.com>
Date:   Tue, 16 May 2023 15:30:03 -0700
In-Reply-To: <20230516170932.1358685-4-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 16 May 2023 17:09:28 +0000")
Message-ID: <xmqqwn17sydw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35972D34-F439-11ED-8CF5-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> git-compat-util.h has grown to a large and difficult to read file partly
> because its set of functionality is overloaded. Besides being a
> compatibility file that ensures Git's operation across different
> operating systems, it has also become a dumping ground for commonly used
> macros and static inline functions.

Yeah, compat-util.h started out as a (surprise) "compatibility aid"
that isolates the knowledge of platform specific inclusion order,
what feature macros to define before including which system header
file, etc.  "A dumping ground for common stuff"---aptly put ;-).

> This commit separates out macros and static inline functions that are
> compatible across operating systems into common.h.

It sounds a bit too generic a name to me, but OK.

At some level I am more or less indifferent, in the sense that both
compat-util and common need to be included by a .c file anyway,
whether it is _our_ source, or in a future third-party source that
wants to link with the libified part of Git, so it does notreally
make much of a difference if ARRAY_SIZE() is defined in which one of
these two headers.  But presumably such a future third-party source
may arrange their own system support using their own counterpart to
compat-util without using ours, and if that is what motivates this
change, I could understand why a more-or-less git-agnostic common.h
could be a good idea.

Everything, other than sane-ctype macros, does look like a generally
useful git-agnostic helper functions.  If we were to move in this
direction, I probably would prefer to separate sane-ctype macros in
a separate header, simply because they are _designed_ to override
system supplied ones and some third-party source may not want to use
such a "feature".
