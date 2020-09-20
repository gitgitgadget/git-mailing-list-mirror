Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A76C43464
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 01:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07EC20809
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 01:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kq0pXFQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgITBAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 21:00:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57817 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgITBAu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 21:00:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84CA574524;
        Sat, 19 Sep 2020 21:00:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JUY0GHJCy7D8uRS+rMdpmXpxtuw=; b=Kq0pXF
        QUu5cBnwQju+UZWmNtqRMPufU54mJvO6xX1erbE4iSJVF3AwU/exyz9l3+XnVukT
        IWxUWGJF14Rf9Zxge3HT/CimyQD/5Zv82UJV03wBE4ruAhgzkfBHZgOn9PmYpxDn
        qBTp8b3Ftz9/EYwqXD73KLGtWLpVH4BKiftFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XWQcWC4jRx03zzpC3mwRJwKwusNJFvXS
        W8JNpXhFFtQnjTFZyuBCy5U4nEwcDIfs4bsY8DNiVlYmnsPTssy77btYk9xS3q/h
        YS0MnmPsZrlUEObWF0kOn08jzVr0ITGCDaXLlugNNo7iJIxKV2noERiHD6x7zYep
        7kTMHUihcfA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AA2E74523;
        Sat, 19 Sep 2020 21:00:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C10974522;
        Sat, 19 Sep 2020 21:00:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 06/13] reftable: (de)serialization for the polymorphic
 record type.
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <791f69c000556e93bf5fcfc0ec9304833b12565b.1600283416.git.gitgitgadget@gmail.com>
Date:   Sat, 19 Sep 2020 18:00:47 -0700
In-Reply-To: <791f69c000556e93bf5fcfc0ec9304833b12565b.1600283416.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 16 Sep 2020
        19:10:09 +0000")
Message-ID: <xmqqlfh5i7nk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8567238-FADC-11EA-BAED-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void reftable_log_record_key(const void *r, struct strbuf *dest)
> +{
> +	const struct reftable_log_record *rec =
> +		(const struct reftable_log_record *)r;
> +	int len = strlen(rec->refname);
> +	uint8_t i64[8];
> +	uint64_t ts = 0;
> +	strbuf_reset(dest);
> +	strbuf_add(dest, (uint8_t *)rec->refname, len + 1);
> +
> +	ts = (~ts) - rec->update_index;
> +	put_be64(&i64[0], ts);
> +	strbuf_add(dest, i64, sizeof(i64));
> +}

We seem to be getting

reftable/record.c: In function 'reftable_log_record_key':
reftable/record.c:578:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  put_be64(&i64[0], ts);
    ^
        CC reftable/refname.o

when this series is merged to 'seen'.

cf. e.g. https://travis-ci.org/github/git/git/jobs/728655368


Thanks.



