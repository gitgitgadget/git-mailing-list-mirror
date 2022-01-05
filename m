Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDF3C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 21:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbiAEVUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:20:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55582 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiAEVUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 16:20:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61F1AFE06B;
        Wed,  5 Jan 2022 16:20:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ROx38LiVS+KoS+IOU3GMqb1oCfD+Iuc8j+kLwt
        NHfvM=; b=DgL3dcwJaRQW+UEgxVjWiQc7HxvfGHGat89cTFCf2ShDL5mPqzfzi/
        ed9x+1pTAc9Yfr+kjZJlZd/0eA7jXHtxGB96Qdti9w2BYN4ncnJ5kRIeZ3POOz3C
        O5llFXDgqg2tPMMSLNPJpz9K4TtjWw8KOfbCBYThkIP3024AsaQHo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58E20FE06A;
        Wed,  5 Jan 2022 16:20:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C263FE069;
        Wed,  5 Jan 2022 16:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] submodule.h: use a named enum for RECURSE_SUBMODULES_*
References: <pull.1111.git.1641410782015.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 13:20:36 -0800
In-Reply-To: <pull.1111.git.1641410782015.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Wed, 05 Jan 2022 19:26:21 +0000")
Message-ID: <xmqq1r1lhobf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53ABE4C0-6E6D-11EC-9E41-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Using a named enum allows casting an integer to the enum type in both
> GDB and LLDB:
>
>     (gdb) p (enum diff_submodule_format) options->submodule_format
>     $1 = DIFF_SUBMODULE_LOG

Hmph, this was somewhat unexpected and quite disappointing.

Because that's not what those "Let's move away from #define'd
constants and use more enums" said when they sold their "enum" to
us.  In the diff_options struct, the .submodule_format member is of
type enum already, so, if we trust what they told us when they sold
their enums, "p options->submodule_format" should be enough to give
us "DIFF_SUBMODULE_LOG", not "1", as its output.  Do you really need
the cast in the above example?

> Name the enum listing the different RECURSE_SUBMODULES_* modes, to make
> debugging easier.

Even though this patch may be a good single step in the right
direction, until it is _used_ to declare a variable or a member of a
struct of that enum type, it probably is not useful as much as it
could be.  The user needs to know which enum is stored in that "int"
variable or member the user is interested in to cast it to.

That is, many changes like this one.

diff --git i/builtin/pull.c w/builtin/pull.c
index c8457619d8..f2fd4784df 100644
--- i/builtin/pull.c
+++ w/builtin/pull.c
@@ -71,7 +71,7 @@ static const char * const pull_usage[] = {
 /* Shared options */
 static int opt_verbosity;
 static char *opt_progress;
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static enum submodule_recurse_mode recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase = -1;
