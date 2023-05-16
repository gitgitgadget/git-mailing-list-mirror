Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B9C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjEPRT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEPRTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:19:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2EFC
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:19:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AC321F7FF4;
        Tue, 16 May 2023 13:19:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1r7+zPPtll3kS8sgqwQyB7XrjLO5VUZFbp44wg
        47w5M=; b=B4P4jSh35feqcQ2BydVbuQbUBuuy3/Smn79mz4cKdMZhWC8Yh7hnrA
        RI28WbAy5Vt6GA/V2iZojyW/T4KlxZcqJxp4vtE7qN+mp9K7DffBtBHn0KMAEbIw
        ogOPX7VbKSR+ruqTvY9KfZ2wzDlkNXowEXwJD9MWCt7v02/NY+ilI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93C961F7FF3;
        Tue, 16 May 2023 13:19:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D8571F7FF2;
        Tue, 16 May 2023 13:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [BUG] Git 2.41.0-rc0 - Compile Error ALLOC_GROW
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
        <ZGO4LesPe4A2ftdm@nand.local>
Date:   Tue, 16 May 2023 10:19:48 -0700
In-Reply-To: <ZGO4LesPe4A2ftdm@nand.local> (Taylor Blau's message of "Tue, 16
        May 2023 13:06:53 -0400")
Message-ID: <xmqqlehourbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCE28B78-F40D-11ED-ADF0-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

Ah, alloc.h was introduced and everybody who took ALLOC_GROW() from
git-compat-util.h (or was it cache.h?) now includes it, but
apparently Elijah forgot  run-command.c and nobody caught this.

I wonder if there are other leftover ones that we haven't caught?

    $ git grep -l '[^_]ALLOC_GROW(' \*.c | sort >/var/tmp/1
    $ git grep -l 'alloc\.h' \*.c | sort >/var/tmp/2
    $ comm -23 /var/tmp/[12]
    compat/simple-ipc/ipc-unix-socket.c
    run-command.c

But the former one is only in a comment, so it probably is OK.

