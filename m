X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: If I were redoing git from scratch...
Date: Sat, 04 Nov 2006 03:34:42 -0800
Message-ID: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 11:35:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30919>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgJnd-0003FE-UR for gcvg-git@gmane.org; Sat, 04 Nov
 2006 12:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965286AbWKDLeo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 06:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbWKDLeo
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 06:34:44 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11941 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S965286AbWKDLen
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 06:34:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104113443.LRXU18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Sat, 4
 Nov 2006 06:34:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ibaM1V00K1kojtg0000000 Sat, 04 Nov 2006
 06:34:21 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've been thinking about these for a while on the back of my
head, and thought it might be better to start writing it down.

A lot of issues involve UI which means it will not materialize
without breaking existing uses, but if we know in advance what
we will be aiming for, maybe we will find a smoother path to
reach there.

* Core data structure

I consider on-disk data structures and on-wire protocol we
currently use are sane and there is not much to fix.  There are
certainly things to be enhanced (64-bit .idx offset, for
example), but I do not think there is anything fundamentally
broken and needs to be reworked.

I have the same feeling for in-core data structures in general,
except a few issues.

The biggest one is that we use too many static (worse, function
scope static) variables that live for the life of the process,
which makes many things very nice and easy ("run-once and let
exit clean up the mess" mentality), but because of this it
becomes awkward to do certain things.  Examples are:

 - Multiple invocations of merge-bases (needs clearing the
   marks left on commit objects by earlier traversal),

 - Creating a new pack and immediately start using it inside the
   process itself (prepare_packed_git() is call-once, and we
   have hacks to cause it re-read the packs in many places).

 - Visiting more than one repositories within one process
   (many per-repository variables in sha1_file.c are static
   variables and there is no "struct repository" that we can
   re-initialize in one go),

 - The object layer holds onto all parsed objects
   indefinitely.  Because the object store at the philosophy
   level represents the global commit ancestry DAG, there is
   no inherent reason to have more than one instance of
   object.c::obj_hash even if we visit more than one
   repositories in a process, but if the two repositories are
   unrelated, objects from the repository we were looking at
   only waste memory after switching to a different
   repostiory.

 - The diffcore is not run-once but it is run-one-at-a-time.
   This is easy to fix if needed, though.

There are some other minor details but they are not as
fundamental.  Examples are:

 - The revision traversal is nicely done but one gripe I have is
   that it is focused on painting commits into two (and only
   two) classes: interesting and uninteresting.  If we allowed
   more than one (especially, arbitrary number of) kinds of
   interesting, answering questions like "which branches does
   this commit belong to?  which tagged versions is this commit
   already included in?"  would become more easy and efficient.
   show-branch has machinery to do that for a handful but it
   could be unified with the revision.c traversal machinery. 

 - We have at least three independent implementations of
   pathspec match logic and two different semantics (one is
   component-prefix match, the other is shell glob), and they
   should be unified.  You can say "git grep foo -- 't/t5*'" but
   not "git diff otherbranch -- 't/t5*'".


* Fetch/Push/Pull/Merge confusion

Everybody hates the fact that inverse of push is fetch not pull,
and merge is not a usual Porcelain (while it _is_ usable as a
regular UI command, it was originally done as a lower layer
helper to "pull" Porcelain and has a strange parameter order
with seemingly useless HEAD parameter in the middle).

If I were doing git from scratch, I would probably avoid any of
the above words that have loaded meanings from other SCMs.
Perhaps...

 - "git download" would download changes made in the other end
   since we contacted them the last time and would not touch our
   branches nor working tree (associate the word with getting
   tarballs -- people would not expect the act of downloading a
   tarball would touch their working tree nor local history.
   untarring it does).  It is a different story if the end-user
   should be required to explicitly say "download"; I am leaning
   towards making it more or less transparent.

 - "git upload" to upload our changes to the other end -- that
   is what "git push" currently does.

 - "git join" to merge another branch into the current branch,
   with the "per branch configuration" frills to decide what the
   default for "another branch" is based on what the current
   branch is, etc.

* Less visible "remoteness" of remote branches

If I were doing git from scratch, I would probably have done
separate remotes _the_ only layout, except I might have opted to
make "remotes" even less visible and treating it as merely a
cache of "the branch tips and tags we saw when we connected over
the network to look at them the last time".

So "git branch --list $remote" might contact the remote over the
network or use cached version.  When you think about, it it is
not all that different from always contacting the remote end --
the remote end may have mirror propagation delays, and your
local instance of git caching and not contacting the remote all
the time introduces a similar delay on your end which is (1) not
a big deal, and (2) unlike the remote mirror delay, controllable
on your end.  For example, you could force it to update the
cache by "git download $remote; git branch --list $remote".

* Unified "fetch" and "push" across backends.

I was rediscovering git-cvsimport today and wished if I could
just have said (syntax aside):

	URL: cvs;/my.re.po/.cvsroot
        Pull: HEAD:remotes/cvs/master
        Pull: experiment:remotes/cvs/experiment

to cause "git fetch" to run git-cvsimport to update the remotes/cvs/
branches (and "git pull" to merge CVS changes to my branches).
The same thing should be possible for SVN and other foreign SCM
backends.

Also it should be possible to use git-cvsexportcommit as a
backend for "git push" into the cvs repository.

That's it for tonight...
