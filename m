Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0032C71153
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjIBWhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjIBWhE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:37:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA0D1A7
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:37:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B89F2B141;
        Sat,  2 Sep 2023 18:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=yg5lMM9gryQrWlb1mq8uxSNnNINFV5YHnPD9vu
        4Vt8M=; b=R/F9rpLm/3swDXnIrfw3X12nvafXFn2P3V+kGEdEmpavrELuy34gVx
        2e7bY7glDpzurfK0hKSBfxhrr+q17glYpJ2cr+wzwLvs4pNBrZWNRQjA7Gg2jPLD
        2I4dspjPYGXZ47GQTXaA5Z7HWsJvhW37z/9mHkQKnlXmmI+RN32vs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8502F2B140;
        Sat,  2 Sep 2023 18:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 330342B13E;
        Sat,  2 Sep 2023 18:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley <wesleys@opperschaap.net>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <fa702b47-ae29-4299-9226-4920620b9fff@opperschaap.net> (Wesley's
        message of "Fri, 1 Sep 2023 21:35:33 -0400")
References: <20230819203528.562156-1-wesleys@opperschaap.net>
        <20230819203528.562156-2-wesleys@opperschaap.net>
        <6127b570-5e9b-404f-9802-9135a1c9f31f@gmail.com>
        <a168fe69-f305-4280-b0e6-9406fbac796f@opperschaap.net>
        <xmqqledppxw3.fsf@gitster.g>
        <fa702b47-ae29-4299-9226-4920620b9fff@opperschaap.net>
Date:   Sat, 02 Sep 2023 15:36:57 -0700
Message-ID: <xmqqo7ikkxrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39DBA76E-49E1-11EE-A979-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley <wesleys@opperschaap.net> writes:

> On 9/1/23 14:10, Junio C Hamano wrote:
>> Wesley <wesleys@opperschaap.net> writes:
>> 
>>> The quirk is this: --fork-point looks at the reflog and reflog is
>>> local. Meaning, having an remote upstream branch will make
>>> --fork-point a noop. Only where you have an upstream which is local
>>> and your reflog has seen dropped commits it does something.
>> Why do you lack reflog on your remote-tracking branches in the first
>> place?
>
> I do not know? I tested with a bare repo and two clones. And I also
> tested it with just a remote upstream in another branch.

IIRC, a non-bare repository (i.e. with working tree) should get
core.logallrefupdates set to true by default, so all your refs, not
just local and remote-tracking branches, should have records.

> I haven't force pushed anything btw, maybe that could explain things?

If your "remote" is never force-pushed, then the movements of refs
at the remote (which you will observe whenever you fetch from it)
will always fast-forward, and the remote-tracking branches in your
local repository that keeps track of the movement will also record
the fast-forwarding movement in the reflog.  But then there is no
need for the fork-point heurisitics to trigger, and even if it
triggered the heuristics would not change the outcome, when rebasing
against such a remote branch, as their tip will always a decendant
of all commits that ever sat at the tip of that remote branch.

