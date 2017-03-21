Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319AD2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757701AbdCUSUt (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:20:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54429 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933674AbdCUSTq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:19:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 942F06503D;
        Tue, 21 Mar 2017 14:14:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h1NiTYEfcxB076NYHHbTs3oXPOw=; b=ZFse8J
        lEizFKRUwNu4x3bi521iKPSjTrvfmxxsOTiUC2tst3BfsnRX+Iz4SsSPs11jDJlm
        bJHbEAWdfHO1D99C3dF+e26eyJgaWhvx272F2sHZIpEVboqpI05wjPLWPhjaYoM4
        735EjPHrKviO7OC/yxHMvvkA8sHYL1iD0eFWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YvBChhSi+3pV2qBwfVQ1FCJmw6zfYuV0
        4zNYuAT1sPhxJ9PwheitP+WqHK31z84x0Iy1a3YnxuXMcybMwnoey7Bkb6cN2Gj9
        y4VTN4kNnprTjiH2Uc6A65mqV4YBGkvG7Ml0K3LHzsGmpF+Br/QL9Jk7OXmb5hEi
        qwliOMDQU4Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C1D76503C;
        Tue, 21 Mar 2017 14:14:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 004E965035;
        Tue, 21 Mar 2017 14:14:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] prefix_filename: return newly allocated string
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
        <20170321012847.yebhpdmk5zrizgmj@sigill.intra.peff.net>
Date:   Tue, 21 Mar 2017 11:14:23 -0700
In-Reply-To: <20170321012847.yebhpdmk5zrizgmj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Mar 2017 21:28:49 -0400")
Message-ID: <xmqqinn2qyyo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36FBFA2E-0E62-11E7-BD40-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/worktree.c b/worktree.c
> index 42dd3d52b..2520fc65c 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -250,16 +250,19 @@ struct worktree *find_worktree(struct worktree **list,
>  {
>  	struct worktree *wt;
>  	char *path;
> +	char *to_free;
>  
>  	if ((wt = find_worktree_by_suffix(list, arg)))
>  		return wt;
>  
> -	arg = prefix_filename(prefix, arg);
> +	if (prefix)
> +		arg = to_free = prefix_filename(prefix, arg);
>  	path = real_pathdup(arg, 1);
>  	for (; *list; list++)
>  		if (!fspathcmp(path, real_path((*list)->path)))
>  			break;
>  	free(path);
> +	free(to_free);
>  	return *list;
>  }

worktree.c:265:6: error: to_free may be used uninitialized in this function
---
 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 2520fc65cc..bae787cf8d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -250,7 +250,7 @@ struct worktree *find_worktree(struct worktree **list,
 {
 	struct worktree *wt;
 	char *path;
-	char *to_free;
+	char *to_free = NULL;
 
 	if ((wt = find_worktree_by_suffix(list, arg)))
 		return wt;
-- 
2.12.1-382-gc0f9c70589

