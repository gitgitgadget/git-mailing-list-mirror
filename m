Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D731F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 06:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeKTQlN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:41:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65395 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeKTQlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:41:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1EF328CE9;
        Tue, 20 Nov 2018 01:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A2INwclybd+pEh1lwmOdPD0+geE=; b=cPifUe
        fZ4lkP6ckqL+gbDgMptJcISafO8i6pcSq7ulLHx2ed5LdCRZNf432TOJBMetqIAH
        7hoiuHeEzyum48B9g3EO/IH75Qik/QTVdZt5+EoLzsP7/2+X4uFPEItBuP8WFbDE
        /ELDViFEqNcqQgW9137ll9c7li2XRj8DpEEN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WmG8yXYPD5U7EtxvJqQAZCqpJCnnHMrt
        ZtgumJIFPnQbCF7D6keDvzgJJK38fX9MUglV3DPCD5QQvk+yi6iZit52S5G4QRRe
        i/ATaQoqt9ooTEKvDjo5Z35M5LYf7OSUkwocNjhnOouqhvZJd7qQLSZqecFKFzSx
        4TDiHiJg9Ec=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EFC328CE8;
        Tue, 20 Nov 2018 01:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DC2128CE6;
        Tue, 20 Nov 2018 01:13:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] revision.c: use new topo-order logic in tests
References: <pull.83.git.gitgitgadget@gmail.com>
        <ab7c2dd46fb72523b865ecf34204c7ae31dee416.1542654209.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Nov 2018 15:13:42 +0900
In-Reply-To: <ab7c2dd46fb72523b865ecf34204c7ae31dee416.1542654209.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 19 Nov 2018
        11:03:33 -0800 (PST)")
Message-ID: <xmqqsgzw9syx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F4B25C2-EC8B-11E8-A22C-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -3143,6 +3144,9 @@ int prepare_revision_walk(struct rev_info *revs)
>  		commit_list_sort_by_date(&revs->commits);
>  	if (revs->no_walk)
>  		return 0;
> +	if (revs->limited &&
> +	    git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
> +		revs->limited = 0;
>  	if (revs->limited) {
>  		if (limit_list(revs) < 0)
>  			return -1;

That is equivalent to say

	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
		revs->limited = 0;

Wouldn't that make the codepath that involves limit_list()
completely unreachable while testing, though?

The title only mentions "topo-order" logic, but the topo-order is
not the only reason why limited bit can be set, is it?  When showing
merges, simplifying merges, or post-processing to show ancestry
path, or showing a bottom-limited revision range, the limited bit is
automatically set because all of these depend on first calling
limit_list() and then postprocessing its result.  Doesn't it hurt
these cases to unconditionally drop limited bit?

