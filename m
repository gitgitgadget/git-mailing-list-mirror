Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE0C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0858164F79
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEBwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:52:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54111 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEBwz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 20:52:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCE82119B39;
        Thu,  4 Mar 2021 20:52:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1tTy7dTtP3u1hprXozuxNm02CRo=; b=kCdae6
        cLmbGFriL2X37PSkH68zKSGt4raMSAsC9ei8/bdcA5QpTP3U5xfknFsK6pt2hqZI
        /FGR8R7+1kAjGmnCtPW9wMNbY9GA8ZxoFIooZvVDotLLUTf8CY41XzSZeENnF051
        BSYdlHJkRGie4uYsCvbrD1UI8Qa2yllKjSbgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RtCoe9GfKETsNRdDEvb5TBixF+mxFwe5
        2jXJFBeAB1zV8qTTi5LL0adhMPNgtlwLsIWOVZ83q2lAUHBgfyNxgvlfojMdPj0R
        VndKjIR7ZUBnhVTohUaGI5ga/qiJrtjJzpUr+Savxg+pv1tnkW2PZnfWDW02TnSf
        mMKDG7MJWgs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C56D8119B38;
        Thu,  4 Mar 2021 20:52:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1BB32119B37;
        Thu,  4 Mar 2021 20:52:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <YEF5BfE6eXmhhiAf@google.com>
        <20210305011621.599649-1-jonathantanmy@google.com>
Date:   Thu, 04 Mar 2021 17:52:50 -0800
In-Reply-To: <20210305011621.599649-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 4 Mar 2021 17:16:20 -0800")
Message-ID: <xmqqh7lqbc3x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EFF29AC-7D55-11EB-8B11-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> One simplification that we could do is to eliminate the unpack-objects
> codepath. As far as I understand, the main advantage of writing loose
> objects is that we have automatic SHA-1 collision detection, but we have
> such mitigations when writing packs too, so that might not be as large a
> benefit as we think. This simplification would have enabled us to avoid
> this bug, I think.

My understanding is that the primary advantage of loose objects
codepath is to help us avoid having too many little packs (instead,
we can accumulate enough objects in the loose form and let GC pack
them, at least the ones among them that are still reachable, into a
single pack).  Historically, the only mode of operation "repack"
offers that reduces the number of remaining packs has been "do full
reachability of the entire history, and pack everything into one",
so avoiding creation of little packs and leaving things loose until
we accumulate enough used to matter.

With the geometric rolling repacking, it may not matter as much, and
keeping everything packed, even in a small pack, might start to be
overall win.  So I am not opposed to such a simplification; we may
not be ready for it right now, but I think it would be a sensible
future direction.




