Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4391F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfHMSIu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:08:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52148 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfHMSIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:08:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F3BB1707E6;
        Tue, 13 Aug 2019 14:08:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vc8gXGxys25YfpCjrK4x4cNdwDs=; b=LfOVkX
        CcEcnLDLhhV+mcJcG8oaOIBCdTWnUKdrMpsRQllVokSBh6BaRocSL7ZzTDdlDZZS
        9+WPNOI1qKuJKe/u5+U5bs478WD8+BZqAiuS4D5vxBSFxLReAPZVpAr0PyvS6Cgu
        6uTAL6EAgfh/xFOJogwxsA/+QbIy0GCTNNw6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t9hYSShZ9H88kQ0MrkPIT54bGJPBexc5
        AI3xkGJNlwCrQOn0aZN263fajOCRCdQnsOKzIutG5pvmU7enF/MTlA7FrhqpW+Hq
        WD1A5MmXBP0v9j4N47X62XSWUSt/ncxweBDawrIAcXxDtMRlgjS6DNts/yUHjYi1
        1mWpmo6O/74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 083C01707E5;
        Tue, 13 Aug 2019 14:08:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64E511707E4;
        Tue, 13 Aug 2019 14:08:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] apply: reload .gitattributes after patching it
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190813024307.705016-1-sandals@crustytoothpaste.net>
        <20190813024307.705016-3-sandals@crustytoothpaste.net>
Date:   Tue, 13 Aug 2019 11:08:46 -0700
In-Reply-To: <20190813024307.705016-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 13 Aug 2019 02:43:07 +0000")
Message-ID: <xmqq7e7h7xap.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65383016-BDF5-11E9-B483-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When applying multiple patches with git am, or when rebasing using the
> am backend, it's possible that one of our patches has updated a
> gitattributes file. Currently, we cache this information, so if a
> file in a subsequent patch has attributes applied, the file will be
> written out with the attributes in place as of the time we started the
> rebase or am operation, not with the attributes applied by the previous
> patch. This problem does not occur when using the -m or -i flags to
> rebase.

Back when "am" was a script that repeatedly calls "apply --index &&
commit-tree", caching the original contents of the attributes file
and using it throughout the series would have been impossible to
begin with, so this must be a regression when we rewrote it in C and
moved to do everything in a single process without clearly the state
between the steps, I guess.

"rebase -m" and "rebase -i" are not repeated run_command() calls
that invoke "git cherry-pick" or "git merge" these days, either, so
I am somewhat curious how they avoid fallilng into the same trap.

Thanks for the fix.  Will queue.
