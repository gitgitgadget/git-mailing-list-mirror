Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49225C001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 00:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjHOAz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 20:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjHOAzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 20:55:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26919A6
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 17:55:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C2121F375;
        Mon, 14 Aug 2023 20:51:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KJWHudS8xTMTb98vaFbKXxRNP2ERpXcPHqJb4K
        QUfYo=; b=ErBKIxlp/dU194d+j6+FszYhFUOGwaNzkCzQKJLzvyiJZ+LAEC47rj
        ImY1uHwZ88qAMLnDMa1yQXnLMff+XS32CYer3OWu1VDitk5Ch2adMmzqjA1jdw5L
        MXBdSumnvCrt1k8z8sXQtbrzCA6TUl5nFmeIQh0f43ELXSHlQYRBc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8390C1F374;
        Mon, 14 Aug 2023 20:51:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B5F51F373;
        Mon, 14 Aug 2023 20:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on
 a filter
References: <20230808082608.582319-1-christian.couder@gmail.com>
        <20230812000011.1227371-1-christian.couder@gmail.com>
Date:   Mon, 14 Aug 2023 17:51:05 -0700
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com> (Christian
        Couder's message of "Sat, 12 Aug 2023 02:00:03 +0200")
Message-ID: <xmqqv8dhjfgm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1914FF4-3B05-11EE-BCC2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> # Changes since version 4
>
> Thanks to Junio who reviewed versions 1, 2, 3 and 4, and to Taylor who
> reviewed version 1, 3 and 4! Thanks also to Robert Coup who
> participated in the discussions related to version 2 and Peff who
> participated in the discussions related to version 4. The changes are
> the following:
>
> - In patch 2/8, which introduces `test-tool find-pack`, a spurious
>   space character has been removed between 'die' and '(', as suggested
>   by Taylor.
>
> - In patch 4/8, which refactors code into a find_pack_prefix()
>   function, this function has been changed so that the `packdir` and
>   `packtmp` arguments are now 'const', as suggested by Taylor.
>
> - In patch 5/8, which introduces `--filter=<filter-spec>` option, the
>   `filter_options` member of the 'cruft_po_args' variable is not
>   initialized and freed anymore, as this member is actually unused.
>
> - Also in patch 5/8, the '--filter fails with --write-bitmap-index'
>   test has been changed to use `test_must_fail env` to fix failures
>   with the 'test-lint' Makefile target, as suggested by Junio and
>   Taylor. (Junio's 'SQUASH???' patch was squashed into that patch.)

Thanks.  I do not recall if the previous version with SQUASH??? passed
the tests or not, but this round seems to be breaking the exact test
we had trouble with with the previous round:

  https://github.com/git/git/actions/runs/5850998716/job/15861158252#step:4:1822

The symptom looks like that "test_must_fail env" test is not
failing.  Ring a bell?

Thanks.
