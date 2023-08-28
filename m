Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E5C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 23:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjH1XyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjH1Xxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 19:53:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C3131
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:53:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E45D1BAD4B;
        Mon, 28 Aug 2023 19:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E5PqpIxo9fOM/qUn5PcYTLRkIAJWJNgtcW9G8U
        978L8=; b=CDWVfDK3wl4jFY2KjuzYxVd9Hn9r41OFYSdUMNtE9qCA9RcrvvNcVj
        MDncXnjNaXKWb9PZi5ZeKdEsGRLyG7nsQVDPJzcwCeSmbNPyr66HxWxH/NquQ3nU
        43znfgSw6ASz84hYJNobpQ9JSzl1Lf20cxL7shBHDASY5WfjkfTGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26E931BAD4A;
        Mon, 28 Aug 2023 19:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B9181BAD49;
        Mon, 28 Aug 2023 19:53:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/log.c: prepend "RFC" on --rfc
References: <20230828144940.18245-1-sir@cmpwn.com>
        <xmqqa5ubi1nh.fsf@gitster.g> <ZO0sFWJLX8YaJ2F/@nand.local>
Date:   Mon, 28 Aug 2023 16:53:42 -0700
In-Reply-To: <ZO0sFWJLX8YaJ2F/@nand.local> (Taylor Blau's message of "Mon, 28
        Aug 2023 19:21:57 -0400")
Message-ID: <xmqqledug1vd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ECDB2BE-45FE-11EE-9CBB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I am not super familiar with this code, so could easily be missing
> something here, but I think that you can do this in a more direct way
> like so:
> ...
>  static int rfc_callback(const struct option *opt, const char *arg, int unset)
>  {
> +	free(subject_prefix);
> +	subject_prefix = xstrfmt("RFC %s", revs->subject_prefix);

As Phillip Wood pointed out, this approach no longer works once
"--rfc" is "no matter what subject-prefix says, we prepend RFC in
front", as the order of command line flags is not forced.  At this
point, revs->subject_prefix may be one value (or worse, even not
initialized), and then --subject-prefix=<new-prefix> command line
argument may yet to be parsed.

> +	return subject_prefix_callback(opt, subject_prefix, unset);
>  }

So, we'd most likely need to treat subject_prefix and rfc as two
separate strings while parse_options() is doing its work, and then
after that prepend the rfc string, if set, to the final version of
the subject_prefix string.
