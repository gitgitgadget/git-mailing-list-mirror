Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ADCC46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAONxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 08:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjAONxO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 08:53:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63853113C9
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 05:53:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DA71A66EC8;
        Sun, 15 Jan 2023 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673790790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPGwlM49yDefZKoVUcFOJrzkyqnqAUkjaHC1IM1buL4=;
        b=QV4aabWBLjJtCBdN/Rr24B/ZqZE1aezMY7GhogN3Y+yEJx7AJpWWv7QWTRhiMluvWSd4OM
        RgFV3kVJ35sBXR+uXsi+jMJKeCr9qXhXNTnQQ38WS0u4J3BumgSx8j4RpjEYImZH/cQ2op
        NnG5uefjlheyUEmleSImLOQkYOn/eDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673790790;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPGwlM49yDefZKoVUcFOJrzkyqnqAUkjaHC1IM1buL4=;
        b=xsPE6yFKQzQdQ2qD9h95Bnyi+nBlzlE638Q3ZXtprcMTbt2xBl8gfL6SutiCHQ5nHsncEa
        xJEKqpFucK4i10CA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C8C432C142;
        Sun, 15 Jan 2023 13:53:10 +0000 (UTC)
Date:   Sun, 15 Jan 2023 14:53:09 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230115135245.GB16547@kitsune.suse.cz>
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, Jan 13, 2023 at 02:23:59PM +0100, Hans Petter Selasky wrote:
> Hi,
> 
> Currently GIT only supports cryptographic hashes for its commit tags.
> 
> That means:
> 
> 1) It's very difficult to edit the history without also recomputing the hash
> tags for all commits after the needed change-point, which then means
> references to a repository is broken.

That also makes it difficult to alter the repository intentionally
without anyone noticing. With SHA1 being somewhat weak it may be
possible to alter repository content although I am not aware of any
practical attacks shown so far. For that reason using stronger hashes is
planned in the future.

> 2) Only a single bit error in the main repository can break everything!
> 
> 3) Illicit contents may be present in binary blobs, which in the future may
> be need to be removed without warrant and the only way to do that is by
> rebasing and force pushing, which will break "everything". It can be
> everything from child-porn to expired distribution licenses.

It's good to avoid spam getting into your repository. If you really need
to alter it long into the past you still can. Everyone will notice that
you did, and that's an intentional feature. In some situations it is
understandably an annoyance but there's so much you can do. At least
tags should remain stable.

> Many people think that bit errors cannot happen because the memory uses ECC
> and the file system uses cryptographic hashes to verify the integrity of the
> data. But what many people forget about is that when copying data from
> memory to disk, typically using a DMA channel data is copied w/o any kind of
> integrity protection, because the integrity protection is not end-to-end.
> The integrity protection is only per-link.

So long as all links have integrity protection it's end-to-end.

Integrity checks for CPU chaches, buses, and IO protocols do exist.

It's not that errors cannot happen, they are very unlikely.

In the very rare case that such error happens so long as non-corrupted
version of the object can be supplied by anyone who has a copy of the
repository it is recoverable.

For old objects this should be your backup system.

For new objects the worst case is that the history is rolled back so the
missing object is not needed.

Thanks

Michal
