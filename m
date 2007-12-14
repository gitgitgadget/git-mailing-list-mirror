From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: handle our top-level path is deleted and later re-added
Date: Fri, 14 Dec 2007 08:39:09 -0800
Message-ID: <20071214163909.GA18300@soma>
References: <475C8748.6000005@cryos.net> <20071210104235.GA7521@xp.machine.xx> <20071213164134.GD18433@soma> <20071213181312.GA4441@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>,
	"Marcus D. Hanwell" <marcus@cryos.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 17:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3DZZ-0008UM-UA
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 17:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbXLNQjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 11:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbXLNQjM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 11:39:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60284 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697AbXLNQjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 11:39:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CB7517DC025;
	Fri, 14 Dec 2007 08:39:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071213181312.GA4441@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68316>

Previously, git-svn would ignore cases where the path we're
tracking is removed from the repository.  This was to prevent
heads with follow-parent from ending up with a tree full of
empty revisions (and thus breaking rename detection).

The previous behavior is fine until the path we're tracking
is re-added later on, leading to the old files being merged
in with the new files in the directory (because the old
files were never marked as deleted)

We will now only remove all the old files locally that were
deleted remotely iff we detect the directory we're in is being
created from scratch.

Thanks for Marcus D. Hanwell for the bug report and
Peter Baumann for the analysis.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Peter Baumann <waste.manager@gmx.de> wrote:
  > On Thu, Dec 13, 2007 at 08:41:34AM -0800, Eric Wong wrote:
  > > Peter Baumann <waste.manager@gmx.de> wrote:
  > > > On Sun, Dec 09, 2007 at 07:24:40PM -0500, Marcus D. Hanwell wrote:
  > > > /trunk and /tags are moved, too.
  > > > (/trunk/avogadro.pro becomes /avogadro/trunk/avogadro.pro):
  > > >     ------------------------------------------------------------------------
  > > >     r68 | dcurtis3 | 2007-01-03 06:47:34 +0100 (Wed, 03 Jan 2007) | 3 lines
  > > >     Changed paths:
  > > >        A /avogadro/tags (from /tags:66)
  > > >        A /avogadro/trunk (from /trunk:66)
  > > >        D /tags
  > > >        D /trunk
  > > > 
  > > >     Making room for libavogadro.
  > > > 
  > > > The above delete/move of trunk isn't recorded anywhere in the git svn import.
  > > > 'git-svn find-rev r66' doesn't produce any output!
  > > > And later git-svn thinks that /trunk and all its files are still there, so
  > > > e.g. /trunk/avogadro.pro stays in the repo forever.
  > > 
  > > Hi,
  > > 
  > > Thanks for the analysis, Peter.
  > > 
  > > git-svn ignores deletions to the directory we're tracking in order to
  > > represent renames when the follow-parent case is hit.
  > > 
  > > Unfortunately, this never took into account the directory we're tracking
  > > reappearing later in history.  I'll try to have a fix later tonight or
  > > over the weekend.
  > > 
  > > > mv /avogadro/trunk/avogadro.pro /trunk/avogadro/avogadro.pro
  > > >    ------------------------------------------------------------------------
  > > >     r75 | dcurtis3 | 2007-01-03 20:49:35 +0100 (Wed, 03 Jan 2007) | 2 lines
  > > >     Changed paths:
  > > >        D /avogadro
  > > >        D /avogadro-lib
  > > >        A /branches
  > > >        A /tags
  > > >        A /trunk
  > > >        A /trunk/avogadro (from /avogadro/trunk:74)
  > > >        A /trunk/libavogadro (from /avogadro-lib/trunk:74)
  > > > 
  > > >     Moving things around.  Conforming to a more KDE-like layout in SVN.
  > > >     I'm going nuts.  SOrry
  > > 
  > > Instead of handling the full delete of everything in r68, I think I'll
  > > make it so importing r75 will clobber all the stuff in trunk/ we ignored
  > > deleting in r68 before adding the contents of trunk/ in r75.
  > > 
  > 
  > Sorry, that last sentence I can't parse/understand. But I trust you to do the
  > right thing.

  I hope the commit message was a better explanation.  Or the code
  and test case I've added makes perfect sense :)

 git-svn.perl                                 |   14 +++++++++
 t/t9103-git-svn-tracked-directory-removed.sh |   39 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100755 t/t9103-git-svn-tracked-directory-removed.sh

diff --git a/git-svn.perl b/git-svn.perl
index 3aa7f8c..d411a34 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3045,6 +3045,20 @@ sub add_file {
 
 sub add_directory {
 	my ($self, $path, $cp_path, $cp_rev) = @_;
+	my $gpath = $self->git_path($path);
+	if ($gpath eq '') {
+		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
+		                                     -r --name-only -z/,
+				                     $self->{c});
+		local $/ = "\0";
+		while (<$ls>) {
+			chomp;
+			$self->{gii}->remove($_);
+			print "\tD\t$_\n" unless $::_q;
+		}
+		command_close_pipe($ls, $ctx);
+		$self->{empty}->{$path} = 0;
+	}
 	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 	delete $self->{empty}->{$dir};
 	$self->{empty}->{$path} = 1;
diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git-svn-tracked-directory-removed.sh
new file mode 100755
index 0000000..0f0b0fd
--- /dev/null
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description='git-svn tracking removed top-level path'
+. ./lib-git-svn.sh
+
+test_expect_success 'make history for tracking' '
+	mkdir import &&
+	mkdir import/trunk &&
+	echo hello >> import/trunk/README &&
+	svn import -m initial import $svnrepo &&
+	rm -rf import &&
+	svn co $svnrepo/trunk trunk &&
+	echo bye bye >> trunk/README &&
+	svn rm -m "gone" $svnrepo/trunk &&
+	rm -rf trunk &&
+	mkdir trunk &&
+	echo "new" > trunk/FOLLOWME &&
+	svn import -m "new trunk" trunk $svnrepo/trunk
+'
+
+test_expect_success 'clone repo with git' '
+	git svn clone -s $svnrepo x &&
+	test -f x/FOLLOWME &&
+	test ! -f x/README
+'
+
+test_expect_success 'make sure r2 still has old file' '
+	cd x &&
+		test -n "$(git svn find-rev r1)" &&
+		git reset --hard $(git svn find-rev r1) &&
+		test -f README &&
+		test ! -f FOLLOWME &&
+		test x$(git svn find-rev r2) = x
+'
+
+test_done
-- 
Eric Wong
