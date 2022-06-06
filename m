Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8D1C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 16:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiFFQNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbiFFQNX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 12:13:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA80310053B
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 09:13:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A04B12E06B;
        Mon,  6 Jun 2022 12:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wMu+cNXZumTqzgqimFlBqXOXU+tSEsLaxZxn6y
        Ov8X4=; b=pF6abKmty+JcVjxt+6swQ550E5Sge3h+2udCibxA3BI6sIUguX+/Jr
        SZqR7X0A9R9To2r8I/WdInuJgY01Vhv95s0ZJWmFwbiZIpOJvGbwju9WAi6AKrHj
        r3Uno3kQLmKnOw+hRYbnlQ8S4M+Oe4P3Gd4t3bt+NpL0vFdQx5bvI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 221CD12E06A;
        Mon,  6 Jun 2022 12:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89D7512E069;
        Mon,  6 Jun 2022 12:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
References: <20220602145935.10512-1-joak-pet@online.no>
        <20220603142521.42863-1-joak-pet@online.no>
        <xmqqy1ydhfcc.fsf@gitster.g>
        <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no>
        <9fa34f22-3404-7bf8-6985-642c80634bf8@online.no>
        <CAGTqyRxkiGt7CRggV7VeXNRK2VmDMxDX3EpOr5cPcc5AdH8ZaA@mail.gmail.com>
        <xmqqwndxcuru.fsf@gitster.g>
        <ed7d78a5-3c70-df5a-81c3-bdb631271700@online.no>
Date:   Mon, 06 Jun 2022 09:13:19 -0700
In-Reply-To: <ed7d78a5-3c70-df5a-81c3-bdb631271700@online.no> (Joakim
        Petersen's message of "Sat, 4 Jun 2022 11:42:54 +0200")
Message-ID: <xmqq7d5tbwio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95255A40-E5B3-11EC-A3CE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> There might be something I'm not seeing, but having it so each element
> counters whatever colour left by the preceding element seems less
> intuitive when adding or moving elements in the final $gitstring. Adding
> an element will then require going into __git_ps1_colorize_gitstring,
> even when it is not intended to be colourized. All existing uncoloured
> elements will also need to be prefixed to protect against colour bleed
> from being moved around. I'm partial to the idea of each coloured
> element clearing its own colour.

I think that each makes sense in its own way.  Depending on what
assumption we can make on the use of terminal attributes, one can
produce shorter output than the other.

For example, if you have 3 things, A, B, and C, that are shown in
this order, the "clear after yourselves" scheme would give

	gitstring=<red>A<clear><blue>B<clear><green>C<clear>

while "clear the slate for yourself before you draw, the framework
will clear the effect of the last one" scheme can give

	gitstring=<red>A<blue>B<green>C<clear>

if we know that no additive terminal attributes are used, and the
latter gives a shorter output.

If we need to support some additive ones (like "reverse"), on the
other hand, and if each element is independent (i.e. "clear the
slate for me" cannot use the knowledge of what the previous one
did), then we have to write

	gitstring=<red>A<clear><blue>B<clear><green>C<clear>

for the latter, which becomes more verbose (but is the same as the
"each is on its own, clear after yourselves" version).

I have no strong preference either way myself.  "each on its own"
might be conceptually simpler and easier to understand and explain
what is going on.

Thanks.
