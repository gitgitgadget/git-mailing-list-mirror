Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F193211B4
	for <e@80x24.org>; Wed,  5 Dec 2018 06:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeLEGaP (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 01:30:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55372 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeLEGaO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 01:30:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E013324F24;
        Wed,  5 Dec 2018 01:30:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eZ1D4d0hxmtJUlweHy+g2FxrEPE=; b=dO7acd
        tMJQ46oZWeGzWaPxp5u/J49/blod7L6erjdYqMxELIkm0JKeYLjsEYU96893R8tz
        mBGpPHulyNPNx5z9om+QyGxftr3UHPW+fM2CZN/iOkS8CqghRrz2yqHWYp4wCCQS
        iDSzWSQsrGO9XSlATYvzwI2BsqZVtm815d4i0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TbqSCyGOa40z3jGAedIUGWdBX71UBsx8
        aMg3Nv0/bBxzT3nBnmN0zNmCEWRTWZ2Hjs68v2E9oLQdyD52WwXU1Qf5r5h82G+2
        eyMHeX8H8OJ7jImVHjC2enZYDbKrWo3yUlvlADxYIvT1294pq2ds9Mkdhmn1UT+d
        VkGS0UxgNgQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D917424F22;
        Wed,  5 Dec 2018 01:30:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D01B124F21;
        Wed,  5 Dec 2018 01:30:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 3/5] upload-pack: refactor reading of pack-objects out
References: <cover.1543879256.git.jonathantanmy@google.com>
        <e19f294df9ff999d30a47339a7848c7104bfae7d.1543879256.git.jonathantanmy@google.com>
Date:   Wed, 05 Dec 2018 15:30:03 +0900
In-Reply-To: <e19f294df9ff999d30a47339a7848c7104bfae7d.1543879256.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 3 Dec 2018 15:37:36 -0800")
Message-ID: <xmqqzhtkbi50.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3455758A-F857-11E8-A9FA-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +struct output_state {
> +	char buffer[8193];
> +	int used;
> +};
> +
> +static int read_pack_objects_stdout(int outfd, struct output_state *os)
> +{

The naming feels quite odd.  We are downstream of pack-objects and
reading its standard output stream, so "read stdout-of-pack-objects"
is not wrong per-se, but it may be just me.  Stepping back and what
the function is really about often helps us to understand what we
are doing.

I think the function you extracted from the existing logic is
responsible for relaying the data read from pack-objects to the
fetch-pack client on the other side of the wire.  So from that point
of view, singling out "read" as if it is a primary thing the
function does is already suboptimal.  Perhaps

	static int relay_pack_data(int in, struct output_state *os)

because the fd is what we "read" from (hence, 'in', not 'out'), and
relaying is what we do and reading is only one half of doing so?

> +	/* Data ready; we keep the last byte to ourselves
> +	 * in case we detect broken rev-list, so that we
> +	 * can leave the stream corrupted.  This is
> +	 * unfortunate -- unpack-objects would happily
> +	 * accept a valid packdata with trailing garbage,
> +	 * so appending garbage after we pass all the
> +	 * pack data is not good enough to signal
> +	 * breakage to downstream.
> +	 */

Yeah, I recall writing this funky and unfortunate logic in 2006.
Perhaps we want to update the comment style to make it a bit more
modern?

The "Data ready;" part of the comment applies more to what the
caller of this logic does (i.e. poll returned and revents indicates
we can read, and that is why we are calling into this logic).  The
remainder is the comment that is relevat to this logic.

> +	ssize_t readsz;
> +
> +	readsz = xread(outfd, os->buffer + os->used,
> +		       sizeof(os->buffer) - os->used);

So we read what we could read in the remaining buffer.

I notice that you alloated 8k+1 bytes; would this code end up
reading that 8k+1 bytes in full under the right condition?  I am
mainly wondering where the need for +1 comes from.

> +	if (readsz < 0) {
> +		return readsz;
> +	}

OK, report an error to the caller by returning negative.  I am
guessing that you'd have more code in this block that currently have
only one statement in the future steps, perhaps.

> +	os->used += readsz;
> +
> +	if (os->used > 1) {
> +		send_client_data(1, os->buffer, os->used - 1);
> +		os->buffer[0] = os->buffer[os->used - 1];

OK, this corresponds to the "*cp++ = buffered"  in the original just
before xread().

> +		os->used = 1;
> +	} else {
> +		send_client_data(1, os->buffer, os->used);
> +		os->used = 0;

I am not sure if the code is correct when os->used happens to be 1
(shouldn't we hold the byte, skip the call to send_client_data(),
and go back to poll() to expect more data?), but this is a faithful
code movement and rewrite of the original.

I've read the caller (below, snipped) and the conversion looked
sensible there as well.  The final flushing of the byte(s) held back
in *os also looks good.
