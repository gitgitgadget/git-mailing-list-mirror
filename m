From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories
 and ranges
Date: Wed, 27 Sep 2006 12:59:04 +0100
Message-ID: <451A6788.5030808@shadowen.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 14:00:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSY4h-0003z0-HB
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 13:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWI0L7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 07:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWI0L7g
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 07:59:36 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:263 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030195AbWI0L7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 07:59:36 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GSY45-0000AR-Ei; Wed, 27 Sep 2006 12:59:01 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27900>

Junio C Hamano wrote:
> Josh Triplett <josh@freedesktop.org> writes:
> 
>> Jamey Sharp and I wrote a script called git-split to accomplish this
>> repository split. git-split reconstructs the history of a sub-project
>> previously stored in a subdirectory of a larger repository. It
>> constructs new commit objects based on the existing tree objects for the
>> subtree in each commit, and discards commits which do not affect the
>> history of the sub-project, as well as merges made unnecessary due to
>> these discarded commits.
> 
> Very nicely done.
> 
>> We would like to acknowledge the work of the gobby team in creating a
>> collaborative editor which greatly aided the development of git-split.
> 
>> from itertools import izip
>> from subprocess import Popen, PIPE
>> import os, sys
> 
> How recent a Python are we assuming here?  Is late 2.4 recent
> enough?
> 
>> def walk(commits, new_commits, commit_hash, project):
>>     commit = commits[commit_hash]
>>     if not(commit.has_key("new_hash")):
>>         tree = get_subtree(commit["tree"], project)
>>         commit["new_tree"] = tree
>>         if not tree:
>>             raise Exception("Did not find project in tree for commit " + commit_hash)
>>         new_parents = list(set([walk(commits, new_commits, parent, project)
>>                                 for parent in commit["parents"]]))
>>
>>         new_hash = None
>>         if len(new_parents) == 1:
>>             new_hash = new_parents[0]
>>         elif len(new_parents) == 2: # Check for unnecessary merge
>>             if is_ancestor(new_commits, new_parents[0], new_parents[1]):
>>                 new_hash = new_parents[0]
>>             elif is_ancestor(new_commits, new_parents[1], new_parents[0]):
>>                 new_hash = new_parents[1]
>>         if new_hash and new_commits[new_hash]["new_tree"] != tree:
>>             new_hash = None
> 
> This is a real gem.  I really like reading well-written Python
> programs.
> 
> When git-rev-list (or "git-log --pretty=raw" that you use in
> your main()) simplifies the merge history based on subtree, we
> look at the merge and if the tree matches any of the parent we
> discard other parents and make the history a single strand of
> pearls.  However for this application that is not what you want,
> so I can see why you run full "git-log" and prune history by
> hand here like this.
> 
> I wonder if using "git-log --full-history -- $project" to let
> the core side omit commits that do not change the $project (but
> still give you all merged branches) would have made your job any
> easier?
> 
> You are handling grafts by hand because --pretty=raw is special
> in that it displays the real parents (although traversal does
> use grafts).  Maybe it would have helped if we had a --pretty
> format that is similar to raw but rewrites the parents?

I have wondered recently why grafts are hidden in this way.  I feel they
are something I want to know is occuring in my history as this history
is being manipulated.  Perhaps we could emit a graft record in the
output, indeed have a graft object there?  Someone could commit a
change, then graft over it in the history so I'd not see it even though
its in my working copy.

For instance in my historical git tree I have the following, note the
lack of a parent.  If I move the graft up one commit, then I get a
parent, but not a parent that points at the next commit.

  commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
  tree 0bba044c4ce775e45a88a51686b5d9f90697ea9d
  author Linus Torvalds <torvalds@ppc970.osdl.org> 1113690036 -0700
  committer Linus Torvalds <torvalds@ppc970.osdl.org> 1113690036 -0700

  [...]

  commit e7e173af42dbf37b1d946f9ee00219cb3b2bea6a
  tree 0bba044c4ce775e45a88a51686b5d9f90697ea9d
  parent 607899e17218b485a021c6ebb1cff771fd690eec
  author Linus Torvalds <torvalds@ppc970.osdl.org> 1112580513 -0700
  committer Linus Torvalds <torvalds@ppc970.osdl.org> 1112580513 -0700

It might be nice to have it more like the following, with a graft in
there, N*40 would obviously be fakes in the first instance as the object
isn't modified.  M*40 would refer to the old parent if there was one,
else NONE or 0*40 perhaps.

  commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
  tree 0bba044c4ce775e45a88a51686b5d9f90697ea9d
  parent NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
  author Linus Torvalds <torvalds@ppc970.osdl.org> 1113690036 -0700
  committer Linus Torvalds <torvalds@ppc970.osdl.org> 1113690036 -0700

  [...]

  graft NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
  parent e7e173af42dbf37b1d946f9ee00219cb3b2bea6a

    OLD: MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

  commit e7e173af42dbf37b1d946f9ee00219cb3b2bea6a
  tree 0bba044c4ce775e45a88a51686b5d9f90697ea9d
  parent 607899e17218b485a021c6ebb1cff771fd690eec
  author Linus Torvalds <torvalds@ppc970.osdl.org> 1112580513 -0700
  committer Linus Torvalds <torvalds@ppc970.osdl.org> 1112580513 -0700

I guess the other option would be to annotate the previous commit,
perhaps on the parent line so we can see the 'right' data in the normal
place, but the overridden data is right there and grepable.

  parent e7e173af42dbf37b1d946f9ee00219cb3b2bea6a GRAFT M*40
or
  parent e7e173af42dbf37b1d946f9ee00219cb3b2bea6a GRAFT NONE

-apw
