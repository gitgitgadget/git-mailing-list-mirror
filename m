Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9C81F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 14:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502553AbfJQOrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 10:47:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56365 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2440344AbfJQOrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 10:47:20 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HEl8g9010903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 10:47:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6B6B7420458; Thu, 17 Oct 2019 10:47:08 -0400 (EDT)
Date:   Thu, 17 Oct 2019 10:47:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191017144708.GI25548@mit.edu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016150020.cr6jgfpd2c6fyg7t@yadavpratyush.com>
 <a1c33600-14e6-be37-c026-8d8b8e4bad92@oracle.com>
 <20191017131140.GG25548@mit.edu>
 <507d7293-964a-048b-2de6-98e7e7982cfb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507d7293-964a-048b-2de6-98e7e7982cfb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 04:01:33PM +0200, Vegard Nossum wrote:
> 
> In your example, couldn't Darrick simply base his xfs work on the latest
> xfs branch that was pulled by Linus? That should be up to date with all
> things xfs without having any of the things that made Linus's tree not
> work for him.

Sure, but sometimes there are changes in subsystems which the file
system depends upon that were also merged by Linus.  So for example,
the ext4 branch might be based on v5.3-rc4, and gets pulled after v5.3
is released, along with a huge number of other subsystem trees, so the
delta between v5.3 and v5.3-rc1 is ***huge***.

So while I could base my development on my previous ext4.git branch
(based off of v5.3-rc4), at *some* point I need to be able to sync up
with upstream.  And the usual way to do this is to start a new
development branch based on (for example) v5.4-rc2, or in some cases
v5.4-rc4.

We could keep the development branch on based off of v5.3-rc4, and
wait until things stablize, and *then* merge in v5.4-rcX, when
v5.4-rcX is finally stable, but that makes for a more complex merge,
and so it means that things like "git log origin..master" don't really
work any more.  So the preferred development practice is very much....

   rc2 o --> patch 1 --> patch 2 --> ... --> patch N 
(origin)                                     (master)

Where the "master" branch gets merged into the rewinding "dev" branch
(which works much like git's pu branch), and where the "master" branch
is what Linus will merge at the next merge window.

> Otherwise, you could apply the stabilisation patches and then do your
> final testing in a branch that merges that with your patchset, like so:
> 
>    rc1 o -----> fixup A ------> fixup B ---->o merge (tested)
> (base)  \                                   /
>          \                                 /
>           ---> patch 001 --> patch 002 -->o patchset (submitted)

I cloud do that, but remember that the checked out kernel tree is
about a gigabyte (this assumes using git clone --shared, so it doesn't
include the git pack files, and this is source only; the object files
are another 2.6 GB).  I could keep separate checked out trees, and
separate build trees, but that burns a lot of disk/SSD space.  Or I
could switch back and forth by using "git checkout" between the
development branch and the branch with the stablization patches, but
then I'm constantly having to rebuild the object files, and ccache
only helps so much.

So it's much simpler to put the fixup patches at the on top of the
origin, and then mail them out without having to play git branch
rebasing gymnastics.  When the patch series is finally ready to roll,
then the maintainer will apply the patch series on a clean branch,
since hopefully by then -rc3 or -rc4 is finally stable enough to use
as an origin point.

So the idea is that developer might be sending out revisions of their
patches on top of -rc1 plus fixup patches, but then the final version
of the patch series, after a few rounds of review, gets applied on top
of -rc3 or -rc4.

> I think the more difficult problem to solve might be how to ensure that
> the base commit is actually public/reachable when this is the intention.
> A bot watching the mailing list could always respond with a "Hey, I
> don't have that, could you rebase the series or push it somewhere?". But
> it would be even better if git could tell you when you're about to
> submit a patch. Maybe something like:
> 
>   git send-email --ensure-reachable-from [remote] rev^^..
> 
> In the worst case, I guess the base commit will just not be available --
> the email will still have a sha1 on it, though, and which might still be
> usable as an identifier for the patch/patchset. If not, it's still not
> worse than the current workflow (which would still work).

... or what we can do is allow the developer to specify the intended
base --- e.g., -rc1, even though his patchset was against "-rc1 plus fixups".

	     	       	     	  	     - Ted
