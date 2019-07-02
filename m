Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4381F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGBTYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:24:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52766 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfGBTYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:24:33 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62JODLe020187
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 15:24:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E998F42002E; Tue,  2 Jul 2019 15:24:12 -0400 (EDT)
Date:   Tue, 2 Jul 2019 15:24:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, rsbecker@nexbridge.com,
        Eric Kulcyk <Eric.kulcyk@microsoft.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Tracking parent branches in Git
Message-ID: <20190702192412.GE3032@mit.edu>
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
 <007d01d53049$4db5bec0$e9213c40$@nexbridge.com>
 <77a2b000-f1dc-6f3e-54db-abd227ce6163@iee.org>
 <xmqqef3849v6.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-GhD50Dy0O7JjV4vTyQfFcifyKzeYDS_HtAXy604HxqVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-GhD50Dy0O7JjV4vTyQfFcifyKzeYDS_HtAXy604HxqVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 02, 2019 at 11:52:35AM -0700, Bryan Turner wrote:
> Sorry, I should have clarified my "--no-track" in my original message
> when I provided the example. I did "--no-track" because if I push
> "bturner-some-bugfix" to a server, I'm likely going to do something
> like "git push -u origin bturner-some-bugfix" so that my local
> "bturner-some-bugfix" branch will track the remote version of itself.
> At that point, the remote-tracking information would change from
> "release/5.16" to "bturner-some-bugfix" (without any sort of warning,
> for whatever that's worth), effectively "losing" the ancestry.
> 
> The other issue is that my local remote-tracking information doesn't
> help the server I'm talking to; it's not shareable. Assuming I could
> use remote-tracking to track ancestry, there's still no way to
> communicate that to the server so that it could know, when I go to
> create a pull request for "bturner-some-bugfix", that it's tracking
> "release/5.16" in my local repository.

I think the real problem with all of this feature request is that it's
all presuming a particular workflow, and git is currently *not*
strongly opinionated about the workflow.

So for example, if I create a local branch against origin/release/5.16
with a series of fixes, and I'm pushing to a gerrit server for review,
I might need to do something like this:

  git push gerrit HEAD:refs/for/release/5.16%r=reviewer@example.com,%cc=kernel-reviewers@example.com

So the fact that we've recorded the information about the parent
branch when doing a "git checkout -b bugfix origin/release/5.16" is
part of the puzzle, but the other part of the puzzle is knowing what
the destination server is going to want or need.  Internally at $WORK
we have our own internal script that does this automatically, so I
just have to run something like "kdt mail -r reviewer@example.com",
but it's always going to be very workflow-independent.

> I could certainly be misunderstanding the request, but I think it's
> asking for something less ephemeral--and more shareable--than
> remote-tracking, and it seems logical to want to be able to retain
> ancestry while still using remote-tracking setup such that local
> branches still track the remote version of themselves, rather than
> some other (albeit related) branch.

In order for it to be shareable, we have to make some very strong
assumptions about workflow.  It gets worse when people pull from more
than one tree, or there is a series of subtrees.

For example, suppose the 2nd-level lieutenant has a "net" tree, and
the 3rd-level lieutenants have a "sctp" and a "ipsec" tree.  Now let's
assume that there is some common infrastructure branch that both
3rd-level lieutenants need to build off of that comes from some other
2nd-level tree, and so for that development cycle, they first pull
from the top-level tree, and then both 3rd level trees merge in a
branch from the "mm" tree, but then they will be both be sending pull
request emails to the "net" tree.

There will be a whole series of git pulls and git merges that will be
in flight, and just for yucks, let's suppose some trees are do patch
review via email, and some trees are doing patch review via gerrit,
and yet other trees have their maintainer do a quick cursory review at
"git pull" time after the tree sends a git pull request.

What sort of shareable context should git --- which is ignorant of all
of these arrangements --- be preserving?  And presenting to whom?  And
for what goal/purpose?

						- Ted
