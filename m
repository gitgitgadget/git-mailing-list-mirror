Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F0D2047F
	for <e@80x24.org>; Thu, 28 Sep 2017 04:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbdI1EM1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 00:12:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59847 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750731AbdI1EM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 00:12:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD91AB0684;
        Thu, 28 Sep 2017 00:12:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3kvzADBaGG5RXpxi9pQacFtTDpI=; b=vW+E5Z
        CWa3mIokBquPUIUIA9KJ+kdwVbetJtssOWoAxZueBI4toxiymhchoaph7bxDAfHG
        qkUHw7s71EAKcY5FHUVOiTyBAnwlwEv303tAS9JTIkdTuV0ULJ0VO9dlfed0hBRN
        iVJD5y2tIymBaKZtxuTV5MWX0XeFN2+LUNXl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SIPoXaX7nhlXUd2ZqFvfqQYsZZitQCPO
        GXWREr38K7eX5V9WFLhFeBnq9q/Ezm84CWDM45V/A9l8z2iTUVndUDB6WfmmLijz
        m4olnLC4+2wfESlMDm/PAa01pfALHdu0CDwuoDIAf69xeZaq5YGmYeLeJldOLbKv
        1N0G7GQX1wI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5531B0683;
        Thu, 28 Sep 2017 00:12:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 286B0B0682;
        Thu, 28 Sep 2017 00:12:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diffstat summary mode change bug
References: <CA+55aFzThd6cayUVuv39k=sb8KCphLkWGCV4n2HUjfn7Pxkd3g@mail.gmail.com>
Date:   Thu, 28 Sep 2017 13:12:23 +0900
In-Reply-To: <CA+55aFzThd6cayUVuv39k=sb8KCphLkWGCV4n2HUjfn7Pxkd3g@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 27 Sep 2017 11:15:04 -0700")
Message-ID: <xmqqd16b31i0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BB7177E-A403-11E7-8F22-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> and the reason seems to be that the '\n' at the end got dropped as the
> old code was very confusing (the old code had two different '\n' cases
> for the "show filename or not").
>
> I think the right fix is this whitespace-damaged trivial one-liner:
>
>   diff --git a/diff.c b/diff.c
>   index 3c6a3e0fa..653bb2e72 100644
>   --- a/diff.c
>   +++ b/diff.c
>   @@ -5272,6 +5272,7 @@ static void show_mode_change(struct
> diff_options *opt, struct diff_filepair *p,
>                           strbuf_addch(&sb, ' ');
>                           quote_c_style(p->two->path, &sb, NULL, 0);
>                   }
>   +               strbuf_addch(&sb, '\n');
>                   emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
>                                    sb.buf, sb.len, 0);
>                   strbuf_release(&sb);
>
> but somebody should double-check that.
>
>                         Linus

Thanks for being extra gentle by mentioning "old code was very
confusing", but it was not necessary.  We should have caught this
breakage during the review, but I somehow failed to spot it.  My
bad.

Thanks for a fix.
