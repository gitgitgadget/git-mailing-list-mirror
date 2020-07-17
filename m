Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B2C433E3
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E581F20737
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lFfxdvV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGQQyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:54:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54300 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgGQQyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 12:54:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F377F6A2FD;
        Fri, 17 Jul 2020 12:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X+gm1zIgotAxBFzSGbgesarmAHk=; b=lFfxdv
        V6ZKPECtwho5ubCgUFTm8jIqeVPkFTIE5HnPWxTHLRURoeVwLVi3kstEBNFwkt2b
        ETfAPNGnq47nilIK8/WwjW3/Xjt6681NO9y14CZJkl7wtcGJC3W6Vh6qkItCg6H8
        ELF9zJEk80us4GMu2otv/OGUxJevfDfV9R0i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AVmLQ8awMfXhiWZFgfzgIsxn599zKOv3
        k+p6SQQa8ddt+IktwxopATZ+N0r2fdW0stJGZvxpbeqnIkPrKcLd6KTwatStMOgn
        Tv22ijdJRo9XNilyOlCVHcRNbLZteok+NyhU5/iD/P+TEt7d4B+eJNG7XbcTdfIA
        0v8XJbqtxL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA1C06A2FC;
        Fri, 17 Jul 2020 12:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78D4E6A2FB;
        Fri, 17 Jul 2020 12:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v5 06/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
References: <20200717105406.82226-1-mirucam@gmail.com>
        <20200717105406.82226-7-mirucam@gmail.com>
Date:   Fri, 17 Jul 2020 09:54:31 -0700
In-Reply-To: <20200717105406.82226-7-mirucam@gmail.com> (Miriam Rubio's
        message of "Fri, 17 Jul 2020 12:53:59 +0200")
Message-ID: <xmqqv9imdquw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3082EA5A-C84E-11EA-8060-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_next()` and the `bisect_auto_next()` shell functions
> in C and add the subcommands to `git bisect--helper` to call them from
> git-bisect.sh .
>
> bisect_auto_next() function returns an enum bisect_error type as whole
> `git bisect` can exit with an error code when bisect_next() does.
>
> Using `--bisect-next` and `--bisect-auto-next` subcommands is a
> temporary measure to port shell function to C so as to use the existing
> test suite. As more functions are ported, `--bisect-auto-next`
> subcommand will be retired and will be called by some other methods.
> ...
> +static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
> +{
> +	int no_checkout;
> +	enum bisect_error res;
> +
> +	bisect_autostart(terms);
> +	if (bisect_next_check(terms, terms->term_good))
> +		return BISECT_FAILED;
> +
> +	no_checkout = file_exists(git_path_bisect_head());

The ref API is getting updated so that the 40-hex files whose names
are all capital and ends with _HEAD are being converted from "files
that happen to record 40-hex" to "refs that live at the toplevel
outside refs/ hierarchy".  Checking with

	no_checkout = ref_exists("BISECT_HEAD");

would work in both old and new worlds, hopefully.

Similarly, if the new code you are writing reads directly from
git_path_bisect_head(), write into it, or unlink it, these accesses
should be replaced with calls to refs API (e.g. you already do so in
your bisect_state() helper where you use get_oid() on the refname,
not read from the file).

Please learn to pay attention to your surroundings, or you risk
colliding into other topics in flight.

Thanks.
