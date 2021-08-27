Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE5C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F47A60F5C
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhH0DAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 23:00:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53439 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhH0DAj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 23:00:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9283159651;
        Thu, 26 Aug 2021 22:59:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=EsE1ud1hAdNocrvGdz7MYgoYAFJ6/pgTAOozWlAwSyk=; b=qZIV
        G1lIR83g4FcEXCKvpBdr02rF5D17HwmbNJ3NGQCtesGBZVo0u3JS7Y0O49pkdbwA
        VK0F2uk6RvHwxskCvOujtwuOGtp3xnFqTvVQGz1szIjBPdtR9cwyUzk+ya4dVZVm
        R1AlMLhynBM968v2IyrtPw79kg1ToY/hxdu0qV8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C26DB15964F;
        Thu, 26 Aug 2021 22:59:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1558315964E;
        Thu, 26 Aug 2021 22:59:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Maksym Sobolyev via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Maksym Sobolyev <sobomax@gmail.com>,
        Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: [PATCH v2] Make ident dynamic, not just a hardcoded value of
 "$Id".
References: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com>
        <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
Date:   Thu, 26 Aug 2021 19:59:46 -0700
Message-ID: <xmqq1r6fd23h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6FE439C-06E2-11EC-A06F-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Maksym Sobolyev via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Maksym Sobolyev <sobomax@sippysoft.com>
>
> This allows ident to be something like $FreeBSD$ so it provides matching
> functionality for repos migrated from CVS / SVN.
>
> This works by allowing ident to have a parameter, i.e.:
>
> * ident=MyCustomId
>
> In .gitattributes.
>
> Signed-off-by: Maksym Sobolyev <sobomax@sippysoft.com>

Just like cvs uses its configuration mechanism for LocalKeyword,
this belongs to the .git/config file.

The attribute mechanism is inherently for stuff that you would want
to specify per-path, so the "do we do keyword expansion for this
file (yes/no)?" is a good match to be an attribute, and that
question is what the original 'ident' attribute asks.

I do not think "what keyword do we want to expand as if it were
$Id$?" is a question we want to be giving different answers per
path, and it does not smell like a good match to be an attribute.

By allowing a potentially separate values for

    *.txt ident=FreeBSD
    *.cc  ident=OpenBSD

this gives long rope to create a mess to the users.  In addition, a
project can easily attack and break its users by having .gitattributes
with overly long ident defined, as it would cause the attribute code
to trigger the die() call added by this patch.

In short, I do not think the approach taken by this patch to use
per-path attribute is a good idea at all.

I suspect that this patch mimics crlf_action when naming the new
"ident_action" thing, but that is a poor choice.  crlf_action does
specify what different actions to be taken, but the setting does not
change the way 'ident' filter behaves in any fundamental way.  It
just changes the constant string used to locate and replace from
$Id$ to something else.  ident_keyword (as this is "keyword
expansion" behaviour) may be a better name.

There is no inherent reason why the custom ident string must be
shorter than 255, even though it might not be a bad idea to have a
reasonable floor for the length.

