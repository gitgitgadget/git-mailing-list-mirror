Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C91F1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfH3SIh (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 14:08:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56877 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfH3SIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 14:08:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 287A6164F81;
        Fri, 30 Aug 2019 14:08:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9mGXCtnGgOoNwbvJx1IgrBdnyuo=; b=vgAh0g
        ZIgQ+0RyPAlP3jTVrpQebm0ZYgBySfdNTVQvIOxs1eQOYLZfbKN2yph5BVTU7bL4
        zApPcX4NzUFiOoyEXRrHfzYjMS6LVEd/4COu/tO7EH4LjgkHgAAp63H6JV7YQtOE
        8RlXuFH+Ahph0m5U0Ls9NX/4tIwsmNIK6QslE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p1zJyXVbuwJ5t7vrXLB/GfVXbkD0C4mR
        ZeT2UMcLrPsX8csmR2/EZvOHbHim4fwMXL6GAthEcnvOyb3nBXwx0njT1/p/zVzt
        PdYMjYOXH8e8dsjwFE5/xNIwtnAh+qnJ8yfZ+7s2yquHg5c13Wz9YLa0u3N7egnD
        DEDAntw8h88=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F52C164F80;
        Fri, 30 Aug 2019 14:08:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74D4F164F7F;
        Fri, 30 Aug 2019 14:08:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jon Simons <jon@jonsimons.org>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        sunshine@sunshineco.com, stolee@gmail.com
Subject: Re: [PATCH v3 1/2] list-objects-filter: only parse sparse OID when 'have_git_dir'
References: <20190829231925.15223-1-jon@jonsimons.org>
        <20190829231925.15223-2-jon@jonsimons.org>
Date:   Fri, 30 Aug 2019 11:08:34 -0700
In-Reply-To: <20190829231925.15223-2-jon@jonsimons.org> (Jon Simons's message
        of "Thu, 29 Aug 2019 19:19:24 -0400")
Message-ID: <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F208938-CB51-11E9-AE6F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jon Simons <jon@jonsimons.org> writes:

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 1cb20c659c..aaba312edb 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -71,7 +71,8 @@ static int gently_parse_list_objects_filter(
>  		 * command, but DO NOT complain if we don't have the blob or
>  		 * ref locally.
>  		 */
> -		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
> +		if (have_git_dir() &&
> +		    !get_oid_with_context(the_repository, v0, GET_OID_BLOB,
>  					  &sparse_oid, &oc))
>  			filter_options->sparse_oid_value = oiddup(&sparse_oid);
>  		filter_options->choice = LOFC_SPARSE_OID;

Sorry, I do not quite understand what this wants to do.  We say "we
parsed this correctly, this filter is sparse:oid=<blob>" without
filling sparse_oid_value field at all.  What do the consumers of
such a filter_options instance do to such a half-read option?

If they say "ah, the parser wanted to do sparse:oid but we couldn't
really figure the <blob> part out, so let's ignore it", that might
be the best they could do anyway, but it somewhat feels iffy.  I
wonder if we are better off inventing a new "we tried to parse but
we lack sufficient info to make it useful" value to use in .choice
field and return it instead.

In the longer term, what do we want to happen in such a case where
"read this blob to figure out what I want you to do" cannot be
satisfied due to chicken-and-egg situation like this?  Can we
postpone fetching or cloning that *wants* to use the named <blob>
when we discover that the <blob> is not available (of which, your
"!have_git_dir()" is a subset), grab that single <blob> first from
the other side before doing the main transfer, and then resume the
transfer that wants to use the <blob> after we successfully do so,
or something?
