Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F99C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 00:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJJA4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 20:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJAz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 20:55:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE5DDC
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 17:39:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7CB11B7E4D;
        Sun,  9 Oct 2022 20:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oEW14jHIfMJf
        p/sfL+VPdNgUXcFf/HzT0kBAmju3kEU=; b=SKkMth3uFQE8oAY4gcy/PYIpkwPu
        M6iMLc2V1fQqxor43tLbarUhKCHS/rdFNdcjCSX99F8Vyr4i1ZlG8meQ/Wsrs4Mc
        iS7ByOtZiedbhK2IrL4IxlBnNoFLa0nWaJnQphucV3QOX1BG+2lrGUE/4BJrqser
        9LJx3ac1PmMamb8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF58B1B7E4A;
        Sun,  9 Oct 2022 20:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 064541B7E49;
        Sun,  9 Oct 2022 20:38:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
        <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com>
        <xmqqa6647qx2.fsf@gitster.g>
        <dacb1f40-2765-5978-1131-f78ba919e6e6@gmail.com>
Date:   Sun, 09 Oct 2022 17:38:41 -0700
In-Reply-To: <dacb1f40-2765-5978-1131-f78ba919e6e6@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 9 Oct 2022 23:26:56 +0200")
Message-ID: <xmqq4jwc5x7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4605104-4833-11ED-9092-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Mmm, I don't feel the same here, we already discussed about this. Maybe=
?:
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 17853225fa..307073cc47 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -817,7 +817,8 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>                 strbuf_release(&branch_ref);
>                 strbuf_release(&buf);
> =20
> -               return ret;
> +               if (ret)
> +                       return ret; /* some failure happened */
>         } else if (copy) {
>                 if (!argc)
>                         die(_("branch name required"));

Before the above change, the body of the "else if" clause for the
option was self contained.  With the above change, the reader has to
follow to the end of the long top-level cascade to see the rest of
the function does not do anything funny.

If we have a big common clean-up after each operation, then, falling
through in the success case might be good, but that is not what I am
seeing here.  So...

