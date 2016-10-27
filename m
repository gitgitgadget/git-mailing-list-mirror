Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF8120193
	for <e@80x24.org>; Thu, 27 Oct 2016 19:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934812AbcJ0T5o (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 15:57:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933171AbcJ0T5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 15:57:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A71AF4ACD8;
        Thu, 27 Oct 2016 15:57:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B5PBTAI1yyPz
        VIrok4GHVVmX9cc=; b=XWQitwHOs+dgf3cn3x/ljcWcCnIbVc+Ps3US3kzdYsZX
        ysOX2nmwmEWKCmQwbLIePxCswsoy0E4ZT0RdTeaDexK6ESTJTUX3sbvXR/qhuEd4
        kIu7Ad4c2SujeT3DlC/xk6Z3XCSnSN1rmrfzo+EaLDxyS0qSME5kKf60z1JNOCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UULrST
        hTPTEzDusVGi6bLu7CvqQblOrg+sCApm+JSlN8ezf/OAV83DCncuxqk5Jeb8yMiq
        TV5Kms2AtZftO0jvZi9E+4Fuxcl6ys2DjblRkjyh8SUp31Ns0N5Neu84n9tx+INS
        s/vgg3/9+5yDOWxW1dAu++q6ahhCi6u5RAIRw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D8C54ACD7;
        Thu, 27 Oct 2016 15:57:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1842B4ACD6;
        Thu, 27 Oct 2016 15:57:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] read-cache: factor out get_sha1_from_index() helper
References: <20161009095649.1886-1-tboegi@web.de>
        <20161012134726.28326-1-tboegi@web.de>
Date:   Thu, 27 Oct 2016 12:57:40 -0700
In-Reply-To: <20161012134726.28326-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 12 Oct 2016 15:47:26 +0200")
Message-ID: <xmqqinsd5zuz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9ED83F7C-9C7F-11E6-BAE8-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Factor out the retrieval of the sha1 for a given path in
> read_blob_data_from_index() into the function get_sha1_from_index().
>
> This will be used in the next commit, when convert.c can do the
> analyze for "text=3Dauto" without slurping the whole blob into memory
> at once.
>
> Add a wrapper definition get_sha1_from_cache().
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  cache.h      |  3 +++
>  read-cache.c | 29 ++++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 1604e29..04de209 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -380,6 +380,7 @@ extern void free_name_hash(struct index_state *ista=
te);
>  #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, =
at)
>  #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
>  #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(=
&the_index, (path), (sz))
> +#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, (p=
ath))

Should have caught this earlier, but there is an extra SP after "from_ind=
ex"
which I'll remove (the topic is not in 'next' yet, lucky us).

I re-read this to ensure that it does not break read_blob_data_from_index=
()
the new function borrows the logic from.

Thanks.
