Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25525C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F169A20936
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v7IjRFxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgEFRRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:17:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59622 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFRRF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:17:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC7F9CEC6F;
        Wed,  6 May 2020 13:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vyzbNrDu4ilvxvzqbznrbub6sf0=; b=v7IjRF
        xHscIlbrayQmlISb88vLQ9pR1Q5cOpRbhrMVfv/e7y4NHn770kSqpsk13nfDXPVI
        ZvXc4G6s7zK5iDkx7C0dj4t6sWRYcBNqVPg+NqhaRWVFuzUEMnkfWrbbPk7GK8nz
        1n+o7+iSmjvNIHx9Zr7kb8Ia+1u9dVb35/dME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mY2Pz2NGMb9I1tq2qtKvm2Mf/tnprt7j
        fPi2A/CkfgpnK2d9phL3ZjM8nd9UOIrznQ+QIPxb4fmo71Ah3JuRurvwkfrU8nNy
        tOwJZOxnBSUstUGHEKHCdgGIFNpZBHT+LsFJvBQU9219nS+QzR3ar+Tnuo4nQ5nb
        xCJiXteg/z8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B39ACCEC6E;
        Wed,  6 May 2020 13:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 04123CEC6C;
        Wed,  6 May 2020 13:17:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <CAP8UFD0o7WwibV8+cwYOO949BkBggSphi0zbgPUZsk6nfvYyHQ@mail.gmail.com>
        <20200506163128.GA14899@konoha>
Date:   Wed, 06 May 2020 10:16:59 -0700
In-Reply-To: <20200506163128.GA14899@konoha> (Shourya Shukla's message of
        "Wed, 6 May 2020 22:01:28 +0530")
Message-ID: <xmqqpnbh6l10.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65F49D42-8FBD-11EA-9D4A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> On 06/05 10:09, Christian Couder wrote:
>> > +       strbuf_addf(&config_name, "submodule.%s.url", path);
>> > +
>> > +       config_set_in_gitmodules_file_gently(config_name.buf, newurl);
>> > +       sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
>> > +
>> > +       strbuf_release(&config_name);
>> 
>> Nit: it might be a bit simpler to define config_name as a "char *",
>> and then use xstrfmt() and free() instead of strbuf_addf() and
>> strbuf_release().
>
> Apart from the simplicity purposes, does doing this aid in performance
> in any way?

strbuf.c::xstrfmt() uses strbuf.c::xstrvfmt() that formats into a
temporary strbuf and returns the detached buffer as the result.

Compare it with what strbuf.c::strbuf_addf() and you can draw a
conclusion on your own ;-)


