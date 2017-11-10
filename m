Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0797F201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 05:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750757AbdKJFLp (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 00:11:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60803 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750711AbdKJFLn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 00:11:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E902B5636;
        Fri, 10 Nov 2017 00:11:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Ew4LO3oo74riQb5NiiKlDwXpgM=; b=XPfnn9
        uSmOyAY60NLtSkYaVb5tw3WJGT20FxjBxR+337ttF+8BgdPowyWh4c0MV7/AgriO
        FBVKzgfr1nosMYb9SaxqzQz+PC59DJ9M5B6RjhtwHxSVDO9O/i32CzZNTVAcvRFm
        sdWF8rEZXhE9SkJv6h85O+zabRSSJ6Ut0zSME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s5WM9MeDSBXOvpTs6pZwyTGjRdoBJzFg
        cnJLGYPWVQkwjNxUYyEMoukoakicpokX1TO3TFW80E8OEqRy+ReoViH7nZHNTWB7
        Vli/IPujOCbRFr9F2tOIljfJw4TYKHey99bGSWzrH69HCto+G/S3Pbb2WrMMNkCT
        7GW7g6mV98A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1591FB5635;
        Fri, 10 Nov 2017 00:11:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81353B5634;
        Fri, 10 Nov 2017 00:11:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 2/2] fsmonitor: Store fsmonitor bitmap before splitting index
References: <20171109195810.30446-1-alexmv@dropbox.com>
        <1a8090dfa6f273bae68cfcdd62446944bedbc8a7.1510257457.git.alexmv@dropbox.com>
        <4ff73be656d5bbf9e2cada6bdec61843da9d1516.1510257457.git.alexmv@dropbox.com>
Date:   Fri, 10 Nov 2017 14:11:41 +0900
In-Reply-To: <4ff73be656d5bbf9e2cada6bdec61843da9d1516.1510257457.git.alexmv@dropbox.com>
        (Alex Vandiver's message of "Thu, 9 Nov 2017 11:58:10 -0800")
Message-ID: <xmqqvaiig1ki.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3D4D050-C5D5-11E7-BDC6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> ba1b9caca6 resolved the problem of the fsmonitor data being applied to

(from SubmittingPatches)

If you want to reference a previous commit in the history of a stable
branch, use the format "abbreviated sha1 (subject, date)",
with the subject enclosed in a pair of double-quotes, like this:

    Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
    noticed that ...

The "Copy commit summary" command of gitk can be used to obtain this
format, or this invocation of "git show":

    git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>


> the non-base index when reading; however, a similar problem exists
> when writing the index.  Specifically, writing of the fsmonitor
> extension happens only after the work to split the index has been
> applied -- as such, the information in the index is only for the
> non-"base" index, and thus the extension information contains only
> partial data.

So... what's the effect of not applying this change?  Do we miss
paths that are known to the watchman to have been modified and end
up not adding them if we do "git add -u"?  Or do we miss paths that
are known to the watchman to be clean but mistakenly think are dirty,
and spend unnecessary cycles?  IOW, is this fixing a correctness
issue, or a performance one?

> When saving, compute the ewah bitmap before the index is split, and
> store it in the fsmonitor_dirty field, mirroring the behavior that
> occurred during reading.  fsmonitor_dirty is kept from being leaked by
> being freed when the extension data is written -- which always happens
> precisely once, no matter the split index configuration.

The observation and the approach stated to fix both sounds
sensible.  I'll queue this too, awaiting for Ben's review.

Thanks.
