Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551BAC433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 23:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3421E20878
	for <git@archiver.kernel.org>; Sun, 24 May 2020 23:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BlxDLS9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbgEXXSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 19:18:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52198 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbgEXXSm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 19:18:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89708D3932;
        Sun, 24 May 2020 19:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K8iox4zaV++2zzxwhxccw4HIkUA=; b=BlxDLS
        9zn+6+WSmUg1GHdiJQZr/OutnvUiR73pmhLHqrR66DIAgIKxbqQbCZP6ChUF0iRK
        /gpfYatHAYNm7ivnzJnRenA49cjvjREAhmjSwculVxVksVgdy3uZpyVRY9R1bBzM
        K24kiVjvs199a6fIkkYDYIPTJK7/Cr80pNxGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SvNkr601Rc1DsRMBWh2OrkFJxc3b2uyx
        jwzfe55XnfxPV3RvkdqlTRLsy20cy97svpEpaUDIZMYld7D3/O7yw77YvD4K/HUw
        +TXs5/Wk8f83J7yIzpdwO/Bmh66sfChv01RjE0ETY93GH38Z37OssxTF6Pm5HhBF
        LmibliAF2W4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F7D4D3931;
        Sun, 24 May 2020 19:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C71EDD3930;
        Sun, 24 May 2020 19:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        congdanhqx@gmail.com, sunshine@sunshineco.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell to C
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
        <nycvar.QRO.7.76.6.2005230012090.56@tvgsbejvaqbjf.bet>
        <xmqqtv05orgq.fsf@gitster.c.googlers.com>
Date:   Sun, 24 May 2020 16:18:36 -0700
In-Reply-To: <xmqqtv05orgq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 24 May 2020 16:15:01 -0700")
Message-ID: <xmqqpnasq5v7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5B0EA08-9E14-11EA-B8A0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> +	config_set_in_gitmodules_file_gently(config_name, opt_branch);
>>
>> What happens if this fails? E.g. when the permission is denied or disk is
>> full? This C code would then still `return 0`, pretending that it
>> succeeded. But the original shell script calls `git submodule--helper
>> config [...]` which calls `module_config()`, which in turn passes through
>> the return value of the `config_set_in_gitmodules_file_gently()` call.
>>
>> In other words, you need something like this:
>>
>> 	int ret;
>>
>> 	[...]
>>
>> 	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
>>
>> 	free(config_name);
>> 	return ret;
>
> Making sure we check the return value of helper functions we call is
> a good discipline,...

By the way, another topic by you for set-url has exactly the same
issue.  Its call to config_set_in_gitmodules_file_gently() can fail.

So can the call to sync_submodule(), but when it fails it won't come
back, so we do not have to worry about not capturing its return
value ;-)

