Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E302C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 19:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiBATRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 14:17:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58902 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBATRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 14:17:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E30C7103881;
        Tue,  1 Feb 2022 14:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wcNaiipZXBs+
        hoZu9puR4dWITDUiJ9UbNvJTkmElkm4=; b=UMYtAow2feVxvmViqHdaH1StFMQP
        glMdgoD110Z/VSvdkYoNk+PMMDRIIx0MS7E8Zrr4D5Ya8sK0KquIQ5FFLQK7Hqj/
        RJOgzb3l+3nnLZd3At2ZyaKIIfRwai699FJMhlsW+WxpobusX0ALUopZ+QkxZ+Y0
        BKhcWPKj6oNpLsI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7B13103880;
        Tue,  1 Feb 2022 14:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0154010387F;
        Tue,  1 Feb 2022 14:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 06/10] object-file API: replace some use of
 check_object_signature()
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
        <patch-06.10-2a065bf23da-20220201T144803Z-avarab@gmail.com>
Date:   Tue, 01 Feb 2022 11:16:57 -0800
In-Reply-To: <patch-06.10-2a065bf23da-20220201T144803Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 1 Feb
 2022 15:53:08
        +0100")
Message-ID: <xmqqy22ucs7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8703C226-8393-11EC-8E36-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a "hash_object_file_literally()" function to go with the existing
> "hash_object_file()" function. This is currently a wrapper for its
> sibling, but this change will allow us to change it to take an "enum
> object_type" in a subsequent commit.

This is a confusing renaming, because there is already a public
function that exists under that name.  And with this implementation,
...

> +static void hash_object_file_literally(const struct git_hash_algo *alg=
o, const void *buf,
> +				       unsigned long len, const char *type,
> +				       struct object_id *oid)
> +{
> +	hash_object_file(algo, buf, len, type, oid);
> +}

... it is dubious why we need it.

> -int hash_object_file_literally(const void *buf, unsigned long len,
> -			       const char *type, struct object_id *oid,
> -			       unsigned flags)
> +int hash_write_object_file_literally(const void *buf, unsigned long le=
n,
> +				     const char *type, struct object_id *oid,
> +				     unsigned flags)

This renaming is actually OK, if hash_object_file() which is also
public is renamed to hash_write_object_file() at the same time.

But I would say we should try to avoid such name churn to the public
namespace.
