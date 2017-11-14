Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4AF201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750811AbdKNB0v (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:26:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55998 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750779AbdKNB0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:26:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5AD6AA75A;
        Mon, 13 Nov 2017 20:26:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RXENQgJOMOSARvm7iTXaq/LL7Lo=; b=FzNU3k
        IXJ14Gi5D/UEsV0AwrSk5UV7Bo1TNv7pybryAz7dLH3YQ1Hde2IuBCfnosNEYIZg
        HjqNxwINGUZfoRdW+gJXVb7K59D1LmPAB9jicXK/kPe6I8lZPDbi26kPdMdQQdN0
        Vaxmb0KBX6If8MLTLz6XoNcpVOGd914/H/sbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YDEInLes2fN22nDNW1Ea5QvijrR4JlAW
        UA26NxCejhDIwVxuDaQXVWgkOJVDfEfYIhR0mfu7oGu7WKErvNRm2rUrLg3rdiFD
        /K0gn5vUGUfqxXQnjdG/I8qaY1pgZE40YiUjkes2mzuOn3PacxwzoGMMRkXOGgVK
        dkeTg9s6dhQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C595AA759;
        Mon, 13 Nov 2017 20:26:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CC56AA758;
        Mon, 13 Nov 2017 20:26:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/30] merge-recursive: Add explanation for src_entry and dst_entry
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-4-newren@gmail.com>
Date:   Tue, 14 Nov 2017 10:26:47 +0900
In-Reply-To: <20171110190550.27059-4-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 11:05:23 -0800")
Message-ID: <xmqqshdh7iqw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2C8B4C2-C8DA-11E7-A846-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> If I have to walk through the debugger and inspect the values found in
> here in order to figure out their meaning, despite having known these
> things inside and out some years back, then they probably need a comment
> for the casual reader to explain their purpose.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 52521faf09..3526c8d0b8 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -513,6 +513,28 @@ static void record_df_conflict_files(struct merge_options *o,
>  
>  struct rename {
>  	struct diff_filepair *pair;
> +	/*
> +	 * Because I keep forgetting every few years what src_entry and
> +	 * dst_entry are and have to walk through a debugger and puzzle
> +	 * through it to remind myself...

Very much appreciated.  I recall having trouble reasoning about
them myself, too (even though I admit I wasn't involved in the
implementation of this part very much and know this code a lot less
intimately than you do in the first place).

> +	 *
> +	 * If 'before' is renamed to 'after' then src_entry will contain
> +	 * the versions of 'before' from the merge_base, HEAD, and MERGE in
> +	 * stages 1, 2, and 3; dst_entry will contain the versions of
> +	 * 'after' from the merge_base, HEAD, and MERGE in stages 1, 2, and
> +	 * 3.  Thus, we have a total of six modes and oids, though some
> +	 * will be null.  (Stage 0 is ignored; we're interested in handling
> +	 * conflicts.)
> +	 *
> +	 * Since we don't turn on break-rewrites by default, neither
> +	 * src_entry nor dst_entry can have all three of their stages have
> +	 * non-null oids, meaning at most four of the six will be non-null.
> +	 * Also, since this is a rename, both src_entry and dst_entry will
> +	 * have at least one non-null oid, meaning at least two will be
> +	 * non-null.  Of the six oids, a typical rename will have three be
> +	 * non-null.  Only two implies a rename/delete, and four implies a
> +	 * rename/add.
> +	 */
>  	struct stage_data *src_entry;
>  	struct stage_data *dst_entry;
>  	unsigned processed:1;
