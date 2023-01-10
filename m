Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4221BC54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjAJNOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbjAJNOC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:14:02 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD98138
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:14:01 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 663BECA1261;
        Tue, 10 Jan 2023 08:14:00 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:8902:4d8e:1b37:eec2] (unknown [IPv6:2600:1700:840:e768:8902:4d8e:1b37:eec2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1E743CC8312;
        Tue, 10 Jan 2023 08:14:00 -0500 (EST)
Message-ID: <a28f1f70-0259-e249-87e7-57dedd01de91@jeffhostetler.com>
Date:   Tue, 10 Jan 2023 08:13:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 5/5] treewide: always have a valid "index_state.repo"
 member
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <patch-5.5-b3b0e592101-20230110T060340Z-avarab@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <patch-5.5-b3b0e592101-20230110T060340Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/10/23 1:17 AM, Ævar Arnfjörð Bjarmason wrote:
> When the "repo" member was added to "the_index" in [1] the
> repo_read_index() was made to populate it, but the unpopulated
> "the_index" variable didn't get the same treatment.
> 
> Let's do that in initialize_the_repository() when we set it up, and
> likewise for all of the current callers initialized an empty "struct
> index_state".
> 
> This simplifies code that needs to deal with "the_index" or a custom
> "struct index_state", we no longer need to second-guess this part of
> the "index_state" deep in the stack. A recent example of such
> second-guessing is the "istate->repo ? istate->repo : the_repository"
> code in [2]. We can now simply use "istate->repo".
> 
> For "fsmonitor-settings.c" we can remove the initialization of a NULL
> "r" argument to "the_repository". This was added back in [3], and was
> needed at the time for callers that would pass us the "r" from an
> "istate->repo". Before this change such a change to
> "fsmonitor-settings.c" would segfault all over the test suite (e.g. in
> t0002-gitfile.sh).
[...]

Thanks for looking at this.  Yes, it'll be nice to be able to
finally depend on istate->repo not being null all over the place.

Jeff

