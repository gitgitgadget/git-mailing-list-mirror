Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C6C433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 23:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DD660EE9
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 23:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhJWXPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 19:15:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61467 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhJWXPs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 19:15:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C106EA0F2;
        Sat, 23 Oct 2021 19:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JwBtQL2K+dD085nOTV+qjJFhXBAaO3457YLSXm
        Xgc/o=; b=I+LrtTmNvTUrW+MrLcaXfgMoX3lCRMKfcCWaoZGPl+mNRFNKdK+1Cq
        H3jOycl8r6Whb/xB4MFJS/GjEsDGf3xFRrpE6fsnhRRxEOiiC7Q/zb7GlRcFVtFG
        T3pNNLisnvf6b/cyLjalHaJDUhmGtg1+SCvTiXGNOwoQZALKpNccw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E71F1EA0F0;
        Sat, 23 Oct 2021 19:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 507F3EA0EE;
        Sat, 23 Oct 2021 19:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, "Han-Wen Nienhuys" <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Hans Jerry Illikainen" <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Gwyneth Morgan" <gwymor@tilde.club>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Josh Steadmon" <steadmon@google.com>
Subject: Re: [PATCH 1/6] ssh signing: extend check_signature to accept
 payload metadata
References: <20211022150949.1754477-1-fs@gigacodes.de>
        <20211022150949.1754477-2-fs@gigacodes.de>
Date:   Sat, 23 Oct 2021 16:13:26 -0700
In-Reply-To: <20211022150949.1754477-2-fs@gigacodes.de> (Fabian Stelzer's
        message of "Fri, 22 Oct 2021 17:09:44 +0200")
Message-ID: <xmqqfssr8hd5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D431AEE6-3456-11EC-8789-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Adds two new parameters to the check_signature api and passes them to the

"Add". "pass".

> internal verification ssh/gpg methods.

> A payload timestamp that will be used to verify signatures at the time of their
> objects creation if the signing method supports it (only ssh for now).

OK.

> And a signer strbuf containing ident information about the signer that
> we will need for implementing "Trust on first use" in a future patch
> series.

OK.

It would flow better in our "git log" stream if you explain upfront
what problem you are trying to solve, before starting to give orders
to the codebase to pass these pieces of information.  Something
like:

    In order to implement the "trust on the first use of a key"
    behaviour in later steps, allow callers to optionally pass the
    timestamp of the payload and the identity of the signer to
    check_signature().

It is unclear what "payload timestamp" is without actually seeing
how it is used, so if you cannot explain it in easy terms in the log
message for this step, it may be an indication that it is not a such
good idea to add these parameters in a separate step.

>  int check_signature(const char *payload, size_t plen,
> -		    const char *signature, size_t slen,
> -		    struct signature_check *sigc);
> +		    timestamp_t payload_timestamp,
> +		    struct strbuf *payload_signer, const char *signature,
> +		    size_t slen, struct signature_check *sigc);

Funny line wrapping.  Just like payload and plen form a pair (hence
they sit next to each other on the same line), signature and slen
should sit next to each other on the same line.

What's the reason why payload-signer MUST come in a strbuf?  A
caller that has only ptr and len must invent a new strbuf that is
otherwise unused to call this function because of that calling
convention, which looks suboptimal.

If the function accepts <ptr, len>, just like <payload, plen> or
<signature, slen> are taken by the function, such a caller can just
call the function without having to have an extra instance of
strbuf, while a caller that happens to already have a strbuf can
pass <buf.buf, buf.len> as two separate parameters.

What's the driving principle that decided where in the list of
parameters these two new ones are added?

I would explain one possible order I may find "logical" using the
level of detail I expect from an answer to "what's the guiding
principle?" as an example here:

 - we should move 'sigc' to the beginning, because the convention
   used by many of our API functions that have some central
   structure to work with is to have such a structure as the first
   thing in the list of parameters;

 - we should then append 'payload_timestamp', 'payload_signer', and
   'payload_signer_len' at the end, as the function is about
   "validate <signature, slen> is valid for <payload, plen> and
   leave the result in <sigc>", and anything we add is auxiliary
   input to the process, which are of less significance than the
   existing ones.

Another possible direction to go might be to add these auxiliary
input to the process to the signature_check structure.  Then this
step can disappear, or just flip the order of the parameter to move
sigc to the beginning, and then the later stemp that does the "first
use" thing can add the necessary members to the structure *and* use
the members to do its thing, which helps readers better understand
what is going on.

One possible downside is that sigc has been mostly output-only
structure, and turning it into a structure that also has some input
members might make it too confusing.  I dunno.

Thanks.
