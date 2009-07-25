From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc2
Date: Sat, 25 Jul 2009 03:38:21 -0700
Message-ID: <20090725103821.GA13534@dcvr.yhbt.net>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org> <20090724093847.GA20338@dcvr.yhbt.net> <7vk51ykm42.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mattias Nissler <mattias.nissler@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 12:38:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUee8-0003si-DF
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 12:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbZGYKiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 06:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbZGYKiX
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 06:38:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59563 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbZGYKiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 06:38:22 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 6211B1F4E8;
	Sat, 25 Jul 2009 10:38:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vk51ykm42.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124000>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >>  * git-svn updates, including a new --authors-prog option to map author
> >>    names by invoking an external program, 'git svn reset' to unwind
> >>    'git svn fetch', support for more than one branches, etc.
> >
> > I completely forgot the implications of a change made in commit
> > 0b2af457a49e3b00d47d556d5301934d27909db8.  This change probably doesn't
> > affect a lot of repos out there, but --minimize-url is no longer the
> > default for new imports.

> > Let me know if the above made sense, it's late and I nodded off
> > several times while writing this.
> 
> Your description makes sense, and I suspect that the old default may be
> easier to work with.

Yes.  I think the old default makes more sense, so I'll be reverting
back to it.  However, I'll make it possible to override from the
command-line.

> Minimally, a patch to git-svn.txt and RelNotes-1.6.4.txt in Documentation/
> to describe the situation with a recipe (in the former) to allow people
> the older behaviour would be in order.  It appears minimize-url is not
> even documented as far as I can see in the current documentation set.

>From a93241b082cd6e7344d0e53969b1e66d443fa48b Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 25 Jul 2009 00:00:50 -0700
Subject: [PATCH] git-svn: revert default behavior for --minimize-url

This reverts the --minimize-url behavior change that
appeared recently in commit 0b2af457a49e3b00d47d556d5301934d27909db8
("Fix branch detection when repository root is inaccessible").

However, we now allow the option to be turned off by allowing
"--no-minimize-url" so people with limited-access setups can
still take advantage of the fix in
0b2af457a49e3b00d47d556d5301934d27909db8.

Also document the behavior and default settings of minimize-url
in the manpage for the first time.

This introduces a temporary UI regression to allow t9141 to pass
that will be reverted (fixed) in the next commit.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt            |   11 +++++++++++
 git-svn.perl                         |    7 ++++++-
 t/t9141-git-svn-multiple-branches.sh |    8 ++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 068aa58..22a0389 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -80,6 +80,17 @@ COMMANDS
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
 	of '--ignore-paths'.
+--no-minimize-url;;
+	When tracking multiple directories (using --stdlayout,
+	--branches, or --tags options), git svn will attempt to connect
+	to the root (or highest allowed level) of the Subversion
+	repository.  This default allows better tracking of history if
+	entire projects are moved within a repository, but may cause
+	issues on repositories where read access restrictions are in
+	place.  Passing '--no-minimize-url' will allow git svn to
+	accept URLs as-is without attempting to connect to a higher
+	level directory.  This option is off by default when only
+	one URL/branch is tracked (it would do little good).
 
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
diff --git a/git-svn.perl b/git-svn.perl
index 7015920..10b77ad 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -19,6 +19,7 @@ $ENV{GIT_DIR} ||= '.git';
 $Git::SVN::default_repo_id = 'svn';
 $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
+$Git::SVN::_minimize_url = 'unset';
 
 $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
@@ -100,7 +101,7 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
                   'branches|b=s@' => \@_branches, 'prefix=s' => \$_prefix,
                   'stdlayout|s' => \$_stdlayout,
-                  'minimize-url|m' => \$Git::SVN::_minimize_url,
+                  'minimize-url|m!' => \$Git::SVN::_minimize_url,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
 		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },
 		  'use-svnsync-props' => sub { $icv{useSvnsyncProps} = 1 },
@@ -399,6 +400,10 @@ sub cmd_init {
 	init_subdir(@_);
 	do_git_init_db();
 
+	if ($Git::SVN::_minimize_url eq 'unset') {
+		$Git::SVN::_minimize_url = 0;
+	}
+
 	Git::SVN->init($url);
 }
 
diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
index 3cd0671..cb9a6d2 100755
--- a/t/t9141-git-svn-multiple-branches.sh
+++ b/t/t9141-git-svn-multiple-branches.sh
@@ -99,22 +99,22 @@ test_expect_success 'Multiple branch or tag paths require -d' '
 
 test_expect_success 'create new branches and tags' '
 	( cd git_project &&
-		git svn branch -m "New branch 1" -d b_one New1 ) &&
+		git svn branch -m "New branch 1" -d project/b_one New1 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e b_one/New1/a.file ) &&
 
 	( cd git_project &&
-		git svn branch -m "New branch 2" -d b_two New2 ) &&
+		git svn branch -m "New branch 2" -d project/b_two New2 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e b_two/New2/a.file ) &&
 
 	( cd git_project &&
-		git svn branch -t -m "New tag 1" -d tags_A Tag1 ) &&
+		git svn branch -t -m "New tag 1" -d project/tags_A Tag1 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e tags_A/Tag1/a.file ) &&
 
 	( cd git_project &&
-		git svn tag -m "New tag 2" -d tags_B Tag2 ) &&
+		git svn tag -m "New tag 2" -d project/tags_B Tag2 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e tags_B/Tag2/a.file )
 '
-- 
Eric Wong
