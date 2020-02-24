Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC867C38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB4421556
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/1v0rib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgBXVC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:02:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60975 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBXVC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 16:02:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 667C0CA157;
        Mon, 24 Feb 2020 16:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+kdE7YE9UrK4riXxXJ7xlVu4nd0=; b=C/1v0r
        iby3gYYzHDk3ilUd1gcOpH+nwGurEbKnQ/DGN53rn3Vwu4Lu1/8aUeWpTpoMrT2q
        DEi0QuvlL+8XLXWtX5eBo07p7G0HdmVZRC1GEbDSZf0kuh5QBjPZTZq0ckN0maxv
        YtmkJrM6yQb21NjRqifiArDlY26Bs5tFssiro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qQTa9g+UBapNJ0w8NykRatB+y8sxJ17V
        LymOiwoMbXGgdnvPTYZ/7qfWXADtIgj2LnPg0CafX8/8MV+qzOukAeBhjZv1sedZ
        znh12T26P1MnZI99KJLCUQp+Wb550bAAi0/bWFeZl0XLIlljQlGV0Xxa+89NV0Ht
        IdWJDmoaEUw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E1D5CA156;
        Mon, 24 Feb 2020 16:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81400CA155;
        Mon, 24 Feb 2020 16:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Cameron Gunnin <cameron.gunnin@synopsys.com>
Subject: Re: [PATCH 0/3] git-worktree: fix "add" being fooled by suffix matching
References: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
        <20200224090848.54321-1-sunshine@sunshineco.com>
Date:   Mon, 24 Feb 2020 13:02:49 -0800
In-Reply-To: <20200224090848.54321-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 24 Feb 2020 04:08:45 -0500")
Message-ID: <xmqqzhd7og06.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04F2BD32-5749-11EA-B40C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Rather than adding more band-aids to the validation to work around magic
> matching performed by find_worktree(), this patch series fixes the
> problem once and for all by locating a worktree deterministically based
> only on pathname.

Makes sense.  I wonder if strange synonyms that make more than one
paths string refer to the same filesystem entity (read: case
insensitive or unicode smashing filesystems Windows and macintoshes
use) have similar effect on the codepath, and if so, if we want to
do anything about it (my personal answers are "I don't know but I
would not be surprised if it is the case" and "No, just tell users
not to hurt themselves and move on").

Will queue.  Thanks.
