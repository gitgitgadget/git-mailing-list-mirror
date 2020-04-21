Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C818C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3E7206B8
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cj4f1MC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDUUGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:06:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63446 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUUGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:06:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF6C8537EF;
        Tue, 21 Apr 2020 16:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fFhlTO8TyBxjdTdwHdj5aeg201E=; b=cj4f1M
        C6pRmbs/hLQpgroPl65tUblnzOuQhPjl0hJH1sp6wyVS1LJCIPAH9VaXeocrVvBd
        xTEC3Mnyd6j4QmHNJhsLm8MJAOk3jCQgHAumzhlJivfTZyHGVTLgrKj+PVbTIXKL
        DJIbXmJC0yChZlqnm+LC8DDVG/iaVJm1xf6HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PBKBPZ96VH5YxQMwBgAHtpTPW3C0i+38
        CHYwKsMP2gRGCPTqL5pNGNCq3hHX4U88tQ6ZmeULUDMtWexekbdbniXWMduogDH8
        NcdKN2Kov8hEwXbauVM8YbR0LLV76fB6NY+7Bx/Vqu2xy1XtWkbFksHAi0Ev6yBV
        JyQvvPXS3cg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A69D8537ED;
        Tue, 21 Apr 2020 16:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30723537EB;
        Tue, 21 Apr 2020 16:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Dixit\, Ashutosh" <ashutosh.dixit@intel.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Bug in 2.26: git-fetch fetching too many objects?
References: <878siqxiu0.wl-ashutosh.dixit@intel.com>
        <20200421064541.GG96152@google.com>
        <xmqqblnkodi4.fsf@gitster.c.googlers.com>
        <20200421193611.GA103469@google.com>
Date:   Tue, 21 Apr 2020 13:06:34 -0700
In-Reply-To: <20200421193611.GA103469@google.com> (Jonathan Nieder's message
        of "Tue, 21 Apr 2020 12:36:11 -0700")
Message-ID: <xmqqtv1cmwmt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A0B2AE6-840B-11EA-A9CA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, if I understand correctly, it's describing an issue
> that also exists in protocol v0 for https.  I would be *very*
> interested in any evidence one way or another about whether I am
> understanding correctly.

I am assuming that the issue experienced by these people after
flipping the default to v2 was *not* experienced by the same folks
back when they were not on v2.  If not, I cannot explain why their
report say "it suddenly started doing this".

> ..., since we've been using protocol v2 as the
> default at $DAYJOB for quite a long time now.

Is it possible that folks getting hurt after 2.26 got released have
quite different use case / fetch pattern from what you see at
$DAYJOB, which are covered well in the current code?  Keep using v2
at $DAYJOB may not help us diagnose the issue more than flipping the
default back (and at $DAYJOB the default is under your control ;-).
