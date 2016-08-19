Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9231F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754963AbcHSUew (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:34:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754011AbcHSUev (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:34:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62C4537F75;
        Fri, 19 Aug 2016 16:31:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EKvtLI1CQpwYVn4UqnRt3m4EJK0=; b=BQTViR
        faeLpSIO7fPYWBKOUYVjJEMsRCybsP37bjck8NPKVjBQiCGo2w77VuN390U2jSTQ
        HjiW+wKOyf3judg+fKbu4K8DX6vxCtcvtV7enhunS2CKur/q5U4QZ5rNNQOkj5RD
        2ut5r7SLeults62Zw/3Aa8aP3jYXn0J0tjhIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JjPZuGLwoDJYBDFjlvz3BT8rTvoAdnKp
        PUh2tgIZtopVbsaN9vM12ohG+xJQZ99i/wej7MsOM9fvfG5LVTHFT3GXA7GEXvl+
        702oweBeC/kPYv0mkBJHM+RJzFsahWLCbJqkHG3c7zoVHIkf2IAwZzAkw3tQq1bm
        woFaxgcSEdE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AA8C37F74;
        Fri, 19 Aug 2016 16:31:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5B2F37F73;
        Fri, 19 Aug 2016 16:31:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 7/8] cache: add empty_tree_oid object
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-8-jacob.e.keller@intel.com>
Date:   Fri, 19 Aug 2016 13:31:27 -0700
In-Reply-To: <20160819000031.24854-8-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 18 Aug 2016 17:00:30 -0700")
Message-ID: <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E907732A-664B-11E6-9C0D-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Add an empty_tree_oid object which can be used in place of
> EMPTY_TREE_SHA1_BIN_LITERAL for code which is being converted to struct
> object_id.

How widely do you envision the users of this symbol would be spread
across the entire codebase?  I am debating myself if we need a
singleton in-core copy like this (if we end up referring to it from
everywhere), or we only need one level higher abstraction,
e.g. "is_empty_tree_oid()" helper (in which case I do not think we
even need a singleton; just imitate how is_empty_blob_sha1() is
implemented).

Even if we need such a singleton, I think we avoid ".field = value"
struct initializations in our code.

>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  cache.h     | 2 ++
>  sha1_file.c | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index f30a4417efdf..da9f0be67d7b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -964,6 +964,8 @@ static inline void oidclr(struct object_id *oid)
>  #define EMPTY_BLOB_SHA1_BIN \
>  	((const unsigned char *) EMPTY_BLOB_SHA1_BIN_LITERAL)
>  
> +extern const struct object_id empty_tree_oid;
> +
>  static inline int is_empty_blob_sha1(const unsigned char *sha1)
>  {
>  	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
> diff --git a/sha1_file.c b/sha1_file.c
> index 1e23fc186a02..10883d56a600 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -38,6 +38,9 @@ static inline uintmax_t sz_fmt(size_t s) { return s; }
>  
>  const unsigned char null_sha1[20];
>  const struct object_id null_oid;
> +const struct object_id empty_tree_oid = {
> +	.hash = EMPTY_TREE_SHA1_BIN_LITERAL
> +};
>  
>  /*
>   * This is meant to hold a *small* number of objects that you would
