Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C8CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbjJLQRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJLQRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:17:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103EEE1
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:17:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 429AA19CDFF;
        Thu, 12 Oct 2023 12:17:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=w1yUvjBRz4pUZsEw7/WWqwigoU/syRYHZck9lN
        Q5P6g=; b=MhaR95MAQjIY0o7T2nTBkQzzDH22vOMNr4tJmPo/kpw7++mfoZH+ZP
        2RlvaApcNEUWJZ6ofcNfJ3QtGOf/RXvY9yXb/6aYdn2j1zBi8NL8QcpGuRRfVxcP
        6wS4euu8If6Qzs/hlpqPgBXQ1GUgrr5zpN7a318p6cuwc+bFb/lXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B4EB19CDFE;
        Thu, 12 Oct 2023 12:17:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EC3F19CDFD;
        Thu, 12 Oct 2023 12:17:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <ZSfSt4tXx8sE68Bn@tanuki> (Patrick Steinhardt's message of "Thu,
        12 Oct 2023 13:04:23 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
        <ZSTs3BUVtaI9QIoA@tanuki> <xmqqil7etndo.fsf@gitster.g>
        <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
        <xmqqbkd5nlq0.fsf@gitster.g>
        <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
        <ZSfSt4tXx8sE68Bn@tanuki>
Date:   Thu, 12 Oct 2023 09:17:09 -0700
Message-ID: <xmqqy1g7hl2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBF03F2C-691A-11EE-B191-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Wouldn't this have the potential to significantly regress performance
> for all those preexisting users of the `--missing` option? The commit
> graph is quite an important optimization nowadays, and especially in
> commands where we potentially walk a lot of commits (like we may do
> here) it can result in queries that are orders of magnitudes faster.

The test fails only when GIT_TEST_COMMIT_GRAPH is on, which updates
the commit-graph every time a commit is made via "git commit" or
"git merge".

I'd suggest stepping back and think a bit.

My assumption has been that the failing test emulates this scenario
that can happen in real life:

 * The user creates a new commit.

 * A commit graph is written (not as part of GIT_TEST_COMMIT_GRAPH
   that is not realistic, but as part of "maintenance").

 * The repository loses some objects due to corruption.

 * Now, "--missing=print" is invoked so that the user can view what
   are missing.  Or "--missing=allow-primisor" to ensure that the
   repository does not have missing objects other than the ones that
   the promisor will give us if we asked again.

 * But because the connectivity of these objects appear in the
   commit graph file, we fail to notice that these objects are
   missing, producing wrong results.  If we disabled commit-graph
   while traversal (an earlier writing of it was perfectly OK), then
   "rev-list --missing" would have noticed and reported what the
   user wanted to know.

In other words, the "optimization" you value is working to quickly
produce a wrong result.  Is it "significantly regress"ing if we
disabled it to obtain the correct result?

My assumption also has been that there is no point in running
"rev-list --missing" if we know there is no repository corruption,
and those who run "rev-list --missing" wants to know if the objects
are really available, i.e. even if commit-graph that is out of sync
with reality says it exists, if it is not in the object store, they
would want to know that.

If you can show me that it is not the case, then I may be pursuaded
why producing a result that is out of sync with reality _quickly_,
instead of taking time to produce a result that matches reality, is
a worthy "optimization" to keep.

Thanks.
