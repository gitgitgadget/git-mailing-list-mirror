Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66AC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43617206CC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OncegC+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBMSTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:19:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64670 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMSTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:19:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D810BC15C;
        Thu, 13 Feb 2020 13:19:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p84GMYqmf39Bd7d63ODRcRZWpMg=; b=OncegC
        +ex9n2l6J/Pf0vKDhbofbyrCZTtWV3aBZwzQk1JHmqH8VQCx/UdQzShjjSlYSabG
        yPg7YhNUmpBX8HsZBQesucGmrk357yXlp4zpki+cpKmFcO5AfLmsw+1QmvJbQ9N8
        FatDQQ4oSfrl0y+ojXcaYfMk/udnOrC40jfe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yhSSHO3Pa6r/PEIaIdox/Lf91gs2LyDW
        aK1ugQfLujocCMiMHg4HYxETJzWEYi2lUHqRmhhzdr47Rkz53Myg4Ti1UTf/M4oA
        0tn+AzxCkQpakN6eohJwNfRIxwo0lnFth2Gwq+MWoiY2oeiSdjunQVSFky5w9+sT
        QPEXippB8Xo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5589EBC15B;
        Thu, 13 Feb 2020 13:19:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 825ECBC15A;
        Thu, 13 Feb 2020 13:19:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/13] rev-list: fallback to non-bitmap traversal when filtering
References: <20200213021506.GA1124607@coredump.intra.peff.net>
        <20200213021730.GC1126038@coredump.intra.peff.net>
Date:   Thu, 13 Feb 2020 10:19:19 -0800
In-Reply-To: <20200213021730.GC1126038@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Feb 2020 21:17:30 -0500")
Message-ID: <xmqq8sl6s63c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B30AE26-4E8D-11EA-81E8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "--use-bitmap-index" option is usually aspirational: if we have
> bitmaps and the request can be fulfilled more quickly using them we'll
> do so, but otherwise fall back to a non-bitmap traversal.
>
> The exception is object filtering, which explicitly dies if the two
> options are combined. Let's convert this to the usual fallback behavior.
>
> This is a minor convenience for now (since the caller can easily know
> that --filter and --use-bitmap-index don't combine), but will become
> much more useful as we start to support _some_ filters with bitmaps, but
> not others.

Makes sense.  

Perhaps the option should have been called allow-bitmap-index or
something along that line, but it is too late ;-)

> +test_expect_success 'set up bitmapped repo' '
> +	# one commit will have bitmaps, the other will not
> +	test_commit one &&
> +	git repack -adb &&
> +	test_commit two
> +'
> +
> +test_expect_success 'filters fallback to non-bitmap traversal' '
> +	# use a path-based filter, since they are inherently incompatible with
> +	# bitmaps (i.e., this test will never get confused by later code to
> +	# combine the features)
> +	filter=$(echo "!one" | git hash-object -w --stdin) &&
> +	git rev-list --objects --filter=sparse:oid=$filter HEAD >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter=sparse:oid=$filter HEAD >actual &&
> +	test_cmp expect actual
> +'

OK.
