Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81662047F
	for <e@80x24.org>; Mon,  7 Aug 2017 23:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdHGXCd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 19:02:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51652 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751826AbdHGXCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 19:02:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C399A2303;
        Mon,  7 Aug 2017 19:02:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fOdc5NPNDr5JoaOnJVkcl5YUUFg=; b=dDnyx2
        KwbSp2Ntvj7f+7X31zH4LbhD98CTWAdhzfSVTBsY5Rf234BcOC32UeNXqIa9ZlfZ
        IvOhUqqxZpO8JVH6GgBZHFZzHR0elU6kPfpjUzPP1Xm4jpiBtbNUcJ8JGUy34kEc
        jw75S/+KF9EoebZ7kNOVtIf6BDOnJ99XwGEGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xh6bF1HS0YsUWpYF3YPnFtmsNiOwSdDA
        MLd5u011ttboj3CbDw57PqoQi1IQZ5Ka3ONtjrtHJEU9pSHerJy7OeAOpMrunf+U
        iY90fyLcmWNyQNp+NFo7tqkIzsRGTo1Ag7zpqyaeDGiBK1LexO82Pen049D+3oKO
        JDpZ5fcBj/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 753D8A2302;
        Mon,  7 Aug 2017 19:02:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D92DCA2300;
        Mon,  7 Aug 2017 19:02:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
        <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1708072136290.4271@virtualbox>
        <xmqqshh3p3b0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1708072307410.4271@virtualbox>
        <xmqqwp6fnjpg.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 07 Aug 2017 16:02:23 -0700
In-Reply-To: <xmqqwp6fnjpg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 07 Aug 2017 14:36:59 -0700")
Message-ID: <xmqqzibbm16o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A04B03E-7BC4-11E7-9735-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This is not about where the bar is set.  It is about expectation....

After having thought about this a bit more, I think in the message I
am responding to I mischaracterised the aspect of a patch that
influences the "expectation".  It is much less about who the
contributor is but more about what the patch does.  

If the patch in question were from a more experienced contributor
(like you or Peff), my internal reaction would have been "gee, the
submitter should have known better that a more complete fix should
involve a larger integral type, not stopping at matching the largest
type that happens to be used in the interface without updating the
interface".

But I still would have said that the patch is an improvement--as it
indeed is; it does not make things worse anywhere and brings in a
more consistency.  And I still would have mentioned the same "in the
longer term, we would want to use size_t or uintmax_t here, not just
ulong".

The only thing I would have done differently if the submission were
by a more experienced contributor is that I probably would have
added "yes this may be an improvement, but I expected you should
know better to at least mention the longer term direction to use
size_t or uintmax_t in the log message, even if you didn't
immediately extend this patch into a more complete series".

That one is a difference of expectation between an occasional
contributor and an experienced one.
