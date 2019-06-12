Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD83B1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 17:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407698AbfFLR0I (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 13:26:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56412 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406395AbfFLR0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 13:26:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C2126FA4D;
        Wed, 12 Jun 2019 13:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CJuOctpQb5lN
        FYpGkXs9mOGhTLA=; b=Jk2EWT630N74CGXMYioZ8Pvo1w6W5jErtfOjAWCQaLZ3
        xnWUcILoaU9veH1rI6FCN7u2MC3Ewm8j2Eac1tvLzDgyZXdjPJ0pU1m410LHq3un
        OXYyip4RZnX0OrcFR4FiMWh5bxr9mOsDRITJtFra7EriQsCiDsD+JQC1ExQkTh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=J21eE+
        iojbzPuqW7Prmw55cK17+iBQKxBQ+aNRZs2Fh9wyFA/VtRKt8c5usdIh7UtDuVJB
        nL0m3kVpoqERmSlKmzcP5V8YC8yTZYf72L/MDiGbOcAUsBF39niQDI96xOtKkOWK
        nM45+BCerVWQ4KUENxTecmBVORBENYAykA1mY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 248BF6FA4C;
        Wed, 12 Jun 2019 13:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BF8A6FA48;
        Wed, 12 Jun 2019 13:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Scott Johnson <scott.johnson@arilinc.com>
Cc:     git@vger.kernel.org
Subject: Re: push.recurseSubmodules=check doesn't consider tags
References: <62F6F2E3-FAED-4EE9-BDB8-D484252A845F@arilinc.com>
Date:   Wed, 12 Jun 2019 10:26:01 -0700
In-Reply-To: <62F6F2E3-FAED-4EE9-BDB8-D484252A845F@arilinc.com> (Scott
        Johnson's message of "Tue, 11 Jun 2019 19:04:40 -0700")
Message-ID: <xmqqef3yk95i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27481F6C-8D37-11E9-B183-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Scott Johnson <scott.johnson@arilinc.com> writes:

> I occasionally rebase my submodules. I realize the danger (historical s=
ubmodule pointers could point to commits that get garbage-collected away)=
 so I always create and push a tag before the rebase, to make sure the ol=
d commits will never get purged. I believe this is safe, based on some ex=
periments I=E2=80=99ve run.
>
> The issue: I set the config var push.recurseSubmodules=3Dcheck, and
> it seems to insist on having a branch and not merely a tag.

I suspect that this is pretty much by design.

When deciding if it needs a push in a submodule repository,
submodule.c::submodule_needs_pushing() gets called and asked to
check what is available at the remote without actually making a
connection to the other side.  It is done by looking at the
remote-tracking branches in the copy of the submodule repository we
have locally.  As there is no "remote-tracking tags" (iow, you
cannot tell from the output of "git -C submodule tag -l" if each of
the tags you have locally in your copy of the submodule exists in
another repository you push to and fetch from), this process does
not look at refs/tags/ hierarchy of your copy of the submodule
repository and that is quite deliberate, I would think.
