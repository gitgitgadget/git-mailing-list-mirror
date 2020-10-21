Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C767C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA71D2419A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2N++/QI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506071AbgJUVUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:20:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51707 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506068AbgJUVUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 17:20:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 479C97FB46;
        Wed, 21 Oct 2020 17:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I6T8mAkrZGEZFh4UDtBGyM2mrkQ=; b=n2N++/
        QIW+0mftMgC5qkTP2l/0T8aBp1opp19+9PfpsWmdwg2urJn/u3smcG5/vB4qYZ3V
        FY8o/9NzFlzexp3bd6KAVW+dwnJMUdte2OBKIwDvGERohBJwCqWij6jJBOAN6KN2
        i8WeLekTqitpQ/7+nWNMt43vUlmPTq9xtYTnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bfBmYL7U8DmNaegFAm78AFdxW2XSYbXG
        LYHEx3x8Pg6GmeHixCEPUFqADb/EDwNlGgD4PMhE+esil8z5NKfXF2UvHynVXX7g
        F5YnvQZ8yDrxztUuFuN8AY6MPYjS6HufjwIz/WURHj50zBTKmjg2UIw2bVT4Iox4
        buUkLNV/tVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E5BC7FB45;
        Wed, 21 Oct 2020 17:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCC947FB40;
        Wed, 21 Oct 2020 17:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 02/11] merge-one-file: rewrite in C
References: <20200901105705.6059-1-alban.gruin@gmail.com>
        <20201005122646.27994-1-alban.gruin@gmail.com>
        <20201005122646.27994-3-alban.gruin@gmail.com>
        <xmqqmu0z3tge.fsf@gitster.c.googlers.com>
        <e407ce78-8f93-3fb1-4ef2-ce8213f39df2@gmail.com>
        <xmqqimb3728g.fsf@gitster.c.googlers.com>
Date:   Wed, 21 Oct 2020 14:20:27 -0700
In-Reply-To: <xmqqimb3728g.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Oct 2020 13:28:31 -0700")
Message-ID: <xmqqsga75l9g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DA85BA8-13E3-11EB-9D7C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> This open(..., ce->ce_mode) call is way insufficient.
>>> ...
> But all that is unnecessary once you port this to C.  So the comment
> does not apply to the code you wrote, I think, and should just be
> dropped.

Sorry, forgot to mention one thing.  Using ce->ce_mode to create the
output file is the way how helpers in entry.c check out paths from
the index to the working tree, so the code is OK.  It's just the
copied comment was about the issue that your code did not even have
to worry about.

Thanks.
