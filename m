Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F968211B4
	for <e@80x24.org>; Thu,  6 Dec 2018 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeLFVZI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 6 Dec 2018 16:25:08 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:55489 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFVZI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 16:25:08 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gV18s-00079w-1S
        for git@vger.kernel.org; Thu, 06 Dec 2018 16:25:06 -0500
Date:   Thu, 6 Dec 2018 16:24:59 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181206212459.GN4633@hopa.kiewit.dartmouth.edu>
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [wishlist] git submodule update --reset-hard
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 06 Dec 2018, Stefan Beller wrote:

> On Thu, Dec 6, 2018 at 10:02 AM Yaroslav Halchenko <yoh@onerussian.com> wrote:

> > Dear Git Gurus,

> > I wondered what would be your take on my wishlist request to add
> > --reset-hard option, which would be very similar to regular "update" which
> > checks out necessary commit, but I want it to remain in the branch.

> What if the branch differs from the sha1 recorded in the superproject?

git reset --hard  itself is an operation which should be done with some
level of competence in doing "the right thing" by calling it.  You
can hop branches even in current (without any submodules in question)
repository with it and cause as much chaos as you desire.

If desired though, a number of prevention mechanisms could be in place (but
would require option(s) to overcome) to allow submodule to be reset --hard'ed
only when some conditions met (e.g. only to the commit which is among parent
commits path of the current branch).  This way wild hops would be prevented,
although you might still end up in some feature branch.  But since "reset
--hard" itself doesn't have any safe-guards, I do not really think they should
be implemented here either.

> > Rationale: In DataLad we heavily rely on submodules, and we have established
> > easy ways to do some manipulations across full hierarchies of them. E.g. a
> > single command could introduce a good number of commits across deep hierarchy
> > of submodules, e.g. while committing changes within deep submodule, while also
> > doing all necessary commits in the repositories leading to that submodule so
> > the entire tree of them stays in a "clean" state. The difficulty comes when
> > there is a need to just "forget" some changes.  The obvious way is to e.g.

> >    git reset --hard PREVIOUS_STATE

>   git reset --hard --recurse-submodules HEAD

> would do the trick

it does indeed some trick(s) but not all seems to be the ones I desire:

1. Seems to migrate submodule's .git directories into the top level
.git/modules

	$>  git reset --hard --recurse-submodules HEAD^^^
	Migrating git directory of 'famface' from        
	'/tmp/gobbini/famface/.git' to
	'/tmp/gobbini/.git/modules/famface'
	Migrating git directory of 'famface/data' from
	'/tmp/gobbini/famface/data/.git' to
	'/tmp/gobbini/.git/modules/famface/modules/data'
	Migrating git directory of 'famface/data/scripts/mridefacer' from
	'/tmp/gobbini/famface/data/scripts/mridefacer/.git' to
	'/tmp/gobbini/.git/modules/famface/modules/data/modules/scripts/mridefacer'
	HEAD is now at 9b4296d [DATALAD] aggregated meta data

we might eventually adopt this default already for years model (git annex seems
to be ok, in that it then replaces .git symlink file with the actual
symlink .git -> ../../.git/modules/...  So things seems to keep working
for annex)

2. It still does the detached HEAD for me

	$> git submodule status --recursive              
	 2569ab436501a832d35afbbe9cc20ffeb6077eb1 famface (2569ab4)
	 f1e8c9b8b025c311424283b9711efc6bc906ba2b famface/data (BIDS-v1.0.1)
	 49b0fe42696724c2a8492f999736056e51b77358 famface/data/scripts/mridefacer (49b0fe4)


> > in the top level repository.  But that leaves all the submodules now in
> > the undesired state.  If I do

> undesirable in the sense of still having local changes (that is what
> the above reset with `--recurse` would fix) or changed the branch
> state? (i.e. is detached but was on a branch before?)

right -- I meant the local changes and indeed reset --recurse-submodules
indeed seems to recurse nicely.  Then the undesired effect remaining only
the detached HEAD

> >   git submodule update --recursive

> > I would end up in the detached HEADs within submodules.

> > What I want is to retain current branch they are at (or may be possible
> > "were in"? reflog records might have that information)

> So something like

>   git submodule foreach --recursive git reset --hard

> ?

not quite  -- this would just kill all local changes within each submodule, not
to reset it to the desired state, which wouldn't be specified in such
invocation, and is only known to the repo containing it

> You may be interested in
> https://public-inbox.org/git/20180927221603.148025-1-sbeller@google.com/
> which introduces a switch `submodule.repoLike [ = true]`, which
> when set would not detach HEAD in submodules.

Thanks! looks interesting -- was there more discussion/activity beyond those 5
posts in the thread?
https://public-inbox.org/git/87h8i9ift4.fsf@evledraar.gmail.com/#r 

This feature might indeed come handy but if I got it right, it is somewhat
complimentary to just having submodule update --reset-hard .  E.g.  submodules
might be in different branches (if I am not tracking based on branch names), so
I would not want a recursive checkout with -b|-B.  But we would indeed benefit
from such functionality, since this difficulty of managing branches of
submodules I think would be elevated with it! (e.g. in one use case we probably
will end up with a few thousands of submodules, and at least 3 branches in each
which would need to be in sync, and typically you wouldn't want different
branches to be checked out in different submodules)

> Can you say more about the first question above:
> Would you typically have situations where the
> submodule branch is out of sync with the superproject
> and how do you deal with that?

typically I do not have anything out of sync.  My primary use-case is to
"cancel" recent changes in the entire tree of repositories.  I guess for
my use case, instead of needing two commands

   git reset --hard PREVIOUSPOINT
   git submodule update --reset--hard --recursive

I wish there was just one

   git reset --hard --recursive PREVIOUSPOINT

but I felt that   submodule update   might be a better starting point
since it already  provides different modes for update.  If I was even greedier,
I would have asked for 

   git revert --recursive <commit>...
   git rebase --recursive [-i] ...

which I also frequently desire (could elaborate on the use cases etc).

NB or --recurse-submodules to avoid confusion with recursive merge
strategy?


But for a complete answer -- if submodule branch is ahead of the superproject's
record, I just commit new state for it in superproject.  Or if I see that all
what I have done was actually a throw away -- "reset --hard" to that needed
state, again manually in submodule.  With  submodule update --reset-hard
--recursive  or  git reset --hard --recursive   I would be just ready
regardless of the depth and complexity of the hierarchy ;-)

> Adding another mode to `git submodule update` sounds
> reasonable to me, too.

cool, thanks!

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
