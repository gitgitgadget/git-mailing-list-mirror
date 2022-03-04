Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED6C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 02:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiCDCio (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiCDCin (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 21:38:43 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB63D3C4B1
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 18:37:56 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E413D170132;
        Thu,  3 Mar 2022 21:37:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8D5Anu2l6BebQnFKa81sKRviaNaL2vOrtGYlIg
        tGrAo=; b=AkGgWI9J3pFpThnLq+x+L+KpTPD42cR5JLviDbnAt376MVgzUmglCC
        vBEF7ylh+lExkQuJuZBwapzNXRwpkZu4Y+Ka4Od+1At846MwLGMK8QbgJHxG83UA
        7Q7fsB+P9/NqAa6JRhCvGJbyRtXVIU6CREuQ3T7051LOqUIqDOwr8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBA5D170131;
        Thu,  3 Mar 2022 21:37:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D61C170130;
        Thu,  3 Mar 2022 21:37:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 09/10] fetch: fetch unpopulated, changed submodules
References: <20220224100842.95827-1-chooglen@google.com>
        <20220304005757.70107-1-chooglen@google.com>
        <20220304005757.70107-10-chooglen@google.com>
Date:   Thu, 03 Mar 2022 18:37:52 -0800
In-Reply-To: <20220304005757.70107-10-chooglen@google.com> (Glen Choo's
        message of "Thu, 3 Mar 2022 16:57:56 -0800")
Message-ID: <xmqqsfry4f3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17716984-9B64-11EC-A658-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>  		item = string_list_insert(changed, name);
> -		if (!item->util)
> +		if (item->util)
> +			cs_data = item->util;
> +		else {
>  			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
> -		cs_data = item->util;
> +			cs_data = item->util;
> +			cs_data->super_oid = commit_oid;
> +			cs_data->path = xstrdup(p->two->path);
> +		}

I do not quite get this change.

collect_changed_submodules() walks a range of revisions in the
superproject, doing an equivalent of "git log --raw" and feeding the
differences to this callback function.  The above code looks at the
path and uses the "changed" string list to record which submodule
was modified, what commit in the submodule is needed, etc.

What happens when the range has more than one change to the same
submodule?  cs_data has only one room for recording .super_oid
(which commit in the superproject touches the submodule) and .path
(where in the superproject's tree the submodule exists).  "git mv"
of a submodule might be rare and it may not hurt too much that only
a single .path can be kept, but it looks somewhat iffy.

>  		oid_array_append(&cs_data->new_commits, &p->two->oid);

At least, we are not losing any submodule commit even when the same
submodule is touched more than once by the superproject, but it is
dubious why we have cs_data.super_oid and cs_data.path in the first
place.

How are they used, or are they something that seemed useful when the
code was first written but it turned out that they weren't and left
unused?

Or do we need to make cs_data an array of 3-tuple { .super_oid,
.submodule_oid, .path } for each submodule name?
