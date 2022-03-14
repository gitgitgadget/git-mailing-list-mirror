Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BFEC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 17:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbiCNRsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiCNRsh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 13:48:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E2DEBD
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 10:47:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0BC517948B;
        Mon, 14 Mar 2022 13:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4srj6VTb1VFA
        wGVN9YLovM7T22Sl3K9nbfskHO8PFVk=; b=K71WtRJnClNesvWDXRakTfSgEKI/
        X53UZGYRH/VN5SOqVTu0f+91Z3o89yHA06QPZOBY7Z4zvnzYIPOo1h3WDC4XPhKM
        6GrTWpxv261cjBuwKMOU5iolkBnKcQqSdGyUNvPfhY/dB2o4EO94NEc3LMKlSD0B
        KBauRUdpt7bRY7w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA01217948A;
        Mon, 14 Mar 2022 13:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 66208179489;
        Mon, 14 Mar 2022 13:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 05/16] fsmonitor--daemon: refactor cookie handling for
 readability
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
        <84df95be620c76afed73d1679722459e2ff32018.1647033303.git.gitgitgadget@gmail.com>
        <220314.86bky9ezdw.gmgdl@evledraar.gmail.com>
        <7ddeffc4-3442-b4a1-e6f4-e68b3aa3f5ec@github.com>
Date:   Mon, 14 Mar 2022 17:47:23 +0000
In-Reply-To: <7ddeffc4-3442-b4a1-e6f4-e68b3aa3f5ec@github.com> (Derrick
        Stolee's message of "Mon, 14 Mar 2022 10:49:18 -0400")
Message-ID: <xmqqo828s9xw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CE71FF7E-A3BE-11EC-A460-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/14/2022 4:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Mar 11 2022, Jeff Hostetler via GitGitGadget wrote:
>
>>> +	/*
>>> +	 * Technically, close() and unlink() can fail, but we don't
>>> +	 * care here.  We only created the file to trigger a watch
>>> +	 * event from the FS to know that when we're up to date.
>>> +	 */
>>> +	close(fd);
>>=20
>> It still seems odd to explicitly want to ignore close() return values.
>>=20
>> I realize that we do in (too many) existing places, but why wouldn't w=
e
>> want to e.g. catch an I/O error here early?
>
> What exactly do you propose we do here if there is an I/O error
> during close()?

We created the file to trigger a watch event, but now we have a
reason to suspect that the wished-for watch event may not come.

We only did so to know that when we're up to date.  Now we may never
know?  We may go without realizing we are already up to date a bit
longer than the reality?

How much damage would it cause us to miss a watch event in this
case?  Very little?  Is it a thing that sysadmins may care if we see
too many of, but there is nothing the end user can immediately do
about?  If it is, perhaps a trace2 event to report it (and other "we
do not care here" syscalls that fail)?



