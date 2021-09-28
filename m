Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50874C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B2C60551
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbhI1X5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:57:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57310 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243487AbhI1X5i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:57:38 -0400
Received: (qmail 12092 invoked by uid 109); 28 Sep 2021 23:55:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 23:55:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6328 invoked by uid 111); 28 Sep 2021 23:55:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 19:55:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 19:55:54 -0400
From:   Jeff King <peff@peff.net>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v7 1/9] object-file.c: do not rename in a temp odb
Message-ID: <YVOrikAl/u5/Vi61@coredump.intra.peff.net>
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
 <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
 <6e65f68fd6d4d90b0a7bca2e2e57ace9ad749266.1632871971.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e65f68fd6d4d90b0a7bca2e2e57ace9ad749266.1632871971.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 11:32:43PM +0000, Neeraj Singh via GitGitGadget wrote:

> If a temporary ODB is active, as determined by GIT_QUARANTINE_PATH
> being set, create object files with their final names. This avoids
> an extra rename beyond what is needed to merge the temporary ODB in
> tmp_objdir_migrate.

What's our goal here? Is it the performance of avoiding the extra
rename()? Or do we benefit from the simplicity of avoiding it?

If the former, do we have measurements on how much this matters?

If the latter, what does the simplicity buy us? I thought maybe it would
make reasoning about fsync() easier, because we don't have to worry
about fsyncing the rename. But we'd eventually have to rename() into the
real object directory anyway.

The reason I want to push back is...

> Creating an object file with the expected final name should be okay
> since the git process writing to the temporary object store is the
> only writer, and it only invokes write_loose_object/create_object_file
> after checking that the object doesn't exist.

...this seems like a kind-of dangerous assumption. Most of the time,
yeah, I'd expect just a single process to be writing. But one of the
things that happens during the receive-pack quarantine is that we run
hooks, which can run any set of arbitrary Git commands, including
simultaneous readers and writers. It seems like we might be introducing
subtle races there.

-Peff
