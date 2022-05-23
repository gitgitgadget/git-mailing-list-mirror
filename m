Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E5C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 21:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiEWVdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 17:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEWVdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 17:33:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E413CC1
        for <git@vger.kernel.org>; Mon, 23 May 2022 14:33:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCB001AFFBC;
        Mon, 23 May 2022 17:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7YcqBAPmkBwqq/zl755C+YP8SyR1hC+pMbtXQn
        3WnIA=; b=gUE7urORpSVATwF8SIByogrlMfprW0ckp6YnqmQyE6Vo30LPUMp5tq
        Oy/y8zUzSgdc0NUcXhFHiHbCANLuDebmXyq/HLbImP8KYK7/i+696ac18nXkpkpS
        xrfboBYKhg/o1MHStC7lHJYmgjyiCNrgrNf39ezMHORsr3YCwjA+I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B43491AFFBB;
        Mon, 23 May 2022 17:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5701A1AFFB8;
        Mon, 23 May 2022 17:33:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 27/30] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <6a8308699543faaea760d4605babe50a0e478f41.1653336765.git.gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 14:33:33 -0700
In-Reply-To: <6a8308699543faaea760d4605babe50a0e478f41.1653336765.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 23 May 2022
        20:12:42 +0000")
Message-ID: <xmqq5ylworwy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFAD31BE-DADF-11EC-AE31-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	ls | test-tool hexdump | grep "63 5f c3 a9"

A few comments:

 * Not folding output lines at arbitrary place like "od", "hd",
   etc. does, is a good design decision made by "hexdump" here.
   Depending on where in the pathname the 4-byte sequence appears,
   tools from other people may split the sequence across output
   lines, making grep ineffective.  But our hexdump would work fine
   here.

 * For the narrow purpose of the tests in this script, output that
   is a single long line produced by hexdump might be sufficient,
   but I wonder if it makes the tool more useful if we at least
   placed the hexified output for each line on separate output
   lines.

 * Purist in us may find it a bit disturbing that exit status from
   test-tool is hidden by the pipe.  I do not care too deeply about
   it, as it is very unlikely that we care about segfault after
   hexdump successfully shows the substring the downstream grep is
   looking for, but it does make us feel dirty.

A devil's advocate suggestion is to go in the completely opposite
side of the spectrum.  Perhaps if we are willing to limit the tool's
utility to the tests done in this script file, it might be a good
idea to combine the latter two elements in the pipeline, i.e.

	ls | test-tool hexgrep 63 5f c3 a9

that exits with 0 when the output from "ls" has the 4-byte sequence,
exits with 1 when it does not, and exits with 139 when it segfauls ;-)
