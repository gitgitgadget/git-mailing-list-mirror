Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5243C43217
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiEWS1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245606AbiEWS1L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:27:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ED2118027
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:02:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3EA31824E5;
        Mon, 23 May 2022 14:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BiX+ohDFj9/6EKBCXc5MKs8lP+rF/j28vjOs3+
        Io1TM=; b=oVf8Jkxi0Zk8z2BbdRUJtpTTIDHHFWwDFAbAyfDXhYlegMNgZBuPYc
        MIk+2aTD5+HFZNL4C+uUz0uatysVHKHM3jQoM7+mUERww6umYIfLTma/zIZlUoqo
        GcTtFIAN97EEcTqOxlsODZdYpbVFT1PqZLP0Er7Gp81S9yfzUz+Hg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D9C31824E4;
        Mon, 23 May 2022 14:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4CEEA1824E3;
        Mon, 23 May 2022 14:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/10] sparse-index: complete partial expansion
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
        <xmqqsfp3coqy.fsf@gitster.g>
        <5909f466-c323-0874-b175-51fe5e93dc12@github.com>
        <f9abea8d-5386-5275-4de2-27d443945c7a@github.com>
Date:   Mon, 23 May 2022 11:01:54 -0700
In-Reply-To: <f9abea8d-5386-5275-4de2-27d443945c7a@github.com> (Derrick
        Stolee's message of "Mon, 23 May 2022 09:18:43 -0400")
Message-ID: <xmqqmtf8ruul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E74C288-DAC2-11EC-A11A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> As I went to remove these from sparse-index.c, I found another that
> exists, but for good reason. See 8a96b9d0a (sparse-index: use
> WRITE_TREE_MISSING_OK, 2021-09-08), which explains that that instance
> needs the flag because it could be used during 'git add'.

Hmph, re-reading that explanation, it appears to me that it is
working around a lack of another option that could be useful in such
a situation, namely, "update the cache tree, and if a tree object is
missing then create one locally; do not bother asking any promisor
remote".  I am reasonably sure that back when I invented missing-ok
there wasn't any such thing as "promisor remote" or "lazy fetch",
and it sounds like those who added "promissor remote" broke the
cache-tree subsystem by introducing calls to fetch from elsewhere?

How does a normal "new object creation" codepath work when promisor
remotes exist?  Does write_object_file() first ask if any promisor
remote have that object and fetch before creating one locally?  That
sounds absurd (i.e. if we have data to create locally why ask others
if they have one already?).  Why should cache-tree behave any
differently?

All of the above are mere observations on changes that have nothing
to do with the change in this series, but cache_tree_update()
knowing about promisor remotes feels serious breakage to me.

> It still isn't necessary in the instances being added here, so I will
> remove them.

OK.
