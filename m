Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EE6C6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 16:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIWQk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIWQkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 12:40:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201966132
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 09:40:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C44B1B78EF;
        Fri, 23 Sep 2022 12:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kWVRyyo7J1eS9jSTyMsQYs9ZGqDjV2DChDRx8W
        pFvPk=; b=qRPFDB8USrmX88FIoeEYY5gUNwKtKyObJTr7j6q55XXIiU4iIFKuXo
        2pXy5Ta3UFjoQFBtx3P8NWgWYzAOTyNgyBfaQopWvoCdtjUryWbS4eizoTCoPHO+
        PPY/B0915OLBPIZBKBuhFJ4ImXJuXDA4PQtZP9JmT9sm6j0QzbZSY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53FCB1B78EE;
        Fri, 23 Sep 2022 12:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 149D11B78EC;
        Fri, 23 Sep 2022 12:40:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com,
        newren@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v6 1/1] builtin/grep.c: integrate with sparse index
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
        <20220923041842.27817-2-shaoxuan.yuan02@gmail.com>
Date:   Fri, 23 Sep 2022 09:40:18 -0700
In-Reply-To: <20220923041842.27817-2-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Thu, 22 Sep 2022 21:18:42 -0700")
Message-ID: <xmqq7d1uvybx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 697B79F0-3B5E-11ED-A174-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> - Command used for testing:
>
> 	git grep --cached bogus -- "f2/f1/f1/*"
>
> The reason for specifying a pathspec is that, if we don't specify a
> pathspec, then grep_tree() will walk all the trees and blobs to find the
> pattern, and the time consumed doing so is not too different from using
> the original ensure_full_index() method, which also spends most of the
> time walking trees. However, when a pathspec is specified, this latest
> logic will only walk the area of trees enclosed by the pathspec, and the
> time consumed is reasonably a lot less.

Good.  So without pathspec, we lazily populate the index and catch
matches even from outside the sparse cone.  We punt to "implicitly"
apply the sparse cone(s) as a pathspec that limits the hits to the
paths in the sparse cone(s).

> That is, if we don't specify a pathspec, the performance difference [1]
> is indistinguishable: both methods walk all the trees and take generally
> same amount of time (even with the index construction time included for
> ensure_full_index()).

Good.
