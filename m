X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Working copy as a pseudo-head
Date: Mon, 27 Nov 2006 00:19:31 -0800
Message-ID: <456A9F93.1060801@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 08:19:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32389>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GobiH-0004Cb-TJ for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757365AbWK0IT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757376AbWK0IT2
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:19:28 -0500
Received: from tater.midwinter.com ([216.32.86.90]:63981 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S1757365AbWK0IT2 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:19:28 -0500
Received: (qmail 12117 invoked from network); 27 Nov 2006 08:19:27 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 27 Nov 2006 08:19:27
 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I was trying to explain to someone today why "git pull" fails if you 
have working-copy edits of one of the files that changed in the other 
branch, and it occurred to me that there may be a way to model the world 
so it doesn't fail. I am still relatively new to git so I hope this is 
not a totally idiotic idea.

Right now there is a hard distinction between what's in the working copy 
and the revision history of the tree. Merge is an operation on the 
revision history, and the working copy doesn't enter into it aside from 
the sanity check in git-merge to prevent you from inadvertently 
overwriting local edits.

What if instead, we had a notion of a temporary commit, call it WORK, 
that is ahead of what we currently think of as HEAD? That is, where now 
we have

A----B----C----D(HEAD)

we instead allowed

A----B----C----D(HEAD)----E(WORK)

When you do some operation that currently would complain about 
working-copy edits, it instead commits a WORK revision but does not 
adjust HEAD. Then it performs the operation against HEAD (advancing HEAD 
as needed) and rebases WORK under the newly merged HEAD, updating the 
working copy as a normal rebase would. Then, with one exception I'll get 
to below, it removes the WORK revision from the version history but 
leaves the contents of the working copy alone.

For example, say you have a pristine working copy of a branch with some 
history:

A----B----C(HEAD)

and you make some edits to the working copy. Now you want to pull down 
the latest changes from upstream, revision "X". So the system silently 
commits your work in progress to a temporary revision, which (while the 
merge is running) changes your history to:

A----B----C(HEAD)----D(WORK)

Then it merges the new changes with HEAD to form a new "Y" revision:

            /--D(WORK)
           /
A----B----C----Y(HEAD)
 \            /
  \-------X--/

Then it rebases WORK:

A----B----C----Y(HEAD)----D(WORK)
 \            /
  \-------X--/

And finally it removes WORK from the version history.

A----B----C----Y(HEAD) + working-copy edits
 \            /
  \-------X--/

I believe something like the above is currently how Cogito does its 
"update from the origin without losing working copy edits" thing, though 
it has to stash the working-copy edits in a temporary branch. Having the 
underlying functionality supported in the core git tools would be far 
preferable to having to hack around the lack of it in a frontend.

The one exception to the above flow is when you want to switch branches. 
Here, we create a WORK temporary commit on the current branch and move 
over to the new branch as normal, blowing away the WORK commit on the 
*new* branch, if any, and leaving its edits in the working copy. That 
allows you to freely switch back and forth between branches without 
worrying about whether you need to save your changes in progress, and 
without cluttering your repository with intermediate copies of files 
you're editing.

This is a behavior change! But I think the proposed behavior makes more 
sense. It treats the working copy as an extension of whatever branch 
you're on, rather than a separate entity that can flit back and forth 
between branches if there aren't conflicts or prevent you from changing 
branches at all if there are. It has always seemed confusing and 
inconsistent to me that, in some sense, doing a commit makes my changes 
LESS sticky -- that is,

echo foo >> testfile
git checkout other-branch
tail -1 testfile

says "foo", but

echo foo >> testfile
git commit -a
git checkout other-branch
tail -1 testfile

doesn't. I know (or I think I do) why it's doing that, but from a user 
experience point of view it's just weird, because it makes it look like 
"commit" reduces the importance of my change. And it also makes it a lot 
less convenient to pop over to another branch for a moment to check out 
the old version of some code I'm in the middle of rewriting.

Also, I realize I can use StGIT to get something like the above. But 
again, I think it'd be cleaner to support this in the underlying tool; 
"pull down some updates while I'm still working" is a very common usage 
model that's handled fine by other SCMs (Subversion, etc.) and right now 
with Git it requires a bunch of awkward extra commands. And preserving 
working-copy edits when switching branches seems like a huge convenience 
win to me; I have a hard time imagining how the current behavior is a 
time-saver for anyone (though I'm sure I'll hear all about it now!)

Comments? Is this just nuts?

