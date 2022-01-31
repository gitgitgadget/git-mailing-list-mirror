Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0308BC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 18:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348806AbiAaSYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:24:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63812 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348492AbiAaSYa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5140F1635B0;
        Mon, 31 Jan 2022 13:24:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6+GxMayoBALDru5xX1xzuJV9TEMMatNNBtLX9c
        TXx+o=; b=ph0PRDopC7TYZiaV8TK/12EvgZJMOshm6w+NDLxmrSSpRqKxO/VC6z
        yuc/IctQRNo1JYyi4yNJOWwmfxWAwZk7RvEMlg2WcszrdefhOuHqh39nI4bzOhjA
        QRqifFqsSPodHiHkjalLbZXodPEF7Dgd1diAIY2tEuWadmSz18OU8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49DF61635AF;
        Mon, 31 Jan 2022 13:24:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7EC21635AE;
        Mon, 31 Jan 2022 13:24:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com,
        e@80x24.org
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
References: <20220128183319.43496-1-johncai86@gmail.com>
        <56f851f3-946b-0524-1643-25799ef46b55@gmail.com>
Date:   Mon, 31 Jan 2022 10:24:26 -0800
In-Reply-To: <56f851f3-946b-0524-1643-25799ef46b55@gmail.com> (Bagas Sanjaya's
        message of "Mon, 31 Jan 2022 18:44:20 +0700")
Message-ID: <xmqqpmo7ix0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 064EC110-82C3-11EC-86CC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 29/01/22 01.33, John Cai wrote:
>> Future improvements:
>> - a non-trivial part of "cat-file --batch" time is spent
>> on parsing its argument and seeing if it's a revision, ref etc. So we
>> could add a command that only accepts a full-length 40
>> character SHA-1.
>
> I think the full hash is actually revision name.

There is no entry for "revision name" in Documentation/glossary-content.txt
;-)

But to John, if you have a loop that feedseach line to get_oid(), 

	while (getline(buf)) {
		struct object_id oid;
		if (get_oid(buf, &oid))
			warn and continue;
		use oid;
	}

is it much slower than a mode that can ONLY handle a full object
name input, i.e.

	while (getline(buf)) {
		struct object_id oid;
		if (get_oid_hex(buf, &oid))
			warn and continue;
		use oid;
	}

when your input is restricted to full object names?

get_oid() == repo_get_oid()
-> get_oid_with_context()
   -> get_oid_with_context_1()
      -> get_oid_1()
	 -> peel_onion()
	 -> get_oid_basic()
	    -> get_oid_hex()
	    -> repo_dwim_ref()

it seems that warn_ambiguous_refs and warn_on_object_refname_ambiguity
we would waste time on refname discovery but I see cat-file already
has some provision to disable this check.  So when we do not need to
call repo_dwim_ref(), do we still spend measurable cycles in this
callchain?





