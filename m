Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF6CC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2321E206D8
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+OP4BTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKVCYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:24:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53274 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfKVCYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 21:24:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F6498BAFE;
        Thu, 21 Nov 2019 21:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iofF1JDYlgWraNIY6YHET+a+J4g=; b=M+OP4B
        TohXllycMaLKrgxOLN88z2P3aZsJyKXYbW3V3YVv9A096Lq7wnEeC62CTDUTDOg3
        ILSeeXClTpDe0f8qUBVx3/dHo3fBWImVk1QbqNJYSMb8/LEEn7vNn21E14+uInV6
        udD8zldtCZQGE95EAy03TzF/b0OV4nzaEMq/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lGFxuNBT2fVoKRsLCW+qXPXrOKda4VT7
        Zst6kdLLB2sOif9k2/fUDdvzmBZ4/nC8G1YmbyYApoMribzxeGiqOuw7g11y7mWe
        5oltVH3yBl+eof2f9mhHIaokXl/1F1336dxAXLC6khainy4S1zz1XvEHBlo9VBJG
        njKoBOqf1cg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38FB38BAFD;
        Thu, 21 Nov 2019 21:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E24D8BAFB;
        Thu, 21 Nov 2019 21:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] grep: provide pathspecs/patterns via file or stdin
References: <20191122011646.218346-1-emilyshaffer@google.com>
Date:   Fri, 22 Nov 2019 11:24:15 +0900
In-Reply-To: <20191122011646.218346-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 21 Nov 2019 17:16:46 -0800")
Message-ID: <xmqq1ru08x80.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F025552-0CCF-11EA-A375-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach 'git grep' how to receive pathspecs via file, and add convenience
> flags for receiving pathspecs or patterns via stdin.

When I invented the terms "pathspec", "refspec", etc. for this
project, I meant them to be collective nouns.  A pathspec is a set
of pathspec elements, each of which is usually given as a separate
argument on the command line.  So "Read pathspec from file" is good
(not "Read pathspecs from file").

Are you aware of the am/pathspec-from-file topic that has been
cooking for a while by now?

I do not necessarily agree with the second rationale why many
commands may want to learn this option given in that series, but do
agree with the first one.  A lot of times running underlying "git"
command multiple times via xargs invocation can mean quite different
thing from giving a large pathspec to a single invocation of "git".
But not with "git grep" ;-)  So I'd say this is a second class
target for the pathspec-from-file theme.

Thanks.
