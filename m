Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A21D202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 06:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdJYGn0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 02:43:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52265 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751421AbdJYGnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 02:43:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99DBCADB1C;
        Wed, 25 Oct 2017 02:43:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=US1K+gYuVKacw9Zh11vZ3rbR56s=; b=fUYwMM
        9LAjm3ULm0q1WlDGrUgPbzC4SBo/hVyuTh2+BtD8mR7FLgral9BK76Ek53krk2eW
        kHUVJ2EF2al/KL64SzD+25hS/yVBTF/Z5YQq4rVGD/Mrn1fJMOuUkn7f6P8O9wFL
        1VRoeEWoE9IqhZjHNFlydX2x64V+4SKSKFm7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dl6Olxq8s8VYQLhkYN7Xkf04QEVNEy4r
        reztIQ/YS01Sp85utxgArrNBAQXOEHwpmLlW8LwT+L6C6/VI3uAXDuvTpw/KamSI
        PkhFVilaDoGGmI+5q5Q5AFjBJr7yjYNrQx3nTd53iGkGYKQTGm0rkdfnCEo/uvjx
        B6Hk0hz1pYA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 915B2ADB1B;
        Wed, 25 Oct 2017 02:43:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AE15ADB19;
        Wed, 25 Oct 2017 02:43:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 01/13] dir: allow exclusions from blob in addition to file
References: <20171024185332.57261-1-git@jeffhostetler.com>
        <20171024185332.57261-2-git@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 15:43:22 +0900
In-Reply-To: <20171024185332.57261-2-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Tue, 24 Oct 2017 18:53:20 +0000")
Message-ID: <xmqq60b3iv79.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC61CAEC-B94F-11E7-8106-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +static int add_excludes_from_buffer(char *buf, size_t size,
> +				    const char *base, int baselen,
> +				    struct exclude_list *el);
> +
>  /*
>   * Given a file with name "fname", read it (either from disk, or from
>   * an index if 'istate' is non-null), parse it and store the
> @@ -754,9 +758,9 @@ static int add_excludes(const char *fname, const char *base, int baselen,
>  			struct sha1_stat *sha1_stat)
>  {
>  	struct stat st;
> -	int fd, i, lineno = 1;
> +	int fd;
>  	size_t size = 0;
> -	char *buf, *entry;
> +	char *buf;
>  
>  	fd = open(fname, O_RDONLY);
>  	if (fd < 0 || fstat(fd, &st) < 0) {

The post-context of this hunk is quite interesting in that there is
a call to read_skip_worktree_file_from_index(); which essentially 
pretends as if we read from the filesystem but in fact it grabs the
blob object name registered in the index and reads from it.

The reason why it is interesting is because this patch adds yet
nother "let's instead read from a blob object" function and there is
no sign to make the existing one take advantage of the new function
seen in this patch.
