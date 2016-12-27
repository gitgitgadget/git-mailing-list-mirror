Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D3B200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756094AbcL0TKf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:10:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64136 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756140AbcL0TKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:10:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 304DA59A43;
        Tue, 27 Dec 2016 14:10:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o1InuWDxxlbtsy/c5rQSnZFKISw=; b=vRPkim
        hR32yXool+O+knCrv8iuyLRu444knmXvl9ONSptQ9Cvkv86V1LeTjIYB7c8LWnNW
        M6goJIX6AUBofcAoaS7mNx3qGGMmoSOCFx4F5bM5MqHX+2Pc+6fTyYDZiKJ1FlN+
        Y9/NKXw43TNkBhkx+2yEKWK6S/JIAoKRH26Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JjOjakq25YdumBhMq6d8NErrQ0QjUR5s
        mJ4F05X1pEtyPt+eI/pH5OwAcugmaM/YJChXHNep2CmylHlQAhWgfSILA8s4wpta
        gp/JE8GwQ5dyH+NLkW1mtVjoN9bu44XdObKgPCx0jKfrjhTOXTH9F2zTWQJ7lfbe
        T329RwTtOPg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 280D059A42;
        Tue, 27 Dec 2016 14:10:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AFFD59A41;
        Tue, 27 Dec 2016 14:10:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
Date:   Tue, 27 Dec 2016 11:10:30 -0800
In-Reply-To: <20161226102222.17150-15-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 26 Dec 2016 11:22:15 +0100")
Message-ID: <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22FE337A-CC68-11E6-95DD-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +/*
> + * Signal that the shared index is used by updating its mtime.
> + *
> + * This way, shared index can be removed if they have not been used
> + * for some time. It's ok to fail to update the mtime if we are on a
> + * read only file system.
> + */
> +void freshen_shared_index(char *base_sha1_hex)
> +{
> +	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
> +	check_and_freshen_file(shared_index, 1);

What happens when this call fails?  The function returns 0 if the
file did not even exist.  It also returns 0 if you cannot update its
timestamp.

Shouldn't the series be exposing freshen_file() instead _and_ taking
its error return value seriously?

> +}
> +
>  int read_index_from(struct index_state *istate, const char *path)
>  {
>  	struct split_index *split_index;
> @@ -2273,6 +2286,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>  		int ret = write_shared_index(istate, lock, flags);
>  		if (ret)
>  			return ret;
> +	} else {
> +		freshen_shared_index(sha1_to_hex(si->base_sha1));
>  	}
>  
>  	return write_split_index(istate, lock, flags);
