Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B3ECA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349178AbjIKVcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbjIKTNG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 15:13:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B80F9
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 12:13:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAD681AACE5;
        Mon, 11 Sep 2023 15:12:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yHlvQkEOE0SY
        2PwbknfuUuzco/26l5u68Y1tQK17qxk=; b=gxVxEZbDgpdb5o1yqBQIEt7GVTKe
        x6rS5qhY88qP8eaTn1QN0GcS3DQjOMtS7Ol+4B/PWDg/wowujfqr8bHXqbjp3dPt
        EqKVimpXtlh+/b4J6fAJYhQbsP5roZEagxrv7AH5H700mquE8OBNdXht4S6OVE7x
        Ja0C24Npx4zZVC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C17DE1AACE4;
        Mon, 11 Sep 2023 15:12:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38C631AACE3;
        Mon, 11 Sep 2023 15:12:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
In-Reply-To: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 9 Sep 2023 23:14:20 +0200")
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
        <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
Date:   Mon, 11 Sep 2023 12:12:55 -0700
Message-ID: <xmqqedj4v808.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 36CA5C12-50D7-11EE-972F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Some uses of OPT_CMDMODE provide a pointer to an enum.  It is
> dereferenced as an int pointer in parse-options.c::get_value().  These
> two types are incompatible, though -- the storage size of an enum can
> vary between platforms.  C23 would allow us to specify the underlying
> type of the different enums, making them compatible, but with C99 the
> easiest safe option is to actually use int as the value type.
>
> Convert the offending OPT_CMDMODE users and use the typed value_int
> point in the macro's definition to enforce that type for future ones.

Interesting.  I wondered if this means that applying [1/2] alone
will immediately break these places that [2/2] fixes, but the answer
is no, as the previous step did not make these places use the typed
pointer.  But it also means that with this step alone to use "int",
instead of various "enum" types that can have representations that
are different from "int", would already "fix" the current code
while still casing back and forth from (void *)?

In any case, the two-patch series looks good, and it does not break
bisectability, either.

Thanks.
