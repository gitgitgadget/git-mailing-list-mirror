Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0303C77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEQQUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEQQUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:20:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CD2AD06
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:20:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37A53196DDD;
        Wed, 17 May 2023 12:20:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3emKV4FwaagajfutXuRaMRgteuB01oaN72T9Ux
        8A1r4=; b=IimjCk1tAHmlDHuvr6wwnHKFCxItnQ6zqoROV6feyxLnpPjfcAy5/M
        vFlNO4VZ2U1P7EQ0VhEpdSVnEL/Jfqs09siiYaPqgc9nBlYHkjhytekKM64q/Mc+
        OvRWH0mQh78W02YsucuH5PlLtCS5OMxGKhAUXvWuUnbwbaNeblCKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24407196DDC;
        Wed, 17 May 2023 12:20:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F9B8196DDB;
        Wed, 17 May 2023 12:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
Date:   Wed, 17 May 2023 09:19:58 -0700
In-Reply-To: <ZGT6fEZFumAsZnxu@nand.local> (Taylor Blau's message of "Wed, 17
        May 2023 12:02:04 -0400")
Message-ID: <xmqqilcrq6a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB57A0B8-F4CE-11ED-9D1B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, May 17, 2023 at 08:49:37AM -0700, Junio C Hamano wrote:
>> Christian Hesse <list@eworm.de> writes:
>>
>> > From: Christian Hesse <mail@eworm.de>
>> >
>> > We use xstrfmt() here, so let's include the header file.
>> >
>> > Signed-off-by: Christian Hesse <mail@eworm.de>
>> > ---
>> >  imap-send.c | 1 +
>> >  1 file changed, 1 insertion(+)
>>
>> Puzzled.  For me Git 2.41-rc0 builds as-is without this change just
>> fine, it seems.
>
> It will fail to build for ancient versions of curl (pre-7.34.0, which
> was released in 2013), or if you build with `NO_CURL=1`.

xstrfmt() is used at exactly one place, inside "#ifndef NO_OPENSSL",
in the implementation of the static function cram().

Ah, the mention of that function was a huge red herring.  There are
tons of strbuf API calls in the file outside any conditional
compilation, and where it inherits the include from is "http.h",
that is conditionally included.

OK, so the fix seems to make sense, but the justification for the
change needs to be rewritten, I think.

    We make liberal use of the strbuf API functions and types, but
    the inclusion of <strbuf.h> comes indirectly by including
    <http.h>, which does not happen if you build with NO_CURL.

or something like that?

Thanks.
