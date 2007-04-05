From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Thu, 05 Apr 2007 00:03:37 -0700
Message-ID: <7vhcrvti9i.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0uypz7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 09:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZM0V-0000j5-MR
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 09:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbXDEHDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 03:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbXDEHDk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 03:03:40 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45099 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161232AbXDEHDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 03:03:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405070338.YSL25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 03:03:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jK3d1W00H1kojtg0000000; Thu, 05 Apr 2007 03:03:38 -0400
X-master-at: 1ddb47acbdfae4ee43b54b3b96d108b814a9c751
X-next-at: 9a83558fc7517090b21289a51cabd6bbe0fd945b
In-Reply-To: <7vwt0uypz7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 02 Apr 2007 22:41:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43802>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* cc/bisect (Thu Apr 5 05:33:53 2007 +0200) 2 commits
 + Documentation: bisect: "start" accepts one bad and many good
   commits
 + Bisect: teach "bisect start" to optionally use one bad and many
   good revs.

This allows "git bisect start <bad> <good1> <good2>... -- <paths>".

Being able to give more than one good commits upfront may not
happen very often, but when you are, this makes it unnecessary
to avoid an extra whole-tree checkout that happens when you give
a new good commit every time.

Being able to bisect without any good commit is outside of the
scope of this series, but I suspect that it probably is a simple
matter of making "git bisect next", after getting a <bad> commit
but before gettingt a <good> commit, not to barf but warn
(because it would pick an ancient commit and wastes one checkout
if done by mistake), ask confirmation if interactive, and drive
"git-rev-list --bisect".

* fp/make-j (Wed Apr 4 22:42:33 2007 +0200) 1 commit
 + Makefile: Add '+' to QUIET_SUBDIR0 to fix parallel make.

This makes our Makefile more dependent on GNU make, but I think
it already is.

* jc/index-output (Sat Mar 31 23:27:41 2007 -0700) 2 commits
 + git-read-tree --index-output=<file>
 + _GIT_INDEX_OUTPUT: allow plumbing to output to an alternative
   index file.

This is primarily to make index manipulation more efficient and
safer in the codepath to do "git commit <paths>".  Although I
tested the results, I do not know if it breaks things for other
people in real life projects, as I almost never do this "index
jumping" commit myself.  Testing and feedback is appreciated.

I think the above three series are ready for 'master'.

* fl/cvsserver (Sat Mar 31 15:57:47 2007 +0200) 6 commits
 + cvsserver: Use DBI->table_info instead of DBI->tables
 + cvsserver: Abort if connect to database fails
 + cvsserver: Make the database backend configurable
 + cvsserver: Allow to override the configuration per access method
 + cvsserver: Handle three part keys in git config correctly
 + cvsserver: Introduce new state variable 'method'

Although the code looked sane, I do not interact with git
repositories over CVS protocol in real life, so I haven't
personally tested it.  I cannot push this out to 'master'
without positive feedbacks.  Testing needed.

* jc/checkout (Thu Mar 29 01:23:12 2007 -0700) 4 commits
 + Use BASE index extension in git-commit and git-merge.
 + update-index --{set,get}-base
 + Add BASE index extension.
 + checkout: allow detaching to HEAD even when switching to the tip
   of a branch

I've rewritten the bottom commit not to require an explicit -d
option when detaching.  You can say "git checkout master^0"
instead to get a detached head that is at the tip of master.  I
may make that one commit graduate to 'master' earlier than
others.

This series is primarily to make it safer when somebody else
updates the tip of the branch you have currently checked out.
As I said in previous messages, I think the series covers basic
operations fine but there probably are gaps in the coverage.
Motivated volunteers are needed to fill them.

* jc/read-tree-df (Thu Mar 15 23:25:22 2007 -0700) 6 commits
 + Fix switching to a branch with D/F when current branch has file D.
 + Fix twoway_merge that passed d/f conflict marker to
   merged_entry().
 + Fix read-tree --prefix=dir/.
 + unpack-trees: get rid of *indpos parameter.
 + unpack_trees.c: pass unpack_trees_options structure to
   keep_entry() as well.
 + add_cache_entry(): removal of file foo does not conflict with
   foo/bar

I think this fixes the "my branch has foo/bar and I cannot
switch to another branch that has foo as a file" issue better
than the previous attempts.  Heavy testing and reporting is
needed until it graduates to 'master'.

* jc/the-index (Sun Apr 1 23:26:07 2007 -0700) 2 commits
 - Make read-cache.c "the_index" free.
 - Move index-related variables into a structure.

This libifies the "cache" part of the system.  Parked in 'pu' as
there is no immediate need.

* jc/blame (Tue Mar 27 01:58:01 2007 -0700) 3 commits
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
* jc/pathattr (Thu Mar 1 01:20:21 2007 -0800) 5 commits
 - pathattr: allow piping to external program.
 - pathattr: read from git_config().
 - git-show: use pathattr to run "display"
 - pathattr: path based configuration of various attributes.
 + convert: add scaffolding for path based selection of conversion
   routines.
* js/fetch-progress (Sun Feb 25 13:13:17 2007 -0800) 1 commit
 + git-fetch: add --quiet
* jc/merge-subtree (Thu Feb 15 16:32:45 2007 -0800) 1 commit
 - A new merge stragety 'subtree'.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

These are stalled.
