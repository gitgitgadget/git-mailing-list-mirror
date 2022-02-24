Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B2DC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiBXXCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiBXXCH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:02:07 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB0AE016
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:01:35 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63AFD1765BB;
        Thu, 24 Feb 2022 18:01:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v+74st7KCCxbxKrkDNHUqa2cxtY6f7YYlQvgYJ
        s5P4Q=; b=Pv7wjiTK1FnGWqcqMW63f1yOG887FLHrHUAr8thiShvL7eDBRVSJg8
        C8sSJRB5e3uZLp2ePEo63WBpUBtkqVO5zKLGUUhV5GoXGHePI0cDLAEQ/ZgayvN6
        TF1ttizu8iG78AzEYJuUo+GWK/hiqcIKU3zUK6tCw67GLqOpEQLt4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B5B61765BA;
        Thu, 24 Feb 2022 18:01:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C49F51765B5;
        Thu, 24 Feb 2022 18:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 6/7] commit-graph: parse file format v2
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <28fe8824ba71ff9cda5ec5c034b6a6fb3c857654.1645735117.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 15:01:31 -0800
In-Reply-To: <28fe8824ba71ff9cda5ec5c034b6a6fb3c857654.1645735117.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 24 Feb 2022
        20:38:35 +0000")
Message-ID: <xmqq1qzrkgxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5861D6C-95C5-11EC-84DD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The commit-graph file format v2 alters how it stores the corrected
> commit date offsets within the Commit Data chunk instead of a separate
> chunk. The idea is to significantly reduce the amount of data loaded
> from disk while parsing the commit-graph.
>
> We need to alter the error message when we see a file format version
> outside of our range now that multiple are possible. This has a
> non-functional side-effect of altering a use of GRAPH_VERSION within
> write_commit_graph().
>
> By storing the file format version in 'struct commit_graph', we can
> alter the parsing code to depend on that version value. This involves
> changing where we look for the corrected commit date offset, but also
> which constants we use for jumping into the Generation Data Overflow
> chunk. The Commit Data chunk only has 30 bits available for the offset
> while the Generation Data chunk has 32 bits. This only makes a
> meaningful difference in very malformed repositories.
>
> Also, we need to be careful about how we enable using corrected commit
> dates and generation numbers to rely upon the read_generation_data value
> instead of a non-zero value in the Commit Date chunk. In
> generation_numbers_enabled(), the first_generation variable is
> attemptint to look for the first topological level stored to see that it
> is nonzero. However, for a v2 commit-graph, this value is actually
> likely to be zero because the corrected commit date offset is probably
> zero.

I see references to OVERFLOW_V3 that comes after OVERFLOW, but there
is no OVERFLOW_V2.  Intended, or should it be V2 to match the "file
format v2" of "generation number v2"?  It is getting awkward to have
two different version scheme ("gen v2" means corrected committer
timestamp, whose on-disk representation is different between "file
v1" and "file v2", and this OVERFLOW vs OVERFLOW_V3 is about the
difference between "file v1" and "file v2" if I am following the
series correctly).
