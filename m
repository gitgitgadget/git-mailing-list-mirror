Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D2DC2BA19
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3E620678
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZOvrQ5cN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgDEVhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:37:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50275 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEVht (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 17:37:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B04CAB835F;
        Sun,  5 Apr 2020 17:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gxrBrwO5kgrk9twVrWU1e8mAaJk=; b=ZOvrQ5
        cNMcWRhMk+b/HABlycPmoWdl66+22l1RT5KtFKispaSEnIothibNpo8ivaA0gO13
        CbUVwyJeKIwR9YUkf0/hVZqEaTnvIgZ7d4xRf0RgeWpjHBaFbIGwzJXWj0oxqK61
        uax3nBaSA7IZ0RYTelsxhbkA75/jpoOyAvaPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aQlmbTU0mjBvVmBi00tsXe5W87xdYR1V
        MgpANbeaWjb2/sw1VCCFnmxfwoqKaxt1ADshheJJV+4Y0l0cxafeq8ND8blWhqsA
        RPHbUWgd3o/6wDWJqFFIhR4/VmeRhBoJ2zIpZ+Hfbs2XIgASZu9sc8qZzw8L1fGI
        k7T4+I0euf4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99F7EB835E;
        Sun,  5 Apr 2020 17:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D53AAB835D;
        Sun,  5 Apr 2020 17:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 03/23] sequencer: stop leaking buf
References: <cover.1584782450.git.liu.denton@gmail.com>
        <cover.1585962672.git.liu.denton@gmail.com>
        <76585e5b1367a3adf18d761b2af9356ee64b46fd.1585962672.git.liu.denton@gmail.com>
        <xmqqzhbpwrcb.fsf@gitster.c.googlers.com>
Date:   Sun, 05 Apr 2020 14:37:43 -0700
In-Reply-To: <xmqqzhbpwrcb.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 05 Apr 2020 14:33:08 -0700")
Message-ID: <xmqqv9mdwr4o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF9D4426-7785-11EA-9CAE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  		read_strategy_opts(opts, &buf);
>> -		strbuf_release(&buf);
>> +		strbuf_reset(&buf);
>
> As read_oneliner() has a strbuf_reset() at the beginning *anyway*,
> why not just get rid of the call to _release() here instead?  After
> all, there is no _release() or _reset() before the call to read_oneliner()
> in the next hunk, or two calls to read_oneliner() inside the
> read_strategy_opts() function called in the above.

Ah, I was reading the state of applying the series thru to the end.
At this point, there is no reset there, so you'd need to call reset
to ensure that the next read_oneliner() on &buf will not append, but
restart from the beginning.

>>  		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
>> -			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0)
>> -				return error(_("unusable squash-onto"));
