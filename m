From: Eric Wong <normalperson@yhbt.net>
Subject: [CFT] git-svn - almost a rewrite...
Date: Thu, 1 Feb 2007 05:29:34 -0800
Message-ID: <20070201132934.GB7800@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 14:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCc0r-0004B5-R9
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 14:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422872AbXBAN3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 08:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbXBAN3h
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 08:29:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:49446 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422872AbXBAN3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 08:29:36 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D00FE7DC094;
	Thu,  1 Feb 2007 05:29:34 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 01 Feb 2007 05:29:34 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38351>

I wanted to better support multi-fetch and --follow-parent, but the
original design of git-svn was strongly biased towards following a
single path.  I ended up rewriting significant parts of it.

Now git-svn uses .git/config for managing remote fetches (no wildcard
support yet, unfortunately); making it easy to see what files.  With
connection minimization (git-svn migrate --minimize), git-svn can now
avoid unnecessary reconnections to repositories.

With a single connection, git-svn can finally multi-fetch
chronologically, which means --follow-parent is much less likely to
fetch redundant information.  Additionally, parents created by
--follow-parent are no longer tracked on subsequent invocations
(since we originally just wanted the child), so we avoid waisting
time fetching things we didn't ask for.

Not strictly --follow-parent, but git-svn can now better track
paths that have been deleted up to (but not including) the revision
where it was deleted.

fetch and multi-fetch is much better at figuring out if there's nothing
to fetch, so repeatedly running 'git-svn multi-fetch' to get the latest
changes should be noticeably cheaper.

--follow-parent is not yet the default, some more testing from others
would be nice.  --follow-parent is now greatly improved, as it
can follow into deleted directories as well as tracking subdirectories
with no explicit parent at its current level.

graft-branches is gone.  We could still implement merge-tracking the way
git-svnimport does since we multi-fetch chronologically now...
Volunteers?

I don't have any hacks using shorter-lived children to reduce memory
usage anymore.  This was mainly to make development easier, but the Perl
bindings for SVN 1.4.3 have fixed some memory leak issues from the delta
editors.

Unfortunately, do_switch() still does not work with SVN 1.4.3.

Sam Vilain's revprops tracking hasn't been merged yet, but I intend to
support alternate SVN URLs/revnos from both svm:* revprops as well as
being able to override the repository root path (file:// => http://
for public distribution).

Repository available here, this is based against Junios git.git master:

  git://git.bogomips.org/git-svn.git
  http://git.bogomips.org/git-svn.git

I *will* rebase the master here as I see fit...

To take full advantage of remote connection minimization, just run:
"git-svn migrate --minimize" once and continue to add/edit remote
refspecs via .git/config.

As great as these changes sound, I don't feel they bring significant
enough improvement to risk introducing brokeness for 1.5.0.  I would
like to wait until 1.5.0 has passed before merging into mainline.  I
still have _not_ used this version of git-svn for any real work yet.

It's way past my bed time so I may have missed a few things or written
incoherently, but have fun with this anyways :)

---
 Documentation/git-svn.txt         |   71 +-
 git-svn.perl                      | 4257 +++++++++++++++++++------------------
 t/t9100-git-svn-basic.sh          |   54 +-
 t/t9101-git-svn-props.sh          |   26 +
 t/t9103-git-svn-graft-branches.sh |   60 -
 t/t9104-git-svn-follow-parent.sh  |  126 ++-
 t/t9105-git-svn-commit-diff.sh    |    9 +
 t/t9107-git-svn-migrate.sh        |   92 +
 8 files changed, 2467 insertions(+), 2228 deletions(-)

---
Eric Wong (65):
      git-svn: move authentication prompts into their own namespace
      git-svn: cleanup: move process_rm around
      git-svn: cleanup: put SVN workarounds into their own namespace
      git-svn: cleanup: avoid re-use()ing Git.pm in sub-packages
      git-svn: add Git::SVN module (to avoid global variables)
      git-svn: convert 'init' to use Git::SVN
      git-svn: convert multi-init over to using Git::SVN
      git-svn: make multi-init capable of reusing the Ra connection
      git-svn: add a test for show-ignore
      git-svn: convert show-ignore over to Git::SVN
      git-svn: moved the 'log' command into its own namespace
      git-svn: port the 'rebuild' command to use Git::SVN objects
      git-svn: do not let Git.pm warn if we prematurely close pipes
      git-svn: convert the 'commit-diff' command to Git::SVN
      git-svn: get rid of Memoize for now...
      git-svn: fetch/multi-fetch converted over to Git::SVN module
      git-svn: switch dcommit to using Git::SVN code
      git-svn: convert 'set-tree' command to use Git::SVN
      git-svn: remove graft-branches command
      git-svn: add support for metadata in .git/config
      git-svn: fix a regression in dcommit that caused empty log messages
      git-svn: reuse open SVN::Ra connections by URL
      git-svn: enable --minimize to simplify the config and connections
      git-svn: fix --follow-parent to work with Git::SVN
      git-svn: --follow-parent works with svn-remotes multiple branches
      git-svn: disallow ambigious local refspecs
      git-svn: allow --follow-parent on deleted directories
      git-svn: get rid of additional fetch-arguments
      git-svn: allow 'init' to work outside of tests
      git-svn: better error reporting if --follow-parent fails
      git-svn: 'init' attempts to connect to the repository root if possible
      git-svn: --follow-parent now works on sub-directories of larger branches
      git-svn: track writes writes to the index in fetch
      git-svn: add an odd test case that seems to cause segfaults over HTTP
      git-svn: avoid tracking change-less revisions
      git-svn: correctly track revisions made to deleted branches
      git-svn: fix segfaults from accessing svn_log_changed_path_t
      git-svn: fix committing to subdirectories, add tests
      git-svn: avoid an extra svn_ra connection during commits
      git-svn: simplify usage of the SVN::Git::Editor interface
      git-svn: cleanup remove unused function
      git-svn: allow multi-fetch to fetch things chronologically
      git-svn: correctly track diff-less copies with do_switch
      git-svn: correctly handle do_{switch,update} in deep directories
      git-svn: stop using path names as refnames with --follow-parent
      git-svn: cleanup: move editor-specific variables into the editor namespace
      git-svn: just use Digest::MD5 instead of requiring it
      git-svn: reinstate the default SVN error handler after using get_log
      git-svn: don't rely on do_switch + reparenting with svn(+ssh)://
      git-svn: fetch tracks initial change with --follow-parent
      git-svn: remove the 'rebuild' command and make the functionality automatic
      git-svn: fix several fetch bugs related to repeated invocations
      git-svn: reinstate --no-metadata, add --svn-remote=, variable cleanups
      git-svn: gracefully handle --follow-parent failures
      git-svn: make (multi-)fetch safer but slower
      git-svn: avoid a huge memory spike with high-numbered revisions
      git-svn: re-enable repacking flags
      git-svn: do our best to ensure that our ref and rev_db are consistent
      git-svn: avoid redundant get_log calls between invocations
      git-svn: use sys* IO functions for reading rev_db
      git-svn: don't write to the config file from --follow-parent
      git-svn: save paths to tags/branches with for future reuse
      git-svn: migrations default to [svn-remote "git-svn"]
      git-svn: get rid of revisions_eq check for --follow-parent
      git-svn: avoid extra get_log calls when refspecs are added for fetching

-- 
Eric Wong
