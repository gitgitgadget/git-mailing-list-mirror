Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C5BC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKWBZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:25:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51267 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 20:25:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F1B1F6F35;
        Mon, 22 Nov 2021 20:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CKBWgU7v4xksnty56otzH0FP3Uj4J1/G4EQcGP
        IB/3Q=; b=qSSmDZO6nc1v/hCM9jXKEIky53VDHLn82i+apowf6Wt1+Yrm1c9r0R
        Ot081KH/sARiuB/AhUnqtVGvsubnGZOL0ESumcVrAZyWY6WrMJk3KcIYe2o2ArSx
        vVnyWuiAXQmQOoac0ApHab04xQ2Psk2vLHybueAlSyPitVs+JqZsY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86594F6F34;
        Mon, 22 Nov 2021 20:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF78FF6F33;
        Mon, 22 Nov 2021 20:22:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, peff@peff.net,
        avarab@gmail.com
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
References: <cover.1634077795.git.jonathantanmy@google.com>
        <cover.1637020610.git.jonathantanmy@google.com>
        <1c1a07a0b65d4bbbb0f2628a3ddf1980e37d5065.1637020610.git.jonathantanmy@google.com>
Date:   Mon, 22 Nov 2021 17:22:32 -0800
In-Reply-To: <1c1a07a0b65d4bbbb0f2628a3ddf1980e37d5065.1637020610.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 15 Nov 2021 16:00:33 -0800")
Message-ID: <xmqqtug3aco7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5F318A2-4BFB-11EC-98AF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is a feature that supports config file inclusion conditional on
> whether the repo has a remote with a URL that matches a glob.
>
> Similar to my previous work on remote-suggested hooks [1], the main
> motivation is to allow remote repo administrators to provide recommended
> configs in a way that can be consumed more easily (e.g. through a
> package installable by a package manager - it could, for example,
> contain a file to be included conditionally and a post-install script
> that adds the include directive to the system-wide config file).
>
> In order to do this, Git reruns the config parsing mechanism upon
> noticing the first URL-conditional include in order to find all remote
> URLs, and these remote URLs are then used to determine if that first and
> all subsequent includes are executed. Remote URLs are not allowed to be
> configued in any URL-conditionally-included file.
>
> [1] https://lore.kernel.org/git/cover.1623881977.git.jonathantanmy@google.com/
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/config.txt |  11 ++++
>  config.c                 | 121 ++++++++++++++++++++++++++++++++++++---
>  config.h                 |   7 +++
>  t/t1300-config.sh        | 100 ++++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+), 8 deletions(-)

Here is just a design level comment, without trying to outline the
implementation in my head like I usually do before making any
suggestion, but it strikes me somewhat sad that config.c needs to
know specifically about "remote_url".

I wonder if this can be a more generalized framework that allows us
to say "we introduce a new [includeIf] variant to get another file
included only if some condition is met for the configuration
variables we read without the includeIf directive", with variations
of "condition" including

 - a literal X is among the values of multi-valued variable Y.
 - a pattern X matches one of the values of multi-valued variable Y.
 - a literal Y is the name of an existing configuration variable.
 - a pattern Y matches the name of an existing configuration variable.

If that is done, I would imagine that the feature can become a thin
specialization e.g. "there is an existing configuration variable
whose name is 'remotes.https://github.com/janathantanmy/git.url'"

Perhaps I am dreaming?

Thanks.



