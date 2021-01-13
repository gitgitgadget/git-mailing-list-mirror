Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAA7C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9962360D
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhAMO42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:56:28 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:44108 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbhAMO42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 09:56:28 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <yoh@onerussian.com>)
        id 1kzhYo-0003BE-4s; Wed, 13 Jan 2021 09:55:46 -0500
Date:   Wed, 13 Jan 2021 09:55:45 -0500
From:   yoh@onerussian.com
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Adina Wagner <a.wagner@fz-juelich.de>
Message-ID: <X/8J8ScJGL4RKBiC@lena.dartmouth.edu>
References: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
 <e7301aaf-b341-ec0b-9e2d-ab7f60ac58da@fz-juelich.de>
 <X/ipCPFyW3gAWrHo@nand.local>
 <xmqq35z9g3pw.fsf@gitster.c.googlers.com>
 <X/ymFuUPn2POWA/p@nand.local>
 <X/3gbjQs7+wHoJpb@lena.dartmouth.edu>
 <X/3urtfn6L551gzJ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/3urtfn6L551gzJ@nand.local>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: me@ttaylorr.com, git@vger.kernel.org, a.wagner@fz-juelich.de
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: suspected race between packing and fetch (single case study)
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, 12 Jan 2021, Taylor Blau wrote:
> > > ++
> > > +*NOTE*: this operation can race with concurrent modification to the
> > > +source repository, similar to running `cp -r src dst` while modifying
> > > +`src`.

> > Couldn't `gc` be triggered by git in seemingly read-only operations,
> > thus possibly ruining the analogy with `cp` while doing `rm` (explicit
> > intent to modify)?

> > Moreover, situation is also a bit different since a sane user script
> > would not place `rm` into background to keep operating on original
> > source right before doing `cp` -- and that is what is happening here:

> If you're suggesting that something is missing from the above patch, I'm
> not sure I quite understand what you would like added.

Slept on it.  I think your patch (doc disclaimer) is factually correct
and probably as good as it can get.  Not yet sure if it is worth
explicit mentioning `gc` or `repack` as one of such concurrent
operations.

> All of these (background gc, explicit rm-ing) fall under the category of
> "concurrent modification": they are changing the source directory in
> some way while a read operation is taking place.

yes.  My comment was more on how such modifications are triggered: via
explicit actions (e.g. `rm`) intended to modify vs as a "house
keeping running in the background", which is the case of gc in
particular when triggered by seemingly read-only operations.

> > `git` operation is presumably complete (but leaves `gc` running in the
> > background) and script advances to the next step only to run into a race
> > condition with that preceding `git` command which apparently triggered
> > `gc`.  Should then any script which operates on local `git` repositories
> > not to forget to add   -c gc.autodetach=0  for every git
> > invocation which might be potentially effected?

> If your workflow is that you are frequently cloning via the local
> transport and there is no other synchronization going on between
> whatever work is happening in the source repository, then yes. (But note
> of course that you can set gc.autodetach=0 via the source repository's
> .git/config rather than typing it each time).

IMHO it affects efficiency, become cumbersome (for git users), and thus
might be error-prone: e.g.  gc.autodetach=0 is necessity only to
mitigate only for a possible subsequent `clone` invocation operating
locally.  Higher level constructs siting on top of `git` would not know
what is the next command ran in the user script (like in our case of
datalad) to set such config variable for their invocations.  Adding
gc.autodetach=0 to every single `git` invocation would effect our
efficiency. User might not be made aware of such necessity for using
`git clone` on local repositories, only after having their scripts
deployed and at some random points in time start hitting the race
condition and go "google" and RTFM mode to figure out what is
going on.

That is why I am more in-line with your initial comment  in
https://lore.kernel.org/git/X%2FipCPFyW3gAWrHo@nand.local/ :

> Perhaps Git could take some sort of lock when writing to the object
> store, but an flock wouldn't work since we'd want to allow multiple
> readers to acquire the lock simultaneously, so long as there is no
> writer.

I think it would be nice to have `clone_local()` first check that
there is no ongoing modifications happening  before proceeding and wait
some reasonable amount of time (up to ?0 sec?) if still ongoing, and
then fail "informatively" if still cannot clone.  Even though it would
not prevent race condition in full (`clone_local` might check and
initiate, and then some process starts altering while `clone_local` is
ongoing), it would mitigate any scripted cases of a local `git clone`
following some heavy manipulations of original repository which triggers
background gc.

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
WWW:   http://www.linkedin.com/in/yarik        

