From: Theodore Tso <tytso@mit.edu>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Thu, 5 Feb 2009 08:28:14 -0500
Message-ID: <20090205132814.GK8945@mit.edu>
References: <200902021948.54700.jnareb@gmail.com> <20090202202424.GG14762@mit.edu> <200902040304.05028.jnareb@gmail.com> <20090204235436.GA8945@mit.edu> <7v4oz9lpes.fsf@gitster.siamese.dyndns.org> <20090205024333.GH8945@mit.edu> <7vmyd1ieo6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:29:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV4Ic-00009V-Ed
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbZBEN2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 08:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755376AbZBEN2T
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 08:28:19 -0500
Received: from thunk.org ([69.25.196.29]:48830 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755048AbZBEN2S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 08:28:18 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LV4H9-0007aS-HZ; Thu, 05 Feb 2009 08:28:15 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LV4H8-0005Wk-Pn; Thu, 05 Feb 2009 08:28:14 -0500
Content-Disposition: inline
In-Reply-To: <7vmyd1ieo6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108559>

On Wed, Feb 04, 2009 at 10:24:57PM -0800, Junio C Hamano wrote:
> All the while, the development community started discussing how the source
> tree should be organized to support multiple backends, and you learned
> that the plan is to have one directory per larger backend, while keeping
> single file ones in <db/*.c>.  Specifically, you learned that innodb
> related code will be stored in <innodb/*.c>, and there may be other
> <somedb/*.c> and <someotherdb/*.c> groups added, but you are not
> interested in anything but enhancing innodb support.
> 
> You rename "scm mv db innodb" and then add <innodb/enhanced.c>, or perhaps
> you may have done it the other way, i.e. added <db/enhanced.c> and then
> renamed "scm mv db innodb".

The argument would be that for SCM that properly tracked user
intentions, you did the wrong thing.  If the SCM properly understood
directory renames, there is a big differene between this:

	scm mvdir db innodb

and this

	scm mv db/* innodb

You see?  The first moves the *directory* db to innodb.  The second
moves all of the *files* that are in db to a new directory, innodb.
If, in your example, you had learned that the goal was to keep single
file ones in <db/*.c>, and larger backends in <innodb/*.c>, the
correct thing to tell the SCM is *not* to rename the directory db to
innodb, but rather, to move all of the files currently in <db/*.c>,
which implement innodb, into the innodb directory.  If an SCM properly
handles directory renames, it would distinguish between these two
cases and record them different, since it implies a different
intention about what should happen to new files created in <db/*.c> in
other branches when it comes time to merge them.

Of course, this distinction does not exist in git, because we track
content only.  And a number of other SCM's like Hg, which only track
file renames, wouldn't get this right either.  In order to get this
right, you need to treat directory renames as separate and distinct
operations from file renames, because they have different merge
implications.

> See how that argument is flawed?  The point of my example is that the line
> between your example (1) and (2) in the previous message is blurry.

It's blurry if you don't properly make the distinction between file
and directory renames, yes.  A SCM that only handles file renames
can't record the difference between "move all the files in directory
foo to bar" from "rename directory foo to bar".  Just as an SCM (like
git) that only handles content that tell the difference between "move
all of the lines of content from foo.c to bar.c" and "rename foo.c to
bar.c".

Our argument for git is that with sufficiently smart merge algorithms
it doesn't matter, since we can intuit the right thing at merge time.
However, your argument that it's not possible to determine whether the
new file should appear as db/gdbm.c or innodb/gdm.c is an argument
content-tracking alone isn't enough. 

Personally, I think the scenario I used of renaming plugins is more
likely that the sort of source reorganization which you've posited,
but I agree they are both possible scenarios.  The question for git
development is whether these sorts of issues ar ones that we should
try to handle or not?  After all, one possibility is just to tell
people that if they are folks who like to go wild with source tree
reorganizations all the time, they should go to some other SCM like
bzr or Hg; that in git's view, the costs of being able to handle
random file and directory renames isn't worth the benefits for what is
normally a rare occurrence (and if it's happening all the time, the
project is probably doing something else wrong....)

						- Ted
