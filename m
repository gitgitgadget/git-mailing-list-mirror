Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61BB1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756066AbeAHUhf (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:37:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62258 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755320AbeAHUhe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:37:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65209D5746;
        Mon,  8 Jan 2018 15:37:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sPcHoIGrkcbQdrzssWr9d2Qi8sI=; b=u+g8hk
        8DJ3klI0d1HxxAczSWjKzYjUsYyP8OqSMtlxZWkx4tJhUbA9GhE0W+rG8JV2e8EY
        RlSqjm1gPa6GOeKM4ktlFPujZOTxYQcbuo9Cfa+Wk4LVwM1avTlugvmD2cjkisaX
        eUCpepb/bjlPajyWzdRFVdTZ0cwG81LcxL0Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jkk7ZeQynbDgn2lWUHFIOO6f9OHfCnzb
        S4IPTvJJlRtnL4hFCR8C4+6Qo2xgu/8LsDWR6Zh3XRfB28i7BixInjatzf7Ft8Jm
        4KBxBRwdsag3+72X8APx8iV2bsYkg/AwaMxB1j60j8tJy1YL6NNt4D9cPr4TuBG9
        GxN79Jt7ms4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B6CCD5745;
        Mon,  8 Jan 2018 15:37:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C96F4D5744;
        Mon,  8 Jan 2018 15:37:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, a.krey@gmx.de
Subject: Re: [PATCH 3/3] merge-recursive: Avoid incorporating uncommitted changes in a merge
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
        <20171221191907.4251-1-newren@gmail.com>
        <20171221191907.4251-3-newren@gmail.com>
Date:   Mon, 08 Jan 2018 12:37:31 -0800
In-Reply-To: <20171221191907.4251-3-newren@gmail.com> (Elijah Newren's message
        of "Thu, 21 Dec 2017 11:19:07 -0800")
Message-ID: <xmqqbmi484tw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0C2CD72-F4B3-11E7-98F9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 2ecf495cc2..780f81a8bd 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1952,6 +1952,13 @@ int merge_trees(struct merge_options *o,
>  	}
>  
>  	if (oid_eq(&common->object.oid, &merge->object.oid)) {
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		if (index_has_changes(&sb)) {
> +			err(o, _("Dirty index: cannot merge (dirty: %s)"),
> +			    sb.buf);
> +			return 0;
> +		}
>  		output(o, 0, _("Already up to date!"));
>  		*result = head;
>  		return 1;

I haven't come up with an addition to the test suite, but I suspect
this change is conceptually wrong.  What if a call to this function
is made during a recursive, inner merge?

Perhaps something like this is needed?

 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 780f81a8bd..0fc580d8ca 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1954,7 +1954,7 @@ int merge_trees(struct merge_options *o,
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		if (index_has_changes(&sb)) {
+		if (!o->call_depth && index_has_changes(&sb)) {
 			err(o, _("Dirty index: cannot merge (dirty: %s)"),
 			    sb.buf);
 			return 0;


