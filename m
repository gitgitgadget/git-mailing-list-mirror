Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181FCC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 22:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CC422DFB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 22:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbhARWrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 17:47:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53047 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbhARWqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 17:46:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E85298867;
        Mon, 18 Jan 2021 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ApNgoetbg+DE/tZJfmE2z7RCiA0=; b=UCib9D
        UgOxhFADzDODldWJRqNZCUwzssKP9rNSWQ6EqbfCDzsUc/qMq5jZBvjh4gtoEnkd
        DOlub7xgaDFzcUEF2glZUy3UALMbawz0hUvtcT8gsBu1YAocsYusghT1KhPSrALU
        CfJTAoUorvJC6YiYjIHocRn38zWWvcHWfcTHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S+epB19E1tWs8x5TtMef/pPPrk5KCF2Z
        /YEslvQwnUHa/OpO9/2odEs82z2NfEhCzn3MeT5vCtuKS26YWAwIfwwICOOyfogd
        0BMmB+3jD0Gds58JTDryFxqCU9w4ThyqIIc0unCQnNqfhBQIxvoExyna0dnXd8bL
        Gj8/WD02qcc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35C7398865;
        Mon, 18 Jan 2021 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B84D098864;
        Mon, 18 Jan 2021 17:45:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com
Subject: Re: [PATCH RESEND] refs: Always pass old object name to reftx hook
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
        <ae5c3b2b783f912a02b26142ecd753bf92530d2f.1610974040.git.ps@pks.im>
Date:   Mon, 18 Jan 2021 14:45:30 -0800
In-Reply-To: <ae5c3b2b783f912a02b26142ecd753bf92530d2f.1610974040.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 18 Jan 2021 13:49:05 +0100")
Message-ID: <xmqq4kjdkgol.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE09DD6A-59DE-11EB-B49C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Inputs of the reference-transaction hook currently depends on the
> command which is being run. For example if the command `git update-ref
> $REF $A $B` is executed, it will receive "$B $A $REF" as input, but if
> the command `git update-ref $REF $A` is executed without providing the
> old value, then it will receive "0*40 $A $REF" as input. This is due to
> the fact that we directly write queued transaction updates into the
> hook's standard input, which will not contain the old object value in
> case it wasn't provided.

In effect, the user says "I do not care if this update races with
somebody else and it is perfectly OK if it overwrites their update"
by not giving $B.

> While this behaviour reflects what is happening as part of the
> repository, it doesn't feel like it is useful. The main intent of the
> reference-transaction hook is to be able to completely audit all
> reference updates, no matter where they come from. As such, it makes a
> lot more sense to always provide actual values instead of what the user
> wanted. Furthermore, it's impossible for the hook to distinguish whether
> this is intended to be a branch creation or a branch update without
> doing additional digging with the current format.

But shouldn't the transaction hook script be allowed to learn the
end-user intention and behave differently?  If we replace the
missing old object before calling the script, wouldn't it lose
information?

The above is not an objection posed as two rhetoric questions.  I am
purely curious why losing information is OK in this case, or why it
may not be so OK but should still be acceptable because it is lessor
evil than giving 0{40} to the hooks.

Even without this change, the current value the hook can learn by
looking the ref up itself if it really wanted to, no?
