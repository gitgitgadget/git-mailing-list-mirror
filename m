Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9165CCA47C
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 17:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiGNRTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbiGNRTO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 13:19:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD094E630
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:19:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84ECA1A038A;
        Thu, 14 Jul 2022 13:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=m9N01MzcrvPw
        jJNnuINRdKjPNnK0+nvedNqInUbSIJc=; b=nltOdBpCj189CkY7hqmZfZtXUmYv
        ZfV3GRFm5IvJDq2FB0iOxePDKc1CORnh2/B1dIeSw/lM2SH86YUSQCb7yMlrxda0
        XGQmM5f6X9Foa+mDSalB5DBI7mzQtxBHQxKxL1eXzEAQXupwlW0WECR3BZhIAXvi
        ETRFvGxxPCmq8fc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D9801A0389;
        Thu, 14 Jul 2022 13:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2FBE71A0388;
        Thu, 14 Jul 2022 13:19:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 02/11] submodule--helper: replace memset() with { 0
 }-initialization
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
        <kl6lfsj4684n.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqy1wwaey8.fsf@gitster.g>
        <kl6lbkts63fb.fsf@chooglen-macbookpro.roam.corp.google.com>
        <220714.86v8s00y1z.gmgdl@evledraar.gmail.com>
Date:   Thu, 14 Jul 2022 10:19:08 -0700
In-Reply-To: <220714.86v8s00y1z.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 14 Jul 2022 12:25:42 +0200")
Message-ID: <xmqqbktr7gtv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 126922EA-0399-11ED-9C14-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It's curious that the { 0 } v.s. { NULL } form jumps out at people, but
> seemingly not that you don't memset(&x, NULL, ...). I.e. that we're
> already dealing with a form where C's "0 is NULL in pointer context"
> rules kick in :)

Strictly speaking there are different mechanisms at play here.
Literal "0" spelled in source code and assigned to a pointer
variable assigns a NULL to the variable even on architectures where
the representation of NULL is *not* "all 0-bit filling the width of
the variable" and C language is what guarantees "NULL pointer is
spelled as integer 0 in the source code".

Also, the language, not runtime and pointer representation, is how
second and subsequent members of a struct that are pointers are
initialized to NULL (not necessarily to "all 0-bit filling the width
of the member").

memset(&ptr, '\0', sizeof(ptr)), where ptr is a pointer variable or
a struct/union with a pointer member, on the other hand, is unaware
of how a NULL pointer is represented on the platform.  All it can
(and should) do is to fill the thing "ptr" with all 0-bit.  On an
exotic architecture, where NULL is not "all 0-bit filling the width
of the variable", I do not think it would work.

So from that point of view, using memset() as a replacement for zero
initialization is simply wrong, but in practice people do not work
on such a platform that the distinction matters anymore, hopefully?

> So I wonder if we should say anything about the first member at all.

The mention of the first member of the struct is historically
important only because some checkers like sparse used to complain
about

    struct { TYPE *member0; ... } var =3D { 0 };

the same way as

    char *string;
    string =3D 0;

before they got fixed so that they know about "{ 0 }" convention to
be silent about the former, while still warning about "even though C
language says literal 0 is a valid way to spell NULL, you shouldn't
do that" to the latter.

These days, we can safely write "{ 0 }" without having to worry
about the type of the first member.

