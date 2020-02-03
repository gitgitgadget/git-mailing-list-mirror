Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D07C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888D2080C
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 17:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBCRF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:05:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:51440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727256AbgBCRF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 12:05:57 -0500
Received: (qmail 3472 invoked by uid 109); 3 Feb 2020 17:05:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 17:05:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25724 invoked by uid 111); 3 Feb 2020 17:14:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 12:14:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 12:05:55 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200203170555.GB3525@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx>
 <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx>
 <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
 <20200130072122.GC2189233@coredump.intra.peff.net>
 <CAFQ2z_PvKiz==GyS6J1H1uG0FRPL86JvDj+LjX1We4-yCSVQ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_PvKiz==GyS6J1H1uG0FRPL86JvDj+LjX1We4-yCSVQ+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 05:39:55PM +0100, Han-Wen Nienhuys wrote:

> OK, so permissions are out. How about:
> 
>   HEAD - convincing enough for old versions to accept
>   refs/ - a standard rwx directory
>   reftable/ - a normal directory
>   reftable-list - the list of tables
>   reads/heads  - a file containing "this repo uses reftables. Upgrade
> to git vXYZ"
> 
> this would prevent people from erroneously creating normal branches.

That seems reasonable. They could still write "refs/tags/foo", etc, but
presumably branches would be more common.

Trying to write to any ref there (including HEAD, assuming it has a
dummy value in refs/heads/) would yield something like:

  fatal: cannot lock ref 'HEAD': unable to create lock file .git/refs/heads/master.lock; non-directory in the way

Unfortunately reading with an old version would quietly return "no such
ref", at least with old versions of Git (but those maybe aren't as
interesting as alternate implementations, since old versions of Git
would also complain about the extensions marked in the config).

Iterating with "for-each-ref" would say something like:

  $ git for-each-ref
  warning: ignoring broken ref refs/heads
  $ echo $?
  0

which is so-so. Replacing "refs/" with a file with an executable bit
(which is still playing with permissions, but I think in a little bit
less exotic way) behaves similarly, except that for-each-ref does not
even produce a warning. :-/

I dunno. I wish the failure mode were a little more complete. OTOH, I'm
really not that worried about it. The config repo-version stuff is
_supposed_ to be the definitive word on whether Git is willing to open
up a repository. So this is really belt-and-suspenders on top of that.

-Peff

PS I don't know if it's set in stone yet, but if we're changing things
   around, is it an option to put reftable-list inside the reftable
   directory, just to keep the top-level uncluttered?
