X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Mon, 27 Nov 2006 22:59:52 -0800
Message-ID: <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 07:00:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32488>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gowws-0003Lv-Nc for gcvg-git@gmane.org; Tue, 28 Nov
 2006 08:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935683AbWK1G7y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 01:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935684AbWK1G7y
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 01:59:54 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43418 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S935683AbWK1G7x
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 01:59:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128065953.TWLU97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 01:59:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id s7011V00A1kojtg0000000; Tue, 28 Nov 2006
 02:00:01 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Enough about "git commit -a" for tonight.

I've been playing with a "private edition" git to see how it
feels like to use "git commit" that defaults to the "-a"
behaviour, using myself as a guinea pig, for the rest of the
evening.

Confession time.  I've had a "purist me" deep inside, who always
thought that people who play contributor role (that is to say
"99.9% of people") should make no commits other than the "-a"
kind [*1*].  So this is not only trying out the issues in the
discussion I had with you, but what that "other me" wanted to do
for quite some time.

A pair of patches will follow this message and I encourage you
to try it out, work with it for a dozen or so commits, handful
of merges, a patch application or two to get part of changes
from different commits (not a "git format-patch | git am" to get
another commit wholesale, but "git apply" followed by your own
edits that eventually result in "git commit"), a few rebases and
resets.  If you have a few new people you can sacrifice their
"git virginity" for experimenting this on, I am reasonably sure
they will like it, but I do not know how their learning curve
later will be affected by this change -- it would be interesting
to know.  I do not think it would flatten the learning curve of
index much. I am somewhat fearful that it might make it harder,
but I lost my git virginity long time ago, so it is just an
unsubstantiated feeling.

Judging from my experience so far, although I really wanted to
like this, I am still hesitant to recommend this for inclusion.
It does not make any difference while I am doing the simplest
operation (it is just not having to say "-a"), so I do not
foresee problems either way for new people following a saner
version of tutorial, which does not exist yet, that does not
talk much about "git commit -a".

The problem I have with the new behaviour is that it goes
against the mental model when I start doing anything nontrivial
(I would not use words as strong as "totally breaks the mental
model", but it comes close).  I am not sure how well I can
express this, but the short of it is that "grokking index" is
not about understanding how the index works, but about trusting
that git does the right thing to the index and you do not have
to worry about it all the time.

For example, "git apply --index" will update the index for paths
that the patch I feed it talks about (and reminds me if I have
local changes to them by refusing to lose my changes) so after
it finishes successfully, I do not have to think about the index
at all [*2*].  After working on a few files, I can ask "git
diff" to see if the changes so far are reasonable, and mark them
with "git update-index" so that I do not have to worry about
them anymore and keep going to make matching changes to other
files.  Once I tell something to git via index, I do not have to
worry about it, and this is a big relief.

The same thing can be said about "git merge" (or "git pull .").
The index is updated for cleanly merged paths so I do not have
to worry about the details -- the only thing I have to know is
that index keeps track of the state and cleanly merged paths are
taken care of for me automatically, so I do not have to worry
about them.  "git diff" and "git ls-files -u" will give me
conflicting paths and I can only concentrate on them.

Once I am done, I can ask "git diff" and expect it to show my
local changes I have no intention of committing for now
(e.g. GIT-VERSION-GEN in the working tree has v1.4.5-rc1.GIT
long before I plan to start the rc1 cycle to constantly remind
me what the next version will be, which is a trick I picked up
from Linus), and "git diff --cached" would show exactly what I
will commit.

And at that point, I trust "git commit" to do the right thing --
the damn thing I just checked with "git diff --cached" _is_ what
will be committed.  In that sense, I do not have to think about
the index at all, because I know git is doing appropriate things
behind the scene for me.

Coming from this perspective, having to say "git commit -i" at
the time of making the commit just makes me feel uneasy, if not
counterintuitive.  Making "git commit" default to "-a" rubs this
mental model quite the wrong way.

Probably new people who are not used to the index do not have
this problem, but I suspect I am not alone among old time
gitters.

I lost about half an hour after saying "git commit --amend",
without thinking, because I wanted to amend only the commit
message, and much later I noticed that it swallowed unrelated
changes I had in the working tree because it now implied the
"-a" behaviour, and I should have said "git commit -i --amend".

I needed to redo bunch of commits, which involved having to
re-test a handful revisions (this is not git.git project but my
day job one -- I do not work on it after work, but I was doing
the guinea pig).  But this is something re-training can fix and
much a smaller problem than the mental model issue.


[Footnote]

*1* The reason to favor "-a" commit is not about hiding the
index but about discipline.  For the "integrator" people to be
able to coast over the changes, they need to be able to trust
the work by contributors to some degree without worrying about
small details; the changes fed to the integrators must be well
tested when they leave the hand of a contributor, and making a
commit that never existed as a whole in the working tree goes
against this discipline.

*2* It might be a good idea to make "--index" the default for
"git apply" when we know we are in a git repository ("git apply"
must be usable outside a git repository so this needs to be
handled with care if somebody wants to do it).  There is no
"--no-index" option to countermand it right now, which also
needs to be added.


