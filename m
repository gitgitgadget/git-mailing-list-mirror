X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add log.fulldiff config option
Date: Wed, 20 Dec 2006 00:14:14 -0800
Message-ID: <7v8xh3j86h.fsf@assigned-by-dhcp.cox.net>
References: <20061220060102.GA540@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 08:14:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061220060102.GA540@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 20 Dec 2006 01:01:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34909>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwwai-0004tD-K2 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 09:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753052AbWLTIOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 03:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbWLTIOQ
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 03:14:16 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59671 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752963AbWLTIOP (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 03:14:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220081414.MYIM19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 20
 Dec 2006 03:14:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0wES1W00k1kojtg0000000; Wed, 20 Dec 2006
 03:14:27 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I use --full-diff all the time, so this should save some typing. I can't
> think of a time when I wouldn't want it on, but if there is, we probably
> need a --no-full-diff.

Absolutely.

> Also, should this instead be diff.fulldiff?

Probably not.

> Also also, I was going to submit a patch to document --full-diff,
> but I had a few questions. Should it go in diff-options? That makes some
> sense to me, but the parsing actually happens in setup_revisions.

Not at all.

> Furthermore, it seems to do the same thing as --pickaxe-all. Should we
> try to combine these?

No.

Try this with various combinations of with and without
the two flags.

    $ git log -1 -Sstate --full-diff --pickaxe-all b3d9899 -- git-fetch.sh

Your understanding needs to be clarified on how paths are
filtered, and how log family and diff interacts, and probably
these need to be better documented.

First, lets forget about 'log', but talk about diff (any of
diff-tree, diff-index --cached, diff-index, and diff-files).
They take paths as arguments.  The arguments limit the input
side of the diff.

    Side note: that is why "diff -C arch/x86_64" would not
    care about renames or copies from arch/i386 to
    arch/x86_64.  The diff machinery does not even see files
    under arch/i386 with that command line.

The pickaxe (-S) is defined at the 'diff' layer, and works as
the output filter from the 'diff' machinery.  It omits the
filepair (pair of preimage and postimage) whose both sides have
the same number of specified string in them ("pickaxe
criteria").

    $ git-diff-tree --name-status b3d9899

will show three paths, git-fetch.sh, git-ls-remote.sh, and
pkt-line.c.  But only git-fetch.sh matches the pickaxe criteria.
That's why:

    $ git-diff-tree -p -Sstate b3d9899

shows only git-fetch.sh and omits the other two paths.

The option --pickaxe-all changes this paths filtering to
all-or-none.  If any of the incoming paths matches the pickaxe
criteria, all changed paths, even the ones that do not match the
criteria, are included in the output.  Thus,

    $ git-diff-tree -p -Sstate --pickaxe-all b3d9899

gives three paths, although the other two paths do not change
the number of string "state".

With me so far?

Now, when you give paths to commands of the log family, they are
used to filter commits considered for the output by the revision
traversal machinery.  The revision machinery feeds only commits
whose tree is different from its parents at the specified paths
to the commands in the log family.  b3d9899 is eligible for
output in the first example because it changes "git-fetch.sh".

Then the commit is fed to the tree-diff machinery, with the same
paths limiter given to the log command.  If the diff machinery
says there is no interesting diff, the commit is not even
output.

    Side note: that is why

        $ git log -p -1 -Snosuchstring b3d9899 -- git-fetch.sh

    does not say anything.  Pickaxe says git-fetch.sh does not
    change "nosuchstring" and nothing comes out of the diff
    machinery.

What --full-diff does is to dissociate the paths limiter from
the diff machinery.  Before talking about pickaxe interaction,
let's try one without it.

Compare:

    $ git log -p -1             b3d9899 -- git-fetch.sh
    $ git log -p -1 --full-diff b3d9899 -- git-fetch.sh

In both, git-fetch.sh is first used by the revision traversal to
determine that b3d9899 is worth considering (the commit changes
that path).  Then the former uses the same paths limiter to
compute the diff for the commit.  Hence you will see only
git-fetch.sh.  The latter, however, does not use git-fetch.sh as
the paths limiter to generate diff because of --full-diff; it
feeds the full trees and that is why you can see three files.

Finally.

How do all of the above interact with the pickaxe?

    $ git log -p -1 -Sstate b3d9899 -- git-fetch.sh

Because git-fetch.sh is changed by b3d9899, revision traversal
makes the commit eligible.  It feeds that single path to diff
machinery and pickaxe says it changes "state".  Then it outputs
that path.

How about this one?

    $ git log -p -1 -Sstate --full-diff b3d9899 -- git-fetch.sh

git-fetch.sh makes b3d9899 eligible, --full-diff makes all three
paths touched by the commit (ignoring the paths you gave from
the command line) to be fed to the diff machinery, and pickaxe
picks git-fetch.sh because that is the only one that changes
"state".  For the same reason, you would see git-fetch.sh out of
this one:

    $ git log -p -1 -Sstate --full-diff b3d9899 -- pkt-line.c

Truly finally.

If you add --pickaxe-all to the last one:

    $ git log -p -1 -Sstate --pickaxe-all --full-diff b3d9899 -- pkt-line.c

pkt-line.c makes b3d9899 eligible, --full-diff feeds three
changed paths to diff machinery, pickaxe notices that one of
them (git-fetch.sh which is different from what you gave from
the command line) changes "state", --pickaxe-all causes all
three incoming paths to be output.
