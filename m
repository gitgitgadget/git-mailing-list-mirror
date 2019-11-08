Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49D71F454
	for <e@80x24.org>; Fri,  8 Nov 2019 06:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKHGds (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 01:33:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60390 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKHGds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 01:33:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4231A9C69A;
        Fri,  8 Nov 2019 01:33:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RnGXpw+//4J75RV7dfaWzsTyMKw=; b=FiS6qe
        Rdthhj6p1jb0o77hDhKxyRIWIrhz9pJaUv+qWfrgzFYECXeXM+8o4trujm2Y4C6W
        XAgkGtx7r17Dio6Q+v2gav2zXQqE/Ux3P3AnzDyn91GIba8F2uhnnhcerRVP8z53
        aeyJ5ecNnelIPs3+ENL6wVL29KxFxPCyNokPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BJDtxExkdTOEVsjXcrwiGLhpl15/NT7k
        PUry90YOYHsTaEKR/Tj7pd8t/ldEqabLDbMvfFmUdlIVnnru4eMg7SKzMvJ9Pm0N
        TxVx/lo3DBZEO2hPt3AGVTdXfl6/yb4UqsMdBYX76S7uogk1vi6kY6wQ6KNoccG3
        8cXi9dAFiqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A6BE9C699;
        Fri,  8 Nov 2019 01:33:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 635829C698;
        Fri,  8 Nov 2019 01:33:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] fetch: remove fetch_if_missing=0
References: <20191101203830.231676-1-jonathantanmy@google.com>
        <20191105185619.207173-1-jonathantanmy@google.com>
Date:   Fri, 08 Nov 2019 15:33:40 +0900
In-Reply-To: <20191105185619.207173-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 5 Nov 2019 10:56:19 -0800")
Message-ID: <xmqqr22inagr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5A18710-01F1-11EA-B137-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0c345b5dfe..5ff7367dd7 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1074,7 +1074,8 @@ static int check_exist_and_connected(struct ref *ref_map)
>  	 * we need all direct targets to exist.
>  	 */
>  	for (r = rm; r; r = r->next) {
> -		if (!has_object_file(&r->old_oid))
> +		if (!has_object_file_with_flags(&r->old_oid,
> +						OBJECT_INFO_SKIP_FETCH_OBJECT))
>  			return -1;
>  	}
>  
> @@ -1755,8 +1756,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	packet_trace_identity("fetch");
>  
> -	fetch_if_missing = 0;
> -
>  	/* Record the command line for the reflog */
>  	strbuf_addstr(&default_rla, "fetch");
>  	for (i = 1; i < argc; i++)

As this is on a stale codebase, let's base the fix on top of
c32ca691c2 or later.  The part of the patch for builtin/fetch.c
adjusted for that decision would look like attached.

An interesting thing is that c32ca691c2^2 that moved the assignment
to this big red switch variable around causes 3-way merge to fail in
a miserable way.  The "moving around" would involve removing from
the same location as the rebased patch below removes, plus adding
the assignment elsewhere, so "both sides removed the assignment from
this hunk, so take that" would correctly leave the original assignment
we see in the second hunk above removed, but fails to notice that
the assignment made elsewhere (the result of "moving around" patch)
is no longer needed, because "c32ca691c2^2 added one and this change
does not do anything there, so take the addition" cleanly resolves
to an incorrect merge result.

 builtin/fetch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 863c858fde..5ff7367dd7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1074,7 +1074,8 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 * we need all direct targets to exist.
 	 */
 	for (r = rm; r; r = r->next) {
-		if (!has_object_file(&r->old_oid))
+		if (!has_object_file_with_flags(&r->old_oid,
+						OBJECT_INFO_SKIP_FETCH_OBJECT))
 			return -1;
 	}
 
@@ -1822,8 +1823,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	fetch_if_missing = 0;
-
 	if (remote) {
 		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
