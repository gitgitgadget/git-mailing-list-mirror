Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7233C433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3DD2076D
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2ebCGof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgH2SzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:55:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59427 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 14:55:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 907BA70188;
        Sat, 29 Aug 2020 14:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1upfvjnI4KeF+vq+9HE5lRWb7nM=; b=e2ebCG
        ofUXIZwRBC2JhIlzG8e9NyhLqPODuHHs1gT5gxKE9sV8ZyORSGSqE8wc/2HmWRWq
        AnS6iMkLMXG/ZrqI3Edl71OKrqVrTTAEEd03rSY2t4BYOm0kDSV1Hea5ouJxSp9E
        awMWeIMWQUUs1B65sc1klbNqKtBJNEo2ashuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wphbEgzB42dhxhxuloa9UmwoQ6ikZvw3
        Bg2vGRZy9UNHvRTFkzCCv0cfpreZROyxsBcLz4k1Zaot9TNAFKjo5i2Tcoqq82kv
        xlJTRUYLQboJF60q3S6Jyfk3OIqu5duXsmXkqEvARlH9VFR5W1Nb/BX5CznsVZ15
        DxdhOa3Zk4w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 873D870186;
        Sat, 29 Aug 2020 14:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0834470185;
        Sat, 29 Aug 2020 14:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 2/2] wt-status: tolerate dangling marks
References: <20200513004058.34456-1-jonathantanmy@google.com>
        <cover.1598662525.git.jonathantanmy@google.com>
        <59b91a206d9d7bf64825cb48c747730e28b10a79.1598662525.git.jonathantanmy@google.com>
Date:   Sat, 29 Aug 2020 11:55:14 -0700
In-Reply-To: <59b91a206d9d7bf64825cb48c747730e28b10a79.1598662525.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 28 Aug 2020 18:02:27 -0700")
Message-ID: <xmqqo8mti8od.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C91842C-EA29-11EA-9160-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +
> +	/*
> +	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
> +	 * branch in question does not have such a reference, return -1 instead
> +	 * of die()-ing.
> +	 */
> +	unsigned nonfatal_dangling_mark : 1;

Micronit; I would have avoided "or equivalent" as the point of
parenthetical comment was not to say these two modifiers upstream
and push (and other forms that spell differently but invokes exactly
one of these two features) are special, but to say that these two
are merely examples, and any other ^{modifiers} we have or we will
add in the future would honor this bit.  Perhaps "(and the like)"?

>  };
>  int repo_interpret_branch_name(struct repository *r,
>  			       const char *str, int len,
> diff --git a/refs.c b/refs.c
> index cf09cd039f..b6f1a2f452 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -598,10 +598,13 @@ const char *git_default_branch_name(void)
>   * to name a branch.
>   */
>  static char *substitute_branch_name(struct repository *r,
> -				    const char **string, int *len)
> +				    const char **string, int *len,
> +				    int nonfatal_dangling_mark)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	struct interpret_branch_name_options options = { 0 } ;
> +	struct interpret_branch_name_options options = {
> +		.nonfatal_dangling_mark = nonfatal_dangling_mark
> +	};
>  	int ret = repo_interpret_branch_name(r, *string, *len, &buf, &options);
>  
>  	if (ret == *len) {
> @@ -615,9 +618,10 @@ static char *substitute_branch_name(struct repository *r,
>  }
>  
>  int repo_dwim_ref(struct repository *r, const char *str, int len,
> -		  struct object_id *oid, char **ref)
> +		  struct object_id *oid, char **ref, int nonfatal_dangling_mark)
>  {
> -	char *last_branch = substitute_branch_name(r, &str, &len);
> +	char *last_branch = substitute_branch_name(r, &str, &len,
> +						   nonfatal_dangling_mark);
>  	int   refs_found  = expand_ref(r, str, len, oid, ref);
>  	free(last_branch);
>  	return refs_found;
> @@ -625,7 +629,7 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
>  
>  int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
>  {
> -	return repo_dwim_ref(the_repository, str, len, oid, ref);
> +	return repo_dwim_ref(the_repository, str, len, oid, ref, 0);
>  }
>  
>  int expand_ref(struct repository *repo, const char *str, int len,
> @@ -666,7 +670,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
>  		  struct object_id *oid, char **log)
>  {
>  	struct ref_store *refs = get_main_ref_store(r);
> -	char *last_branch = substitute_branch_name(r, &str, &len);
> +	char *last_branch = substitute_branch_name(r, &str, &len, 0);
>  	const char **p;
>  	int logs_found = 0;
>  	struct strbuf path = STRBUF_INIT;

Among these callers that reach substitute_branch_name(), how were
those that can specify the new bit chosen?

For example, what is the reasoning behind making dwim_ref() unable
to ask the "do so gently" variant, while allowing repo_dwim_ref()
to?

I am NOT necessarily saying these two functions MUST be able to
access the same set of features and the only difference between them
MUST be kept to the current "repo_* variant can work on an arbitrary
repository, while the variant without repo_* would work on the
primary repository only".  As long as there is a good reason to make
their power diverge, it is OK---I just do not see why and I'd like
to know.

The same question about not allowing the gentler variant while
drimming the reflog.

Thanks.
