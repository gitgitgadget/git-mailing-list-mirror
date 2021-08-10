Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74737C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 21:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C70360F55
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 21:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhHJVOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:14:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63010 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhHJVOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 17:14:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EF1ACA2B6;
        Tue, 10 Aug 2021 17:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AdNR6XR/eAOhSeqAE8L7737+gLuTMAGyXiCsbW
        SYRwY=; b=NRVyIXPcq2jtYLRQ8wLM7jKm/JikQiqDhKNb4OJhsiqLOmJDTiSc2/
        MksaXQM7+wLCKQ/qG8kPZspiOjOd6UKWGILQ1l0ymIH7OaMI7KdHeGQwKCBVlNxX
        HgoLu+CazW1fZk42bgLrbKtlQCgesKka3Kom+elnew1tZyCa/VmCA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9767FCA2B4;
        Tue, 10 Aug 2021 17:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17F69CA2B3;
        Tue, 10 Aug 2021 17:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] submodule: lazily add submodule ODBs as alternates
References: <cover.1628618950.git.jonathantanmy@google.com>
        <5994a517e8afc345e8f649b2368756e22b0e9ebe.1628618950.git.jonathantanmy@google.com>
Date:   Tue, 10 Aug 2021 14:13:56 -0700
In-Reply-To: <5994a517e8afc345e8f649b2368756e22b0e9ebe.1628618950.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 10 Aug 2021 11:28:39 -0700")
Message-ID: <xmqqtujxc8a3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFD50F98-FA1F-11EB-BB61-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -1592,6 +1593,10 @@ static int do_oid_object_info_extended(struct repository *r,
>  				break;
>  		}
>  
> +		if (register_all_submodule_odb_as_alternates())
> +			/* We added some alternates; retry */
> +			continue;
> +

OK.  Unless we are running in the "we no longer are relying on the
submodule-odb-as-alternates hack" mode, the control may reach this
point number of times, so this caller expects the function to return
how many new odbs were added with this single invocation.

> diff --git a/submodule.c b/submodule.c
> index 8e611fe1db..8fde90e906 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -165,6 +165,8 @@ void stage_updated_gitmodules(struct index_state *istate)
>  		die(_("staging updated .gitmodules failed"));
>  }
>  
> +static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
> +

I see 2/7 allows callers to add paths for submodule odb to this
list.

> @@ -178,12 +180,28 @@ int add_submodule_odb(const char *path)
>  		ret = -1;
>  		goto done;
>  	}
> -	add_to_alternates_memory(objects_directory.buf);
> +	string_list_insert(&added_submodule_odb_paths,
> +			   strbuf_detach(&objects_directory, NULL));

OK.  By default, any codepath that still call add_submodule_odb()
will add the paths to submodules to the list (so that they will
lazily be loaded).

> +int register_all_submodule_odb_as_alternates(void)
> +{
> +	int i;
> +	int ret = added_submodule_odb_paths.nr;
> +
> +	for (i = 0; i < added_submodule_odb_paths.nr; i++)
> +		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
> +	if (ret) {
> +		string_list_clear(&added_submodule_odb_paths, 0);
> +		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
> +			BUG("register_all_submodule_odb_as_alternates() called");
> +	}
> +	return ret;
> +}

OK.  We add new ones that were added to the list since we were
called for the last time and clear the list.  When we didn't add
anything, we will return 0.  Seems to mean well.

I wonder if we need to prepare ourselves to catch callers that call
add_submodule_odb() to the same path twice or more.  Probably not.

Thanks.

The "pretend as if objects in submodule odb are locally available",
even though it may have been useful, was an ugly hack invented
before we started adding the "access more than one repository at the
time with the 'repo' arg" extended API.  It is pleasing to see this
step shows an approach to incrementally migrate the users of the
hack.

