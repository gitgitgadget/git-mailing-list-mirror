Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BAAC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7171364DEC
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhA1V7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:59:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53696 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhA1V7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 16:59:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31470FA8BA;
        Thu, 28 Jan 2021 16:58:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0hG95UMn7gKH1ss26u5xO9enRr4=; b=j6iTtf
        r82SVGkrT0iNBK78k/7Ya8CleLwHsMg74B8V4ZbdXqVAseNR1+iLve+HOJKO/ijr
        hpU5uoKd2FdkIOksJB2F0H048wtBx6yT1685C4W8Mu6rWozlnK4wWU2YKPqgAf4G
        aJ68NrVROYLnTIH315ivJSr3f/DUDt35U9GQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gagDnwTGS7y2j2sCGradlbo9+qBiHpt/
        S19C/eYMgGB4Mu1skLFyjJwG/5VGRX8E4IBoZloUtPrAVHI03CpjEVyT8V+39OLE
        oN9pjhmSn1RRCmUoXJqnfmhYZKqzfo5PKgo4XUY7ujsv3IfQ9PGh2KKR3CyXTQra
        FzDHVeyAaeE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28E81FA8B8;
        Thu, 28 Jan 2021 16:58:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 216B2FA8B7;
        Thu, 28 Jan 2021 16:58:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4] upload-pack.c: fix filter spec quoting bug
References: <YBCFBivBLgqEAUr1@coredump.intra.peff.net>
        <20210128160453.79169-1-jacob@gitlab.com>
        <xmqqmtwsx4d9.fsf@gitster.c.googlers.com>
        <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
Date:   Thu, 28 Jan 2021 13:58:20 -0800
In-Reply-To: <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
        (Jacob Vosmaer's message of "Thu, 28 Jan 2021 22:12:42 +0100")
Message-ID: <xmqqpn1ovi4j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F02E0D7C-61B3-11EB-9968-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> As a reader looking at t5544, unless I know the backstory of the bug,
> I do not understand why --filter gets a test but those other things do
> not.

Good point.  Perhaps a retitle of the test or a bit of comment would
benefit future readers.


# git clone internally has to invoke upload-pack on the
# other end with multiple arguments, and it used to quote
# them incorrectly only when hooks are enabled.
test_expect_success 'hook works with partial clone' '
	clear_hook_results &&
	test_config_global uploadpack.packObjectsHook ./hook &&
	test_config_global uploadpack.allowFilter true &&

	git clone --bare --no-local --filter=blob:none . dst.git &&
	git -C dst.git rev-list --objects --missing=print HEAD >objects &&
	grep "^?" objects
'

But that may be overkill.  Those curious can run "git blame" to go
back to what you wrote in the log message, and that should be clear
enough for them why we care about this case.

And from that point of view, it may be sufficient that the resulting
repository lacks "some" objects and not necessarily check what are
missing.

Thanks.
