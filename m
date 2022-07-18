Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC1C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiGRTrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiGRTrW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:47:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8F2D1E3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:47:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E7681BEFF6;
        Mon, 18 Jul 2022 15:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3NuBiNX3H5CGPcgu5OscvFbjh6LzdduQ2QX7M6
        6YqIM=; b=cB3yW9/7TFF7DX7Bmjat4hzMt6uUGkjTyGQSH5oYFhu6Yhl13MQPEy
        9ligchrTjYREBnfU1PIgoiyekCCiLePQavbVii7mPxKFaJikzwETd0cit65TqfxW
        yMVzbL8SnNJtIt97lHMwlCZebMY3donkNEZwa1sm7n2Q52a1bG6vU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 972DC1BEFF5;
        Mon, 18 Jul 2022 15:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 460411BEFF4;
        Mon, 18 Jul 2022 15:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH v2] fetch-pack: write effective filter to trace2
References: <20220715172943.2681492-1-jonathantanmy@google.com>
        <20220718170027.3993042-1-jonathantanmy@google.com>
Date:   Mon, 18 Jul 2022 12:47:14 -0700
In-Reply-To: <20220718170027.3993042-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 18 Jul 2022 10:00:27 -0700")
Message-ID: <xmqqwncadwzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C95B9E0-06D2-11ED-8433-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +static void write_and_trace_filter(struct fetch_pack_args *args,
> +				   struct strbuf *req_buf,
> +				   int server_supports_filter)
> +{
> +	if (args->filter_options.choice) {
> +		const char *spec =
> +			expand_list_objects_filter_spec(&args->filter_options);
> +		if (server_supports_filter) {
> +			print_verbose(args, _("Server supports filter"));
> +			packet_buf_write(req_buf, "filter %s", spec);
> +			trace2_data_string("fetch", the_repository,
> +					   "filter/effective", spec);
> +		} else {
> +			warning("filtering not recognized by server, ignoring");
> +			trace2_data_string("fetch", the_repository,
> +					   "filter/unsupported", spec);
> +		}
> +	} else {
> +		trace2_data_string("fetch", the_repository,
> +				   "filter/none", "");
> +	}
> +}

The previous round already had the same issue, but this makes it
even worse by introducing a function that makes it clear that it
mixes quite unrelated two features (i.e. write the filter to the
other end, which MUST be done for correct operation of the protocol,
and write a log to trace2, which may not be even necessary when we
are not logging at all).

Can we make the code a bit better structured, I have to wonder, by
having two separate phases of processing, one for the operation
proper, and the other for the logging/debugging?

In a sense, we can say that the only purpose this helper function is
to tell the server end what the filter we use is by renaming it; it
is OK to have debugging statements and logging code as part of the
implementation of such a function.

I actually like that direction better.  A helper function may exist
*ONLY* to trace, in which case, having "trace" in its name would
make perfect sense.  A helper function may exist to perform the real
work, but it may log what it did to perform the real work as well.
I think the latter shouldn't have "trace" in its name at all, or our
helpers will all be called do_FOO_and_trace(), do_BAR_and_debug(),
etc., which is nonsense.  Just calling do_FOO() and do_BAR(), and
then having them log or trace as needed, is fine.

Will queue, anyway.

Thanks.
