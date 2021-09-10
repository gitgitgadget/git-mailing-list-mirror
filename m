Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88078C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 01:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6688960F02
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 01:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhIJBad (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 21:30:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56071 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhIJBa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 21:30:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B280142AD5;
        Thu,  9 Sep 2021 21:29:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/hToVYCagAKJ
        5FEG+nd9CcVMRh/WC4gyMDVX04SqLx0=; b=mSqzm5OmunQOPpMg4PDJwd8I3zs6
        f/3ZDwSrdYEAuuxVwCSVtvQfzc5wWIRs5QQ0nDHolFZx+jwLQJbd6KZyvmiLAyTu
        URR4mR4RTluAwb1yBUNYjPPIHUrf/uxwrnRJcbIjl8ZeZEhQHgYFZYXZhNjIbtic
        9EA5OCR3OcWvNik=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92749142AD3;
        Thu,  9 Sep 2021 21:29:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1052142AD2;
        Thu,  9 Sep 2021 21:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 3/9] pack-write: refactor renaming in finish_tmp_packfile()
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <35052ef494dbc55119614f3e22742d8d814b21b1.1631157880.git.me@ttaylorr.com>
        <xmqqk0jpzgxu.fsf@gitster.g> <YTp3rYqxLE5/X521@nand.local>
Date:   Thu, 09 Sep 2021 18:29:13 -0700
In-Reply-To: <YTp3rYqxLE5/X521@nand.local> (Taylor Blau's message of "Thu, 9
        Sep 2021 17:07:57 -0400")
Message-ID: <xmqqa6klw74m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 825BC3CE-11D6-11EC-9E84-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> =C3=86var makes a slight mention of this in their commit message:
>
>     This approach of reusing the buffer does make the last user in
>     pack-object.c's write_pack_file() slightly awkward, since we
>     needlessly do a strbuf_setlen() before calling strbuf_release() for
>     consistency. In subsequent changes we'll move that bitmap writing
>     code around, so let's not skip the strbuf_setlen() now.
>
> And this is to set us up for the final patch which moves the call to
> rename_tmp_packfile_idx(&tmpname, &idx_tmp_name) after the closing brac=
e
> in the quoted portion of your message and the strbuf_release(). There,
> we'll want the strbuf reset to the appropriate contents and length, and
> not released.
>
> But in the meantime it is awkward.

That is why I said "adding setlen only when t starts to matter may
make it easier to follow".  It won't make it awkward at this step,
and it will make it stand out why it is needed when it is added,
presumably at the very end, when rename_tmp_packfile_idx() call is
added after this if() block.



