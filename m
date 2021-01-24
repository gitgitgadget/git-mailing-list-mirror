Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB8C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5B622CB3
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 07:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbhAXH5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 02:57:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62236 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXH5b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 02:57:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4E1FA22A5;
        Sun, 24 Jan 2021 02:56:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wC5PQYLExYW2qZuBeTLVMIpCEIk=; b=UB4o2Q
        uXUGZh9RsRotVeFJaFz6FUbtdoQFC+MtjprOh2LFRs+dEzFTznwPUQ2w2u1GxwXy
        iJLNWTQwjjsXvxc/thUhCPf6+mi5jwSFKUXV6/zQs4HK01MEAK/rgClcfEXUqZAf
        JNL5oE3+H6FTo2vD1FGngHatfgFNYItCG8voc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CWbvCKAIv5iBebVQqY8VLW9yvW3dLC5d
        3IETLbrg6dhYYXT9QMSA4nDREzoq1epkw/6zJgeFBlnyZ6TbDjM1QsChPzE1H770
        s0EJyS5NdRR+qMEnbZKlqdOekKbWbTqs+Aip1GcNxmnONRRzbQlvzdHf6FuOSnUq
        zClzulCbFZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B240A22A3;
        Sun, 24 Jan 2021 02:56:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17FD3A22A2;
        Sun, 24 Jan 2021 02:56:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <20210115234300.350442-1-jonathantanmy@google.com>
        <cover.1611455251.git.jonathantanmy@google.com>
        <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
Date:   Sat, 23 Jan 2021 23:56:47 -0800
In-Reply-To: <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Sat, 23 Jan 2021 18:34:30 -0800")
Message-ID: <xmqqy2gizs1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5BC68DE-5E19-11EB-A2A4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 7d5b17909b..8b8fb43dbc 100755
> ...
> +	sane_unset GIT_TEST_SIDEBAND_ALL &&
> +	git -c protocol.version=2 -c transfer.fsckobjects=1 \
> +		-c fetch.uriprotocols=http,https \
> +		clone "$HTTPD_URL/smart/http_parent" http_child &&
> +
> +	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).

Ehh, please don't.  We may add multi-pack-index there, or perhaps
reverse index files in the future.  If you care about having two
packs logically because you are exercising the out-of-band
prepackaged packfile plus the dynamic transfer, make sure you have
two packs (and probably the idx files that go with them).  Don't
assume there will be one .idx each for them *AND* nothing else
there.

> +	ls http_child/.git/objects/pack/* >filelist &&
> +	test_line_count = 4 filelist
> +'

IOW,

	d=http_child/.git/objects/pack/
	ls "$d"/*.pack "$d"/*.idx >filelist &&
	test_line_count = 4 filelist

or something like that.
