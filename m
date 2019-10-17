Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E09D1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394313AbfJQNL5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 09:11:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36897 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726898AbfJQNL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 09:11:57 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HDBe3l008991
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 09:11:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 977A6420458; Thu, 17 Oct 2019 09:11:40 -0400 (EDT)
Date:   Thu, 17 Oct 2019 09:11:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191017131140.GG25548@mit.edu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016150020.cr6jgfpd2c6fyg7t@yadavpratyush.com>
 <a1c33600-14e6-be37-c026-8d8b8e4bad92@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c33600-14e6-be37-c026-8d8b8e4bad92@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 02:23:58PM +0200, Vegard Nossum wrote:
> Of course, this relies strongly on actually having (correct) sha1
> references to previous versions inside the changelog. In my original
> idea, this reference would only appear inside the merge commit that
> binds the patchset together to minimise churn, although maybe it is
> feasible to also append it to each patch -- in that case, the "patchset"
> command from my first email is not sufficient to create a new version of
> a patchset.

This also relies on the base of the commit actually being a public
SHA1.  Sometimes developers will cherry-pick in a patch that they need
so that the kernel will actually *boot* (or otherwise fix problems
that have been fixed in other subsystems, but not yet landed in -rc2
or -rc3).

Of course, we could tell people that they should always create their
patches off of the last stable version (but then there may have been
changes pulled in via the last merge window that makes their patch not
apply), or they could be told to develop against -rc2 or -rc3, and
then cherry pick the required fix-up patches on top of -rc2 and -rc3,
but then they have to do a lot more rebuilding.

So there are no perfect solutions here, and while in the ideal world,
-rc2 and -rc3 should be perfectly stable enough for developers so that
they never need to manually patch in stablization patches, we need to
live in the real world.  I believe that Darrick told me that in the
previous development cycle, he had to wait until -rc4 before the tree
was stable enough for him to start building xfs patches on top
mainline.

(This is also true for this development cycle if you enable
CONFIG_KMEMLEAK, although fortunately, the workaround that worked for
me was to just CONFIG_KMEMLEAK --- although of course, if I do have to
run a KMEMLEAK test run, I'll need to cherry-pick the fix which landed
this week on top of the ext4 git tree.)

What this all might mean is that sometimes it will make sense to allow
the user to override the base commit so such stablization patches can
be elided.  Of course, we could force the user to create a separate
branch and rebase, but can be quite painful and slow --- and they
won't be able to test the rebased branch anyway, unless we then want
to tell them to cherry pick the stablization patches on top, and then
remove them before running "git send-email".

						- Ted
