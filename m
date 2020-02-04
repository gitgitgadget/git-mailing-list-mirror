Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D4C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4592084E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OcX3M9R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgBDULa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:11:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60270 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgBDULa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:11:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAD3AA6071;
        Tue,  4 Feb 2020 15:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GlUvBcniosOroxJ3+gaXaYVMoGY=; b=OcX3M9
        R2sFBAy/1mqOyyvsKWRZKy6HBYzuzY9VFrD8DXqQ+GouyIFEkf3HQRc+uBHMEYkI
        M1l1bqwppjBzeGZcmXtHmk+FlYxAPTRIx4JdJQNJf0fPhnM9Fs6B78nskyQFW3JG
        P5ySwLHpLREQ8aV1JSmpwY3cQ6qBG4V9ud0P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UbnN5QA1l4uiYjyGSLlcIuZQWU1jzU68
        Tv63rKF+edQ2ZBK4MEQQx0ZkF03i+Hv3irEiXr7azLT5vPgvxDt6Lyb5pSD788rS
        lbP0DLa7k2kLrMQkH5e0L7Ci1xzhnwZMhT5SteZl5eQw7gWSgBWBptMjkIyidQD3
        C1wk3X7t1BA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCC11A6070;
        Tue,  4 Feb 2020 15:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA130A606E;
        Tue,  4 Feb 2020 15:11:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4] remote rename/remove: gently handle remote.pushDefault config
References: <04a8673c3cb80802ee20fa4376872cb5ee464264.1580549512.git.bert.wesarg@googlemail.com>
        <nycvar.QRO.7.76.6.2002021911260.46@tvgsbejvaqbjf.bet>
Date:   Tue, 04 Feb 2020 12:11:23 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002021911260.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 2 Feb 2020 21:54:31 +0100 (CET)")
Message-ID: <xmqqv9om6rkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 856CA0E6-478A-11EA-A4F7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	struct push_default_info* info = cb;
>> +	if (strcmp(key, "remote.pushdefault") || strcmp(value, info->old_name))
>> +		return 0;
>
> We will have to be careful to not segfault if a user has this in their
> config:
>
> 	[remote]
> 		pushDefault
>
> i.e. we have to insert `!value || ` before the call to `strcmp()`.

True.  The primary reader in remote.c::handle_config() uses
git_config_string() that complains that the variable is not bool,
but we should reat end-user input as something suspicious and
protect us against it.

> Concretely, I believe that the patched code will misbehave in this
> scenario:
>
> 	git config --global remote.pushDefault january
> 	git config remote.pushDefault february
> 	git remote rename january march

Good to see careful analysis.  Thanks.

>> +static void handle_push_default(const char* old_name, const char* new_name)
>
> That name probably wants to convey better that the push default is handled
> in the `mv`/`rm` commands here, not in any other command. Maybe
> `handle_modified_push_default_remote()`?

Also, the asterisk sticks to the variable not the type ;-)

>> +{
>> +	struct push_default_info push_default = {
>> +		old_name, CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };
>
> Personally, I would prefer the closing bracket to be on a new line,
> followed by an empty line to separate the variable declaration from the
> following statements.

Yes, yes.
