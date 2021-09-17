Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F727C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F61610A6
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhIQJn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 05:43:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53361 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhIQJn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 05:43:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A744015456C;
        Fri, 17 Sep 2021 05:42:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hm9LdIT6AdewnauwpTIUnnxeePmsATlm8fMN+tQkknQ=; b=F6Nu
        ExBXk5H+7HuAEtGZb1HSC3v4u+FYJolYUTpvzb8wXVFl1/9SDv2O5tr8RJ8yn5Se
        Vy1BUEUFE1rw1MwAGV4U90E9rcJntFq3snJD4rnlTV4rp9oz6+cPudlCh6NF1yqa
        0lndhOveKwZ+Yq3LcaJ0mo58O9vT9uQrYKZ9X7c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91F8115456B;
        Fri, 17 Sep 2021 05:42:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE8F1154569;
        Fri, 17 Sep 2021 05:42:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kurt von Laven <kurt.von.laven@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Don't Call commit-msg Hooks With Empty Commit Messages
References: <CAO-Ogzs7vCtfgjZqp+cg1ERiu3bSwZM47arHJyyTrEqAQ=ZLcw@mail.gmail.com>
Date:   Fri, 17 Sep 2021 02:42:00 -0700
Message-ID: <xmqqlf3vilnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 828C58D4-179B-11EC-8143-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kurt von Laven <kurt.von.laven@gmail.com> writes:

> The most common reason commit messages are left empty is to abort
> them. commit-msg hooks that replace empty commit messages with
> non-empty ones (i) make it impossible to abort commits, (ii) are
> startling to developers joining a project configured in this manner,
> and (iii) can offer no value that wouldn't be equally or better
> offered another way. For instance, a default commit message would be
> better implemented as a commit message template or prepare-commit-msg
> hook. I propose that Git eventually cease calling commit-msg hooks
> when the commit-message is empty, but I would understand if backwards
> compatibility were the overriding concern. On the other hand, the
> empty commit message case is easy to overlook when crafting a
> commit-msg hook. One consequence of this behavior is that running the
> popular pre-commit tool (https://pre-commit.com/) tends to lead to a
> spew of false positives to the console on an aborted commit when
> configured with commit-msg hooks.

The primary reason commit-msg hook is there is *not* because we need
a way to tweak the log message.  As you said, prepare-commit-msg and
templates are much better way to give some sort of default.  

The purpose of the hook is to serve as the gatekeeper to cause an
attempt with a bad commit message to fail.  And a properly written
commit-msg hook would be rejecting an empty message, instead of
inserting cruft into an empty message file.

So, from that point of view, if we were to change anything, a more
useful thing to do might be to forbid commit-msg hook from modifying
the file and make sure it would only verify but not modify, I
suspect.  Doing so would have a side effect of making sure that no
commit-msg hook will turn an empty message file into a non-empty
message file ;-).
