Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42B8C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 20:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348262AbiEZUml (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349033AbiEZUmc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 16:42:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DA617F
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:42:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7C111383A2;
        Thu, 26 May 2022 16:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hbc3dnnvFjza
        l9QCQZag8ZeIugEo+/qcmTE0eq8bsF0=; b=LYps6ndlrP+/urkpfK0vMRPQI2y8
        FxLGSo7EFvuoyXOCpj+w3wcTki+NE5gfawEV4NiLseRxjv6Ufnj5zU6aMWx2L7ds
        WMUlOeGEqKEgMQiLMiNaZGskDipTpIMjholmKnhQgDqyjYZxQMm4hg6uWHYg4E3S
        F/h1WyhsjlZd7K4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93A731383A1;
        Thu, 26 May 2022 16:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 077691383A0;
        Thu, 26 May 2022 16:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] rebase: help users when dying with `preserve-merges`
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <d0fb54105940f19809eeb5d5e156bf3889d16b0c.1653556865.git.gitgitgadget@gmail.com>
        <220526.867d687hd5.gmgdl@evledraar.gmail.com>
        <00229772-f075-0b0c-7810-7debf6b971bc@iee.email>
Date:   Thu, 26 May 2022 13:42:19 -0700
In-Reply-To: <00229772-f075-0b0c-7810-7debf6b971bc@iee.email> (Philip Oakley's
        message of "Thu, 26 May 2022 12:44:49 +0100")
Message-ID: <xmqq1qwgxbys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57129092-DD34-11EC-B153-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>>> Make the `rebase --abort` option available to allow users to remove
>>> traces of any preserve-merges rebase, even if they had upgraded
>>> during a rebase.

This patch does not make it "available", though. =20

	Suggest using `--abort` to get out of the situation after a
	failed preserve-rebase and remove traces of ...

perhaps?

I do think the suggestion is worth doing if a user ever gets into
the situation, but how likely does it happen?  A user has to start
"rebase -p" with older Git, wait until Git gets updated to a future
version of Git that includes this change, and then say "rebase -p
--continue"?

>>>  	} else if (is_directory(merge_dir())) {
>>>  		strbuf_reset(&buf);
>>>  		strbuf_addf(&buf, "%s/rewritten", merge_dir());
>>> -		if (is_directory(buf.buf)) {
>>> -			die("`rebase -p` is no longer supported");
>>> +		if (is_directory(buf.buf) && !(action =3D=3D ACTION_ABORT)) {
>>> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
>>> +			"Use `git rebase --abort` to terminate current rebase.\n"
>>> +			"Or downgrade to v2.33, or earlier, to complete the rebase.\n");
>>>  		} else {
>>>  			strbuf_reset(&buf);
>>>  			strbuf_addf(&buf, "%s/interactive", merge_dir());
>> Existing issue: No _(), shouldn't we add it?
> This `strbuf_addf` is forming a path for internal use. It just happens
> to look like legible English ;-)

I do not think =C3=86var meant "%s/interactive"; the enhanced message
above that you inherited from the original "no longer supported"
that was not marked for translation.

>> I wonder if we should use die_message() + advise() in these cases,
>> i.e. stick to why we died in die_message() and have the advise() make
>> suggestions, as e4921d877ab (tracking branches: add advice to ambiguou=
s
>> refspec error, 2022-04-01) does.
>
> Ah, maybe it's my message.. that needs translating.

Yup.

This whole '-p' business will go away in a few releases down, so a
longer message give to the existing die() should be sufficient and
there is no need for the choice between "yes, I am still weaning
myself off of rebase -p and want to keep seeing the advice" and
"thanks, I saw the message often enough, you no longer need to tell
me how to get out", I would think.

Thanks.
