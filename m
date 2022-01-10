Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9FEC433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 21:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbiAJVil (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 16:38:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59228 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244307AbiAJVik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 16:38:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD15D17FEE2;
        Mon, 10 Jan 2022 16:38:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPj/Wjq8H3mGD8+GA6cNPKSNUdAGhHaYRkRc4E
        Xvpo8=; b=s2GGTpzOCFs1aHi7lkB5yXKmpE1kG1i5Kp6/Cg8oEnmXx7HlkZuqU8
        vOXluj1VzQkn3jscTVmn6XWvhrZiJNYj11uSFlWQu3Rib4gDvn+ccesKefex8Hag
        vmmFic8oNpGuB6TxaZv9WfZx26ZqlwPRkp7ZMdbub3Vzv82rEibSo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D21D417FEE1;
        Mon, 10 Jan 2022 16:38:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50DC817FEDE;
        Mon, 10 Jan 2022 16:38:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] fmt-merge-msg: prevent use-after-free with signed tags
References: <YdxqshqXB/+ApOn2@nand.local>
        <6e08b73d602853b3de71257117e85e32b96b5c19.1641849502.git.me@ttaylorr.com>
Date:   Mon, 10 Jan 2022 13:38:36 -0800
In-Reply-To: <6e08b73d602853b3de71257117e85e32b96b5c19.1641849502.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 10 Jan 2022 16:19:06 -0500")
Message-ID: <xmqqsftvxodf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB522ED4-725D-11EC-9FB6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When merging a signed tag, fmt_merge_msg_sigs() is responsible for
> populating the body of the merge message with the names of the signed
> tags, their signatures, and the validity of those signatures.
>
> In 02769437e1 (ssh signing: use sigc struct to pass payload,
> 2021-12-09), check_signature() was taught to pass the object payload via
> the sigc struct instead of passing the payload buffer separately.
>
> In effect, 02769437e1 causes buf, and sigc.payload to point at the same
> region in memory. This causes a problem for fmt_tag_signature(), which
> wants to read from this location, since it is freed beforehand by
> signature_check_clear() (which frees it via sigc's `payload` member).
>
> That makes the subsequent use in fmt_tag_signature() a use-after-free.

Very clearly described.

> As a result, merge messages did not contain the body of any signed tags.
> Luckily, they tend not to contain garbage, either, since the result of
> strstr()-ing the object buffer in fmt_tag_signature() is guarded:
>
>     const char *tag_body = strstr(buf, "\n\n");
>     if (tag_body) {
>       tag_body += 2;
>       strbuf_add(tagbuf, tag_body, buf + len - tag_body);
>     }
>
> Unfortunately, the tests in t6200 did not catch this at the time because
> they do not search for the body of signed tags in fmt-merge-msg's
> output.
>
> Resolve this by waiting to call signature_check_clear() until after its
> contents can be safely discarded. Harden ourselves against any future
> regressions in this area by making sure we can find signed tag messages
> in the output of fmt-merge-msg, too.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

Will fast-track.  Thanks.
