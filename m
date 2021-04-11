Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1BC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8619161028
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhDKQNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 12:13:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58513 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhDKQNX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 12:13:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D9DDBCC4F;
        Sun, 11 Apr 2021 12:13:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=nx8T7+EH88W4iqcSavlaoby+dHw=; b=jv1euYCjyhlh5jywfMFO
        APMYmRBzONB5iPQqzLLm+rwKEyV2eI4Z+uJMiZBIFGSt62Y+ZVcPoIOUB7HyQY1C
        ywHCu+DJxCK0qgPFQdtkOGwExx/aKcgNOQyARKDz0jq3Zs19y0oR/JgNB6yJZQMB
        Pt/P82Bv/H1PmDXeiLU63YU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=D7K2LcvnfsYytG0dkkiC3tyzWrNvLzs/tdRRwGojdPZldi
        cnhnKdS0qxqktPW8LwZDxh/AKJyJ6AAsV0ve4aOnGTa+KywCZC5LkR8jpJ4/hNRn
        hSKB7xrPxvXMRTUNZeW7Lu/AYNAq0zCD7Sry2NV/8BGozwS2ZOM3dTVaXwKv8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53494BCC4E;
        Sun, 11 Apr 2021 12:13:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2AB4BCC4D;
        Sun, 11 Apr 2021 12:13:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] git log: configurable default format for merge
 diffs
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210410171657.20159-1-sorganov@gmail.com>
Date:   Sun, 11 Apr 2021 09:13:05 -0700
Message-ID: <xmqqsg3whka6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC709812-9AE0-11EB-8FB1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> These patches introduce capability to configure the default format of
> output of diffs for merge commits by means of new log.diffMerges
> configuration variable. The default format is then used by -m,
> --diff-merges=m, and new --diff-merges=default options.
>
> In particular,
>
>   git config log.diffMerges first-parent
>
> will change -m option format from "separate" to "first-parent" that
> will in turn cause, say,
>
>   git show -m <merge_commit>
>
> to output diff to the first parent only, instead of appending
> typically large and surprising diff to the second parent at the end of
> the output.

I think that it is a good goal to free a short-and-sweet "-m" from
getting tied forever to the current "two-tree diff for each of the
parent" (aka "separate"), and a configuration to change what the
"-m" option means would be a good approach to do so.  It would help
the interactive use by human end-users, which is the point of having
short-and-sweet options.  Existing scripts may depend on the current
behaviour, so the configuration cannot be introduced right away, but
over time they can be migrated to use the longer and more explicit
option "--diff-merges=separate".

But I do not see much point in adding the "--diff-merges=default".
Who is the target audience?  Certainly not scripts that want to
avoid depending on the 'default' that can be different and easily
vary per user.

Or is the plan to deprecate and remove the short-and-sweet "-m"
option and standardize on "--diff-merges=<style>"?  If so, such a
design makes sense from pureness and completeness standpoint, but I
am not sure if that is a good design for practical use.

