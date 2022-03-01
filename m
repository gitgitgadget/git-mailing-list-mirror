Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CBDC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiCAUd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbiCAUc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:32:58 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97135E03B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:32:13 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E435C110AAC;
        Tue,  1 Mar 2022 15:32:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+UpnTBD8pvkVJFckUQSCx7njBVITAPEAgH29YF
        TbLzs=; b=GBDuEw7iTPIaB/DGOf4s321TnuH7kppnzkm0dPzP/+y4ZABQxeHnSg
        RCi9jh3ZUbSpaIqnOGGJlptJZmf5jJjvyMX8W06KsCKLA9tT0m/g+ANyYds0BHTr
        q/ZaxSsccEoonf6t6yEGAvZ2wBXAoxtZYelKQ7/2OVDenoi4GP0R8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB633110AAB;
        Tue,  1 Mar 2022 15:32:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A767110AA7;
        Tue,  1 Mar 2022 15:32:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
References: <20220215172318.73533-1-chooglen@google.com>
        <20220224100842.95827-1-chooglen@google.com>
        <20220224100842.95827-10-chooglen@google.com>
        <xmqqr17p5ujf.fsf@gitster.g>
Date:   Tue, 01 Mar 2022 12:32:09 -0800
In-Reply-To: <xmqqr17p5ujf.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        26 Feb 2022 10:53:24 -0800")
Message-ID: <xmqq7d9dpg6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACADC924-999E-11EC-8B62-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A few tests added by this patch have been failing on one specific
> job (linux-gcc ubuntu-latest) at GitHub CI.
>
> https://github.com/git/git/runs/5341052811?check_suite_focus=true#step:5:3968
> https://github.com/git/git/runs/5343133021?check_suite_focus=true#step:4:5520
>
>     Side note: you may need to be logged in to GitHub to view them.
>     These two use different versions of CI to show the test traces;
>     in the latter you may have to click on right-facing rectangle on
>     the line with label "5520" to see the breakage.
>
> I think there is some baked-in assumption in the failing test what
> the name of the initial branch by default is, which may be the reason
> why this particular job fails while others don't.
>
> Can you take a look at it?
>
> Thanks.

In case you haven't noticed, this is what I have near the tip of the
topic to fix it.

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a395d2b979..9415a1e7c0 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -3,6 +3,8 @@
 
 test_description='Recursive "git fetch" for submodules'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
