Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F85C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 22:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiEWWht (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEWWhs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 18:37:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316119CF5D
        for <git@vger.kernel.org>; Mon, 23 May 2022 15:37:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94AAC17863B;
        Mon, 23 May 2022 18:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nasOy+Wcjysk
        HdbZ5b7Oqre7OR8rNwscv46IzPS6F50=; b=XA1p3zLKgQx69zJDO2JQ0wLVYrX2
        4Y7ihB3pJfPRFtsk/oIqWMdI5aOp9F83uqVJozAAr7DJS/D+5Pt3iwZqnpnUg/i4
        rKkG6fP1Li2RlbbLrp9W/IH8V1Tu7hF3WMg4VvXatV0uZ/AjDhsSBqcOPLJ1PwCF
        IJlPEHsI6lwYFBY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C6E217863A;
        Mon, 23 May 2022 18:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 303B7178639;
        Mon, 23 May 2022 18:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <220523.86wnecxqol.gmgdl@evledraar.gmail.com>
Date:   Mon, 23 May 2022 15:37:39 -0700
In-Reply-To: <220523.86wnecxqol.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 23 May 2022 15:45:26 +0200")
Message-ID: <xmqqy1yrnado.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F491D074-DAE8-11EC-AE33-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +		if (!opts->commit_use_reference) {
>> +			strbuf_addstr(&msgbuf, "Revert \"");
>> +			strbuf_addstr(&msgbuf, msg.subject);
>> +			strbuf_addstr(&msgbuf, "\"");
>> +		} else {
>> +			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
>
> Having seen how people use git in the wild, this *WILL* result in a
> bunch of history where people don't edit that at all.

It was done very much on purpose.  A pressure from other project
participants against the ugly all caps content-free message will
help instill better behaviour.  A solo developer also will learn
after making reverts with content-free titles (and if they do not
find it inconvenient for their development purpose that their
history is full of content-free titles shouting in all caps, then
more power to them---if they are happy, we are happy, too).

If we leave something like

	# Add one line above and explain not *what* this revert did,
	# but *why* you decided to revert in 50-70 chars.  Did it
	# break something? Was it premature?

	This reverts commit 8aa3f0dc (CI: set CC in MAKEFLAGS directly, 2022-04-=
21)

presumably, stripspace will make the "This reverts commit ..." the
title of the reverted commit.  It would invite people not to edit it
out out of laziness.  Since the whole point of this change is to
encourage people to describe the reason behind the revert on the
subject line, such an invitation is counter-productive.

Doing the first two lines like so:

	Revert 8aa3f0dc (CI: set CC in MAKEFLAGS directly, 2022-04-21)
	# Edit the above line to explain not *what* this revert did,

would have pretty much the same effect, I am afraid.

So...
