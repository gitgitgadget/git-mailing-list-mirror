Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88CE2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbcISVjG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:39:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751207AbcISVjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:39:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA72740E40;
        Mon, 19 Sep 2016 17:39:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FMixqlhzkiHM
        b56Sj3FFln1I+CU=; b=lvEWu5VoaDUxogTl1U4uK+qyUXULf1j2qIccypy6TRNi
        ICY4ld3LQOIJtL1eyzdWoOcb65f+ntC3LFhbUMvFVACQ3phhCS1y89lj2/OTq8ln
        0612VM7yEjfp91i2Qvxw67zzl+b6iQaAMb5MWVY8+zbb4sPKw8UeWbfl+75/aFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c2njcM
        W38+1Bx5Qc+aXL+7sNaJoUweQWL5CuuUxKH3XbPKRQzDA17dPM097oCwgJ6nKzS0
        9upMfYJ6jYj1QAR7ZWSSpTuCpz4nftySYKnRvq2c5jVprwnsNPXZjlIaoSCvMhY/
        5C0RMsDjWu5Wvq04aZxi4JulUAsmUDS7MHQFY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C04FA40E3F;
        Mon, 19 Sep 2016 17:39:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 328C540E3C;
        Mon, 19 Sep 2016 17:39:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 0/4] handle multiline in-body headers
References: <cover.1474319086.git.jonathantanmy@google.com>
Date:   Mon, 19 Sep 2016 14:39:02 -0700
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 19 Sep 2016 14:08:49 -0700")
Message-ID: <xmqqr38fd0y1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7C5DC7B4-7EB1-11E6-B0BC-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is an iteration of the patch set after the discussion in
>  <cover.1474047135.git.jonathantanmy@google.com>.
>
> Changes:
> o largely rewritten to follow Junio's suggested design (refactor of
>   check_header to separate out ">From" and "[PATCH]", and an
>   is_inbody_header function performing an airtight check on whether a
>   line is an in-body header)
> o simpler try_convert_to_utf8 API
> o one file of the expected output of t/t5100/*0015 is modified (instead
>   of the input)
> o t/t5100/*0018--no-inbody-headers test files added
> o example in commit message improved following Peff's suggestion

Overall it looks much nicer, but I still do not understand why we
want to do try-convert-to-utf8.  The _only_ caller of that helper
function is in 4/4 where it tries to convert the line to see if a
line is a scissors line.

It seems to me that the only thing doing so gives us is that you
could later enhance the definition of what a scissors-line looks
like by adding unicode characters [*1*], but I would strongly
suggest not doing that kind of enhancement [*2*].  With the current
definition of what a scissors-line looks like, it can be checked
before you do the UTF-8 conversion, I think, which would mean that
the helper is not strictly necessary.

So...


[Footnotes]

*1* E.g. =E2=9C=82 encoded in non-UTF8 may have to be converted to UTF-8
first before being recognized as such.

*2* Encouraging people to use non-ASCII that older version of Git
did not take for structural things like "what is a scissors line"
merely for the looks is a bad trade-off; patch e-mails that use the
enhanced definition will break for those with older version of Git,
and the benefit of "prettier scissors" is not really worth it, I
would think.





