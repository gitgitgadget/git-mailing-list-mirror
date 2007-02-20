From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [CFT] git-svn - almost a rewrite...
Date: Tue, 20 Feb 2007 01:45:51 -0800
Message-ID: <20070220094550.GA16866@mayonaise.dyndns.org>
References: <20070201132934.GB7800@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 10:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRZb-0005H5-BE
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbXBTJpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbXBTJpz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:45:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33330 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790AbXBTJpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:45:53 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CD2EE7DC091;
	Tue, 20 Feb 2007 01:45:51 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 20 Feb 2007 01:45:51 -0800
Content-Disposition: inline
In-Reply-To: <20070201132934.GB7800@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40218>

Eric Wong <normalperson@yhbt.net> wrote:
> I wanted to better support multi-fetch and --follow-parent, but the

I've deprecated the names 'multi-fetch' and 'multi-init'; however the
functionality they support have been integrated into the 'init' and
'fetch' commands.

> Now git-svn uses .git/config for managing remote fetches (no wildcard
> support yet, unfortunately); making it easy to see what files.  With
> connection minimization (git-svn migrate --minimize), git-svn can now
> avoid unnecessary reconnections to repositories.

Wildcards for branches and tags are now supported.  (multi-)init -b/-t will
create something like this now:

[svn-remote "svn"]
	url = http://server.org/svn
	branches = branches/*/project-a:refs/remotes/*
	tags = tags/*/project-a:refs/remotes/tags/*
	trunk = trunk/project-a:refs/remotes/trunk

> --follow-parent is not yet the default, some more testing from others
> would be nice.  --follow-parent is now greatly improved, as it
> can follow into deleted directories as well as tracking subdirectories
> with no explicit parent at its current level.

I've made --follow-parent the default now.  --no-follow-parent reverts
back to the old default behavior.

> Sam Vilain's revprops tracking hasn't been merged yet, but I intend to
> support alternate SVN URLs/revnos from both svm:* revprops as well as
> being able to override the repository root path (file:// => http://
> for public distribution).

This is in, as is the analogous functionality for svnsync.  Please note
that these features do add some complexity to how dcommit works which
I haven't explored much of.  Perhaps Sam knows better what to do with
it.

> Repository available here, this is based against Junios git.git master:
> 
>   git://git.bogomips.org/git-svn.git
>   http://git.bogomips.org/git-svn.git
> 
> I *will* rebase the master here as I see fit...

New changes pushed out.

> To take full advantage of remote connection minimization, just run:
> "git-svn migrate --minimize" once and continue to add/edit remote
> refspecs via .git/config.
> 
> As great as these changes sound, I don't feel they bring significant
> enough improvement to risk introducing brokeness for 1.5.0.  I would
> like to wait until 1.5.0 has passed before merging into mainline.  I
> still have _not_ used this version of git-svn for any real work yet.

After a few days of dogfooding and nothing breaking; I'd say it's ready
for merging into mainline git.  One last minute change I made while
writing this announcement was supporting invocations from
subdirectories.

There's a lot of changes in here; so I don't think I'll bomb the
mailing list with 113 patches.  Feel free to fetch or clone from
the repositories given above.

Eric Wong (112):
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
      git-svn: just name the default svn-remote "svn" instead of "git-svn"
      git-svn: prepare multi-init for wildcard support
      git-svn: reintroduce using a single get_log() to fetch
      git-svn: run get_log() on a sub-directory if possible
      git-svn: implement auto-discovery of branches/tags
      git-svn: --follow-parent tracks multi-parent paths
      git-svn: remove check_path calls before calling do_update
      git-svn: remove some noisy debugging messages
      git-svn: enable follow-parent functionality by default
      git-svn: fix buggy regular expression usage in several places
      git-svn: correctly handle the -q flag in SVN::Git::Fetcher
      git-svn: correctly handle globs with a right-hand-side path component
      git-svn: remove optimized commit stuff for set-tree
      git-svn: add support for SVN::Mirror/svk using revprops for metadata
      git-svn: add support for per-[svn-remote "..."] options
      git-svn: use private $GIT_DIR/svn/config file more
      git-svn: extra safety for noMetadata and useSvmProps users
      git-svn: use separate, per-repository .rev_db files
      git-svn: write the highest maxRex out for branches and tags
      git-svn: handle multi-init without --trunk, UseSvmProps fixes
      git-svn: make dcommit usable for glob users
      git-svn: include merges when calling rev-list for decommit
      git-svn: usability fixes for the 'git svn log' command
      t910*: s/repo-config/config/g; poke around possible race conditions
      git-svn: hopefully make 'fetch' more user-friendly
      git-svn: allow 'init' to act as multi-init
      git-svn: brown paper bag fixes
      git-svn: simplify the (multi-)init methods of fetching
      git-svn: allow --log-window-size to be specified, default to 100
      git-svn: remember to check for clean indices on globbed refs, too
      git-svn: error checking for invalid [svn-remote "..."] sections
      git-svn: allow dcommit for those who only fetch from SVM with useSvmProps
      git-svn: documentation updates for new functionality
      git-svn: add support for --stat in the log command
      git-svn: checkout files on new fetches
      git-svn: add a 'rebase' command
      git-svn: fix some issues for people migrating from older versions
      git-svn: hide the private git-svn 'config' file as '.metadata'
      git-svn: add 'clone' command, an alias for init + fetch
      git-svn: allow overriding of the SVN repo root in metadata
      git-svn: add support for using svnsync properties
      git-svn: fix useSvmProps, hopefully for the last time
      git-svn: add test for useSvnsyncProps
      git-svn: documentation updates
      git-svn: allow metadata options to be specified with 'init' and 'clone'
      git-svn: give show-ignore HEAD smarts, like dcommit and log
      git-svn: ensure we're at the top-level and can access $GIT_DIR

sam@vilain.net (1):
      git-svn: make test for SVK mirror path import

-- 
Eric Wong
